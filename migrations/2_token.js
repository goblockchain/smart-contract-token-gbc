var GBCERC20 = artifacts.require("./token/GBCERC20.sol");

module.exports = function(deployer, accounts) {
  console.info(accounts[0]);
  deployer.deploy(GBCERC20);
};
