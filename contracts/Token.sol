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
    constructor (address _owner, uint256 _supply) ERC20("RewardsToken", "RT") {
        // Maybe the minting shouldn't be so naive. And define maximum supply and others before the constructor.
        // The rewards calculation has to be done here?

        _mint(_owner, _supply);
    }

    address[] internal stakeholders;
// Check for "is in" built-in function
    function isStakeholder(address _address) public view returns(bool, uint256) {
        for (uint256 s=0; s < stakeholders.length; s+=1) {
            if (_address == stakeholders[s]) return (true, s);
        }
        return (false, 0);
    }

// We could improve this function.
    function addStakeholder (address _stakeholder) public {
        (bool _isStakeholder, ) = isStakeholder(_stakeholder);
        if(!_isStakeholder) {
            stakeholders.push(_stakeholder);
        }
    }

    function removeStakeholder (address _stakeholder) public {
        (bool _isStakeholder, uint256 s) = isStakeholder(_stakeholder);
        if(_isStakeholder){
            // Take a look at what are we doing here
            stakeholders[s] = stakeholders[stakeholders.length - 1];

            stakeholders.pop();
        }
    }

    // Stakes
    mapping(address => uint256) internal stakes;
    // Debugg this shieeeet
    function stakeOf (address _stakeholder) public view returns(uint256) {
        // We should add some requires here.
        return(stakes[_stakeholder]);
    }

    function totalStakes() public view returns(uint256){
        uint256 _totalStake = 0;
        for (uint256 s = 0; s < stakeholders.length; s +=1) {
            _totalStake += stakes[stakeholders[s]];
        }
        return _totalStake;
    }

    // Give capabilities to add or remove stake.

    function addStake(uint256 _stake) public {
        // Look closely what _burn does
        _burn(msg.sender, _stake);
        if(stakes[msg.sender] == 0) addStakeholder(msg.sender);
        // Would += work here? Nope. That's why we are using safemath
        stakes[msg.sender] = stakes[msg.sender] + _stake; 
    }
    // Maybe we should check the max _stake amount here.
    function removeStake (uint256 _stake) public {
        stakes[msg.sender] = stakes[msg.sender] - _stake;
        // Look closely here
        if (stakes[msg.sender] == 0) {
            removeStakeholder(msg.sender);
        }
        _mint(msg.sender, _stake);
    }

    // Rewards
}