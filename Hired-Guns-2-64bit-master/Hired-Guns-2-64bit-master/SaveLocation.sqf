//SaveLocation.sqf
//Runs on server
//Called by players
//Called from SaveLocation event

//pvs
private ["_caller", "_location", "_direction", "_NPC", "_NPCString", "_markerString", "_NPCNumString", "_respawnString", "_markerPos","_uid"];

//var init
_caller = player;
_uid = getPlayerUID player;
_location = getPos player;
_direction = getDir player;
_NPC = _this select 0;

//send location data to server to save
SaveLocation = [_caller,_uid,_location,_direction,_NPC];
publicVariableServer "SaveLocation";

//create a respawn marker if talking to an npc
if not (isPlayer _NPC) then
{
	_NPCString = str _NPC;
	_markerString = "respawn_guerrila_" + _NPCString;
	_NPCNumString = _NPCString select [3,1];
	_respawnString = "respawn" + _NPCNumString;
	_markerPos =  missionNamespace getVariable _respawnString;
	deleteMarkerLocal _markerString;
	createMarkerLocal [_markerString,_markerPos];
};