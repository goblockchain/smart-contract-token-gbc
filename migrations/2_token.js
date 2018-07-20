var GBCERC20 = artifacts.require("./token/GBCERC20.sol");

module.exports = function(deployer) {
  deployer.deploy(GBCERC20);
};
