_ = require 'underscore'
GameRunner = require './GameRunner'

class GameController

    playGame: (player1, player2) ->
        @gameRunner = new GameRunner
        @game =
            board: @gameRunner.newGameBoard
            log: []
            winner: null
        @game.log.push "Game Started!"
        @game.log.push @game.board

        askPlayerMove player1, @game.board, @player1MoveCallback

    player1MoveCallback: (playerMove) =>
        unless validateInput playerMove
            @game.log.push "player1 invalid input! player2 wins"
            @game.winner = player2
            return @game
        @game.log.push "player1 move: #{playerMove}"
        newBoard = @gameRunner.playerTurn playerMove, '1', @game.board
        # if it is an invalidMove or there are no more valid moves
        unless newBoard

    validateInput: (input) ->
        return false unless Array.isArray input
        input.length is 2


module.exports = GameController