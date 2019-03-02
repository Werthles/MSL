#include "\a3\3DEN\UI\resincl.inc"

_mode = param [0,"",[""]];

switch (tolower _mode) do {

	case "init": {
		_icon = gettext (configfile >> "cfg3DEN" >> "Default" >> "Draw" >> "locationList");

		_ctrl = finddisplay IDD_DISPLAY3DEN displayctrl IDC_DISPLAY3DEN_LOCATIONS;
		tvclear _ctrl;

		//--- World
		_idCategory = _ctrl tvadd [[],gettext (configfile >> "cfgWorlds" >> worldname >> "description")];
		{
			_idLocation = _ctrl tvadd [[_idCategory],text _x];
			_ctrl tvsetdata [[_idCategory,_idLocation],str locationposition _x];
			_ctrl tvsetpicture [[_idCategory,_idLocation],_icon];
		} foreach nearestlocations [[0,0,0],["nameVillage","nameCity","nameCityCapital"],worldsize * sqrt 2];

		_ctrl tvsort [[_idCategory],false];
		_ctrl tvexpand [_idCategory];
	};

	case "select": {
		_input = param [1,[],[[]]];
		_ctrl = _input param [0,controlnull,[controlnull]];
		_path = _input param [1,[],[[]]];
		_data = _ctrl tvdata _path;
		if (_data != "") then {
			_pos = call compile _data;
			_pos set [2,0];
			_offsetY = 200;
			_offsetZ = 50;
			move3DENCamera [
				[
					(_pos select 0),
					(_pos select 1) - _offsetY,
					(getTerrainHeightASL _pos) + _offsetZ
				],
				false
			];
			get3DENCamera setdir 0;
			[get3DENCamera,-asin (_offsetZ / _offsetY),0] call bis_fnc_setpitchbank;
		};
	};
};