// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
La dirección del contrato para intentar de hackearlo y mintearse el NFT sobre polygon es la siguiente:
0xb4F3532A95c8a01aB2ce4375c978dDFE2F160680
*/

contract HackOwnerShipAndMintNFT is ERC721, ERC721URIStorage, Ownable {

  uint256 public tokenId;
  string IPFS;

  constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
      IPFS="https://gateway.pinata.cloud/ipfs/QmX3RVDunTTFp4uToNv6hoHZ6EP4pShsrBhSVN6TdYBDwD?_gl=1*1ri81cf*_ga*MDkwZWQwZDgtOTgxNS00NWViLWFlMmUtZjMxMWQwYzBlMGZj*_ga_5RMPXG14TE*MTY3ODkwNzc3OC40LjAuMTY3ODkwNzgwNC4zNC4wLjA.";
  }

  function changeOwner(address _owner) public {
    uint256 len;
    assembly { len := extcodesize(caller()) }
    require(len == 0, "Usted es un contrato");
    if (tx.origin != msg.sender) {
      //owner = _owner;
      _transferOwnership(_owner);
    }
  }

  function changeIPFS(string calldata _IPFS) public onlyOwner {
      IPFS=_IPFS;
  }

    function safeMint() public onlyOwner
    {
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, IPFS);
        tokenId++;
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 _tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(_tokenId);
    }

    function tokenURI(uint256 _tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(_tokenId);
    }



}