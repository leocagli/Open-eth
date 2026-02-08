#!/bin/bash

# Open-eth Quick Setup Script
# This script automates the initial setup process

set -e

echo "==================================="
echo "Open-eth Environment Setup"
echo "==================================="
echo ""

# Check for Node.js
echo "Checking prerequisites..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js >= 18.0.0"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version must be >= 18.0.0. Current version: $(node -v)"
    exit 1
fi

echo "✓ Node.js $(node -v) detected"

# Check for pnpm
if ! command -v pnpm &> /dev/null; then
    echo "pnpm is not installed. Installing pnpm..."
    npm install -g pnpm
fi

echo "✓ pnpm $(pnpm -v) detected"
echo ""

# Install dependencies
echo "Installing dependencies..."
pnpm install

echo ""
echo "==================================="
echo "Setup Complete!"
echo "==================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Compile contracts:"
echo "   pnpm hardhat compile"
echo ""
echo "2. Start local node (in a new terminal):"
echo "   pnpm hardhat node"
echo ""
echo "3. Deploy contracts (in another terminal):"
echo "   pnpm hardhat deploy"
echo ""
echo "4. Start frontend:"
echo "   pnpm dev"
echo ""
echo "For detailed instructions, see SETUP.md"
echo ""
