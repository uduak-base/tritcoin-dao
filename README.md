# TritcoinDAO - Bitcoin-Native Decentralized Treasury Protocol

[![Stacks](https://img.shields.io/badge/Built%20on-Stacks-orange)](https://stacks.co)
[![Clarity](https://img.shields.io/badge/Language-Clarity-blue)](https://clarity-lang.org)
[![Bitcoin](https://img.shields.io/badge/Secured%20by-Bitcoin-F7931A)](https://bitcoin.org)

A permissionless, Bitcoin-aligned treasury management protocol built on Stacks, enabling communities to collectively manage STX reserves through democratic governance and time-locked security mechanisms.

## 🎯 Overview

TritcoinDAO harnesses Bitcoin's security model through Stacks' unique architecture to create a trustless treasury system. Participants stake STX to gain governance rights, propose funding initiatives, and execute community-approved distributions. The protocol implements Bitcoin's conservative principles with time-locked deposits, consensus-driven decision making, and transparent fund management.

### Key Features

- **Bitcoin-Native Security**: Built on Stacks, inheriting Bitcoin's security guarantees
- **Time-Locked Deposits**: Bitcoin-style security with mandatory lock periods
- **Democratic Governance**: Weighted voting based on stake participation
- **Transparent Treasury**: All fund movements tracked on-chain
- **Conservative Parameters**: Bitcoin-aligned timing and security constraints

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    TritcoinDAO Protocol                     │
├─────────────────────────────────────────────────────────────┤
│  Governance Layer                                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │  Proposals  │  │   Voting    │  │  Execution  │        │
│  │             │  │             │  │             │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
├─────────────────────────────────────────────────────────────┤
│  Treasury Management Layer                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Deposits  │  │ Time Locks  │  │ Withdrawals │        │
│  │             │  │             │  │             │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
├─────────────────────────────────────────────────────────────┤
│  Token Management Layer                                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │    Mint     │  │    Burn     │  │   Balance   │        │
│  │             │  │             │  │   Tracking  │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
├─────────────────────────────────────────────────────────────┤
│                 Bitcoin Security Foundation                  │
│               (Stacks Consensus & Bitcoin PoW)              │
└─────────────────────────────────────────────────────────────┘
```

## 🔧 Contract Architecture

### Core Components

#### 1. State Management

- **Balances**: Governance token distribution
- **Deposits**: Stake tracking with time locks
- **Proposals**: Funding request registry
- **Votes**: Double-voting prevention

#### 2. Security Primitives

- **Time Locks**: Bitcoin-style deposit security (10-day minimum)
- **Access Control**: Owner-only initialization
- **Input Validation**: Comprehensive parameter checking
- **Error Handling**: Descriptive error codes (u100-u117)

#### 3. Governance Mechanisms

- **Weighted Voting**: Stake-proportional decision making
- **Proposal Lifecycle**: Creation → Voting → Execution
- **Treasury Controls**: Community-approved fund distribution

### Key Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| Minimum Deposit | 1 STX | Entry threshold for governance |
| Lock Period | 1,440 blocks | ~10 days stake commitment |
| Min Proposal Duration | 144 blocks | ~1 day minimum voting period |
| Max Proposal Duration | 20,160 blocks | ~14 days maximum voting window |

## 🔄 Data Flow

### 1. Deposit & Staking Flow

```
User STX → Contract Treasury → Governance Tokens → Time Lock
    ↓
Voting Power Gained
```

### 2. Proposal Lifecycle

```
Create Proposal → Community Voting → Execution (if approved)
      ↓              ↓                    ↓
   Validation    Vote Tallying       Fund Distribution
```

### 3. Withdrawal Process

```
Time Lock Expires → Token Burn → STX Return
       ↓              ↓             ↓
   Validation    Supply Update   Balance Transfer
```

## 🚀 Getting Started

### Prerequisites

- [Clarinet CLI](https://github.com/hirosystems/clarinet)
- Node.js 16+ (for testing)
- Stacks wallet for testnet interaction

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-org/tritcoin-dao
   cd tritcoin-dao
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Check contract syntax**

   ```bash
   clarinet check
   ```

4. **Run tests**

   ```bash
   npm test
   ```

### Deployment

1. **Local development**

   ```bash
   clarinet console
   ```

2. **Testnet deployment**

   ```bash
   clarinet deploy --testnet
   ```

## 📖 Usage Guide

### For Participants

#### 1. Stake STX for Governance Rights

```clarity
(contract-call? .tritcoin-dao deposit u1000000) ;; Deposit 1 STX
```

#### 2. Create a Funding Proposal

```clarity
(contract-call? .tritcoin-dao create-proposal
  "Development fund for new features"
  u500000 ;; 0.5 STX
  'SP1EXAMPLE... ;; Target address
  u1440) ;; 10-day voting period
```

#### 3. Vote on Proposals

```clarity
(contract-call? .tritcoin-dao vote u1 true) ;; Vote YES on proposal #1
```

#### 4. Execute Approved Proposals

```clarity
(contract-call? .tritcoin-dao execute-proposal u1)
```

#### 5. Withdraw After Lock Period

```clarity
(contract-call? .tritcoin-dao withdraw u1000000) ;; Withdraw 1 STX
```

### For Developers

#### Query Functions

```clarity
;; Check governance token balance
(contract-call? .tritcoin-dao get-balance 'SP1EXAMPLE...)

;; Get proposal details
(contract-call? .tritcoin-dao get-proposal u1)

;; Check deposit information
(contract-call? .tritcoin-dao get-deposit-info 'SP1EXAMPLE...)
```

## 🔐 Security Model

### Bitcoin-Aligned Principles

- **Time Locks**: Mandatory cooling-off periods prevent hasty decisions
- **Consensus Requirement**: Majority approval needed for fund disbursement
- **Transparent Operations**: All actions recorded on Bitcoin-secured blockchain
- **Conservative Parameters**: Long lock periods and voting windows

### Risk Mitigation

- **Reentrancy Protection**: State updates before external calls
- **Input Validation**: Comprehensive parameter checking
- **Access Controls**: Owner-only initialization and emergency functions
- **Double-Voting Prevention**: Cryptographic vote tracking

## 🧪 Testing

The protocol includes comprehensive test coverage:

```bash
# Run all tests
npm test

# Run specific test suites
npm run test:governance
npm run test:treasury
npm run test:security
```

### Test Coverage Areas

- Deposit and withdrawal mechanics
- Proposal creation and voting
- Time lock enforcement
- Error condition handling
- Edge case scenarios

## 🤝 Contributing

We welcome contributions from the Bitcoin and Stacks communities!

### Development Process

1. Fork the repository
2. Create a feature branch
3. Implement changes with tests
4. Submit a pull request

### Code Standards

- Follow Clarity best practices
- Include comprehensive tests
- Document public functions
- Maintain security-first mindset

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Resources

- [Stacks Documentation](https://docs.stacks.co)
- [Clarity Language Reference](https://clarity-lang.org)
- [Bitcoin Whitepaper](https://bitcoin.org/bitcoin.pdf)
- [Stacks Improvement Proposals](https://github.com/stacksgov/sips)
