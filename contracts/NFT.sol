// SPDX-License-Identifier: MIT

pragma solidity^0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721Enumerable, Ownable {
    /*
    


    */
    uint256 public maxTokenSupply = 20;

    uint256 public price = 0.01 ether;

    string _baseTokenURI;

    uint256 public tokenIds;




    constructor (string memory baseURI) ERC721("NotFunnyTokens", "NET") {
        _baseTokenURI = baseURI;
    }

    function mint() public payable {
        require(msg.value >= price, "Pay more");
        require(tokenIds < maxTokenSupply, "All the NFTs already minted");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{ value: amount }("");
        require(sent, "Failed to send the money");

    }

    receive() external payable {}

    fallback() external payable {}


}