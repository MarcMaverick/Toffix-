// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    ---------------------------------------------------------
     TOFFIX ($TOFFIX)
     Fair Launch Utility Token on Base Chain
     1,000,000,000 Fixed Supply
     No Minting — No Taxes — No Hidden Functions
    ---------------------------------------------------------
*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Toffix is ERC20, Ownable {

    // Maximum supply: 1,000,000,000 TOFFIX
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 10**18;

    constructor(address treasury)
        ERC20("Toffix", "TOFFIX")
        Ownable(msg.sender)
    {
        require(treasury != address(0), "Treasury cannot be zero address");

        // Mint entire supply to treasury wallet
        _mint(treasury, MAX_SUPPLY);
    }
}
