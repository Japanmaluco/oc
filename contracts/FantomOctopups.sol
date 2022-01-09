// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract FatNFT is ERC721, ERC721Enumerable, Ownable {
  using Counters for Counters.Counter;

  Counters.Counter private _idCounter;

  address payable public depositAddress = payable(0x1bE1b5B3ae3504724Ba947C7b42d82F1b83eAED0);
  uint256 public maxMintable = 100;

  constructor() ERC721("FatNFT", "FAT") {}

  function _baseURI() internal pure override returns (string memory) {
    return "https://fantomoctopups.com/api/octopup/";
  }

  function setDepositAddress(address payable to) public onlyOwner {
    depositAddress = to;
  }

  function reserve(uint256 quantity) public onlyOwner {
    uint256 id = _idCounter.current();

    require(id < maxMintable, "All phantom have been minted!");

    for (uint256 i = 0; i < quantity; i++) {
      require(_idCounter.current() < maxMintable, "All phantom have been minted!");

      _safeMint(msg.sender, _idCounter.current());
      _idCounter.increment();
    }
  }

  function claim(uint256 quantity) public payable {
    uint256 id = _idCounter.current();
    uint256 price = 1.5 ether * quantity;

    require(msg.value >= price, "Invalid amount!");
    require(id < maxMintable, "All phantom have been minted!");

    depositAddress.transfer(price);
    
    for (uint256 i = 0; i < quantity; i++) {
      require(_idCounter.current() < maxMintable, "All phantom have been minted!");

      _safeMint(msg.sender, _idCounter.current());
      _idCounter.increment();
    }
  }

  function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
    return super.supportsInterface(interfaceId);
  }
}
