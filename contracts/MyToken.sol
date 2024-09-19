// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    uint256 public maxSupply = 1000000 * 10 ** decimals(); // Total max supply: 1M tokens

    constructor(address[] memory initialAccounts) ERC20("VerySpecificToken", "VST") Ownable(msg.sender) {
        uint256 initialSupply = 100000 * 10 ** decimals(); // Mint 100k tokens per address
        for (uint256 i = 0; i < initialAccounts.length; i++) {
            _mint(initialAccounts[i], initialSupply);
        }
    }

    // Function to mint more tokens
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= maxSupply, "Minting exceeds max supply");
        _mint(to, amount);
    }
}
