expect = require 'expect.js'
GameRunner = require '../app/gameRunner'

describe 'The Game Runner', ->

    initialBoard = null

    beforeEach ->
        initialBoard = [
            new Array(6)
            new Array(6)
            new Array(6)
            new Array(6)
            new Array(6)
            new Array(6)
        ]

    describe 'newGameBoard method', ->

        it 'should return an empty 6x6 array', ->
            instance = new GameRunner
            response = instance.newGameBoard()
            expect(response.length).to.eql 6
            for row in response
                expect(row.length).to.eql 6

    describe 'makeMove', ->

        it 'should return the new board for a given position', ->

            move = [2,2]

            instance = new GameRunner
            resultBoard = instance.makeMove move, 'X', initialBoard
            expect(resultBoard[2][2]).to.eql 'X'
            expect(resultBoard).not.to.eql initialBoard

    describe 'validateMove', ->

        it 'should return true if the move is valid', ->
            initialBoard[2][4] = 'O'
            instance = new GameRunner
            isValidMove = instance.validateMove [2,2], initialBoard
            expect(isValidMove).to.be.ok()

        it 'should return true if the move is valid2', ->
            initialBoard[2][4] = 'O'
            instance = new GameRunner
            isValidMove = instance.validateMove [0,0], initialBoard
            expect(isValidMove).to.be.ok()

        it 'should return false if the move is invalid', ->
            initialBoard[2][3] = 'O'
            instance = new GameRunner
            isValidMove = instance.validateMove [2,2], initialBoard
            expect(isValidMove).not.to.be.ok()

        it 'should return false if the move is invalid2', ->
            initialBoard[1][1] = 'O'
            instance = new GameRunner
            isValidMove = instance.validateMove [0,0], initialBoard
            expect(isValidMove).not.to.be.ok()

    describe 'anyValidMove', ->

        it 'should return true if there is any valid move left', ->
            instance = new GameRunner
            expect(instance.anyValidMove initialBoard).to.eql yes

        it 'should return false if there are no valid moves left', ->
            initialBoard = [
                ['X', null, 'O', null, 'X', null]
                [null, null, null, null, null, null]
                [null, 'O', null, 'X', null, 'O']
                [null, null, null, null, null, null]
                ['X', null, 'O', null, 'X', null]
                [null, null, null, null, null, null]
            ]
            instance = new GameRunner
            expect(instance.anyValidMove initialBoard).to.eql no