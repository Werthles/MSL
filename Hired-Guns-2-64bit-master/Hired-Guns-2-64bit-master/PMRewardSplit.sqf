//PMRewardSplit.sqf
//Runs on playersNumber
//Called by mission leader
//Called from PMAddAction2
//Gives players rewards for completing a PM

//pvs
private ["_missionType", "_missionLevel", "_box", "_theGroup", "_starter", "_owner", "_boxLetter", "_array", "_gun", "_i", "_car"];

_missionType = _this select 0;
_missionLevel = _this select 1;
//_box = _this select 2;
_theGroup = _this select 3;
_starter = _this select 4;
_owner = _this select 5;

//remove actions
if not (str _starter == str player) then
{
	if (_missionType > 5 and _missionType < 9) then
	{
		loot removeAction PMLootAction2;
	}
	else
	{
		_starter removeAction PMLootAction2;
	};
};

//add rewards
if (str _starter == str player) then
{
	_boxLetter = "";
	switch (_missionLevel) do
	{
		case 0: {
			_boxLetter = "X";
		};
		case 1: {
			_boxLetter = "Y";
		};
		case 2: {
			_boxLetter = "Z";
		};
	};
	
	_box = missionNamespace getVariable (_boxLetter + str _missionType);
	
	_array = (PMLootArray select _missionType select _missionLevel select 1);
	{
		_box addWeaponCargo [_x, 1];
		_box addMagazineCargo [PMLootArrayAmmo select _missionType select _missionLevel select 1 select _forEachIndex, 8];
	}forEach _array;
	
	{
		_box addItemCargo [_x, 1];
	}forEach (PMLootArrayItem select _missionType select _missionLevel select 1);
	{
		_box addBackpackCargo [_x, 1];
	}forEach (PMLootArrayBackpack select _missionType select _missionLevel select 1);
}
else
{
	_boxLetter = "";
	switch (_missionLevel) do
	{
		case 0: {
			_boxLetter = "X";
		};
		case 1: {
			_boxLetter = "Y";
		};
		case 2: {
			_boxLetter = "Z";
		};
	};
	
	_box = missionNamespace getVariable (_boxLetter + str _missionType);
	
	_gun = selectRandom(PMLootArray select _missionType select _missionLevel select 0);
	_box addWeaponCargo [_gun, 1];
	_i = (PMLootArray select _missionType select _missionLevel select 0) find _gun;
	_box addMagazineCargo [PMLootArrayAmmo select _missionType select _missionLevel select 0 select _i, 8];
	_box addItemCargo [PMLootArrayItem select _missionType select _missionLevel select 0 select _i, 1];
	_box addBackpackCargo [PMLootArrayBackpack select _missionType select _missionLevel select 0 select _i, 1];
	/* 
	if (_missionType>6) then
	{
		_car = selectRandom(PMLootArrayVehicle select _missionType select _missionLevel select 0);
		_car createVehicle (getPos _box);
	};
	 */
};

PMEnded =+ CurrentMission;
CurrentMission = [];
[42,nil] call Messages;
execVM "SaveGear.sqf";