/*
	Author: Karel Moricky

	Description:
	Show a pop-up message

	Syntax:
	[<text>,(<title>,<buttonOK>,<buttonCancel>,<icon>,<parentDisplay>)] call BIS_fnc_3DENShowMessage;

		* text: STRING - message body or property name from Cfg3DEN >> Messages
		* title: STRING - title
		* buttonOK: STRING (button text) or ARRAY in format [<text>,<code>]
			* text: STRING - button text
			* code: CODE - expression executed upon clicking
		* buttonCancel: Same format as buttonOK
		* icon: STRING - image path to icon on left
		* parentDisplay: DISPLAY - display from which the window is opened from

	Returns:
	DISPLAY
*/


#include "\a3\3DEN\UI\resincl.inc"

private ["_text","_title","_buttonOKData","_buttonCancelData","_parentDisplay"];
disableserialization;
_text = _this param [0,"",[""]];
_title = _this param [1,"",[""]];
_buttonOKData = _this param [2,true,[true,"",[]]];
_buttonCancelData = _this param [3,true,[true,"",[]]];
_picture = _this param [4,"",[""]];
_parentDisplay = _this param [5,finddisplay  IDD_DISPLAY3DEN,[displaynull]];

//--- Open display
private ["_display","_ctrlTitle","_ctrlBackground","_ctrlPicture","_ctrlText","_ctrlBottomBackground","_ctrlButtonOK","_ctrlButtonCancel"];
_display = _parentDisplay createdisplay "display3DENMsgBox";
_ctrlTitle = _display displayctrl IDC_DISPLAY3DENMSGBOX_TITLE;
_ctrlBackground = _display displayctrl IDC_DISPLAY3DENMSGBOX_BACKGROUND;
_ctrlPicture = _display displayctrl IDC_DISPLAY3DENMSGBOX_PICTURE;
_ctrlText = _display displayctrl IDC_MSG_BOX_MESSAGE;
_ctrlBottomBackground = _display displayctrl IDC_DISPLAY3DENMSGBOX_BOTTOMBACKGROUND;
_ctrlButtonOK = _display displayctrl IDC_OK;
_ctrlButtonCancel = _display displayctrl IDC_CANCEL;

//--- Set title
_ctrlTitle ctrlsettext _title;
if (_picture != "") then {_ctrlPicture ctrlsettext _picture;};

//--- Set text and stretch the window to fit it
private ["_h","_hh"];
if (istext (configfile >> "Cfg3DEN" >> "Messages" >> _text)) then {_text = gettext (configfile >> "Cfg3DEN" >> "Messages" >> _text);};
_ctrlText ctrlsetstructuredtext parsetext _text;
_h = ctrltextheight _ctrlText;
_hh = _h * 0.5;
{
	private ["_ctrl","_ctrlPos"];
	_ctrl = _x;
	_ctrlPos = ctrlposition _ctrl;
	_ctrlPos set [1,(_ctrlPos select 1) - _hh];
	_ctrl ctrlsetposition _ctrlPos;
	_ctrl ctrlcommit 0;
} foreach [_ctrlTitle];
{
	private ["_ctrl","_ctrlPos"];
	_ctrl = _x;
	_ctrlPos = ctrlposition _ctrl;
	_ctrlPos set [1,(_ctrlPos select 1) - _hh];
	_ctrlPos set [3,(_ctrlPos select 3) + _h];
	_ctrl ctrlsetposition _ctrlPos;
	_ctrl ctrlcommit 0;
} foreach [_ctrlBackground,_ctrlPicture,_ctrlText];
{
	private ["_ctrl","_ctrlPos"];
	_ctrl = _x;
	_ctrlPos = ctrlposition _ctrl;
	_ctrlPos set [1,(_ctrlPos select 1) + _hh];
	_ctrl ctrlsetposition _ctrlPos;
	_ctrl ctrlcommit 0;
} foreach [_ctrlBottomBackground,_ctrlButtonOK,_ctrlButtonCancel];

//--- Set buttons
private ["_buttonOKText","_buttonOKCode","_buttonCancelText","_buttonCancelCode","_showButtonOK","_showButtonCancel"];
_buttonOKText = _buttonOKData param [0,true,["",true]];
_buttonOKCode = _buttonOKData param [1,{},[{}]];
_buttonCancelText = _buttonCancelData param [0,true,["",true]];
_buttonCancelCode = _buttonCancelData param [1,{},[{}]];

_showButtonOK = if (typename _buttonOKText == typename "") then {_ctrlButtonOK ctrlsettext _buttonOKText; true} else {_buttonOKText};
_showButtonCancel = if (typename _buttonCancelText == typename "") then {_ctrlButtonCancel ctrlsettext _buttonCancelText; true} else {_buttonCancelText};

_ctrlButtonOK ctrlshow _showButtonOK;
_ctrlButtonCancel ctrlshow _showButtonCancel;

_ctrlButtonOK ctrladdeventhandler ["buttonclick",_buttonOKCode];
_ctrlButtonCancel ctrladdeventhandler ["buttonclick",_buttonCancelCode];

_display