//onPlayerLeaving.sqf
//Runs on players
//Called on mission ending and player leaving
//Records player gear, location and wipes tasks

//pvs
private ["_unit", "_tasks", "_location", "_direction", "_playerUniform", "_playerVest", "_playerBackpack", "_playerWeaponsItems", "_playerUniformItems", "_playerVestItems", "_playerBackpackItems", "_playerMapItems", "_playerHelmet", "_playerGlasses", "_onlyLoadout","_uid"];

_unit = _this select 0;
_uid = _this select 1;

[_unit] joinSilent grpNull;
_tasks = _unit call BIS_fnc_tasksUnit;
{
	[_x,_unit] spawn BIS_fnc_deleteTask;
}forEach _tasks;
removeAllActions _unit;

_location = getPos _unit;
_direction = getDir _unit;

_playerUniform = uniform _unit;
_playerVest = vest _unit;
_playerBackpack = backpack _unit;
_playerWeaponsItems = weaponsItems _unit;
_playerUniformItems = uniformItems _unit;
_playerVestItems = vestItems _unit;
_playerBackpackItems = backpackItems _unit;
_playerMapItems = assignedItems _unit;
_playerHelmet = headgear _unit;
_playerGlasses = goggles _unit;

_onlyLoadout = true;

SaveGear = [[_unit,_uid],[_playerUniform,_playerVest,_playerBackpack,_playerWeaponsItems,_playerUniformItems,_playerVestItems,_playerBackpackItems,_playerMapItems,_playerHelmet,_playerGlasses],[nil,nil,nil,nil],_onlyLoadout];
publicVariableServer "SaveGear";

SaveLocation = [_unit,_uid,_location,_direction];
publicVariableServer "SaveLocation";