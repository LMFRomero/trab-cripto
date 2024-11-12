// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrypTwitter {
    struct Post {
        uint256 id;         // id do post
        address user;       // address do usuario que criou
        uint256 timestamp;  // timestamp que o post foi criado
        string content;     // conteudo do post
        uint256 likes;      // numero de likes que o post recebeu
    }

    Post[] public posts;
    uint256[] public likes;

    mapping (address => uint[]) public postsToAccountMap; // mapping que relaciona os posts ao seu usuario criador
    mapping (address => uint[]) public likesToAccountMap; // mapping que relaciona um usuario aos seus likes, para evitar likes duplicados

    // verifica se o id do post existe para nao dar erros na operacao
    modifier postExists(uint256 postId) {
        require(postId < posts.length);

        _;
    }

    // cria posts com um conteudo
    function createPost(string memory _content) external {
        require(bytes(_content).length <= 240, "Content exceeds 240 characters");

        uint256 postId = posts.length;
        uint256 timestamp = block.timestamp;

        posts.push(Post(postId, msg.sender, timestamp, _content, 0));
    }

    // verifica se um int esta dentro de um array de ints
    function isInArray(uint256 value, uint256[] memory array) private pure returns(bool) {
        for (uint i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return true;
            }
        }

        return false;
    }

    // adiciona um like em um post
    function likePost(uint256 postId) external postExists(postId) {
        if (isInArray(postId, likesToAccountMap[msg.sender]) == true) return;

        posts[postId].likes += 1;
        likesToAccountMap[msg.sender].push(postId);
    }

    function getFeed(uint256 offset, uint256 maxInPage) external view returns(Post[] memory){
        if (posts.length == 0) {
            Post[] memory emptyArray;

            return emptyArray;
        }

        require(offset < posts.length, "offset not in posts");

        uint256 start = posts.length-1-offset;
        uint256 sizeOfArray = maxInPage;

        if (start+1 < maxInPage) {
            sizeOfArray = start+1;
        }

        Post[] memory postsToReturn = new Post[](sizeOfArray);
        
        for (uint i = 0; i < maxInPage; i++) {
            postsToReturn[i] = posts[start-i];

            if (start-i <= 0) {
                return postsToReturn;
            }
        }

        return postsToReturn;
    }
}
