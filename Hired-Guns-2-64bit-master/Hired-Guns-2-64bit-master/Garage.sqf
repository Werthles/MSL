//Garage.sqf
//Runs on players
//Called from garage addAction
//Tells server to load/save vehicles for the player

//pvs
private ["_caller", "_garage", "_car", "_colour", "_weaponsItemsCargo", "_itemCargo", "_magazineCargo", "_backpackCargo", "_carType", "_bag","_uid"];

_caller = (_this select 1);
_uid = getPlayerUID _caller;
_garage = (_this select 3) select 0;
_car = vehicle _caller;
_colour = (getObjectTextures _car) select 0;
_weaponsItemsCargo = weaponsItemsCargo _car;
_itemCargo = itemCargo _car;
_magazineCargo = magazineCargo _car;
_backpackCargo = backpackCargo _car;
_carType = typeOf _car;

{
	_bag = _x select 1;
	_weaponsItemsCargo = _weaponsItemsCargo + [weaponsItemsCargo _bag];
	_itemCargo = _itemCargo + [itemCargo _bag];
	_magazineCargo = _magazineCargo + [magazineCargo _bag];
	_backpackCargo = _backpackCargo + [backpackCargo _bag];
}forEach (everyContainer _car);
	
if ((effectiveCommander _car == _caller) and (_car != _caller)) then
{//store car
	GarageAccess = [_caller,_uid,_garage];
	publicVariableServer "GarageAccess";
		
	GarageStore =[_caller,_uid,_garage,_carType,_weaponsItemsCargo,_itemCargo,_magazineCargo,_backpackCargo,_colour];
	publicVariableServer "GarageStore";
	
	deleteVehicle vehicle _caller;
}
else
{
	if (_car != _caller) then
	{//get out of car or command it
		[29,nil] call Messages;
	}
	else
	{//load car
		GarageAccess = [_caller,_uid,_garage];
		publicVariableServer "GarageAccess";
	};
};