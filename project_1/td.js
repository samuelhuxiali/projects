//Global Variables
var painted;
var content;
var winningCombinations;
var turn = 0;
var theTd;
var td;
var squaresFilled = 0;
var y;
var Player = function Player(name){
    this.name = name;
    this.record = 0;
}

var xPlayer;
var oPlayer;

    var xPlayerNameInput = prompt("Please enter player1's name");
    xPlayer = new Player(xPlayerNameInput);
    var oPlayerNameInput = prompt("Please enter player2's name");
    oPlayerNameInput =(oPlayerNameInput);

//Instanciate Arrays
window.onload = function(){
    content = new Array();
    painted = new Array();
    //set up an array to collect all win factors
    winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]];
    //set up two array,one in the front to show, one in the back to record contents
    for(var i = 0; i <= 8; i++){
        painted[i] = false;
        content[i] = '';
    }
}

//Game methods
var tdClicked = function(tdNumber){
    theTd = "td"+tdNumber;
    td = document.querySelector("#"+theTd);
    if(painted[tdNumber-1] == false){
        if(turn%2==0){
            td.textContent = "X";
            content[tdNumber-1] = "X";
        } else{
            td.textContent = "O";
            content[tdNumber-1] = "O";      
        }
        turn++;
        painted[tdNumber-1] = true;
        squaresFilled++;
        checkForWinners(content[tdNumber-1]);

        if (squaresFilled==9) {
            alert("Game is over");
            location.reload(true);
        }

    } else{
        alert("SPACE OCCUPIED!");
    }
}

var checkForWinners = function(symbol){
    for(var i = 0; i < winningCombinations.length; i++){
        if(content[winningCombinations[i][0]] == symbol
            && content[winningCombinations[i][1]] == symbol
            && content[winningCombinations[i][2]] == symbol){
            alert(symbol + " WON!");
            playAgain();
        }
    }

}

var updateRecord = function(){}

var playAgain = function(){
    y=confirm("PLAY AGAIN?");
    
    if(y==true){
        alert("GO!GO!GO!");
        // reset the game state
        // set all td text content to ""
        for(var i = 0; i <= 8; i++){
            content[i] = '';
            painted[i] = false;
            
    }
        // set which player goes
        // location.reload(true);
    }
    else{
        alert("bye");
}
}

//var firstTd = document.querySelector("#td1");
//firstTd.addEventListener("click",tdClicked(1));
