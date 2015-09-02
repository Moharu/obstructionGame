angular.module('app', []).
controller('appCtrl', function ($scope, $http){
    $scope.p1Random = $scope.p2Random = true;
    $scope.appUrl = 'http://localhost:1234/play/obstruction';
    $scope.appGridHeight = 6;
    $scope.appGridWidth = 6;
    $scope.play = function (){
        var p1, p2;

        if($scope.p1Random){
            p1 = {
                name: randomName(),
                id: 'X',
                url: 'http://localhost:1234/obstruction'
            }
        } else {
            p1 = {
                name: $scope.p1Name,
                id: $scope.p1Id,
                url: $scope.p1Url
            }
        }

        if($scope.p2Random){
            p2 = {
                name: randomName(),
                id: 'O',
                url: 'http://localhost:1234/obstruction'
            }
        } else {
            p2 = {
                name: $scope.p2Name,
                id: $scope.p2Id,
                url: $scope.p2Url
            }
        }

        var prop ={
            method: 'POST',
            url: $scope.appUrl,
            data:{
                player1: p1,
                player2: p2,
                size: [$scope.appGridWidth, $scope.appGridHeight]
            }
        };

        var games = [];

        function callback(response, statusCode){
            games.push(response);
            if(games.length < 10){
                $http(prop).success(callback);
            } else {
                endGame(games);
            }
        };

        $http(prop).success(callback);

        function endGame(games){
            var l = games.length;
            var result = {
                winners: [],
                logs: []
            };
            for(var i=0;i < l; i++){
                result.winners.push(games[i].winner);
                // var j=1;
                // var log = _.reduce(games[i].log, function(memo, next){
                //     end = memo + '\n' + j + '. ' + next;
                //     j+= 1;
                //     return end;
                // }, '');
                result.logs.push(games[i].log);
            }
            result.score = _.countBy(result.winners, function(value){
                return value;
            });
            $scope.gameScore = p1.name + " " + (result.score[p1.name] || '0') +
            " X " + (result.score[p2.name] || '0') + " " + p2.name;
            $scope.gameLogs = result.logs;
        };
    };
});

function randomName(){
    var names = ['Wilfred Fizzlebang', 'Anub\'arak', 'Justicar Trueheart',
    'Bolf Ramshield', 'Aviana', 'Varian Wrynn', 'Chillmaw', 'Fjola Lightbane',
    'Eydis Darkbane', 'The Mistcaller', 'Gormok the Impaler', 'Skycap\'n Kragg',
    'The Skeleton Knight', 'Nexus-Champion Saraad', 'Icehowl', 'Acidmaw',
    'Dreadscale', 'Rhonin', 'Confessor Paletress', 'Eadric the Pure'];
    var name = names[Math.floor(Math.random()*names.length)]
    return name;
}