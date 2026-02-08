import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Open-eth Dashboard',
  description: 'Decentralized liquidity protocol with Uniswap v4, x402, and ERC-8004',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
