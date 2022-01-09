require('dotenv').config({ path: '.env.local' })
require('@nomiclabs/hardhat-waffle')

module.exports = {
  solidity: '0.8.4',
  defaultNetwork: 'testnet',
  networks: {
    hardhat: {
      chainId: 4002,
      forking: {
        url: process.env.NETWORK_RPC,
        blockNumber: 24066833,
      }
    },
    mainnet: {
      url: 'https://rpc.ftm.tools/',
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    },
    testnet: {
      url: 'https://rpc.testnet.fantom.network/',
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    }
  }
}
