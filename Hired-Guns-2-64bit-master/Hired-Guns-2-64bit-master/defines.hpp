//defines.hpp
//Runs on all machines
//Included from description.ext
//Standard list of Arma 3 GUI definitions

#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102


// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_UPPERCASE      0xC0
#define ST_LOWERCASE      0xD0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar 
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

// Fonts
#define GUI_FONT_NORMAL			PuristaMedium
#define GUI_FONT_BOLD			PuristaSemibold
#define GUI_FONT_THIN			PuristaLight
#define GUI_FONT_MONO			EtelkaMonospacePro
#define GUI_FONT_NARROW			EtelkaNarrowMediumPro
#define GUI_FONT_CODE			LucidaConsoleB
#define GUI_FONT_SYSTEM			TahomaB



// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar 
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4
#define MB_ERROR_DIALOG   8

// Xbox buttons
#define KEY_XINPUT                0x00050000
#define KEY_XBOX_A                KEY_XINPUT + 0
#define KEY_XBOX_B                KEY_XINPUT + 1
#define KEY_XBOX_X                KEY_XINPUT + 2
#define KEY_XBOX_Y                KEY_XINPUT + 3
#define KEY_XBOX_Up               KEY_XINPUT + 4
#define KEY_XBOX_Down             KEY_XINPUT + 5
#define KEY_XBOX_Left             KEY_XINPUT + 6
#define KEY_XBOX_Right            KEY_XINPUT + 7
#define KEY_XBOX_Start            KEY_XINPUT + 8
#define KEY_XBOX_Back             KEY_XINPUT + 9
#define KEY_XBOX_LeftBumper       KEY_XINPUT + 10
#define KEY_XBOX_RightBumper      KEY_XINPUT + 11
#define KEY_XBOX_LeftTrigger      KEY_XINPUT + 12
#define KEY_XBOX_RightTrigger     KEY_XINPUT + 13
#define KEY_XBOX_LeftThumb        KEY_XINPUT + 14
#define KEY_XBOX_RightThumb       KEY_XINPUT + 15
#define KEY_XBOX_LeftThumbXRight  KEY_XINPUT + 16
#define KEY_XBOX_LeftThumbYUp     KEY_XINPUT + 17
#define KEY_XBOX_RightThumbXRight KEY_XINPUT + 18
#define KEY_XBOX_RightThumbYUp    KEY_XINPUT + 19
#define KEY_XBOX_LeftThumbXLeft   KEY_XINPUT + 20
#define KEY_XBOX_LeftThumbYDown   KEY_XINPUT + 21
#define KEY_XBOX_RightThumbXLeft  KEY_XINPUT + 22
#define KEY_XBOX_RightThumbYDown  KEY_XINPUT + 23

// Fonts
#define GUI_FONT_NORMAL			PuristaMedium
#define GUI_FONT_BOLD			PuristaSemibold
#define GUI_FONT_THIN			PuristaLight
#define GUI_FONT_MONO			EtelkaMonospacePro
#define GUI_FONT_NARROW			EtelkaNarrowMediumPro
#define GUI_FONT_CODE			LucidaConsoleB
#define GUI_FONT_SYSTEM			TahomaB

// Grids
#define GUI_GRID_CENTER_WAbs		((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_CENTER_HAbs		(GUI_GRID_CENTER_WAbs / 1.2)
#define GUI_GRID_CENTER_W		(GUI_GRID_CENTER_WAbs / 40)
#define GUI_GRID_CENTER_H		(GUI_GRID_CENTER_HAbs / 25)
#define GUI_GRID_CENTER_X		(safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_Y		(safezoneY + (safezoneH - GUI_GRID_CENTER_HAbs)/2)


////////////////
//Base Classes//
////////////////

class TargetText
{
	style = 18;
	SizeEx = 0.035;
	lineSpacing = 1;
    access = 0;
    idc = -1;
    type = CT_STATIC;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
    shadow = 0;
    font = "PuristaLight";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
};
class MissionText
{
	style = 82;
	SizeEx = 0.035;
	lineSpacing = 1;
    access = 0;
    idc = -1;
    type = CT_STATIC;
    colorBackground[] = {0.05,0.05,0,0.15};
    colorText[] = {1,1,1,1};
    text = "";
    shadow = 0;
    font = "PuristaBold";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
};
class QuadSelected
{
	style = 2096;
	colorText[] = {0.1,0.1,1,1};
    access = 0;
    idc = -1;
    type = CT_STATIC;
    colorBackground[] = {0,0,0,0};
    font = "PuristaLight";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
};
class QuadButton
{
	style = 2096;
    access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,0.95};
    colorDisabled[] = {0,0,0,0};
	colorBackground[] = {1,1,1,0};
	colorBackgroundDisabled[] = {1,1,1,0};
	colorBackgroundActive[] = {1,1,1,0};
    colorFocused[] = {0,0,0,0};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};
    soundEnter[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundEnter.wss",0.3,1};
    soundPush[] = {"\a3\ui_f\data\sound\RscButtonMenuOK\soundPush.wss",0.3,1};
    soundClick[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundClick.wss",0.3,1};
    soundEscape[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundEscape.wss",0.3,1};
    x = 0;
    y = 0;
    w = 0.0;
    h = 0.0;
    shadow = 0;
    font = "PuristaBold";
    sizeEx = 0.055;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    borderSize = 0;
	fadein = 0.1;
	fadeout = 0.1;
	onMouseEnter = "(_this select 0) ctrlSetTextColor [0.1,0.1,1,1];";
	onMouseExit = "(_this select 0) ctrlSetTextColor [1,1,1,1];";
};
class SideButton
{
    access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,0.95};
    colorDisabled[] = {0,0,0,0};
    colorBackground[] = {1,1,1,0.2};
    colorBackgroundDisabled[] = {1,1,1,0.2};
    colorBackgroundActive[] = {1,1,1,0.35};
    colorFocused[] = {0,0,0,0};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};
    soundEnter[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundEnter.wss",0.3,1};
    soundPush[] = {"\a3\ui_f\data\sound\RscButtonMenuOK\soundPush.wss",0.3,1};
    soundClick[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundClick.wss",0.3,1};
    soundEscape[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundEscape.wss",0.3,1};
	style = 98;
    x = 0;
    y = 0;
    w = 0.0;
    h = 0.0;
    shadow = 0;
    font = "PuristaBold";
    sizeEx = 0.055;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    borderSize = 0;
	fadein = 0.1;
	fadeout = 0.1;
	onMouseEnter = "(_this select 0) ctrlSetTextColor [0.1,0.1,1,1];";
	onMouseExit = "(_this select 0) ctrlSetTextColor [1,1,1,1];";
};
class MissionButton
{
	//style = 18;
	SizeEx = 0.035;
	lineSpacing = 1;
    access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,0.95};
    colorDisabled[] = {0,0,0,0};
    colorBackground[] = {117/256,117/256,102/256,0.2};
    colorBackgroundDisabled[] = {117/256,117/256,102/256,0.2};
    colorBackgroundActive[] = {117/256,117/256,102/256,0.35};
    colorFocused[] = {0.05,0.05,00,0};
    colorShadow[] = {0.05,0.05,0,0};
    colorBorder[] = {0.05,0.05,0,0};
    soundEnter[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundEnter.wss",0.3,1};
    soundPush[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundPush.wss",0.3,1};
    soundClick[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundClick.wss",0.3,1};
    soundEscape[] = {"\a3\ui_f\data\sound\RscButtonMenu\soundEscape.wss",0.3,1};
    style = 82;
    x = 0;
    y = 0;
    w = 0.0;
    h = 0.0;
    shadow = 1;
    font = "PuristaBold";
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    borderSize = 0.5;
	fadein = 0.1;
	fadeout = 0.1;
	onMouseEnter = "(_this select 0) ctrlSetTextColor [0.8,0.9,1,0.95];";
	onMouseExit = "(_this select 0) ctrlSetTextColor [1,1,1,0.95];";
};
class Background
{
    type = CT_STATIC;
    idc = -1;
    shadow = 2;
    colorText[] = {1,1,1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
	style = 82;
	colorBackground[] = {0.05,0.05,0,0.7};
};
class RscPicture {
	type = 0;
	idc = -1;
	style = 48;
    font = "PuristaLight";
	colorText[] = {0.75, 0.75, 0.75, 1};
	colorBackground[] = {0, 0, 0, 0};
	sizeEx = 0.025;
	soundClick[] = {"ui\ui_ok", 0.2, 1};
	soundEnter[] = {"ui\ui_over", 0.2, 1};
	soundEscape[] = {"ui\ui_cc", 0.2, 1};
	soundPush[] = {"", 0.2, 1};
	w = 0.275;
	h = 0.04;
	text = "";
};
class MoneyListBox {
	idc = -1;
	type = 5;
	style = 0 + 0x10;
    font = "PuristaLight";
	sizeEx = 0.04221;
    rowHeight = 0.03;
	color[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 0.75};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.6, 0.8392, 0.4706, 1.0};
	colorSelectBackground2[] = {0.6, 0.8392, 0.4706, 1.0};
	columns[] = {0.1, 0.7, 0.1, 0.1};
	period = 0;
	colorBackground[] = {0, 0, 0, 1};
	maxHistoryDelay = 1.0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\IGUI\cfg\actions\arrow_up_gs.paa";
		arrowFull = "\A3\ui_f\data\IGUI\cfg\actions\arrow_up_gs.paa";
		arrowEmpty = "\A3\ui_f\data\IGUI\cfg\actions\arrow_up_gs.paa";
		border = "\A3\ui_f\data\IGUI\cfg\actions\arrow_up_gs.paa";
	};
};