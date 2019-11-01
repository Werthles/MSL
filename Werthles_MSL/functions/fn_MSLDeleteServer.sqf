private ["_inidbi",  "_success", "_inidbiSAVELIST"];

//hint "Serverdelete";
//player setPos [2000,2000,2500];
params [["_clientID",-2,[0]],["_filename","MSLERRORfilename",[""]]];

_inidbi = ["new", _filename] call OO_INIDBI;

_success = "delete" call _inidbi;

["delete", _inidbi] call OO_INIDBI;



_inidbiSAVELIST = ["new", "SAVELIST"] call OO_INIDBI;

if ("exists" call _inidbiSAVELIST) then
{

	{
		if ((["read", [_x, "Filename", ""]] call _inidbiSAVELIST) == _filename) then {
			["deleteSection", _x] call _inidbiSAVELIST;
		};
	}forEach ("getSections" call _inidbiSAVELIST);

};

["delete", _inidbiSAVELIST] call OO_INIDBI;

[_success] remoteExec ["Werthles_fnc_MSLDeletePlayer",_clientID];