;; Title: TritcoinDAO - Bitcoin-Native Decentralized Treasury Protocol
;;
;; Summary: 
;; A permissionless, Bitcoin-aligned treasury management protocol built on Stacks, 
;; enabling communities to collectively manage STX reserves through democratic 
;; governance and time-locked security mechanisms.
;;
;; Description:
;; TritcoinDAO harnesses Bitcoin's security model through Stacks' unique architecture 
;; to create a trustless treasury system. Participants stake STX to gain governance 
;; rights, propose funding initiatives, and execute community-approved distributions. 
;; The protocol implements Bitcoin's conservative principles with time-locked deposits, 
;; consensus-driven decision making, and transparent fund management. Each proposal 
;; undergoes rigorous community review, ensuring alignment with Bitcoin's ethos of 
;; decentralization and sound money principles. Built for Bitcoin maximalists who 
;; believe in decentralized governance without compromising on security.

;; PROTOCOL CONSTANTS & ERROR HANDLING

(define-constant contract-owner tx-sender)

;; Error codes with descriptive meanings
(define-constant err-owner-only (err u100))
(define-constant err-not-initialized (err u101))
(define-constant err-already-initialized (err u102))
(define-constant err-insufficient-balance (err u103))
(define-constant err-invalid-amount (err u104))
(define-constant err-unauthorized (err u105))
(define-constant err-proposal-not-found (err u106))
(define-constant err-proposal-expired (err u107))
(define-constant err-already-voted (err u108))
(define-constant err-below-minimum (err u109))
(define-constant err-locked-period (err u110))
(define-constant err-transfer-failed (err u111))
(define-constant err-invalid-duration (err u112))
(define-constant err-zero-amount (err u113))
(define-constant err-invalid-target (err u114))
(define-constant err-invalid-description (err u115))
(define-constant err-invalid-proposal-id (err u116))
(define-constant err-invalid-vote (err u117))

;; Protocol parameters (Bitcoin time-based)
(define-constant minimum-duration u144)      ;; ~1 day in blocks (Bitcoin-aligned)
(define-constant maximum-duration u20160)    ;; ~14 days maximum proposal lifetime

;; STATE VARIABLES

(define-data-var total-supply uint u0)
(define-data-var minimum-deposit uint u1000000)     ;; 1 STX minimum (in microSTX)
(define-data-var lock-period uint u1440)            ;; ~10 days stake lock period
(define-data-var initialized bool false)
(define-data-var last-rebalance uint u0)
(define-data-var proposal-count uint u0)

;; DATA STRUCTURES

;; Governance token balances
(define-map balances principal uint)

;; Stake deposit tracking with Bitcoin-style time locks
(define-map deposits
    principal
    {
        amount: uint,
        lock-until: uint,
        last-reward-block: uint
    }
)

;; Proposal registry with comprehensive metadata
(define-map proposals
    uint
    {
        proposer: principal,
        description: (string-ascii 256),
        amount: uint,
        target: principal,
        expires-at: uint,
        executed: bool,
        yes-votes: uint,
        no-votes: uint
    }
)

;; Vote tracking to prevent double-voting
(define-map votes {proposal-id: uint, voter: principal} bool)

;; INTERNAL HELPER FUNCTIONS

(define-private (is-contract-owner)
    (is-eq tx-sender contract-owner)
)

(define-private (check-initialized)
    (ok (asserts! (var-get initialized) err-not-initialized))
)

(define-private (validate-proposal-id (proposal-id uint))
    (ok (asserts! (<= proposal-id (var-get proposal-count)) err-invalid-proposal-id))
)

(define-private (calculate-voting-power (voter principal))
    (default-to u0 (map-get? balances voter))
)