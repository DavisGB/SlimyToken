// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.2/contracts/token/ERC20/ERC20.sol";

contract SlimyToken is ERC20 {
    constructor() ERC20("SlimyToken","SLT") {
        
        _mint(msg.sender, 1000000 * 10**18);
    }
    
    
    
}