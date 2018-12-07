var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "";

module.exports = {
  networks: {
    ganache: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
      gas: 4600000
    },
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      gas: 4600000
    },
    rinkeby: {
      provider: function () {
        return new HDWalletProvider(mnemonic, 'https://rinkeby.infura.io/v3/d46d0f948caa4977a97cdd2dbfce3228')
      },
      network_id: '4',
      gas: 4500000,
      gasPrice: 10000000000,
    },
    mainnet: {
      provider: function () {
        return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/v3/d46d0f948caa4977a97cdd2dbfce3228')
      },
      network_id: '1',
      gas: 4500000
    }
  }
};
