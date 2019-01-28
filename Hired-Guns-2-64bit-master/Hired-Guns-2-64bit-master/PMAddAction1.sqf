//PmAddAction1.sqf
//Runs on player
//Called by mission leader
//Called from firts PM addAction on loot
//Sets up part 2 of PM

//pvs
private ["_object", "_caller", "_args", "_missionType", "_missionLevel", "_starter","_ID", "_group"];

//var init
_object = _this select 0;
_caller = _this select 1;
_ID = _this select 2;
_args = _this select 3;
_missionType = _args select 0;
_missionLevel = _args select 1;
_starter = _args select 2;
_group = group _caller;

if (str _starter == str _caller) then
{
	//for vehicle loot
	if (_missionType < 9 and _missionType > 5) then
	{
		_object lock false;
		_caller action ["getInDriver",_object];
		_object removeAction _ID;
	};
	//for box loot
	if (_missionType < 6) then
	{
		deleteVehicle _object;
		sleep 1;
		_object = _starter;
	};
		
	[_missionType,_missionLevel,_object,_starter] remoteExec ["PMLocalSetup2",units _group];
	sleep 5;
	(vehicle player) lock false;
}
else
{
	[35,nil] call Messages;
};