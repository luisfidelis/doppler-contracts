// --- Contracts
let Doppler = artifacts.require("./Doppler.sol");

module.exports = function(deployer, network, accounts) {
  if(network.indexOf('test') > -1) return;
  deployer.deploy(Doppler)
};
