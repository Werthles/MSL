//Money.sqf
//Runs on player
//Called from player's GUI
//Gets and shows player's current cash

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

//Get server info
Cash = nil;
Money = player;
publicVariableServer "LoadMoney";
waitUntil{!(isNil "Cash")};

//show cash
[23,Cash] call Messages;