GameController = require './app/gameController'
GameRunner = require './app/gameRunner'
restify = require 'restify'

gameRunnerInstance = new GameRunner

server = restify.createServer()
server.use restify.bodyParser(mapParams: false)

# Own random player
server.post '/obstruction', (req, res, next) ->
    moves = gameRunnerInstance.allValidMoves req.body
    rndIndex = Math.floor(Math.random() * moves.length)
    response = moves[rndIndex]
    res.json response

# each player must have name, id and url, also must send size with the grid spec
server.post '/play/obstruction', (req, res, next) ->
    instance = new GameController
    player1 = req.body.player1
    player2 = req.body.player2
    player1.client = restify.createJsonClient({
        url: player1.url
        })
    player2.client = restify.createJsonClient({
        url: player2.url
        })
    instance.playGame player1, player2, req.body.size, (gameResult) ->
        res.json gameResult

server.listen 1234, ->
    console.log "Waiting for games!"