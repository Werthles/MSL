//executes on all clients and server
//re-synchronizes a group and its waypoints to whatever they were attached too, on the HC and all clients/server

//private variables
private ["_objs", "_wayPoint"];

//params
params [["_syncGroup",grpNull,[grpNull]],["_trigSyncs",[],[[]]],["_waySyncs",[],[[]]],["_objSyncs",[],[[]]],["_wpArray",[],[[]]]];

//re-sync units
{
	_objs = _objSyncs select _forEachIndex;
	_x synchronizeObjectsAdd _objs;
}forEach units _syncGroup;

//re-sync waypoints
{
	_wayPoint = _x;
	//to triggers
	{
		_wpArray = (synchronizedWaypoints _x) + [_wayPoint];
		_x synchronizeTrigger _wpArray;
	}forEach (_trigSyncs select _forEachIndex);
	//to other waypoints
	{
		_wpArray = (synchronizedWaypoints _x) + [_wayPoint];
		_x synchronizeWaypoint _wpArray;
	}forEach (_waySyncs select _forEachIndex);
}forEach waypoints _syncGroup;