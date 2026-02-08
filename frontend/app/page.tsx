export default function Home() {
  return (
    <main className="min-h-screen bg-gradient-to-br from-blue-900 via-purple-900 to-indigo-900">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-16">
          <h1 className="text-6xl font-bold text-white mb-4">
            Open-eth
          </h1>
          <p className="text-xl text-gray-300">
            Decentralized Liquidity Protocol
          </p>
          <p className="text-md text-gray-400 mt-2">
            Powered by Uniswap v4, x402, and ERC-8004
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
          <div className="bg-white bg-opacity-10 backdrop-blur-lg rounded-xl p-8 border border-white border-opacity-20">
            <h2 className="text-2xl font-bold text-white mb-4">Identity Registry</h2>
            <p className="text-gray-300 mb-4">
              Secure identity management for the Open-eth ecosystem
            </p>
            <div className="text-sm text-gray-400">
              Status: <span className="text-green-400">Deployed</span>
            </div>
          </div>

          <div className="bg-white bg-opacity-10 backdrop-blur-lg rounded-xl p-8 border border-white border-opacity-20">
            <h2 className="text-2xl font-bold text-white mb-4">Reputation System</h2>
            <p className="text-gray-300 mb-4">
              Track and manage user reputation scores
            </p>
            <div className="text-sm text-gray-400">
              Status: <span className="text-green-400">Deployed</span>
            </div>
          </div>

          <div className="bg-white bg-opacity-10 backdrop-blur-lg rounded-xl p-8 border border-white border-opacity-20">
            <h2 className="text-2xl font-bold text-white mb-4">Uniswap v4 Hooks</h2>
            <p className="text-gray-300 mb-4">
              Custom hooks for liquidity operations
            </p>
            <div className="text-sm text-gray-400">
              Status: <span className="text-green-400">Ready</span>
            </div>
          </div>
        </div>

        <div className="mt-16 text-center">
          <div className="bg-white bg-opacity-10 backdrop-blur-lg rounded-xl p-8 border border-white border-opacity-20 max-w-4xl mx-auto">
            <h3 className="text-2xl font-bold text-white mb-4">Features</h3>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-left">
              <div className="text-gray-300">
                <strong className="text-white">✓</strong> Automated liquidity operations
              </div>
              <div className="text-gray-300">
                <strong className="text-white">✓</strong> Risk management agents
              </div>
              <div className="text-gray-300">
                <strong className="text-white">✓</strong> HTTP 402 gateway integration
              </div>
              <div className="text-gray-300">
                <strong className="text-white">✓</strong> ERC-8004 compatibility
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  )
}
