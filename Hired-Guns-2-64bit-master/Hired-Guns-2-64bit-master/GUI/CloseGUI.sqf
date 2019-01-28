//CloseGUI.sqf
//Runs on player
//Called to close GUI, esp. when call not a execVM is required

//no pvs

closeDialog 0;
[] spawn {
	sleep 0.01;
	closeDialog 0;
	sleep 2;
	GUITargetObject = objNull;
	GUITarget = "";
};
closeDialog 0;
true