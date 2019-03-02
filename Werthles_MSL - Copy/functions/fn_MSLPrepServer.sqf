hint "Serverprep";
//player setPos [5000,5000,500];
params [["_clientID",-2,[0]]];


_allSaves = [];
_missionNames = [];

_inidbiSAVELIST = ["new", "SAVELIST"] call OO_INIDBI;

if (("exists" call _inidbiSAVELIST)) then {
	_allSaves = "getSections" call _inidbiSAVELIST;
};


if (isNil "_allSaves") then {_allSaves = []};
if (count _allSaves > 0) then {
	{
		if (_x != "FileListFile") then {
			_missionNames pushBack (["read", [_x, "Filename", "Error"]] call _inidbiSAVELIST);
		};
	}forEach _allSaves;
	[_missionNames] remoteExec ["Werthles_fnc_MSLPrepPlayer",_clientID];
} else {
	hint "No Save Files";
};

["delete", _inidbiSAVELIST] call OO_INIDBI;