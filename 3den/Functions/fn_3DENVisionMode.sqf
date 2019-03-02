/*
	Author: Karel Moricky

	Description:
	Toggle or set 3DEN vision mode

	Parameter(s):
		0: NUMBER - mode
			-2: restore the current mode
			-1: toggle mode
			0: Normal
			1: NVG
			2: Thermal

	Returns:
	NUMBER - selected mode
*/

private ["_input","_mode"];
_input = [_this,0,-1,[0]] call bis_fnc_param;

_mode = uinamespace getvariable ["BIS_fnc_3denVisionMode_mode",0];
_mode = switch _input do {
	case -1: {(_mode + 1) % 3};
	case -2: {_mode};
	default {_input};
};

camusenvg (_mode == 1);
(_mode == 2) setcamuseTI 0;
//if (_input != -2 && _mode != 0) then {playsound ["3DEN_visionMode",true];};

uinamespace setvariable ["BIS_fnc_3denVisionMode_mode",_mode];
"ToggleVision" call bis_fnc_3DENToolbar;
_mode