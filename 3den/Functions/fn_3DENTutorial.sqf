/*
	Author: Karel Moricky

	Description:
	Show tutorial in Eden Editor

	Parameter(s):
		0: STRING - path in format [<categoryClass>,<tutorialClass>], classes are from Cfg3DEN >> Tutorials
		1 (Optional): NUMBER - index of step at which tutorial starts (0 by default)
		2 (Optional): BOOL - true to show only one step, without ability to go forward or backward (false by default)
		3 (Optional): DISPLAY - parent display (Display3DEN by default)

	Returns:
	NOTHING
*/

#include "\a3\3DEN\UI\resincl.inc"
#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\dikCodes.inc"

disableserialization;
private _path = _this param [0,[],[[],displaynull]];
private _display = _this param [3,displaynull,[displaynull]];
private _displayMain = finddisplay IDD_DISPLAY3DEN;
if (isnull _display) then {_display = _displayMain;};
private _displayIDD = ctrlidd _display;

//--- Restore the hint on the child display when it's opened over the main display
if (_path isequaltype displaynull) exitwith {
	_data = uinamespace getvariable ["bis_fnc_3DENTutorial_childcreated",[[],[]]];
	if ((ctrlidd _path) in (_data select 0)) then {
		[nil,nil,nil,_displayMain] call bis_fnc_3dentutorial;
		((_data select 1) + [nil,_path]) call bis_fnc_3dentutorial;
	};
};

//--- Remove existing tutorial
if (count _path != 2) exitwith {
	_display call bis_fnc_highlightControl;
	_display displayremoveeventhandler ["keydown",uinamespace getvariable ["bis_fnc_3DENTutorial_keydown",-1]];
	_displayMain displayremoveeventhandler ["childdestroyed",uinamespace getvariable ["bis_fnc_3DENTutorial_childdestroyed",-1]];
	uinamespace setvariable ["bis_fnc_3DENTutorial_keydown",nil];
	uinamespace setvariable ["bis_fnc_3DENTutorial_childdestroyed",nil];
	uinamespace setvariable ["bis_fnc_3DENTutorial_childcreated",nil];
	ctrldelete (_display displayctrl IDD_GROUPTUTORIAL);
};

private _pathCategory = _path param [0,"",[""]];
private _pathClass = _path param [1,"",[""]];


private _cfgTutorial = configfile >> "Cfg3DEN" >> "Tutorials" >> _pathCategory >> "Sections" >>  _pathClass;
private _displays = getarray (_cfgTutorial >> "displays");
private _cfgSteps = _cfgTutorial >> "Steps";
if !(isclass _cfgSteps) exitwith {["Path %1 >> %2 doesn't exist in Cfg3DEN >> Tutorials!",_pathCategory,_pathClass] call bis_fnc_error;};

_index = _this param [1,0,[0,""]];
if (typename _index == typename "") then {
	{if (configname _x == _index) exitwith {_index = _foreachindex};} foreach configproperties [_cfgSteps];
};
if (_index >= count _cfgSteps) exitwith {["Index %1 not found in Cfg3DEN >> Tutorials >> %2 >> Sections >> %3!",_index,_pathCategory,_pathClass] call bis_fnc_error;};

private _isSingle = _this param [2,false,[false]]; //--- Find singles in your area ;)

private _cfgStep = _cfgSteps select _index;
private _text = gettext (_cfgStep >> "text");
private _posX = getnumber (_cfgStep >> "x");
private _posY = getnumber (_cfgStep >> "y");
private _expression = gettext (_cfgStep >> "expression");
private _variables = getarray (_cfgStep >> "variables");
private _highlightIDC = getnumber (_cfgStep >> "highlight");
private _highlight = _display displayctrl _highlightIDC;

//--- Delete previous control
ctrldelete (_display displayctrl IDD_GROUPTUTORIAL);

//--- Create control
private _ctrlTutorial = _display ctrlcreate ["ctrlControlsGroupTutorial",IDD_GROUPTUTORIAL];
private _ctrlShadow = _ctrlTutorial controlsgroupctrl IDD_GROUPTUTORIAL_SHADOW;
private _ctrlBackground = _ctrlTutorial controlsgroupctrl IDD_GROUPTUTORIAL_BACKGROUND;
private _ctrlText = _ctrlTutorial controlsgroupctrl IDD_GROUPTUTORIAL_TEXT;
private _ctrlPage = _ctrlTutorial controlsgroupctrl IDD_GROUPTUTORIAL_PAGE;
private _ctrlButtonClose = _ctrlTutorial controlsgroupctrl IDD_GROUPTUTORIAL_BUTTONCLOSE;
private _ctrlButtonBack = _ctrlTutorial controlsgroupctrl IDD_GROUPTUTORIAL_BUTTONBACK;
private _ctrlButtonNext = _ctrlTutorial controlsgroupctrl IDD_GROUPTUTORIAL_BUTTONNEXT;
private _ctrlButtonExit = _ctrlTutorial controlsgroupctrl IDD_GROUPTUTORIAL_BUTTONEXIT;
private _ctrlBackgroundOffsetH = GRID_H;

//--- Convert DIK codes to key names
{
	if (_x isequaltype []) then {
		_DIK = _x param [0,0,[0]];
		_variables set [_foreachindex,localize format ["STR_DIK_%1",_DIK call bis_fnc_keyCode]];
	};
} foreach _variables;

//--- Hide navigation buttons when only one hint is displayed
if (_isSingle) then {
	{_x ctrlshow false;} foreach [_ctrlButtonBack,_ctrlButtonNext,_ctrlPage];
	_ctrlBackgroundOffsetH = 0;
};
_ctrlText ctrlsetstructuredtext parsetext format (
	[
		_text,
		/* %1 */ "<img image='\a3\3DEN\Data\Controls\ctrlMenu\arrow_ca.paa' />",
		/* %2 */ "t font='RobotoCondensedBold'",
		/* %3 */ "/t",
		/* %4 */ "",
		/* %5 */ "",
		/* %6 */ "",
		/* %7 */ "",
		/* %8 */ "",
		/* %9 */ ""
	] + _variables
);
private _ctrlTextPos = ctrlposition _ctrltext;
_ctrlTextPos set [3,ctrltextheight _ctrlText];
_ctrlText ctrlsetposition _ctrlTextPos;
_ctrlText ctrlcommit 0;

_ctrlPage ctrlsettext format ["%1 / %2",_index + 1,count _cfgSteps];

{
	_ctrlPos = ctrlposition _x;
	_ctrlPos set [1,(_ctrlTextPos select 1) + (_ctrlTextPos select 3) + 4 * GRID_H];
	_ctrlPos set [3,if (_isSingle) then {0} else {_ctrlPos select 3}];
	_x ctrlsetposition _ctrlPos;
	_x ctrlcommit 0;
} foreach [_ctrlButtonBack,_ctrlButtonNext,_ctrlButtonExit,_ctrlPage];
{
	_ctrlPos = ctrlposition _x;
	_ctrlPos set [3,(ctrlposition _ctrlButtonBack select 1) + (ctrlposition _ctrlButtonBack select 3) + _ctrlBackgroundOffsetH];
	_x ctrlsetposition _ctrlPos;
	_x ctrlcommit 0;
} foreach [_ctrlBackground,_ctrlShadow];

private _ctrlTutorialPos = ctrlposition _ctrlTutorial;
_ctrlTutorialPos set [3,(ctrlposition _ctrlBackground select 3) + GRID_H];
if (_posX == 0) then {_posX = 0.5 - (_ctrlTutorialPos select 2) * 0.5;};
if (_posY == 0) then {_posY = 0.5 - (_ctrlTutorialPos select 3) * 0.5;};
_ctrlTutorialPos set [0,_posX];
_ctrlTutorialPos set [1,_posY];
_ctrlTutorial ctrlsetposition _ctrlTutorialPos;
_ctrlTutorial ctrlcommit 0;

if (_index == 0) then {_ctrlButtonBack ctrlshow false;};
if (_index >= (count _cfgSteps - 1)) then {_ctrlButtonNext ctrlshow false;} else {_ctrlButtonExit ctrlshow false;};
_ctrlButtonBack ctrladdeventhandler ["buttonclick",format ["[%1,%2,nil,finddisplay %3] spawn bis_fnc_3dentutorial",_path,_index - 1,_displayIDD]];
_ctrlButtonNext ctrladdeventhandler ["buttonclick",format ["[%1,%2,nil,finddisplay %3] spawn bis_fnc_3dentutorial",_path,_index + 1,_displayIDD]];
_ctrlButtonExit ctrladdeventhandler [
	"buttonclick",
	format [
		"
			_completed = profilenamespace getvariable ['display3DENTutorial_completed',[]];
			if !(%1 in _completed) then {
				_completed pushback %1;
				profilenamespace setvariable ['display3DENTutorial_completed',_completed];
				saveprofilenamespace;
				uinamespace setvariable ['display3DENTutorial_select',%1];
			};
			_display = finddisplay %2;
			[nil,nil,nil,_display] spawn bis_fnc_3dentutorial;
			if (ctrlidd _display == 313) then {
				_display createdisplay 'Display3DENTutorial';
			};
		",
		_path,
		_displayIDD
	]
];
_ctrlButtonClose ctrladdeventhandler ["buttonclick",format ["[nil,nil,nil,finddisplay %1] spawn bis_fnc_3dentutorial",_displayIDD]];
[_ctrlTutorial] call compile _expression;

//--- Add control by arrow keys
_display displayremoveeventhandler ["keydown",uinamespace getvariable ["bis_fnc_3DENTutorial_keydown",-1]];
uinamespace setvariable [
	"bis_fnc_3DENTutorial_keydown",
	_display displayaddeventhandler [
		"keydown",
		format [
			"
				switch (_this select 1) do {
					case %1: {[nil,nil,nil,finddisplay %6] spawn bis_fnc_3dentutorial; true};
					case %2: {[%4,%5 - 1,nil,finddisplay %6] spawn bis_fnc_3dentutorial; true};
					case %3: {[%4,%5 + 1,nil,finddisplay %6] spawn bis_fnc_3dentutorial; true};
					default {false};
				};
			",
			DIK_ESCAPE,
			if (ctrlshown _ctrlButtonBack) then {DIK_LEFT} else {-1},
			if (ctrlshown _ctrlButtonNext) then {DIK_RIGHT} else {-1},
			_path,
			_index,
			_displayIDD
		]
	]
];

//--- Restore the hint on the main display when child display is closed
_displayMain displayremoveeventhandler ["childdestroyed",uinamespace getvariable ["bis_fnc_3DENTutorial_childdestroyed",-1]];
if (_display != _displayMain) then {
	uinamespace setvariable [
		"bis_fnc_3DENTutorial_childdestroyed",
		_displayMain displayaddeventhandler [
			"childdestroyed",
			format [
				"[%1,%2] spawn bis_fnc_3dentutorial;",
				_path,
				_index
			]
		]
	];
};

//--- Restore the hint on the child display when it's opened over the main display
uinamespace setvariable ["bis_fnc_3DENTutorial_childcreated",[_displays,[_path,_index]]];

//--- Highlight control
if (isnull _highlight || _highlightIDC == 0) then {
	_display call bis_fnc_highlightControl;
} else {
	_highlight call bis_fnc_highlightControl;
};

ctrlsetfocus _ctrlTutorial; //--- Make sure hightlight doesn't overlap the hint