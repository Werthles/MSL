//pvs
private ["_location", "_direction", "_respawns", "_intro","_uid"];

//waitUntil{time>0};
_uid = getPlayerUID player;
LoadLocation = [player,_uid,profileNameSteam];
SendProgress = [player,player];

publicVariableServer "LoadLocation";
publicVariableServer "SendProgress";
publicVariableServer "LoadMoney";

//waitUntil{!isNil "Location"};
//waitUntil{!isNil "Progress"};

while {(isNil "Progress") or (isNil "Location")} do
{
	hintSilent "Please wait until setup has completed.";
};
hintSilent "";

//Location = [_location,_direction,_respawns,_intro];
_location = Location select 0;
_direction = Location select 1;
_respawns = Location select 2;

//set location as last saved, if saved
if (count _location ==3) then
{
	player setDir _direction;
	player setPos _location;
	StartLocation = _location;
};

onPreloadFinished "[false] execVM ""intro.sqf""";

//add breifings of past missions
[true] execVM "AddBreifings.sqf";

//set up extra respawns
if (count _respawns >0) then
{
	if (_respawns select 0 == 1) then {createMarkerLocal ["respawn_guerrila_NPC0",respawn0]};
	if (_respawns select 1 == 1) then {createMarkerLocal ["respawn_guerrila_NPC1",respawn1]};
	if (_respawns select 2 == 1) then {createMarkerLocal ["respawn_guerrila_NPC2",respawn2]};
	if (_respawns select 3 == 1) then {createMarkerLocal ["respawn_guerrila_NPC3",respawn3]};
	if (_respawns select 4 == 1) then {createMarkerLocal ["respawn_guerrila_NPC4",respawn4]};
	if (_respawns select 5 == 1) then {createMarkerLocal ["respawn_guerrila_NPC5",respawn5]};
	if (_respawns select 6 == 1) then {createMarkerLocal ["respawn_guerrila6_NPC",respawn6]};
	if (_respawns select 7 == 1) then {createMarkerLocal ["respawn_guerrila_NPC7",respawn7]};
	if (_respawns select 8 == 1) then {createMarkerLocal ["respawn_guerrila_NPC8",respawn8]};
	if (_respawns select 9 == 1) then {createMarkerLocal ["respawn_guerrila_NPC9",respawn9]};
};