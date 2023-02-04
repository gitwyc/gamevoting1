// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "./Game.sol";

contract GameFactory {
    
    event GameStarted(IERC20 token, uint256 deposit, uint256 number, uint256 numberOfUsers, address owner);

    mapping(address => address) games;

    /// @notice creating new game
    /// @param _token IERC20 token for participate in game
    /// @param _deposit amount of deposit in _token for participate in game
    /// @param _number number which selected by owner of game
    /// @param _numberOfUsers maximum number of players should be equals ZERO if you don't need a limit
    function start(IERC20 _token, uint256 _deposit, uint256 _number, uint256 _numberOfUsers) public {
        address _msgSender = msg.sender;

        require(address(_token) != address(0), "Wrong token address");
        require(_deposit != 0, "Deposit shoul be more than ZERO");
        require (
            games[_msgSender] == address(0),
            "You can create just one game for one addreaa"
        );
        require(
            _number <= 100,
            "Your number should be less or equals to 100"
        );

        Game game = new Game(_token, _deposit, _numberOfUsers, _number);
        games[_msgSender] = address(game);
        _token.transferFrom(_msgSender, address(this), _deposit);

        emit GameStarted(_token, _deposit, _number, _numberOfUsers, _msgSender);
    }
}
