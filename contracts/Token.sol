// SPDX-License-Identifier: MIT

pragma solidity^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/*
As first step create a no-frills ERC20 token called RewardsToken.
Use it to give users rewords for staking there NFT’s in the Protocol.
U can use oppenzeppelin or others implementations for the ERC20 token.
Minting and rewords given for the stking is up to you.
*/

contract Token is ERC20 {
    constructor () ERC20("RewardsToken", "RT") {
        // Maybe the minting shouldn't be so naive.
        // The rewards calculation has to be done here?
        _mint(address(this), 1000000 * 10**18);
    }
}