#include "\a3\3DEN\UI\resincl.inc"

_mode = _this param [0,"init",[""]];

switch (tolower _mode) do {
	case "init": {
		_code = {
			_ctrlMouseArea = _this select 0;
			_display = ctrlparent _ctrlMouseArea;

			_ctrlMap = _display displayctrl IDC_DISPLAY3DEN_MAP;
			_ctrlX = _display displayctrl IDC_DISPLAY3DEN_STATUSBAR_X;
			_ctrlY = _display displayctrl IDC_DISPLAY3DEN_STATUSBAR_Y;
			_ctrlZ = _display displayctrl IDC_DISPLAY3DEN_STATUSBAR_Z;
			_ctrlDis = _display displayctrl IDC_DISPLAY3DEN_STATUSBAR_DIS;

			_pos = [0,0,0];
			_dis = 0;
			if (get3DENActionState "togglemap" > 0) then {
				_pos = _ctrlMap ctrlmapscreentoworld [_this select 1,_this select 2];
				_dis = format [localize "STR_3DEN_Display3DEN_StatusBar_ValueRes",(worldsize * (ctrlmapscale _ctrlMap)) / (getresolution select 2)];
			} else {
				_pos = screentoworld [_this select 1,_this select 2];
				_dis = format [localize "STR_3DEN_Grid_translationUnit",get3DENCamera distance _pos];
			};
			_pos set [2,getterrainheightasl _pos];
			_ctrlX ctrlsettext format [localize "STR_3DEN_Grid_translationUnit",_pos select 0];
			_ctrlY ctrlsettext format [localize "STR_3DEN_Grid_translationUnit",_pos select 1];
			_ctrlZ ctrlsettext format [localize "STR_3DEN_Grid_translationUnit",_pos select 2];
			_ctrlDis ctrlsettext _dis;
		};
		_display = finddisplay IDD_DISPLAY3DEN;

		_ctrlMouseArea = _display displayctrl IDC_DISPLAY3DEN_MOUSEAREA;
		_ctrlMouseArea ctrladdeventhandler ["mousemoving",_code];
		_ctrlMouseArea ctrladdeventhandler ["mouseholding",_code];

		_version = (productversion select 2) * 0.01;
		_build = str (productversion select 3);
		while {count _build < 6} do {_build = _build + "0";};
		_ctrlVersion = _display displayctrl IDC_DISPLAY3DEN_STATUSBAR_VERSION;
		_ctrlVersion ctrlsettext format ["%1.%2",_version,_build];
		_ctrlMod = _display displayctrl IDC_DISPLAY3DEN_STATUSBAR_MOD;
		if !(productversion select 5) then {
			_ctrlMod ctrlsettextcolor [1,1,1,0.25];
			_ctrlMod ctrlsettooltip localize "STR_3DEN_Display3DEN_StatusBar_Mod_false";
		} else {
			_ctrlMod ctrlsettextcolor [1,1,1,1];
			_ctrlMod ctrlsettooltip localize "STR_3DEN_Display3DEN_StatusBar_Mod_true";
		};
		"server" call bis_fnc_3DENStatusBar;
	};
	case "server": {
		_display = finddisplay IDD_DISPLAY3DEN;
		_ctrlServer = _display displayctrl IDC_DISPLAY3DEN_STATUSBAR_SERVER;
		if !(is3DENMultiplayer) then {
			_ctrlServer ctrlsettextcolor [1,1,1,0.25];
			_ctrlServer ctrlsettooltip localize "STR_3DEN_Display3DEN_StatusBar_Server_false";
		} else {
			_ctrlServer ctrlsettextcolor [1,1,1,1];
			_ctrlServer ctrlsettooltip format [localize "STR_3DEN_Display3DEN_StatusBar_Server_true",servername];
		};
	};
};