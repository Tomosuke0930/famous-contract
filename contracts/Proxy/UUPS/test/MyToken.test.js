// test/MyToken.test.js

const { ethers, upgrades } = require("hardhat");

describe("MyToken", function () {
  it("deploys", async function () {
    const MyTokenV1 = await ethers.getContractFactory("MyTokenV1");

    /*
    In order to make this an upgradeable deployment, 
    we need to use the function "deployProxy" from the Upgrades plugin.
    */
    // await MyTokenV1.deploy();

    // Transparent Version
    await upgrades.deployProxy(MyTokenV1); // instead of MyTokenV1.deploy()

    // In order to use UUPS we have to manually specify so with the option kind: 'uups'.
    await upgrades.deployProxy(MyTokenV1, { kind: "uups" });

    // this is upgrade to V2
    await upgrades.upgradeProxy(proxyAddress, MyTokenV2);
  });
});
