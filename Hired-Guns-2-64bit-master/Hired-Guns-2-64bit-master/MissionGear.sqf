//MissionGear.sqf
//Runs on players
//Called from server
//Called by loadtask.sqf
//Gives leader of NPC job some gear for the job in npc's box

//pvs
private ["_NPCWeapons", "_NPCAmmo", "_NPCItems", "_NPCBackpacks", "_NPCUniform", "_NPCVest", "_box", "_caller"];

//[_NPCWeapons,_NPCAmmo,_NPCItems,_NPCBackpacks,_NPCUniform,_NPCVest,_box] remoteExec ["MissionGear", _caller];
_NPCWeapons = _this select 0;
_NPCAmmo = _this select 1;
_NPCItems = _this select 2;
_NPCBackpacks = _this select 3;
_NPCUniform = _this select 4;
_NPCVest = _this select 5;
_box = missionNamespace getVariable (_this select 6);

//weapons
{
	_box addWeaponCargo [_x,8];
}forEach _NPCWeapons;

//magazines
{
	_box addMagazineCargo [_x,40];
}forEach _NPCAmmo;

//items
{
	_box addItemCargo [_x,8];
}forEach _NPCItems;

//backpacks
{
	_box addBackpackCargo [_x,8];
}forEach _NPCBackpacks;

//clothes
{
	_box addItemCargo [_x,8];
}forEach _NPCUniform;

//vests
{
	_box addItemCargo [_x,8];
}forEach _NPCVest;