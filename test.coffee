GameController = require './app/gameController'

instance = new GameController
player1 =
    name: 'Joao'
player2 =
    name: 'Japao'
instance.playGame player1, player2, 7