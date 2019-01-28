//GearSetup.sqf
//Runs on players
//Called from initPlayerLocal.sqf
//Sets up crates and their contents

//pvs
private ["_num", "_playerGear", "_crateGear", "_intro1", "_intro2", "_playerUniform", "_playerVest", "_playerBackpack", "_playerWeaponsItems", "_playerUniformItems", "_playerVestItems", "_playerBackpackItems", "_playerMapItems", "_playerHelmet", "_playerGlasses", "_weaponsItemsCargo", "_itemCargo", "_magazineCargo", "_backpackCargo", "_y"];

waitUntil{time>0};

//create personal ammo boxes
W0 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W0");
W1 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W1");
W2 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W2");
W3 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W3");
W4 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W4");
W5 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W5");
W6 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W6");
W7 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W7");
W8 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W8");
W9 = "Box_GEN_Equip_F" createVehicleLocal (getMarkerPos "W9");

X0 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X0");
X1 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X1");
X2 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X2");
X3 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X3");
X4 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X4");
X5 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X5");
X6 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X6");
X7 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X7");
X8 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X8");
X9 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "X9");

Y0 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y0");
Y1 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y1");
Y2 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y2");
Y3 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y3");
Y4 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y4");
Y5 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y5");
Y6 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y6");
Y7 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y7");
Y8 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y8");
Y9 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Y9");

Z0 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z0");
Z1 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z1");
Z2 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z2");
Z3 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z3");
Z4 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z4");
Z5 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z5");
Z6 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z6");
Z7 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z7");
Z8 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z8");
Z9 = "Box_FIA_Ammo_F" createVehicleLocal (getMarkerPos "Z9");

Boxes = [W0,W1,W2,W3,W4,W5,W6,W7,W8,W9,X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Z0,Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9];

//empty boxes
{
	clearWeaponCargoGlobal _x;
	clearItemCargoGlobal _x;
	clearBackpackCargoGlobal _x;
	clearMagazineCargoGlobal _x;
	_x addAction ["<t color='#FFFF00'>Save Gear<t/>","SaveGear.sqf",[],100,true,true];
	_x allowDamage false;
}forEach Boxes;

//Virtual Ammo
/* ["AmmoboxInit",[player,false,{false}]] spawn BIS_fnc_arsenal;
[player,["arifle_MX_F","arifle_MX_SW_F","arifle_MXC_F"],false] call BIS_fnc_addVirtualWeaponCargo;
[player,["30Rnd_65x39_caseless_mag_Tracer"],false] call BIS_fnc_addVirtualMagazineCargo;
[player,["optic_ACO_grn"],false] call BIS_fnc_addVirtualItemCargo;
[player,["B_AssaultPack_khk"],false] call BIS_fnc_addVirtualBackpackCargo;
{
	_x addAction ["<t color='#E79600'>Basic Supplies (Non-Saving)<t/>","[""Open"",[nil,player,player]] spawn BIS_fnc_arsenal;",[],200,true,true];
}forEach [W0,W1,W2,W3,W4,W5,W6,W7,W8,W9];
 */
execVM "VirtualArsenal.sqf";

//strip player
removeAllAssignedItems player;
removeAllItems player;
removeAllWeapons player;
removeUniform player;
removeBackpack player;
removeVest player;
removeHeadgear player;
removeGoggles player;

//delay immediate loading if the player isnt the server
if !(isServer) then {_num = random [5,7.5,10]; sleep _num;};
LoadGear = player;
Gear = nil;
publicVariableServer "LoadGear";
waitUntil{!isNil "Gear"};

//prepare gear info
_playerGear = Gear select 0;
_crateGear = Gear select 1;
_intro1 = Gear select 2;
_intro2 = 0;
if !(isNil "Location") then
{
	_intro2 = Location select 3;
};

if (_intro1==1 or _intro2==1) then
{//if player has loaded to the server before
	_playerUniform = _playerGear select 0;
	_playerVest = _playerGear select 1;
	_playerBackpack = _playerGear select 2;
	_playerWeaponsItems = _playerGear select 3;
	_playerUniformItems = _playerGear select 4;
	_playerVestItems = _playerGear select 5;
	_playerBackpackItems = _playerGear select 6;
	_playerMapItems = _playerGear select 7;
	_playerHelmet = _playerGear select 8;
	_playerGlasses = _playerGear select 9;
	
	_weaponsItemsCargo = _crateGear select 0;
	_itemCargo = _crateGear select 1;
	_magazineCargo = _crateGear select 2;
	_backpackCargo = _crateGear select 3;
	
	player forceAddUniform _playerUniform;
	player addVest _playerVest;
	player addBackpack _playerBackpack;
	
	{
		player addItem _x;
		player assignItem _x;
	}forEach _playerMapItems;
	
	{
		player addWeapon (_x select 0);
		player addWeaponItem [(_x select 0),(_x select 1)];
		player addWeaponItem [(_x select 0),(_x select 2)];
		player addWeaponItem [(_x select 0),(_x select 3)];
		player addWeaponItem [(_x select 0),((_x select 4) select 0)];
		player addWeaponItem [(_x select 0),(_x select 5)];
	}forEach _playerWeaponsItems;
	
	{
		player addItemToUniform _x;
	}forEach _playerUniformItems;
	
	{
		player addItemToVest _x;
	}forEach _playerVestItems;
	
	{
		player addItemToBackpack _x;
	}forEach _playerBackpackItems;
	
	player addHeadgear _playerHelmet;
	player addGoggles _playerGlasses;
	
	{
		_y = _forEachIndex;
		{
		    _wep = _x select 0;
		    _count = _x select 1;
			(Boxes select _y) addweaponCargo [_wep select 0,_count];
			(Boxes select _y) addItemCargo [(_wep select 1),_count];
			(Boxes select _y) addItemCargo [(_wep select 2),_count];
			(Boxes select _y) addItemCargo [(_wep select 3),_count];
			(Boxes select _y) addMagazineCargo [(_wep select 4) select 0,_count];
			(Boxes select _y) addItemCargo [(_wep select 5),_count];
		}forEach _x;
	}forEach _weaponsItemsCargo;
	
	{
		_y = _forEachIndex;
		{
			(Boxes select _y) addItemCargo _x;
		}forEach _x;
	}forEach _itemCargo;
	
	{
		_y = _forEachIndex;
		{
			(Boxes select _y) addMagazineCargo _x;
		}forEach _x;
	}forEach _magazineCargo;
	
	{
		_y = _forEachIndex;
		{
			(Boxes select _y) addBackpackCargo _x;
		}forEach _x;
	}forEach _backpackCargo;
}
else
{//if player is a new joiner - make visible at start
	//player addAction ["<t color='#BB0000'>Watch Intro Video</t>",{["video\Wildlife.ogv"] spawn BIS_fnc_playVideo},[],-99999,false,true];
	execVM "RespawnGear.sqf";
};