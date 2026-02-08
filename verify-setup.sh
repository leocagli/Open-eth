#!/bin/bash

# Open-eth Environment Verification Script
# Run this script to verify the environment setup

set -e

echo "=========================================="
echo "Open-eth Environment Verification"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a directory exists
check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        return 1
    fi
}

# Function to check if a file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        return 1
    fi
}

# Check Node.js
echo "Checking Prerequisites:"
echo "----------------------"
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo -e "${GREEN}✓${NC} Node.js $NODE_VERSION"
else
    echo -e "${RED}✗${NC} Node.js not found"
fi

# Check pnpm
if command -v pnpm &> /dev/null; then
    PNPM_VERSION=$(pnpm -v)
    echo -e "${GREEN}✓${NC} pnpm $PNPM_VERSION"
else
    echo -e "${YELLOW}⚠${NC} pnpm not found - run: npm install -g pnpm"
fi

echo ""
echo "Checking Directory Structure:"
echo "----------------------------"
check_dir "agentpay-liquidity-ops"
check_dir "contracts"
check_dir "hooks"
check_dir "registries"
check_dir "registries/identity"
check_dir "registries/reputation"
check_dir "agents"
check_dir "risk-agent"
check_dir "router-agent"
check_dir "gateway-x402"
check_dir "frontend"
check_dir "scripts"
check_dir "scripts/deploy"
check_dir "test"

echo ""
echo "Checking Configuration Files:"
echo "-----------------------------"
check_file "package.json"
check_file "pnpm-workspace.yaml"
check_file "hardhat.config.ts"
check_file "tsconfig.json"
check_file ".gitignore"
check_file ".env.example"

echo ""
echo "Checking Smart Contracts:"
echo "------------------------"
check_file "contracts/IdentityRegistry.sol"
check_file "contracts/ReputationRegistry.sol"
check_file "hooks/OpenEthHook.sol"

echo ""
echo "Checking Deployment Scripts:"
echo "---------------------------"
check_file "scripts/deploy/001_deploy_identity_registry.ts"
check_file "scripts/deploy/002_deploy_reputation_registry.ts"

echo ""
echo "Checking Tests:"
echo "--------------"
check_file "test/IdentityRegistry.test.ts"
check_file "test/ReputationRegistry.test.ts"

echo ""
echo "Checking Frontend:"
echo "-----------------"
check_file "frontend/package.json"
check_file "frontend/tsconfig.json"
check_file "frontend/next.config.js"
check_file "frontend/app/page.tsx"
check_file "frontend/app/layout.tsx"

echo ""
echo "Checking Documentation:"
echo "----------------------"
check_file "README.md"
check_file "SETUP.md"
check_file "DEVELOPMENT.md"
check_file "CONTRIBUTING.md"
check_file "ENVIRONMENT_SETUP.md"

echo ""
echo "Checking Dependencies:"
echo "---------------------"
if [ -d "node_modules" ]; then
    echo -e "${GREEN}✓${NC} node_modules installed"
    
    # Check for key dependencies
    if [ -d "node_modules/hardhat" ]; then
        echo -e "${GREEN}✓${NC} Hardhat installed"
    fi
    
    if [ -d "node_modules/ethers" ]; then
        echo -e "${GREEN}✓${NC} Ethers.js installed"
    fi
    
    if [ -d "node_modules/@openzeppelin" ]; then
        echo -e "${GREEN}✓${NC} OpenZeppelin contracts installed"
    fi
    
    if [ -d "node_modules/@uniswap" ]; then
        echo -e "${GREEN}✓${NC} Uniswap v4 installed"
    fi
else
    echo -e "${YELLOW}⚠${NC} node_modules not found - run: pnpm install"
fi

echo ""
echo "=========================================="
echo -e "${GREEN}Verification Complete!${NC}"
echo "=========================================="
echo ""
echo "Next Steps:"
echo "----------"
echo "1. If pnpm is not installed: npm install -g pnpm"
echo "2. If dependencies are missing: pnpm install"
echo "3. Compile contracts: pnpm hardhat compile"
echo "4. Start local node: pnpm hardhat node"
echo "5. Deploy contracts: pnpm hardhat deploy"
echo "6. Start frontend: pnpm dev"
echo ""
echo "For detailed instructions, see SETUP.md"
echo ""
