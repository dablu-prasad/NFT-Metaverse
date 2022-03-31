// contracts/NFT.sol
// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

import "hardhat/console.sol";



contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractAddress;

    function calcFingerPrint() public view returns(bytes4)
    {
        return bytes4(keccak256('supportsInterface(bytes4)'));
    }

    mapping(bytes4=>bool) private _supportedInterface;

    // function supportsInterface1(bytes4 interfaceId) public  view returns (bool)
    // {
    //     return _supportedInterface[interfaceId];
    // }

 function _registerInterface(bytes4 interfaceId) public
 {
     require(interfaceId !=0xffffffff,'ERC165: Invalid Interface!');
     _supportedInterface[interfaceId]=true;
 }
    constructor(address marketplaceAddress) ERC721("Dablu Prasad","DP") {
        contractAddress = marketplaceAddress;
    }

    function createToken(string memory tokenURI) public returns (uint) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }
}