# Open-eth

## Decentralized Liquidity Protocol

Open-eth is a comprehensive decentralized liquidity protocol that integrates Uniswap v4 hooks, HTTP 402 payment gateway (x402), and ERC-8004 standards to provide a robust ecosystem for automated liquidity operations.

## Features

- **Uniswap v4 Integration**: Custom hooks for advanced liquidity management
- **x402 Gateway**: HTTP 402 Payment Required middleware for micropayments
- **ERC-8004 Compatibility**: Support for modern Ethereum standards
- **Identity & Reputation**: On-chain identity and reputation registries
- **Autonomous Agents**: Risk management and routing agents
- **Next.js Dashboard**: Modern frontend for monitoring and management

## Project Structure

```
Open-eth/
├── agentpay-liquidity-ops/  # Automated liquidity operation strategies
├── contracts/               # Smart contracts
├── hooks/                   # Uniswap v4 hooks
├── registries/              # Identity and reputation registries
│   ├── identity/
│   └── reputation/
├── agents/                  # Autonomous agents
├── risk-agent/              # Risk management agent
├── router-agent/            # Transaction routing agent
├── gateway-x402/            # HTTP 402 payment gateway
├── frontend/                # Next.js dashboard
├── scripts/                 # Deployment and utility scripts
│   └── deploy/
└── test/                    # Test files
```

## Prerequisites

- Node.js >= 18.0.0
- pnpm >= 8.0.0

## Quick Start

### 1. Install Dependencies

```bash
pnpm install
```

### 2. Start Local Hardhat Network

In a separate terminal, start the local Hardhat node:

```bash
pnpm hardhat node
```

This will start a local Ethereum network on `http://127.0.0.1:8545`.

### 3. Deploy Smart Contracts

In another terminal, deploy the contracts to the local network:

```bash
pnpm hardhat deploy
```

This will deploy:
- IdentityRegistry
- ReputationRegistry
- Uniswap v4 Hooks

### 4. Start Development Server

Start the Next.js frontend dashboard:

```bash
pnpm dev
```

The dashboard will be available at `http://localhost:3000`.

## Available Scripts

- `pnpm install` - Install all dependencies
- `pnpm node` - Start local Hardhat network
- `pnpm deploy` - Deploy contracts to the network
- `pnpm dev` - Start frontend development server
- `pnpm dev:all` - Start both node and frontend concurrently
- `pnpm build` - Build contracts and frontend
- `pnpm test` - Run contract tests
- `pnpm clean` - Clean build artifacts

## Smart Contracts

### IdentityRegistry

Manages user identities in the Open-eth ecosystem with on-chain identity verification.

### ReputationRegistry

Tracks user reputation scores based on transaction history and success rates.

### OpenEthHook

Uniswap v4 hook for custom liquidity pool operations.

## Modules

### AgentPay Liquidity Operations

Automated strategies for liquidity management and optimization.

### Risk Agent

Analyzes and manages risk across the ecosystem.

### Router Agent

Handles intelligent transaction routing for optimal execution.

### Gateway x402

HTTP 402 Payment Required middleware for micropayment integration.

## Development

### Running Tests

```bash
pnpm test
```

### Compiling Contracts

```bash
pnpm build:contracts
```

### Building Frontend

```bash
pnpm build:frontend
```

## Network Configuration

The default configuration uses Hardhat's local network:
- Chain ID: 31337
- RPC URL: http://127.0.0.1:8545

## Security

This project takes security seriously. All dependencies are regularly updated to patch known vulnerabilities.

**Latest Security Update:** 2026-02-08
- Updated Next.js to 14.2.35 (patched all critical vulnerabilities)
- See [SECURITY.md](SECURITY.md) for details

To report security issues, please see our [Security Policy](SECURITY.md).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT

## Support

For issues and questions, please open an issue on GitHub.