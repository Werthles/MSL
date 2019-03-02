/*
	Author: Karel Moricky

	Description:
	Show notification in the Eden Editor

	Parameter(s):
		0: STRING - message text ot class from Cfg3DEN >> Notifications from where the text will be loaded
		1 (Optional): NUMBER - visual type
			0 - notification (green background; default)
			1 - warning (red background)
		2 (Optional): NUMBER - duration (default: 2 second + 1 seconds for each text line)
		3 (Optional): BOOL - true to animate the notification (default: true)

	Returns:
	NUMBER - selected mode
*/

#include "\a3\3DEN\UI\resincl.inc"

private _class = param [0,"",[0,""]];
private _type = param [1,0,[0,false]];
private _duration = param [2,-1,[0]];
private _animate = param [3,true,[true]];

//--- Pick a message
if (typename _class == typename 0) then {
	_class = switch _class do {
		case 0: {"MissionSaved"};
		case 1: {"MissionAutoSaved"};
		case 2: {"VehicleFull"};
		case 3: {"VehicleEnemy"};
		case 4: {"MissionNoPlayer"};
		case 5: {"MissionExportSP"};
		case 6: {"MissionExportMP"};
		case 7: {"MissionExportError"};
		case 8: {"TooltipExported"};
		default {""};
	};
};

private _text = _class;
if (_type isequaltype false) then {_type = [0,1] select _type;};
if (_class != "") then {
	private _cfg = configfile >> "cfg3DEN" >> "Notifications" >> _class;
	if (isclass _cfg) then {
		_text = gettext (_cfg >> "text");
		_type = getnumber (_cfg >> "isWarning");
	};
};
_type = _type max 0 min 2;

//--- Play sound
private _sounds = ["3DEN_notificationDefault","3DEN_notificationWarning","3DEN_notificationWarning"];
playsound [_sounds select _type,true];

//--- Init notification
private _colors = ["colorNotificationDefault","colorNotificationError","colorNotificationWarning"];
private _display = finddisplay IDD_DISPLAY3DEN;
private _ctrlNotification = _display displayctrl IDC_DISPLAY3DEN_NOTIFICATION;

//--- Measure single line height
_ctrlNotification ctrlsetstructuredtext parsetext "Schnobble";
private _ctrlNotificationTextHeight = ctrltextheight _ctrlNotification;

//--- Apply custom appearance
_ctrlNotification ctrlsetstructuredtext parsetext _text;
_ctrlNotification ctrlsetbackgroundcolor ((configfile >> "Cfg3DEN" >> "Default" >> "Draw" >> (_colors select _type)) call bis_fnc_colorConfigToRGBA);
private _ctrlNotificationPos = ctrlposition _ctrlNotification;

//--- Reset position
_ctrlNotificationPos set [3,0];
_ctrlNotification ctrlsetposition _ctrlNotificationPos;
_ctrlNotification ctrlcommit 0;

//--- Animate
if !(isnil "bis_fnc_3DENNotification_spawn") then {terminate bis_fnc_3DENNotification_spawn;};
bis_fnc_3DENNotification_spawn = [_ctrlNotification,_ctrlNotificationTextHeight,_duration,_animate] spawn {
	scriptname "BIS_fnc_3DENNotification: Spawn";
	disableserialization;

	//--- Expand
	_ctrlNotification = _this select 0;
	_ctrlNotificationTextHeight = _this select 1;
	_duration = _this select 2;
	_animate = _this select 3;

	_commitTime = if (_animate) then {0.1} else {0};
	if (_duration < 0) then {_duration = 2 + (ctrltextheight _ctrlNotification / _ctrlNotificationTextHeight);}; //--- Sleep longer for each text line

	_ctrlNotificationPos = ctrlposition _ctrlNotification;
	_ctrlNotificationPos set [3,ctrltextheight _ctrlNotification];
	_ctrlNotification ctrlsetposition _ctrlNotificationPos;
	_ctrlNotification ctrlcommit _commitTime;

	uisleep _duration;

	//--- Collapse
	_ctrlNotificationPos set [3,0];
	_ctrlNotification ctrlsetposition _ctrlNotificationPos;
	_ctrlNotification ctrlcommit _commitTime;
};
_type