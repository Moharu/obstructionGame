_ = require 'underscore'

class GameRunner

    newGameBoard: () ->
        gameBoard = [
            ['-','-','-','-','-','-']
            ['-','-','-','-','-','-']
            ['-','-','-','-','-','-']
            ['-','-','-','-','-','-']
            ['-','-','-','-','-','-']
            ['-','-','-','-','-','-']
        ]
        gameBoard = JSON.parse JSON.stringify gameBoard

    makeMove: (move, identifier, boardState) ->
        newBoard = JSON.parse JSON.stringify boardState
        newBoard[move[0]][move[1]] = identifier
        newBoard

    validateMove: (move, boardState) ->
        return false if boardState[move[0]][move[1]] isnt '-'
        for i in [0..2]
            for j in [0..2]
                unless (i is 1) and (j is 1)
                    testX = move[0]-1+i
                    testY = move[1]-1+j
                    if ((testX >= 0) and (testX <= 5)) and ((testY >= 0) and (testY <= 5))
                        return false if boardState[testX][testY] isnt '-'
        return true

    playerTurn: (move, identifier, gameBoard) ->
        game =
            board: gameBoard
            msg: null
        unless @validateMove move, game.board
            game.msg = 'Invalid move.'
            return game
        game.board = @makeMove move, identifier, game.board
        game.msg = 'No more valid moves.' unless @anyValidMove game.board
        return game

    anyValidMove: (boardState) ->
        for i in [0..5]
            for j in [0..5]
                if boardState[i][j] is '-'
                    return true if @validateMove [i,j], boardState
        false

module.exports = GameRunner

