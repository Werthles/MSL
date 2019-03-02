#include "\a3\3DEN\UI\resincl.inc"

private ["_mode"];
_mode = [_this,0,"",[""]] call bis_fnc_param;
_mode = tolower _mode;

switch _mode do {
	case "random": {

		//--- Select random position on land, prefer not forested areas
		_radius = worldsize * 0.5;
		_condition = if (random 1 < 0.1) then {"(waterDepth interpolate [0,1,1,0])"} else {"(waterDepth interpolate [0,1,1,0]) * (1 - forest)"};
		_pos = (selectbestplaces [[_radius,_radius,0],_radius,_condition,200,1]) select 0 select 0;

		//--- Move camera
		_pos set [2,10];
		_camera = get3DENCamera;
		_camera setposatl _pos;
		_camera setdir random 360;
		[_camera,-10,0] call bis_fnc_setpitchbank;

		//--- Move map
		_ctrlMap = (finddisplay IDD_DISPLAY3DEN) displayctrl IDC_DISPLAY3DEN_MAP;
		_ctrlMap ctrlmapanimadd [0,(1500 / worldsize) max (ctrlmapscale _ctrlMap),_pos];
		ctrlmapanimcommit _ctrlMap;
	};
	case "selected": {

		_pos = [];

		//--- Use cursor position as default (only when menu bar is closed and nothing is selected)
		if (
			count menuhover (finddisplay IDD_DISPLAY3DEN displayctrl IDC_DISPLAY3DEN_MENUSTRIP) == 0
			&&
			{{count _x > 0} count (get3DENSelected "" + [get3DENSelected "Comment",get3DENSelected "Layer"]) == 0}
		) then {
			_pos = if (get3denactionstate "togglemap" > 0) then {
				(finddisplay IDD_DISPLAY3DEN displayctrl IDC_DISPLAY3DEN_MAP) ctrlmapscreentoworld getmouseposition;
			} else {
				screentoworld getmouseposition;
			};
			_pos set [2,(_pos param [2,0]) + getterrainheightasl _pos];
		};

		//--- Check for comments (they're not listed among all entities)
		{
			_pos = (_x get3DENAttribute "position") select 0;
		} foreach (get3DENSelected "Comment");

		//--- Check for layer recursively (a layer can contain another layers)
		scopename "selected";
		_fnc_getLayerEntities = {
			{
				if (_x isequaltype 0) then {
					_x call _fnc_getLayerEntities;
				} else {
					_pos = (_x get3DENAttribute "position") select 0;
					if (count _pos > 0) then {_pos set [2,(_pos param [2,0]) + getterrainheightasl _pos];};
					breakto "selected";
				};
			} foreach get3DENLayerEntities _this;
		};
		{
			_x call _fnc_getLayerEntities;
		} foreach (get3DENSelected "Layer");

		//--- Check for actually selected entities
		{
			if (count _x > 0) then {
				_pos = ((_x select 0) get3DENAttribute "position") select 0;
				if (count _pos > 0) then {_pos set [2,(_pos param [2,0]) + getterrainheightasl _pos];};
			};
		} foreach (get3DENSelected "");

		//--- Move camera to ASL position
		if (count _pos > 0) then {
			move3DENCamera [_pos,true];
		};
	};
};

/*
pix = (worldsize * scale) / res
pix * res = worldsize * scale
scale = (pix * res) / scale*/