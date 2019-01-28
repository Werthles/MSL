//Progress.sqf
//Runs on player
//Called from player's GUI
//Shows details of player's progress

//no pvs

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

//var init
Intel = [];

//get details from server
//false = one unit
GetIntel = [player,player,false];
publicVariableServer "GetIntel";

//wait for server's info
waitUntil{(count Intel) > 0};

//create dialog
createDialog "HG_Intel";