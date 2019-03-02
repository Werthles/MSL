/*
	Author: Karel Moricky

	Description:
	Toggle or set 3DEN flashlight (light source snapped to the camera)

	Parameter(s):
		0: NUMBER - mode
			-2: restore the current mode
			-1: toggle mode
			0: Off
			1: On

	Returns:
	NUMBER - selected mode
*/

#include "\a3\3DEN\UI\resincl.inc"

private ["_input","_toggle"];
_input = [_this,0,-1,[0]] call bis_fnc_param;

_toggle = [1,0] select (isnil {uinamespace getvariable "BIS_fnc_3denFlashlight_light"});
_toggle = switch _input do {
	case -1: {(_toggle + 1) % 2};
	case -2: {_toggle};
	default {_input};
};

if (_toggle > 0) then {
	private ["_light"];
	_light = uinamespace getvariable ["BIS_fnc_3denFlashlight_light",objnull];
	if (isnull _light) then {
		private ["_intensity"];
		_intensity = 20;
		_light = "#lightpoint" createvehicle position get3DENCamera;
		_light setlightbrightness _intensity;
		_light setlightambient [1,1,1];
		_light setlightcolor [0,0,0];
		_light lightattachobject [get3DENCamera,[0,0,-_intensity * 7]];
		uinamespace setvariable ["BIS_fnc_3denFlashlight_light",_light];
	};
} else {
	private ["_light"];
	_light = uinamespace getvariable ["BIS_fnc_3denFlashlight_light",objnull];
	deletevehicle _light;
	uinamespace setvariable ["BIS_fnc_3denFlashlight_light",nil];
};
"ToggleFlashlight" call bis_fnc_3DENToolbar;
_toggle