// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasketballPlayers {
    // Struct to represent a basketball player
    struct Player {
        string teamName;
        uint256 age;
        string position;
        string playerName;
        uint256 height;
        address creator;
    }

    // Array to store instances of basketball players
    Player[] public players;

    // Event to log the creation of a new player instance
    event PlayerCreated(string teamName, string playerName, address creator);

    // Function to create a new basketball player instance
    function createPlayer(
        string memory _teamName,
        uint256 _age,
        string memory _position,
        string memory _playerName,
        uint256 _height
    ) external {
        // Create a new player instance
        Player memory newPlayer = Player({
            teamName: _teamName,
            age: _age,
            position: _position,
            playerName: _playerName,
            height: _height,
            creator: msg.sender
        });

        // Add the player to the array
        players.push(newPlayer);

        // Emit an event to log the creation of a new player instance
        emit PlayerCreated(_teamName, _playerName, msg.sender);
    }

    // Function to get details of a specific player by index
    function getPlayerDetails(
        uint256 index
    )
        external
        view
        returns (
            string memory teamName,
            uint256 age,
            string memory position,
            string memory playerName,
            uint256 height,
            address creator
        )
    {
        require(index < players.length, "Player index out of bounds");

        Player storage player = players[index];
        return (
            player.teamName,
            player.age,
            player.position,
            player.playerName,
            player.height,
            player.creator
        );
    }
}
