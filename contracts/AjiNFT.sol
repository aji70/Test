// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AjiNFT {
    string public name = 'Ajidokwu';
    string public symbol = 'AJI';
    uint8 public decimals = 18;
    

    uint256 private totalTokens = 1000;
    mapping(address => uint256) private balances;
    mapping(uint256 => address) public tokenOwners;
    mapping(address => mapping(address => bool)) private operators;

    event Transfer(address indexed from, address indexed to, uint256 tokenId);
    event Approval(address indexed owner, address indexed operator, uint256 tokenId);


    function totalSupply() public view returns (uint256) {
        return totalTokens;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return balances[owner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        return tokenOwners[tokenId];
    }

    function approve(address operator, uint256 tokenId) public {
        require(msg.sender == ownerOf(tokenId), "Not the owner of the token");
        operators[msg.sender][operator] = true;
        emit Approval(msg.sender, operator, tokenId);
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return operators[owner][operator];
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        require(from == msg.sender || isApprovedForAll(from, msg.sender), "Not approved to transfer");
        require(ownerOf(tokenId) == from, "Token not owned by sender");
        
        balances[from] -= 1;
        balances[to] += 1;
        tokenOwners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    function mint(address to, uint256 tokenId) public {
        require(balances[to] == 0, "Recipient already owns a token");
        require(tokenOwners[tokenId] == address(0), "Token already minted");

        balances[to] = 1;
        tokenOwners[tokenId] = to;
        totalTokens += 1;

        emit Transfer(address(0), to, tokenId);
    }

    function burn(uint256 tokenId) public {
    address owner = ownerOf(tokenId);
    require(owner == msg.sender || isApprovedForAll(owner, msg.sender), "Not approved to burn");
    
    balances[owner] -= 1;
    delete tokenOwners[tokenId];
    totalTokens -= 1;

    emit Transfer(owner, address(0), tokenId);
}
}
