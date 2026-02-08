# Contributing to Open-eth

Thank you for your interest in contributing to Open-eth! This document provides guidelines and instructions for contributing.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## How to Contribute

### Reporting Issues

If you find a bug or have a feature request:

1. Check if the issue already exists in GitHub Issues
2. If not, create a new issue with:
   - Clear, descriptive title
   - Detailed description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Environment details (Node version, OS, etc.)

### Suggesting Enhancements

We welcome suggestions for new features:

1. Open an issue with tag `enhancement`
2. Describe the feature and its benefits
3. Explain how it would work
4. Provide examples if applicable

### Pull Requests

#### Before Starting

1. Check existing issues and PRs
2. Comment on the issue you want to work on
3. Fork the repository
4. Create a feature branch

#### Development Process

1. **Setup your environment**
   ```bash
   git clone https://github.com/YOUR-USERNAME/Open-eth.git
   cd Open-eth
   pnpm install
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Write clean, documented code
   - Follow existing code style
   - Add tests for new features
   - Update documentation

4. **Test your changes**
   ```bash
   pnpm test
   pnpm hardhat compile
   pnpm dev  # Test frontend
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

   Follow [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation only
   - `style:` - Code style changes
   - `refactor:` - Code refactoring
   - `test:` - Adding tests
   - `chore:` - Maintenance tasks

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Fill in the PR template
   - Link related issues

#### PR Requirements

Your PR should:

- [ ] Pass all tests
- [ ] Include tests for new features
- [ ] Update relevant documentation
- [ ] Follow code style guidelines
- [ ] Have clear commit messages
- [ ] Include a clear description
- [ ] Reference related issues

#### PR Review Process

1. Automated checks run (tests, linting)
2. Maintainers review the code
3. Address feedback and make changes
4. Once approved, PR will be merged

## Development Guidelines

### Smart Contracts

- Use Solidity 0.8.24
- Follow OpenZeppelin patterns
- Write comprehensive tests
- Document all functions
- Consider gas optimization
- Implement security best practices

Example:

```solidity
/**
 * @dev Register a new identity
 * @param _identityHash The hash of the identity data
 */
function registerIdentity(bytes32 _identityHash) external {
    require(!identities[msg.sender].isActive, "Identity already registered");
    // Implementation
}
```

### JavaScript/TypeScript

- Use TypeScript for type safety
- Follow ESLint rules
- Write unit tests
- Document complex logic
- Use meaningful variable names

Example:

```typescript
/**
 * Deploy a contract to the network
 * @param contractName - Name of the contract to deploy
 * @returns Deployed contract instance
 */
async function deployContract(contractName: string): Promise<Contract> {
  // Implementation
}
```

### React/Next.js

- Use functional components
- Implement proper error handling
- Follow React best practices
- Use TypeScript
- Write accessible code

Example:

```tsx
interface Props {
  title: string;
  description: string;
}

export function Card({ title, description }: Props) {
  return (
    <div className="card">
      <h2>{title}</h2>
      <p>{description}</p>
    </div>
  );
}
```

### Testing

- Write tests for all new features
- Maintain test coverage above 80%
- Test edge cases
- Test error conditions

Example:

```typescript
describe("IdentityRegistry", () => {
  it("should register a new identity", async () => {
    const hash = ethers.keccak256(ethers.toUtf8Bytes("test"));
    await expect(registry.registerIdentity(hash))
      .to.emit(registry, "IdentityRegistered");
  });
});
```

## Project Structure

Understanding the structure helps you contribute effectively:

```
Open-eth/
├── contracts/           # Smart contracts
├── test/               # Contract tests
├── scripts/deploy/     # Deployment scripts
├── frontend/           # Next.js application
├── agents/             # Autonomous agents
├── hooks/              # Uniswap v4 hooks
└── registries/         # Registry modules
```

## Testing

### Running Tests

```bash
# All tests
pnpm test

# Specific test file
pnpm hardhat test test/IdentityRegistry.test.ts

# With gas reporting
REPORT_GAS=true pnpm test

# With coverage
pnpm test:coverage
```

### Writing Tests

Place tests in the `test/` directory with `.test.ts` extension.

## Documentation

### Code Documentation

- Document all public functions
- Use JSDoc/NatSpec format
- Explain complex algorithms
- Include usage examples

### User Documentation

Update relevant docs when adding features:

- README.md - Project overview
- SETUP.md - Setup instructions
- DEVELOPMENT.md - Development guide
- API documentation

## Security

### Reporting Security Issues

**DO NOT** open public issues for security vulnerabilities.

Instead:
1. Email security@open-eth.example (if available)
2. Include detailed description
3. Provide steps to reproduce
4. Wait for response before public disclosure

### Security Best Practices

- Never commit secrets or private keys
- Use environment variables for sensitive data
- Follow smart contract security guidelines
- Run security analysis tools
- Request security reviews for critical changes

## Code Review

### As an Author

- Keep PRs focused and small
- Respond to feedback promptly
- Be open to suggestions
- Update based on comments
- Test thoroughly before submitting

### As a Reviewer

- Be constructive and respectful
- Explain reasoning for suggestions
- Acknowledge good work
- Test the changes
- Approve when satisfied

## Release Process

1. Version bump in package.json
2. Update CHANGELOG.md
3. Create release tag
4. Deploy to testnet
5. Run integration tests
6. Deploy to mainnet
7. Announce release

## Community

### Communication Channels

- GitHub Issues - Bug reports, feature requests
- GitHub Discussions - General discussions
- Pull Requests - Code contributions

### Getting Help

- Check existing documentation
- Search closed issues
- Ask in GitHub Discussions
- Contact maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Credited in relevant documentation

## Questions?

If you have questions about contributing:

1. Check this guide
2. Read other documentation
3. Search existing issues
4. Open a new issue with tag `question`

Thank you for contributing to Open-eth! 🚀
