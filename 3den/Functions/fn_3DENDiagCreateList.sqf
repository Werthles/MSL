#include "\a3\3DEN\UI\resincl.inc"

_display = finddisplay IDD_DISPLAY3DEN;
if !(isnull _display) then {

	_allClasses = [];
	{
		_scopeMin = if (getnumber (_x >> "side") == 7) then {1} else {0};
		if (getnumber (_x >> "scope") > _scopeMin) then {_allClasses pushback configname _x;};
	} foreach (configproperties [configfile >> "cfgvehicles","isclass _x"]);

	{
		_ctrl = _display displayctrl _x;
		for "_f" from 0 to ((_ctrl tvcount []) - 1) do {
			for "_c" from 0 to ((_ctrl tvcount [_f]) - 1) do {
				for "_v" from 0 to ((_ctrl tvcount [_f,_c]) - 1) do {
					_class = _ctrl tvdata [_f,_c,_v];
					_allClasses = _allClasses - [_class];
				};
			};
		};
	} foreach [
		IDC_DISPLAY3DEN_CREATE_OBJECT_WEST,
		IDC_DISPLAY3DEN_CREATE_OBJECT_EAST,
		IDC_DISPLAY3DEN_CREATE_OBJECT_GUER,
		IDC_DISPLAY3DEN_CREATE_OBJECT_CIV,
		IDC_DISPLAY3DEN_CREATE_OBJECT_EMPTY
	];
	{
		_ctrl = _display displayctrl _x;
		for "_c" from 0 to ((_ctrl tvcount []) - 1) do {
			for "_v" from 0 to ((_ctrl tvcount [_c]) - 1) do {
				_class = _ctrl tvdata [_c,_v];
				_allClasses = _allClasses - [_class];
			};
		};
	} foreach [
		IDC_DISPLAY3DEN_CREATE_OBJECT_LOGIC,
		IDC_DISPLAY3DEN_CREATE_OBJECT_MODULE
	];

	_text = "";
	_br = tostring [13,10];
	{
		_cfg = configfile >> "cfgvehicles" >> _x;
		_text = _text + _x + "	" + str getnumber (_cfg >> "scope") + "	" + str getnumber (_cfg >> "side") + "	" + gettext (_cfg >> "vehicleclass") + _br;
	} foreach _allClasses;
	copytoclipboard _text;
};