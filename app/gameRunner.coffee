_ = require 'underscore'

class GameRunner

    clearGameBoard: () ->
        gameBoard = [
            new Array(6)
            new Array(6)
            new Array(6)
            new Array(6)
            new Array(6)
            new Array(6)
        ]
        gameBoard = JSON.parse JSON.stringify gameBoard

    makeMove: (move, identifier, boardState) ->
        newBoard = JSON.parse JSON.stringify boardState
        newBoard[move[0]][move[1]] = identifier
        newBoard

    validateMove: (move, boardState) ->
        for i in [0..2]
            for j in [0..2]
                unless (i is 1) and (j is 1)
                    testX = move[0]-1+i
                    testY = move[1]-1+j
                    if ((testX >= 0) and (testX <= 5)) and ((testY >= 0) and (testY <= 5))
                        return false if boardState[testX][testY]?
        return true

    playerTurn: (move, identifier, boardState) ->
        return false unless anyValidMove boardState
        return false unless validateMove boardState
        return makeMove move, identifier, boardState


module.exports = GameRunner

