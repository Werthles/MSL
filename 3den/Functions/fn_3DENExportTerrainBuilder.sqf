#include "\a3\3DEN\UI\resincl.inc"

startloadingscreen [""];
//_br = tostring [13,10];
_br = "
";
_export = "";
_fnc_addLine = {_export = _export + _this + _br;};
_allObjects = allmissionobjects "All";
_allObjectsCount = count _allObjects;
{
	if (isnull group _x) then {
		_pos = getposasl _x;
		_dir = (_x get3DENAttribute "rotation") select 0;
		if !(isnil "_dir") then {
			_model = gettext (configfile >> "cfgvehicles" >> typeof _x >> "model");
			waituntil {
				_slashID = _model find "\";
				_model = _model select [_slashID + 1];
				_slashID < 0
			};

			//--- Read only the name without extension
			_extensionID = _model find ".";
			if (_extensionID >= 0) then {
				_model = _model select [0,_extensionID];
			};

			_pos set [0,(_pos select 0) + 200000]; //--- Terrain Builder coorinate system starts at 200000 for some reason
			{
				_n = str floor _x;
				_nDec = (str (_x % 1)) splitstring ".";
				if (count _nDec == 1) then {_nDec set [1,"0"];};
				_pos set [_foreachindex,format ["%1.%2",_n,_nDec select 1]];
			} foreach _pos select 0;

			//--- Class;posX;posY;Yaw;Pitch;Roll;Scale;posZATL;
			format [
				"""%1"";%2;%3;%4;%5;%6;%7;%8;",
				_model,
				(_pos select 0),
				(_pos select 1),
				(_dir select 2),
				-(_dir select 0),
				-(_dir select 1),
				1, //--- Scale is always 1
				(_pos select 2)
			] call _fnc_addLine;
		};
	};
	progressloadingscreen (_foreachindex / _allObjectsCount);
} foreach _allObjects;
endloadingscreen;

//--- Show export window
/*
disableserialization;
_display = (finddisplay IDD_DISPLAY3DEN) createdisplay "Display3DENCopy";
(_display displayctrl IDC_DISPLAY3DENCOPY_TITLE) ctrlsettext "Export to Terrain Builder";
(_display displayctrl IDC_DISPLAY3DENCOPY_EDIT) ctrlsettext _export;
*/
uinamespace setvariable ["Display3DENCopy_data",[localize "STR_3DEN_Display3DEN_MenuBar_MissionTerrainBuilder_text",_export]];
(finddisplay IDD_DISPLAY3DEN) createdisplay "Display3DENCopy";