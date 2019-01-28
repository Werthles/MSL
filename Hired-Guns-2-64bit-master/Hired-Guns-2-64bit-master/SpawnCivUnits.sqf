//SpawnCivUnits.sqf
//Runs on Server
//Called from SpawnCiv.sqf
//Called often to replenish Civs

//pvs
private ["_town", "_townSize", "_Civ", "_townMarker", "_wp1", "_wp2", "_wp3", "_wp4", "_unit","_group"];

//var init
_town = _this select 0;
_townSize = _this select 1;
_Civ = _this select 2;
_townMarker = _this select 3;

//create group and civ
_group = createGroup civilian;
_group createUnit [_Civ,_town, [], _townSize, "CAN_COLLIDE"];
_group setSpeedMode "LIMITED";
sleep 1;

//give the civ waypoints
_wp1 = _group addWaypoint[_town,_townSize];
_wp1 setWaypointTimeout [120, 360, 600];
sleep 1;

_wp2 = _group addWaypoint[_town,_townSize];
_wp2 setWaypointTimeout [120, 360, 600];
sleep 1;

_wp3 = _group addWaypoint[_town,_townSize];
_wp3 setWaypointTimeout [120, 360, 600];
sleep 1;

_wp4 = _group addWaypoint[waypointPosition _wp1,0];
_wp4 setWaypointType "CYCLE";
_wp4 setWaypointTimeout [120, 360, 600];
sleep 1;

//give the civ variables to determine its combat style and home
_unit = leader _group;
_unit setVariable["type",floor (random 5.9),true];
_unit setVariable["rank",floor (random 8.9),true];
_unit setVariable["town",_townMarker,true];

_unit setRank "PRIVATE";
_unit setSkill 0;