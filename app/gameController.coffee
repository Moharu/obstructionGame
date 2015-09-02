_ = require 'underscore'
GameRunner = require './gameRunner'
prompt = require 'prompt'

class GameController

    playGame: (player1, player2, size, @gameCallback) ->
        prompt.start()
        @gameRunner = new GameRunner
        @game =
            board: @gameRunner.newGameBoard(size)
            log: []
            winner: null
            player1: player1
            player2: player2
        @game.log.push "Game Started!"
        @game.log.push @game.board
        @askPlayerMove @game.player1, @game.board, @player1MoveCallback

    player1MoveCallback: (playerMove) =>
        unless @validateInput playerMove
            @game.log.push "#{@game.player1.name} invalid input! #{@game.player2.name} wins"
            @game.winner = "#{@game.player2.name}"
            return @finishGame @game
        @game.log.push "#{@game.player1.name} move: #{playerMove[1]}, #{playerMove[0]}"
        turnResult = @gameRunner.playerTurn playerMove, @game.player1.id, @game.board
        if turnResult.msg is 'Invalid move.'
            @game.log.push "#{@game.player1.name} invalid move! #{@game.player2.name} wins"
            @game.winner = "#{@game.player2.name}"
            return @finishGame @game
        @game.board = turnResult.board
        @game.log.push "board after move:"
        @game.log.push @game.board
        if turnResult.msg is 'No more valid moves.'
            @game.log.push "No more valid moves, #{@game.player1.name} wins!"
            @game.winner = "#{@game.player1.name}"
            return @finishGame @game
        @askPlayerMove @game.player2, @game.board, @player2MoveCallback

    player2MoveCallback: (playerMove) =>
        unless @validateInput playerMove
            @game.log.push "#{@game.player2.name} invalid input! #{@game.player1.name} wins"
            @game.winner = "#{@game.player1.name}"
            return @finishGame @game
        @game.log.push "#{@game.player2.name} move: #{playerMove[1]}, #{playerMove[0]}"
        turnResult = @gameRunner.playerTurn playerMove, @game.player2.id, @game.board
        if turnResult.msg is 'Invalid move.'
            @game.log.push "#{@game.player2.name} invalid move! #{@game.player1.name} wins"
            @game.winner = "#{@game.player1.name}"
            return @finishGame @game
        @game.board = turnResult.board
        @game.log.push "board after move:"
        @game.log.push @game.board
        if turnResult.msg is 'No more valid moves.'
            @game.log.push "No more valid moves, #{@game.player2.name} wins!"
            @game.winner = "#{@game.player2.name}"
            return @finishGame @game
        @askPlayerMove @game.player1, @game.board, @player1MoveCallback

    askPlayerMove: (player, board, callback) ->

        player.client.post '/obstruction', board, (err, req, res, obj) ->
            return console.log err if err?
            res = JSON.parse res.body
            callback res

    finishGame: (game) ->
        console.log game.log
        final =
            winner: game.winner
            log: game.log
        @gameCallback final

    validateInput: (input) ->
        return false unless Array.isArray input
        input.length is 2

module.exports = GameController