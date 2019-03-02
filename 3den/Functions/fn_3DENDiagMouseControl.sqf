/*
[] call BIS_fnc_3DENDiagMouseControl;
*/

#include "\a3\3DEN\UI\resincl.inc"
#include "\a3\3DEN\UI\dikCodes.inc"

//#define IDD 313

#define DISPLAY		(alldisplays select (count alldisplays - 1))
#define CONTROL(IDC)	(DISPLAY displayctrl IDC)
#define IDC_BASE	69870
#define IDC_LMB		69871
#define IDC_RMB		69872
#define IDC_CTRL	69873
#define IDC_ALT		69874
#define IDC_SHIFT	69875
#define IDCS		[IDC_BASE,IDC_LMB,IDC_RMB,IDC_CTRL,IDC_ALT,IDC_SHIFT]
#define SIZE	256

disableserialization;
_display = alldisplays select (count alldisplays - 1);
if (ctrlidd _display == 56) then {_display = alldisplays select (count alldisplays - 2);}; // No debug console

//--- Create
if (isnull (_display displayctrl IDC_BASE)) then {
	_display ctrlcreate ["ctrlStaticPictureKeepAspect",IDC_BASE];
	_display ctrlcreate ["ctrlStaticPictureKeepAspect",IDC_LMB];
	_display ctrlcreate ["ctrlStaticPictureKeepAspect",IDC_RMB];
	_display ctrlcreate ["ctrlStaticPictureKeepAspect",IDC_CTRL];
	_display ctrlcreate ["ctrlStaticPictureKeepAspect",IDC_ALT];
	_display ctrlcreate ["ctrlStaticPictureKeepAspect",IDC_SHIFT];

};

//--- Set
_textures = ["mouse_ca","mouse_lmb_ca","mouse_rmb_ca","mouse_ctrl_ca","mouse_alt_ca","mouse_shift_ca"];
_show = [true,false,false,false,false,false];
{
	_ctrl = _display displayctrl _x;
	_ctrl ctrlsettext format ["\a3\3DEN\Data\ControlsGroups\DiagMouseControl\%1.paa",_textures select _foreachindex];
	_ctrl ctrlsetposition [
		safezoneX,
		safezoneY + safezoneH - (SIZE * pixelH),
		SIZE * pixelW,
		SIZE * pixelH
	];
	_ctrl ctrlcommit 0;
	_ctrl ctrlshow (_show select _foreachindex);
} foreach IDCS;

//--- Double click anim in display which are accessed that way
if (ctrlidd DISPLAY in [315,321]) then {
	[] spawn {
		(finddisplay 313 displayctrl IDC_LMB) ctrlshow false;
		CONTROL(IDC_LMB) ctrlshow true;
		sleep 0.2;
		CONTROL(IDC_LMB) ctrlshow false;
	};
};

//--- Register handlers
_display displayremoveeventhandler ["mousebuttondown",missionnamespace getvariable ["debug5_mouseButtonDown",-1]];
debug5_mouseButtonDown = _display displayaddeventhandler [
	"mousebuttondown",
	{
		if (ctrlshown CONTROL(IDC_BASE)) then {
			if ((_this select 1) > 0) then {
				CONTROL(IDC_RMB) ctrlshow true;
			} else {
				CONTROL(IDC_LMB) ctrlshow true;
			};
		};
	}
];

_display displayremoveeventhandler ["mousebuttonup",missionnamespace getvariable ["debug5_mouseButtonUp",-1]];
debug5_mouseButtonUp = _display displayaddeventhandler [
	"mousebuttonup",
	{
		if ((_this select 1) > 0) then {
			CONTROL(IDC_RMB) ctrlshow false;
		} else {
			CONTROL(IDC_LMB) ctrlshow false;
		};
	}
];
_display displayremoveeventhandler ["keydown",missionnamespace getvariable ["debug5_keyDown",-1]];
debug5_keyDown = _display displayaddeventhandler [
	"keydown",
	{
		_return = false;
		switch (_this select 1) do {
			case DIK_LCONTROL: {CONTROL(IDC_CTRL) ctrlshow true;};
			case DIK_LMENU: {CONTROL(IDC_ALT) ctrlshow true;};
			case DIK_LSHIFT: {CONTROL(IDC_SHIFT) ctrlshow true;};
			case DIK_SPACE: {CONTROL(IDD_GROUPHIGHLIGHT) ctrlshow !(ctrlshown CONTROL(IDD_GROUPHIGHLIGHT)); _return = true;};
			case DIK_I: {CONTROL(IDC_BASE) ctrlshow !(ctrlshown CONTROL(IDC_BASE)); _return = true;};
		};
		_return
	}
];
_display displayremoveeventhandler ["keyup",missionnamespace getvariable ["debug5_keyUp",-1]];
debug5_keyUp = _display displayaddeventhandler [
	"keyup",
	{
		switch (_this select 1) do {
			case DIK_LCONTROL: {CONTROL(IDC_CTRL) ctrlshow false;};
			case DIK_LMENU: {CONTROL(IDC_ALT) ctrlshow false;};
			case DIK_LSHIFT: {CONTROL(IDC_SHIFT) ctrlshow false;};
		};
		false
	}
];

/*
get3dencamera setposasl [3886.96,7317.2,8.45053];
get3dencamera setVectorDirAndUp [[0.51049,-0.728029,-0.457583],[0.262708,-0.374657,0.889166]];

_pos = [[7476.51,7498.76,7.65108],[[-0.642932,0.60731,-0.466731],[-0.339296,0.320497,0.884399]]];
_pos = [[7478.48,7497.83,7.21721],[[-0.642924,0.607302,-0.466725],[-0.33929,0.320491,0.884402]]];
_pos = [[7505.17,7356.67,8.55624],[[0.790822,-0.453025,-0.411553],[0.357111,-0.204573,0.911385]]];
_pos = [[7505.17,7356.68,8.5623],[[0.732595,-0.52837,-0.429106],[0.348032,-0.251012,0.903253]]];

//get3dencamera setposasl (_pos select 0);
//get3dencamera setVectorDirAndUp (_pos select 1);
*/

(finddisplay 313 displayctrl 32323) ctrlshow false