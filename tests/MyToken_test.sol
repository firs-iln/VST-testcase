// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol"; // Import Remix testing framework
import "../contracts/MyToken.sol"; // Path to your token contract

contract MyTokenTest {
    MyToken token;
    address[] accounts;

    // Before running tests, deploy the token contract
    function beforeAll() public {
        accounts = [address(0x123), address(0x456)];
        token = new MyToken(accounts);
    }

    // Test initial balances
    function testInitialBalances() public {
        Assert.equal(token.balanceOf(address(0x123)), 100000 * 10 ** token.decimals(), "Initial balance should be 100k for account 1");
        Assert.equal(token.balanceOf(address(0x456)), 100000 * 10 ** token.decimals(), "Initial balance should be 100k for account 2");
    }

    // Test minting functionality
    function testMinting() public {
        token.mint(address(0x123), 100000 * 10 ** token.decimals()); // Mint additional tokens
        Assert.equal(token.totalSupply(), 300000 * 10 ** token.decimals(), "Total supply should be 300k after minting");
    }

    // Test total supply limit
    function testSupplyLimit() public {
        bool r;
        (r, ) = address(token).call(abi.encodeWithSignature("mint(address,uint256)", address(0x123), 800000 * 10 ** token.decimals()));
        Assert.equal(r, false, "Minting should fail due to supply limit");
    }
}
