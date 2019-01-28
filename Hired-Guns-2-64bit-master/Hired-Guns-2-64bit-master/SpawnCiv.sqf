//SpawnCiv.sqf
//Runs on Server
//Called once at start
//Called in initServer.sqf
//Runs throughout

//pvs
private ["_town1", "_town1Size", "_town2", "_town2Size", "_town3", "_town3Size", "_town4", "_town4Size", "_town5", "_town5Size", "_town6", "_town6Size", "_town7", "_town7Size", "_Civ"];

//var init
_town1 = getMarkerPos "Town1";
_town1Size = (getMarkerSize "Town1") select 0;
_town2 = getMarkerPos "Town2";
_town2Size = (getMarkerSize "Town2") select 0;
_town3 = getMarkerPos "Town3";
_town3Size = (getMarkerSize "Town3") select 0;
_town4 = getMarkerPos "Town4";
_town4Size = (getMarkerSize "Town4") select 0;
_town5 = getMarkerPos "Town5";
_town5Size = (getMarkerSize "Town5") select 0;
_town6 = getMarkerPos "Town6";
_town6Size = (getMarkerSize "Town6") select 0;
_town7 = getMarkerPos "Town7";
_town7Size = (getMarkerSize "Town7") select 0;

//wait until all civ types have been processed
waitUntil{not(isNil "Civs7")};

//loop checking number of civs in each areas, spawning new civ if too few
while {true} do
{
	if ({(side _x == civilian) and (_x distance _town1)<_town1Size} count allUnits < maxCivTownCount) then
	{
		_Civ = selectRandom Civs1;
		[_town1,_town1Size,_Civ,"town1"] execVM "SpawnCivUnits.sqf";
	};
	
	sleep 1;
	
	if ({(side _x == civilian) and (_x distance _town2)<_town2Size} count allUnits < maxCivTownCount) then
	{
		_Civ = selectRandom Civs2;
		[_town2,_town2Size,_Civ,"town2"] execVM "SpawnCivUnits.sqf";
	};
	
	sleep 1;
	
	if ({(side _x == civilian) and (_x distance _town3)<_town3Size} count allUnits < maxCivTownCount) then
	{
		_Civ = selectRandom Civs3;
		[_town3,_town3Size,_Civ,"town3"] execVM "SpawnCivUnits.sqf";
	};
	
	sleep 1;
	
	if ({(side _x == civilian) and (_x distance _town4)<_town4Size} count allUnits < maxCivTownCount) then
	{
		_Civ = selectRandom Civs4;
		[_town4,_town4Size,_Civ,"town4"] execVM "SpawnCivUnits.sqf";
	};
	
	sleep 1;
	
	if ({(side _x == civilian) and (_x distance _town5)<_town5Size} count allUnits < maxCivTownCount) then
	{
		_Civ = selectRandom Civs5;
		[_town5,_town5Size,_Civ,"town5"] execVM "SpawnCivUnits.sqf";
	};
	
	sleep 1;
	
	if ({(side _x == civilian) and (_x distance _town6)<_town6Size} count allUnits < maxCivTownCount) then
	{
		_Civ = selectRandom Civs6;
		[_town6,_town6Size,_Civ,"town6"] execVM "SpawnCivUnits.sqf";
	};
	
	sleep 1;
	
	if ({(side _x == civilian) and (_x distance _town7)<_town7Size} count allUnits < maxCivTownCount) then
	{
		_Civ = selectRandom Civs7;
		[_town7,_town7Size,_Civ,"town7"] execVM "SpawnCivUnits.sqf";
	};
	sleep 30;
};