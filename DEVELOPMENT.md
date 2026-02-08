# Development Guide

## Overview

This guide covers development best practices, architecture decisions, and contribution guidelines for the Open-eth project.

## Architecture

### Smart Contract Layer

The contract layer consists of:

1. **Core Contracts** (`contracts/`)
   - `IdentityRegistry.sol`: On-chain identity management
   - `ReputationRegistry.sol`: Reputation scoring system

2. **Uniswap v4 Hooks** (`hooks/`)
   - `OpenEthHook.sol`: Custom pool operations
   - Integration with Uniswap v4 core

3. **Deployment** (`scripts/deploy/`)
   - Modular deployment scripts using hardhat-deploy
   - Named deployments for easy reference

### Application Layer

1. **Frontend** (`frontend/`)
   - Next.js 14 with App Router
   - React Server Components
   - Tailwind CSS for styling
   - Web3 integration with ethers.js

2. **Agents** (multiple directories)
   - Autonomous agents for various tasks
   - Risk management
   - Transaction routing
   - Liquidity operations

3. **Gateway** (`gateway-x402/`)
   - HTTP 402 payment middleware
   - Express.js server
   - Integration with payment systems

## Smart Contract Development

### Writing Contracts

Follow these guidelines:

1. **Use Latest Solidity Features**
   - Compiler version: 0.8.24
   - Enable optimizer with 200 runs
   - Use viaIR for better optimization

2. **Follow OpenZeppelin Patterns**
   - Inherit from OpenZeppelin contracts when possible
   - Use `Ownable`, `Pausable`, etc. for access control
   - Emit events for all state changes

3. **Security Best Practices**
   - Check-Effects-Interactions pattern
   - Use `require` for validation
   - Avoid reentrancy vulnerabilities
   - Use SafeMath (or built-in overflow checks)

### Testing Contracts

Write comprehensive tests:

```typescript
import { expect } from "chai";
import { ethers } from "hardhat";

describe("MyContract", function () {
  let contract;
  let owner, user1, user2;

  beforeEach(async function () {
    [owner, user1, user2] = await ethers.getSigners();
    
    const Factory = await ethers.getContractFactory("MyContract");
    contract = await Factory.deploy();
    await contract.waitForDeployment();
  });

  it("Should do something", async function () {
    // Test implementation
  });
});
```

### Deployment

Create deployment scripts in `scripts/deploy/`:

```typescript
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy("MyContract", {
    from: deployer,
    args: [],
    log: true,
  });
};

export default func;
func.tags = ["MyContract"];
```

## Frontend Development

### Component Structure

```
frontend/
├── app/
│   ├── layout.tsx          # Root layout
│   ├── page.tsx            # Home page
│   ├── globals.css         # Global styles
│   └── [feature]/          # Feature-specific pages
├── components/             # Reusable components
├── hooks/                  # Custom React hooks
├── lib/                    # Utilities and helpers
└── public/                 # Static assets
```

### Web3 Integration

Example of connecting to contracts:

```typescript
import { ethers } from 'ethers';

// Get provider
const provider = new ethers.BrowserProvider(window.ethereum);

// Get signer
const signer = await provider.getSigner();

// Connect to contract
const contract = new ethers.Contract(
  contractAddress,
  contractABI,
  signer
);

// Call contract method
const tx = await contract.someMethod();
await tx.wait();
```

### Styling

Use Tailwind CSS utility classes:

```tsx
<div className="bg-gradient-to-br from-blue-900 to-indigo-900">
  <h1 className="text-4xl font-bold text-white">Title</h1>
</div>
```

## Agent Development

Agents are autonomous services that perform specific tasks.

### Agent Structure

```javascript
// agent-name/index.js

class Agent {
  constructor(config) {
    this.config = config;
  }

  async start() {
    console.log('Agent starting...');
    // Initialization logic
  }

  async execute() {
    // Main agent logic
  }

  async stop() {
    console.log('Agent stopping...');
    // Cleanup logic
  }
}

module.exports = Agent;
```

### Risk Agent Example

The risk agent analyzes transaction risks:

```javascript
class RiskAgent {
  async assessTransaction(tx) {
    const risk = this.calculateRisk(tx);
    
    if (risk > THRESHOLD) {
      await this.flagTransaction(tx);
    }
    
    return risk;
  }

  calculateRisk(tx) {
    // Risk calculation logic
    return score;
  }
}
```

## Testing

### Unit Tests

Test individual functions and components:

```bash
pnpm test test/IdentityRegistry.test.ts
```

### Integration Tests

Test interactions between contracts:

```bash
pnpm test test/integration/
```

### Coverage

Generate coverage reports:

```bash
pnpm test:coverage
```

View coverage at `coverage/index.html`.

## Git Workflow

### Branching Strategy

- `main` - Production-ready code
- `develop` - Integration branch
- `feature/xyz` - Feature branches
- `fix/xyz` - Bug fix branches

### Commit Messages

Follow conventional commits:

```
feat: add new contract function
fix: resolve deployment issue
docs: update setup guide
test: add integration tests
refactor: optimize gas usage
```

### Pull Requests

1. Create feature branch
2. Make changes with tests
3. Update documentation
4. Submit PR with description
5. Address review comments
6. Merge after approval

## Code Quality

### Linting

Frontend linting:

```bash
cd frontend
pnpm lint
```

### Gas Optimization

Measure gas usage:

```bash
REPORT_GAS=true pnpm test
```

Optimization tips:
- Use `calldata` for read-only parameters
- Pack storage variables
- Use events instead of storage for logs
- Batch operations when possible

### Security

Run security checks:

```bash
pnpm hardhat check
```

Consider:
- Slither static analysis
- Mythril symbolic execution
- Manual code review
- External audits for mainnet

## Deployment Checklist

Before deploying to mainnet:

- [ ] All tests passing
- [ ] Gas optimization complete
- [ ] Security audit completed
- [ ] Documentation updated
- [ ] Frontend tested with contracts
- [ ] Deployment scripts verified
- [ ] Emergency procedures documented
- [ ] Monitoring set up

## Environment-Specific Config

### Local Development

```javascript
{
  network: 'localhost',
  chainId: 31337,
  url: 'http://127.0.0.1:8545'
}
```

### Testnet

```javascript
{
  network: 'sepolia',
  chainId: 11155111,
  url: process.env.SEPOLIA_RPC_URL
}
```

### Mainnet

```javascript
{
  network: 'mainnet',
  chainId: 1,
  url: process.env.MAINNET_RPC_URL
}
```

## Performance Optimization

### Contract Optimization

- Use `uint256` instead of smaller uints
- Group storage operations
- Use mappings over arrays
- Implement lazy evaluation
- Cache external calls

### Frontend Optimization

- Use React Server Components
- Implement code splitting
- Optimize images
- Use static generation when possible
- Minimize bundle size

## Monitoring

### Contract Events

Monitor contract events:

```typescript
contract.on('IdentityRegistered', (user, hash) => {
  console.log(`New identity: ${user}`);
});
```

### Error Handling

Implement proper error handling:

```typescript
try {
  const tx = await contract.method();
  await tx.wait();
} catch (error) {
  if (error.code === 'INSUFFICIENT_FUNDS') {
    // Handle insufficient funds
  }
}
```

## Resources

- [Hardhat Best Practices](https://hardhat.org/hardhat-runner/docs/guides/project-setup)
- [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html)
- [Next.js Best Practices](https://nextjs.org/docs/app/building-your-application)
- [Web3 Security Best Practices](https://consensys.github.io/smart-contract-best-practices/)

## Getting Help

- Review existing documentation
- Check test files for examples
- Open GitHub issues for bugs
- Join community discussions
- Consult with team members
