#include "\a3\3DEN\UI\resincl.inc"
#include "\a3\3DEN\UI\macros.inc"

private ["_parent","_area","_thickness","_ctrl"];
_parent = _this param [0,controlnull,[controlnull,displaynull]];
_thickness = _this param [1,20,[0]];

if (typename _parent == typename displaynull) exitwith {
	ctrldelete (_parent displayctrl IDD_GROUPHIGHLIGHT);
};

if (isnull _parent) exitwith {["Control not found!"] call bis_fnc_error; controlnull};

//--- Calculate position in controls groups
_area = ctrlposition _parent;
_parentTemp = ctrlparentcontrolsgroup _parent;
_parents = [_parent];
while {!isnull _parentTemp} do {
	_area set [0,(_area select 0) + (ctrlposition _parentTemp select 0)];
	_area set [1,(_area select 1) + (ctrlposition _parentTemp select 1)];
	_parents pushback _parentTemp;
	_parentTemp = ctrlparentcontrolsgroup _parentTemp;
};

//--- Delete previous control
ctrldelete ((ctrlparent _parent) displayctrl IDD_GROUPHIGHLIGHT);

//--- Create control
_ctrl = (ctrlparent _parent) ctrlcreate ["ctrlControlsGroupHighlight",IDD_GROUPHIGHLIGHT];

//--- Increase area size so it's an outside border
_sizeW = _thickness * pixelW;
_sizeH = _thickness * pixelH;
_areaW = _area select 2;
_areaH = _area select 3;
_area = [
	(_area select 0) - _sizeW,
	(_area select 1) - _sizeH,
	_areaW + 2 * _sizeW,
	_areaH + 2 * _sizeH
];
_ctrl ctrlsetposition _area;
_ctrl ctrlcommit 0;
_ctrl ctrlenable false;

//--- Init glow effect
{

	_ctrlTile = _ctrl controlsgroupctrl (313130 + _foreachindex);
	_ctrlTile ctrlsetposition _x;
	_ctrlTile ctrlcommit 0;
} foreach [
	/* TL */ [0,			0,			_sizeW,_sizeH],
	/* TM */ [_sizeW,		0,			_areaW,_sizeH],
	/* TR */ [_sizeW + _areaW,	0,			_sizeW,_sizeH],
	/* ML */ [0,			_sizeH,			_sizeW,_areaH],
	/* MR */ [_sizeW + _areaW,	_sizeH,			_sizeW,_areaH],
	/* BL */ [0,			_sizeH + _areaH,	_sizeW,_sizeH],
	/* BM */ [_sizeW,		_sizeH + _areaH,	_areaW,_sizeH],
	/* BR */ [_sizeW + _areaW,	_sizeH + _areaH,	_sizeW,_sizeH]
];

//--- Animate
[_parents,_ctrl] spawn {
	disableserialization;
	scriptname "BIS_fnc_highlightControl: Animation";
	_parents = _this select 0;
	_ctrl = _this select 1;
	disableserialization;
	_show = true;
	while {!isnull _ctrl} do {
		if ({!ctrlshown _x || ctrlfade _x > 0 || (ctrlposition _x select 1) > 5} count _parents == 0) then {
			_show = !_show;
			//_ctrl ctrlshow true;
			_ctrl ctrlsetfade ([0.8,0] select _show);
			_ctrl ctrlcommit 0.4;
			waituntil {ctrlcommitted _ctrl};
		} else {
			_ctrl ctrlshow false;
		};
	};
};
_ctrl