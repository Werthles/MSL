//OnPauseScript.sqf
//Runs on players
//Called by players when opening Esc Menu

//pvs
private ["_display", "_pauseTime", "_musicStartTime", "_track", "_trackLength", "_timePaused"];

//setup
disableSerialization;
_display = _this select 0;
0.01 fadeMusic 0;
_pauseTime =0+time;

//get global values
_musicStartTime = missionNamespace getVariable "PauseMusicTime";
_track = missionNamespace getVariable "HGMusic";
_trackLength = getNumber(configfile >> "CfgMusic" >> _track >> "duration");

//start music
sleep 0.4;
playMusic [_track, _musicStartTime];
2 fadeMusic 0.3;

//waitUntil pause screen closed
waitUntil {isNull _display};

//save music quit point
_timePaused = time - _pauseTime + _musicStartTime;
_musicStartTime = _timePaused % _trackLength;
missionNamespace setVariable ["PauseMusicTime", _musicStartTime];

//fade out and end music
0.5 fadeMusic 0;
sleep 0.5;
playMusic "";