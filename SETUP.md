# Setup Guide for Open-eth

This guide will walk you through setting up the Open-eth development environment.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** >= 18.0.0 ([Download](https://nodejs.org/))
- **pnpm** >= 8.0.0 (Install with `npm install -g pnpm`)
- **Git** for version control

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/leocagli/Open-eth.git
cd Open-eth
```

### 2. Install Dependencies

Install all project dependencies using pnpm:

```bash
pnpm install
```

This will install:
- Hardhat and related tools
- Smart contract dependencies (@openzeppelin/contracts, @uniswap/v4-core)
- TypeScript and testing libraries
- Frontend dependencies (Next.js, React, Tailwind CSS)
- All workspace packages

### 3. Compile Smart Contracts

Compile the Solidity smart contracts:

```bash
pnpm hardhat compile
```

This creates:
- `artifacts/`: Compiled contract artifacts
- `typechain-types/`: TypeScript bindings for contracts
- `cache/`: Hardhat compilation cache

### 4. Start Local Hardhat Node

In a separate terminal, start the local Ethereum network:

```bash
pnpm hardhat node
```

Keep this terminal running. The node will:
- Run on `http://127.0.0.1:8545`
- Provide test accounts with ETH
- Show transaction logs in real-time

### 5. Deploy Contracts

In another terminal, deploy the contracts to your local network:

```bash
pnpm hardhat deploy
```

This deploys:
- IdentityRegistry contract
- ReputationRegistry contract
- Other configured contracts

Contract addresses will be shown in the output.

### 6. Run Tests

Verify everything is working by running the test suite:

```bash
pnpm test
```

### 7. Start the Frontend

Start the Next.js development server:

```bash
pnpm dev
```

The dashboard will be available at `http://localhost:3000`.

## Project Structure

```
Open-eth/
├── agentpay-liquidity-ops/  # Automated liquidity strategies
├── agents/                  # General autonomous agents
├── contracts/               # Solidity smart contracts
│   ├── IdentityRegistry.sol
│   └── ReputationRegistry.sol
├── frontend/                # Next.js dashboard
│   ├── app/                 # Next.js 14 app directory
│   ├── public/              # Static assets
│   └── package.json
├── gateway-x402/            # HTTP 402 payment gateway
├── hooks/                   # Uniswap v4 hooks
│   └── OpenEthHook.sol
├── registries/              # Registry modules
│   ├── identity/
│   └── reputation/
├── risk-agent/              # Risk management agent
├── router-agent/            # Transaction routing agent
├── scripts/                 # Utility scripts
│   └── deploy/              # Deployment scripts
└── test/                    # Contract tests
    ├── IdentityRegistry.test.ts
    └── ReputationRegistry.test.ts
```

## Available Scripts

### Root Level Scripts

- `pnpm install` - Install all dependencies
- `pnpm node` - Start local Hardhat network
- `pnpm deploy` - Deploy contracts
- `pnpm dev` - Start frontend development server
- `pnpm dev:all` - Run node and frontend concurrently
- `pnpm build` - Build contracts and frontend
- `pnpm test` - Run contract tests
- `pnpm test:coverage` - Run tests with coverage report
- `pnpm clean` - Clean build artifacts

### Frontend Scripts

```bash
cd frontend
pnpm dev      # Start development server
pnpm build    # Build for production
pnpm start    # Start production server
pnpm lint     # Run ESLint
```

## Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
cp .env.example .env
```

Key variables:
- `HARDHAT_NETWORK` - Target network (default: localhost)
- `RPC_URL` - Ethereum RPC endpoint
- `CHAIN_ID` - Network chain ID
- `NEXT_PUBLIC_RPC_URL` - Frontend RPC URL

### Hardhat Configuration

Edit `hardhat.config.ts` to configure:
- Solidity compiler version and settings
- Network configurations
- Deployment settings
- Gas reporter options

## Development Workflow

### 1. Local Development

```bash
# Terminal 1: Start local node
pnpm hardhat node

# Terminal 2: Deploy contracts
pnpm hardhat deploy

# Terminal 3: Start frontend
pnpm dev
```

### 2. Making Changes

After modifying contracts:

```bash
pnpm hardhat compile  # Recompile
pnpm test            # Run tests
pnpm hardhat deploy  # Redeploy
```

After modifying frontend:

The Next.js dev server auto-reloads changes.

### 3. Testing

Run specific test files:

```bash
pnpm hardhat test test/IdentityRegistry.test.ts
```

Run with gas reporting:

```bash
REPORT_GAS=true pnpm test
```

Run with coverage:

```bash
pnpm test:coverage
```

## Smart Contracts

### IdentityRegistry

Manages user identities on-chain.

**Key Functions:**
- `registerIdentity(bytes32)` - Register new identity
- `updateIdentity(bytes32)` - Update identity hash
- `deactivateIdentity()` - Deactivate identity
- `getIdentity(address)` - Get identity info
- `isIdentityActive(address)` - Check if active

### ReputationRegistry

Tracks user reputation scores.

**Key Functions:**
- `initializeReputation(address)` - Initialize user reputation
- `recordTransaction(address, bool)` - Record transaction result
- `getReputation(address)` - Get reputation details
- `getScore(address)` - Get reputation score
- `getSuccessRate(address)` - Get success percentage

### OpenEthHook

Uniswap v4 hook template for custom pool operations.

**Key Functions:**
- `beforeSwap()` - Pre-swap hook
- `afterSwap()` - Post-swap hook
- `initializePool(bytes32)` - Initialize pool

## Modules

### AgentPay Liquidity Operations

Automated strategies for liquidity management.

### Risk Agent

Analyzes and manages ecosystem risks.

### Router Agent

Handles intelligent transaction routing.

### Gateway x402

HTTP 402 middleware for micropayments.

Runs on port 3402 by default.

```bash
cd gateway-x402
pnpm start
```

## Frontend Dashboard

Built with Next.js 14, React 18, and Tailwind CSS.

**Features:**
- Identity Registry status
- Reputation System overview
- Uniswap v4 Hooks integration
- Real-time contract interaction

## Troubleshooting

### Installation Issues

If `pnpm install` fails:

```bash
# Clear cache
pnpm store prune

# Try again
pnpm install
```

### Compilation Errors

If contracts won't compile:

```bash
# Clean and rebuild
pnpm clean
pnpm hardhat compile
```

### Network Connection Issues

Ensure the Hardhat node is running:

```bash
# Check if port 8545 is in use
lsof -i :8545

# Kill if needed
kill -9 <PID>

# Restart
pnpm hardhat node
```

### Frontend Not Loading

```bash
cd frontend
rm -rf .next
pnpm dev
```

## Next Steps

1. Review the smart contracts in `contracts/`
2. Explore the frontend code in `frontend/app/`
3. Read the deployment scripts in `scripts/deploy/`
4. Check out the tests in `test/`
5. Customize the configuration in `hardhat.config.ts`

## Additional Resources

- [Hardhat Documentation](https://hardhat.org/docs)
- [Next.js Documentation](https://nextjs.org/docs)
- [Uniswap v4 Documentation](https://docs.uniswap.org/contracts/v4/overview)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts)

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests
5. Submit a pull request

## Support

For issues and questions:
- Open an issue on GitHub
- Check existing documentation
- Review test files for examples

## License

MIT License - see LICENSE file for details
