//MapConditions.sqf
//Runs on player
//Called from player's GUI
//Shows current weather and a forcast

//no pvs

//close GUI
closeDialog 0;
sleep 0.05;
closeDialog 0;

//create weather GUI
createDialog "HG_MapConditionsGUI";