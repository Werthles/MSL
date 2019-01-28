//CurrentTeam.sqf
//Runs on player
//Called from player GUI
//Opens GUI intel for each team member

//no pvs

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

Intel = [];

//request info
//false = one unit
GetIntel = [player,player,true];
publicVariableServer "GetIntel";

//Wait for response
waitUntil{(count Intel) > 0};

//create Intel GUI
createDialog "HG_Intel";
