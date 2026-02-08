/**
 * Gateway x402
 * 
 * HTTP 402 Payment Required middleware for the Open-eth ecosystem.
 */

const express = require('express');
const app = express();
const PORT = process.env.PORT || 3402;

app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'gateway-x402' });
});

app.listen(PORT, () => {
  console.log(`Gateway x402 listening on port ${PORT}`);
});

module.exports = app;
