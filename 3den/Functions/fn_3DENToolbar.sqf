#include "\a3\3DEN\UI\resincl.inc"

_fnc_checkButton = {
	if (get3DENActionState _mode < 0) then {
		//--- Action state not initialized yet, spawn the same code with a delay
		[_mode] spawn BIS_fnc_3denToolbar;
	} else {
		(finddisplay IDD_DISPLAY3DEN displayctrl _this) cbsetchecked ([false,true] select get3DENActionState _mode);
	};
};

disableserialization;
private ["_mode"];
_mode = _this param [0,"",[""]];

switch _mode do {
	case "Init": {
		"VerticalToggle" call bis_fnc_3DENToolbar;
		"SurfaceSnapToggle" call bis_fnc_3DENToolbar;
		"WidgetToggle" call bis_fnc_3DENToolbar;
		"ToggleVision" call bis_fnc_3DENToolbar;
	};
	case "VerticalToggle": {
		IDC_DISPLAY3DEN_TOOLBAR_VERT call _fnc_checkButton;
	};
	case "SurfaceSnapToggle": {
		IDC_DISPLAY3DEN_TOOLBAR_SRFSNAP call _fnc_checkButton;
	};
	case "MoveGridToggle": {
		IDC_DISPLAY3DEN_TOOLBAR_GRID_TRANSLATION call _fnc_checkButton;
	};
	case "RotateGridToggle": {
		IDC_DISPLAY3DEN_TOOLBAR_GRID_ROTATION call _fnc_checkButton;
	};
	case "ScaleGridToggle": {
		IDC_DISPLAY3DEN_TOOLBAR_GRID_SCALING call _fnc_checkButton;
	};
	case "ScaleGridToggle": {
		IDC_DISPLAY3DEN_TOOLBAR_GRID_SCALING call _fnc_checkButton;
	};
	case "WidgetToggle": {
		{
			_ctrl = finddisplay IDD_DISPLAY3DEN displayctrl (_x select 1);
			_ctrl cbsetchecked (get3DENActionState (_x select 0) > 0);
		} foreach [
			["WidgetNone",IDC_DISPLAY3DEN_WIDGET_NONE],
			["WidgetTranslation",IDC_DISPLAY3DEN_WIDGET_TRANSLATION],
			["WidgetRotation",IDC_DISPLAY3DEN_WIDGET_ROTATION],
			["WidgetScale",IDC_DISPLAY3DEN_WIDGET_SCALING],
			["WidgetArea",IDC_DISPLAY3DEN_WIDGET_AREA]
		];
	};
	case "ToggleMap": {
		IDC_DISPLAY3DEN_TOOLBAR_MISSION_MAP call _fnc_checkButton;
	};
	case "ToggleVision": {
		_texture = [
			"\a3\3DEN\Data\Displays\Display3DEN\ToolBar\vision_normal_ca.paa",
			"\a3\3DEN\Data\Displays\Display3DEN\ToolBar\vision_nvg_ca.paa",
			"\a3\3DEN\Data\Displays\Display3DEN\ToolBar\vision_ti_ca.paa"
		] select (uinamespace getvariable ["BIS_fnc_3denVisionMode_mode",0]);
		(finddisplay IDD_DISPLAY3DEN displayctrl IDC_DISPLAY3DEN_TOOLBAR_MISSION_VISION) ctrlsettext _texture;
	};
	case "ToggleFlashlight": {
		_toggle = [true,false] select (isnil {uinamespace getvariable "BIS_fnc_3denFlashlight_light"});
		(finddisplay IDD_DISPLAY3DEN displayctrl IDC_DISPLAY3DEN_TOOLBAR_MISSION_FLASHLIGHT) cbsetchecked _toggle;
	};
	case "MissionSection": {
		_ctrlList = (finddisplay IDD_DISPLAY3DEN) displayctrl IDC_DISPLAY3DEN_TOOLBAR_WORKSPACE;
		for "_i" from 0 to (lbsize _ctrlList - 1) do {
			if (get3DENActionState (_ctrlList lbdata _i) > 0 && {lbcursel _ctrlList != _i}) exitwith {_ctrlList lbsetcursel _i;}; //--- Sellect current section
		};
		['ButtonPlay'] call bis_fnc_3DENInterface; //--- Refresh PLAY button text, it has section mentioned in it
	};
	case "History": {
		_display = finddisplay IDD_DISPLAY3DEN;
		{
			_ctrl = _display displayctrl (_x select 1);
			_ctrl ctrlenable (get3DENActionState (_x select 0) == 0);
		} foreach [
			["Undo",IDC_DISPLAY3DEN_TOOLBAR_UNDO],
			["Redo",IDC_DISPLAY3DEN_TOOLBAR_REDO]
		];
	};
};