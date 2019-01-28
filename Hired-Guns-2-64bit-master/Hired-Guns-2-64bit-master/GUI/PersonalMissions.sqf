//PersonalMissions.sqf
//Runs on player
//Called from player's GUI
//Displays PM map

//pvs
private ["_nightTime", "_hour"];

//close GUI
call CloseGUI;

//check if nighttimes
_nightTime = false;
_hour = date select 3;
if (_hour<6 or _hour>20) then
{
	_nightTime = true;
};

MyMap = [nil,
	PMDefaultMapPos,
	PersonalMissionArray,
	[],
	[],
	[],
	1,
	_nightTime,
	500000,
	true,
	"Select A Personal Missions",
	true,
	"\A3\Ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa"
] spawn BIS_fnc_StrategicMapOpen;