// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
/*
Axie infinity
but
instead of furballs
We do
Slimes
and body parts will be
eyes(determines element)
Headwear(can be hat or angel halo or etc)
weapons(determines atk value)
offhand(shield etc additional stats like defense increase or more attack
And wing variant(if any) determines speed boost
or initiative in fights
AND
Facial Expression!(temperament or how the skills scale when leveled up)




*/

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.2/contracts/token/ERC721/ERC721.sol";

contract SlimyNFT is ERC721{
    using Address for address;
    using Strings for uint256;
    constructor() ERC721("SlimyNFT","SNFT"){
        
        
        
    }
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    address private seedaddress = 0x49a1d95168AedC1A0Fd0395fB3f90D2E79b54429;
    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;
   
    mapping(uint256 => uint) private _metadata;
    
    function random() public view returns(uint){
        
        uint stats = 0;
        stats = uint(keccak256(abi.encodePacked(blockhash(block.number), block.timestamp, msg.sender, seedaddress)));
        stats = stats % 100000000;
        return stats;
    }
    
    function determinestats(uint256 tokenID) public view returns(string[] memory){
        uint statnumber = _metadata[tokenID];
        uint slimerank = statnumber % 100;
        string memory slimerankstring = "";
        string[] memory slimestatarray = new string[](4);
        if(slimerank == 0)
        {
            slimerankstring = "Rank 3";
        }
        else if(slimerank>66)
        {
            slimerankstring = "Rank 2";
        }
        else
        {
            slimerankstring = "Rank 1";
        }
        slimestatarray[0] = slimerankstring;
        statnumber = statnumber / 100;
        slimerank = statnumber%100;
        if(slimerank < 10)
        {
            slimerankstring = "Darkness Eyes";
        }
        else if(slimerank < 20)
        {
            slimerankstring = "LightDawn Eyes";
        }
        else if(slimerank < 40)
        {
            slimerankstring = "Blaze Eyes";
        }
        else if(slimerank < 60)
        {
            slimerankstring = "SeaDepth Eyes";
        }
        else if(slimerank < 80)
        {
            slimerankstring = "CloudSmite Eyes";
        }
        else if(slimerank < 100)
        {
            slimerankstring = "NatureGrasp Eyes";
        }
        
        slimestatarray[1] = slimerankstring;
        
        return slimestatarray;
        
    }
    
    
    
    function _checkOnERC721ReceivedSlimy(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data) returns (bytes4 retval) {
                return retval == IERC721Receiver(to).onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("ERC721: transfer to non ERC721Receiver implementer");
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    }
    
    
    
    function publicminttestslimy(address to, uint256 tokenId) public
    {
        _safeMintSlimy(to,tokenId);
    }
    
    
    function _safeMintSlimy(address to, uint256 tokenId) internal virtual {
        uint tokenData = random();
        _safeMintSlimy(to, tokenId, tokenData, "");
    }
    
    function _safeMintSlimy(
        address to,
        uint256 tokenId,
        uint tokenData,
        bytes memory _data
    ) internal virtual {
        _mintSlimy(to, tokenId, tokenData);
        require(
            _checkOnERC721ReceivedSlimy(address(0), to, tokenId, _data),
            "ERC721: transfer to non ERC721Receiver implementer"
        );
    }
    
    
    function _mintSlimy(address to, uint256 tokenId, uint tokenData) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _beforeTokenTransfer(address(0), to, tokenId);
        _metadata[tokenId] = tokenData;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }
    
}