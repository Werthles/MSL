//GUITarget.sqf
//Runs on player
//Called from player opening GUI
//Gets the target's name and displays in GUI

//pvs
private ["_control", "_idc"];

disableSerialization;
_control = _this select 0;
_idc = _this select 1;

{player reveal _x} forEach [NPC0,NPC1,NPC2,NPC3,NPC4,NPC5,NPC6,NPC7,NPC8,NPC9];

if (isNull cursorTarget or !(cursorTarget isKindOf "Man")) then
{
	GUITarget = "No-one";
	GUITargetObject = objNull;
}
else
{
	GUITargetObject = cursorTarget;
	GUITarget = name cursorTarget;
};
 
(_control displayCtrl _idc) ctrlSetText format["Interacting with:\n%1",GUITarget];