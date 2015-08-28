_ = require 'underscore'
GameRunner = require './gameRunner'
prompt = require 'prompt'

class GameController

    playGame: (player1, player2) ->
        prompt.start()
        @gameRunner = new GameRunner
        @game =
            board: @gameRunner.newGameBoard()
            log: []
            winner: null
            player1: player1
            player2: player2
        @game.log.push "Game Started!"
        @game.log.push @game.board
        @askPlayerMove @game.player1, @game.board, @player1MoveCallback

    player1MoveCallback: (playerMove) =>
        unless @validateInput playerMove
            @game.log.push "player1 invalid input! player2 wins"
            @game.winner = 'player2'
            return @finishGame @game
        @game.log.push "player1 move: #{playerMove}"
        turnResult = @gameRunner.playerTurn playerMove, '1', @game.board
        if turnResult.msg is 'Invalid move.'
            @game.log.push "player 1 invalid move! player2 wins"
            @game.winner = 'player2'
            return @finishGame @game
        @game.board = turnResult.board
        @game.log.push "board after move:"
        @game.log.push @game.board
        if turnResult.msg is 'No more valid moves.'
            @game.log.push "No more valid moves, player 1 wins!"
            @game.winner = 'player1'
            return @finishGame @game
        @askPlayerMove @game.player2, @game.board, @player2MoveCallback

    player2MoveCallback: (playerMove) =>
        unless @validateInput playerMove
            @game.log.push "player2 invalid input! player1 wins"
            @game.winner = 'player1'
            return @finishGame @game
        @game.log.push "player2 move: #{playerMove}"
        turnResult = @gameRunner.playerTurn playerMove, '2', @game.board
        if turnResult.msg is 'Invalid move.'
            @game.log.push "player 2 invalid move! player1 wins"
            @game.winner = 'player1'
            return @finishGame @game
        @game.board = turnResult.board
        @game.log.push "board after move:"
        @game.log.push @game.board
        if turnResult.msg is 'No more valid moves.'
            @game.log.push "No more valid moves, player 2 wins!"
            @game.winner = 'player2'
            return @finishGame @game
        @askPlayerMove @game.player1, @game.board, @player1MoveCallback

    askPlayerMove: (player, board, callback) ->
        console.log "#{player.name} move! The board looks like this:"
        console.log board
        prompt.get ['x', 'y'], (err, result) ->
            callback [result.y, result.x]

    finishGame: (game) ->
        console.log game.log

    validateInput: (input) ->
        return false unless Array.isArray input
        input.length is 2


module.exports = GameController