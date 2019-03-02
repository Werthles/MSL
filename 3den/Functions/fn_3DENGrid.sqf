#include "\a3\3DEN\UI\resincl.inc"
// Combo box values must be integers - multiply them to support fractions
#define COEF	1000

_mode = _this select 0;
_input = _this select 1;

switch _mode do {
	case "increase";
	case "decrease": {
		_dIndex = if (_mode == "increase") then {+1} else {-1};
		_cfg = configfile >> "Cfg3DEN" >> "Default" >> "Grid";
		_gridType = "translation";
		_gridDefault = getnumber (_cfg >> (_gridType + "Default"));
		_gridValue = get3DENGrid _gridType;
		_gridValues = getarray (_cfg >> _gridType);
		_index = _gridValues find _gridValue;
		_indexNew = _index + _dIndex;
		if (_index < 0) then {
			{
				_indexNew = _foreachindex;
				if (_x > _gridValue) exitwith {};
			} foreach _gridValues;
		};
		if (_indexNew >= 0 && _indexNew < count _gridValues) then {
			set3DENGrid [_gridType,_gridValues select _indexNew];
		};
	};
	case "init": {

		_control = _input select 0;
		_controlCfg = _input select 1;

		//--- Fill combo box based on config
		_gridType = gettext (_controlCfg >> "gridType");
		_cfg = configfile >> "Cfg3DEN" >> "Default" >> "Grid";
		_gridDefault = getnumber (_cfg >> (_gridType + "Default"));
		_unit = gettext (_cfg >> (_gridType + "Unit"));
		{
			_lbAdd = _control lbadd format [_unit,_x];
			_control lbsetvalue [_lbAdd,_x * COEF];
		} foreach getarray (_cfg >> _gridType);

		//--- Set default config value (only after handler was added)
		set3DENGrid [_gridType,_gridDefault];
		["OnGridChange",[_gridType,_gridDefault],false] spawn bis_fnc_3DENGrid;

		//--- Set grid when user picked an item from combo box
		_control ctrladdeventhandler [
			"lbSelChanged",
			{
				_control = _this select 0;
				_lbAdd = _this select 1;
				set3DENGrid [ctrlclassname _control,(_control lbvalue _lbAdd) / COEF];
			}
		];
	};
	case "OnGridChange": {
		disableserialization;
		_gridType = _input select 0;
		_gridValue = _input select 1;
		_force = _this select 2;
		_gridAction = "";
		_idc = switch _gridType do {
			case "translation":	{_gridAction = "MoveGridToggle"; IDC_DISPLAY3DEN_TOOLBAR_GRID_TRANSLATION_VALUE};
			case "rotation":	{_gridAction = "RotateGridToggle"; IDC_DISPLAY3DEN_TOOLBAR_GRID_ROTATION_VALUE};
			case "scaling":		{_gridAction = "ScaleGridToggle"; IDC_DISPLAY3DEN_TOOLBAR_GRID_SCALING_VALUE};
			default {-1};
		};
		if (_force && get3DENActionState _gridAction == 0) then {do3DENAction _gridAction;}; //--- Force toggle grid
		_control = finddisplay IDD_DISPLAY3DEN displayctrl _idc;
		_pictureEnabled = gettext (configfile >> "ctrlMenu" >> "pictureCheckboxEnabled");
		_pictureDisabled = gettext (configfile >> "ctrlMenu" >> "pictureCheckboxDisabled");
		_gridExist = false;
		for "_i" from 0 to (lbsize _control - 1) do {
			_value = (_control lbvalue _i) / COEF;
			_picture = if (str _value == str _gridValue) then {_gridExist = true; _pictureEnabled} else {_pictureDisabled};
			_control lbsetpictureright [_i,_picture];
			if ((_control lbdata _i) != "") then {_control lbdelete _i;};
		};
		if !(_gridExist) then {
			_text = gettext (configfile >> "Cfg3DEN" >> "Default" >> "Grid" >> "textCustom");
			_unit = gettext (configfile >> "Cfg3DEN" >> "Default" >> "Grid" >> (_gridType + "Unit"));
			_lbAdd = _control lbadd format [_text,format [_unit,_gridValue]];
			_control lbsetvalue [_lbAdd,_gridValue * COEF];
			_control lbsetdata [_lbAdd,"#"];
			_control lbsetpictureright [_lbAdd,_pictureEnabled];
		};
	};
};