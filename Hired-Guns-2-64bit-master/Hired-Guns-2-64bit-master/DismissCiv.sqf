//DismissCiv.sqf
//Runs on server
//Called from server
//Called from JobFinished.sqf or PVEH.sqf
//Sets up civ waypoints and removes gear

//pvs
private ["_civ", "_town", "_townPos", "_townSize", "_wp1", "_wp2", "_wp3", "_wp4","_group"];

sleep 1;

//var init
_civ = _this select 0;
_town = _civ getVariable "town";
_townPos = getMarkerPos _town;
_townSize = (getMarkerSize _town) select 0;

removeAllWeapons _civ;
removeAllItems _civ;
removeAllAssignedItems _civ;
removeUniform _civ;
removeVest _civ;
removeBackpack _civ;
removeHeadgear _civ;
removeGoggles _civ;

_civ forceAddUniform "U_BG_Guerilla3_1";
_civ addHeadgear "H_StrawHat_dark";
_civ addGoggles "G_Aviator";
sleep 1;

_group = createGroup civilian;
sleep 1;

[_civ] joinSilent _group;
_group setSpeedMode "LIMITED";
_group setBehaviour "CARELESS";
_group setCombatMode "GREEN";

_wp1 = _group addWaypoint[_townPos,_townSize,1];
_wp1 setWaypointTimeout [120, 360, 600];
sleep 1;

_wp2 = _group addWaypoint[_townPos,_townSize,2];
_wp2 setWaypointTimeout [120, 360, 600];
sleep 1;

_wp3 = _group addWaypoint[_townPos,_townSize,3];
_wp3 setWaypointTimeout [120, 360, 600];
sleep 1;

_wp4 = _group addWaypoint[waypointPosition _wp1,0,4];
_wp4 setWaypointType "CYCLE";
_wp4 setWaypointTimeout [120, 360, 600];

_civ setSkill 0;