#include "\a3\3DEN\UI\resincl.inc"

#define KEY_NONE			""
#define KEY_ALT				"Alt +"
#define KEY_CTRL			"Ctrl +"
#define KEY_SHIFT			"Shift +"
#define KEY_2				"2 x"

#define TEXTURE_NONE			"#(argb,8,8,3)color(0,0,0,0)"
#define TEXTURE_LMB			"\a3\3DEN\Data\Displays\Display3DEN\Hint\lmb_ca.paa"
#define TEXTURE_LMB_DRAG		"\a3\3DEN\Data\Displays\Display3DEN\Hint\lmb_drag_ca.paa"
#define TEXTURE_RMB			"\a3\3DEN\Data\Displays\Display3DEN\Hint\rmb_ca.paa"
#define TEXTURE_RMB_DRAG		"\a3\3DEN\Data\Displays\Display3DEN\Hint\rmb_drag_ca.paa"

#define CURSOR_NONE			"#(argb,8,8,3)color(0,0,0,0)"
#define CURSOR_MOVE			"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denMove_ca.paa"
#define CURSOR_MOVEIN			"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denMoveIn_ca.paa"
#define CURSOR_MOVEZ			"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denMoveZ_ca.paa"
#define CURSOR_ROTATE			"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denRotate_ca.paa"
#define CURSOR_PLACE			"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denPlace_ca.paa"
#define CURSOR_PLACEMULTI		"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denPlaceMulti_ca.paa"
#define CURSOR_PLACEWAYPOINT		"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denPlaceWaypoint_ca.paa"
#define CURSOR_PLACEWAYPOINTMULTI	"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denPlaceWaypointMulti_ca.paa"
#define CURSOR_ATTACHWAYPOINT		"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denPlaceWaypointAttach_ca.paa"
#define CURSOR_ATTACHWAYPOINTMULTI	"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denPlaceWaypointAttachMulti_ca.paa"
#define CURSOR_CONNECTGROUP		"\a3\3DEN\Data\CfgWrapperUI\Cursors\3denConnectGroup_ca.paa"

#define LOC_MOVE			(localize "STR_3DEN_Display3DEN_ControlsHint_Move")
#define LOC_MOVEZ			(localize "STR_3DEN_Display3DEN_ControlsHint_MoveZ")
#define LOC_ROTATE			(localize "STR_3DEN_Display3DEN_ControlsHint_Rotate")
#define LOC_CONNECTGROUP		(localize "STR_3DEN_Connections_Group")
#define LOC_ATTACHWAYPOINT		(localize "STR_3DEN_Display3DEN_ControlsHint_AttachWaypoint")
#define LOC_PLACEWAYPOINT		(localize "STR_3DEN_Display3DEN_ControlsHint_PlaceWaypoint")
#define LOC_ATTRIBUTES			(localize "STR_3DEN_Display3DEN_ControlsHint_Attributes")
#define LOC_CANCEL			(localize "STR_3DEN_Display3DEN_ControlsHint_Cancel")
#define LOC_ATTACH			(localize "STR_3DEN_Display3DEN_ControlsHint_Attach")
#define LOC_ATTACHMULTI			(localize "STR_3DEN_Display3DEN_ControlsHint_AttachMulti")
#define LOC_PLACE			(localize "STR_3DEN_Display3DEN_ControlsHint_Place")
#define LOC_PLACEMULTI			(localize "STR_3DEN_Display3DEN_ControlsHint_PlaceMulti")
#define LOC_PLACEEMPTY			(localize "STR_3DEN_Display3DEN_ControlsHint_PlaceEmpty")
#define LOC_DISCONNECT			(localize "STR_3DEN_Display3DEN_ControlsHint_Disconnect")

_display = finddisplay IDD_DISPLAY3DEN;
_ctrlHint = _display displayctrl IDC_DISPLAY3DEN_CONTROLSHINT;

_mode = _this param [0,"",[""]];
switch _mode do {
	case "loop": {
		if !(ctrlshown _ctrlHint) exitwith {};

		//--- Function for adding hint lines
		_fnc_show = {
			_lbAdd = _ctrlHint lbadd (_x select 0);
			_ctrlHint lbSetTextRight [_lbAdd,_x select 1];
			_ctrlHint lbSetPictureRight [_lbAdd,_x select 2];
			//_ctrlHint lbSetPicture [_lbAdd,_x select 3];
		};

		//--- Get entity under cursor
		private ["_hoverType","_hoverEntity"];
		_hover = get3DENMouseOver;
		_hoverType = "";
		if (count _hover > 0) then {
			_hoverType = _hover select 0;
			_hoverEntity = _hover select 1;
		};
		//--- Show hint
		lbclear _ctrlHint;
		_operation = _this param [1,current3DENOperation];
		switch _operation do {

			//--- No Operation
			case "": {
				//--- Editing
				_selected = +(uinamespace getvariable ["bis_fnc_3DENControlsHint_selected",[0,[0,0,0,0,0,0],[[],[],[],[],[],[]]]]);
				_countTotal = _selected select 0;
				_countTypes = _selected select 1;
				_selectedTypes = _selected select 2;

				//--- Edit entity under cursor
				_countTypesLocal = +_countTypes;
				if (_hoverType != "") then {
					_typeID = ["Object","Group","Trigger","Waypoint","Logic","Marker","Comment"] find _hoverType;
					if (_typeID >= 0) then {
						_countTypesLocal set [_typeID,(_countTypesLocal select _typeID) + 1];

						_fnc_show foreach [[LOC_MOVE,			KEY_NONE,	TEXTURE_LMB_DRAG,	CURSOR_MOVE]];
						if (get3DENActionState "togglemap" == 0) then {
							_fnc_show foreach [[LOC_MOVEZ,	KEY_ALT,	TEXTURE_LMB_DRAG,	CURSOR_MOVEZ]];
						};
						if ((_countTypesLocal select 0) > 0 || (_countTypesLocal select 2) > 0 || (_countTypesLocal select 4) > 0 || (_countTypesLocal select 0) > 5) then {
							_fnc_show foreach [[LOC_ROTATE,		KEY_SHIFT,	TEXTURE_LMB_DRAG,	CURSOR_ROTATE]];
						};
						if (_hoverType == "Object" && {!isnull group _hoverEntity}) then {
							_fnc_show foreach [[LOC_CONNECTGROUP,	KEY_CTRL,	TEXTURE_LMB_DRAG,	CURSOR_CONNECTGROUP]];
						};
					} else {
						["'%1' is not a correct entity type!",_hoverType] call bis_fnc_error;
					};
				};

				//--- Add waypoint to selected entity
				if (_countTotal > 0 && {{!isnull group _x} count (_selectedTypes select 0) > 0} || {(_countTypes select 1) > 0} || {(_countTypes select 3) > 0}) then {
					if (_hoverType == "Object") then {
						_fnc_show foreach [[LOC_ATTACHWAYPOINT,	KEY_SHIFT,	TEXTURE_RMB,		CURSOR_ATTACHWAYPOINT]];
					} else {
						_fnc_show foreach [[LOC_PLACEWAYPOINT,	KEY_SHIFT,	TEXTURE_RMB,		CURSOR_PLACEWAYPOINT]];
					};
				};

				if (_hoverType != "") then {
					_fnc_show foreach [[LOC_ATTRIBUTES,		KEY_2,		TEXTURE_LMB,		CURSOR_NONE]];
				};
			};

			//--- Editing
			case "MoveUnit": {
				if (get3DENActionState "togglemap" == 0) then {
					_fnc_show foreach [
						[LOC_MOVEZ,	KEY_ALT,	TEXTURE_LMB_DRAG,	CURSOR_MOVEZ]
					];
				};
				_fnc_show foreach [
					[LOC_CANCEL,		KEY_NONE,	TEXTURE_RMB,		CURSOR_NONE]
				];
			};
			case "RotateUnit": {
				_fnc_show foreach [
					[LOC_CANCEL,		KEY_NONE,	TEXTURE_RMB,		CURSOR_NONE]
				];
			};

			//--- Placing
			case "CreateObject": {
				_place = uinamespace getvariable ["bis_fnc_3DENControlsHint_place",[""]];
				_placeClass = _place select 0;
				if (_placeClass != "") then {
					_mouseButtons = uinamespace getvariable ["bis_fnc_3DENControlsHint_mouseButtons",[false,false]];
					if (_mouseButtons select 0) then {

						//---- Drag & Drop
						_fnc_show foreach [
							[LOC_CANCEL,		KEY_NONE,	TEXTURE_RMB,		CURSOR_NONE]
						];

					} else {

						//--- Click
						if (get3DENActionState "SelectWaypointMode" > 0) then {
							//--- Waypoint
							if (count (get3denselected "object" + get3denselected "group" + get3denselected "waypoint") > 0) then {
								if (_hoverType == "Object") then {
									_fnc_show foreach [
										[LOC_ATTACH,		KEY_NONE,		TEXTURE_LMB,	CURSOR_ATTACHWAYPOINT],
										[LOC_ATTACHMULTI,	KEY_CTRL,		TEXTURE_LMB,	CURSOR_ATTACHWAYPOINTMULTI],
										[LOC_CANCEL,		KEY_NONE,		TEXTURE_RMB,	CURSOR_NONE]
									];
								} else {
									_fnc_show foreach [
										[LOC_PLACE,		KEY_NONE,		TEXTURE_LMB,	CURSOR_PLACEWAYPOINT],
										[LOC_PLACEMULTI,	KEY_CTRL,		TEXTURE_LMB,	CURSOR_PLACEWAYPOINTMULTI],
										[LOC_CANCEL,		KEY_NONE,		TEXTURE_RMB,	CURSOR_NONE]
									];
								};
							};
						} else {
							//--- Other
							_fnc_show foreach [
								[LOC_PLACE,		KEY_NONE,	TEXTURE_LMB,		CURSOR_PLACE],
								[LOC_PLACEMULTI,	KEY_CTRL,	TEXTURE_LMB,		CURSOR_PLACEMULTI]
							];
							_isVehicle = _place select 1;
							if (
								get3DENActionState "SelectObjectMode" > 0
								&&
								_isVehicle
							) then {
								_fnc_show foreach [
									[LOC_PLACEEMPTY,KEY_ALT,	TEXTURE_LMB,		CURSOR_PLACE]
								];
							};
							_fnc_show foreach [
								[LOC_CANCEL,		KEY_NONE,	TEXTURE_RMB,		CURSOR_NONE]
							];
						};
					};
				};
			};

			//--- Connecting
			default {
				_connect = uinamespace getvariable ["bis_fnc_3DENControlsHint_connect",["",""]];
				_connectName = _connect select 0;
				if (_connectName != "") then {
					//--- Connecting
					_connectTexture = _connect select 1;
					if (_hoverType == "") then {
						_fnc_show foreach [
							[LOC_DISCONNECT,	KEY_NONE,	TEXTURE_LMB,		_connectTexture]
						];
					} else {
						_fnc_show foreach [
							[_connectName,	KEY_NONE,	TEXTURE_LMB,		_connectTexture]
						];
					};
					_fnc_show foreach [
						[LOC_CANCEL,		KEY_NONE,	TEXTURE_RMB,		CURSOR_NONE]
					];
				};
			};
		};

		//--- Position the hint
		_posDef = uinamespace getvariable ["bis_fnc_3DENControlsHint_pos",[0,0,0,0]];
		_pos = +_posDef;
		_pos set [3,(_pos select 3) * lbsize _ctrlHint * 0.1];
		_pos set [1,(_pos select 1) - (_pos select 3)];
		_ctrlHint ctrlsetposition _pos;
		_ctrlHint ctrlcommit 0;
	};
	case "mousebuttondown";
	case "mousebuttonup": {
		_mouseButtons = uinamespace getvariable ["bis_fnc_3DENControlsHint_mouseButtons",[false,false]];
		_mouseButtons set [(_this select 1) select 1,_mode == "mousebuttondown"];
		uinamespace setvariable ["bis_fnc_3DENControlsHint_mouseButtons",_mouseButtons];

	};
	case "place": {
		_data = _this param [1,[]];
		_ctrlList = _data select 0;
		_path = _data select 1;
		_data = if (_ctrlList tvcount _path == 0) then {
			_class = _ctrlList tvdata _path;
			_isVehicle = if (get3DENActionState "SelectObjectMode" > 0) then {
				_simulation = gettext (configfile >> "cfgvehicles" >> _class >> "simulation");
				(tolower _simulation) in ["car","carx","tank","tankx","helicopter","helicopterx","helicopterrtd","airplane","airplanex","ship","shipx","submarinex","hovercraftx","motorcycle","parachute","paraglide"]
			} else {
				false
			};
			[_class,_isVehicle]
		} else {
			["",false]
		};
		uinamespace setvariable ["bis_fnc_3DENControlsHint_place",_data];
		["loop","CreateObject"] call bis_fnc_3DENControlsHint;
	};
	case "select": {
		_selectedObject = get3denselected "object";
		_selectedGroup = get3denselected "group";
		_selectedTrigger = get3denselected "trigger";
		_selectedWaypoint = get3denselected "waypoint";
		_selectedLogic = get3denselected "logic";
		_selectedMarker = get3denselected "marker";

		_countObject = count _selectedObject;
		_countGroup = count _selectedGroup;
		_countTrigger = count _selectedTrigger;
		_countWaypoint = count _selectedWaypoint;
		_countLogic = count _selectedLogic;
		_countMarker = count _selectedMarker;

		uinamespace setvariable [
			"bis_fnc_3DENControlsHint_selected",
			[
				_countObject + _countGroup + _countTrigger + _countWaypoint + _countLogic + _countMarker,
				[_countObject,_countGroup,_countTrigger,_countWaypoint,_countLogic,_countMarker],
				[_selectedObject,_selectedGroup,_selectedTrigger,_selectedWaypoint,_selectedLogic,_selectedMarker]
			]
		];
	};
	case "connectStart": {
		if (count (_this select 1) == 3) exitwith {["connectEnd",_this select 1] call bis_fnc_3DENControlsHint;}; //--- ToDo: Remove

		_connectClass = (_this select 1) select 0;
		_connectCfg = configfile >> "Cfg3DEN" >> "Connections" >> _connectClass;
		_connectName = gettext (_connectCfg >> "displayName");
		_connectCursor = gettext (_connectCfg >> "cursor");
		_connectCursorTexture = configfile >> "CfgWrapperUI" >> "cursors" >> _connectCursor >> "texture";
		uinamespace setvariable ["bis_fnc_3DENControlsHint_connect",[_connectName,_connectCursorTexture]];
	};
	case "connectEnd": {
		uinamespace setvariable ["bis_fnc_3DENControlsHint_connect",["",""]];
	};
	case "show": {
		_ctrlHint ctrlshow true;
		profilenamespace setvariable ["display3DEN_ControlsHint",true];
		saveprofilenamespace;

		//--- Remove existing handlers (shouldn't be any, but just in case)
		_ctrlMouseArea = _display displayctrl IDC_DISPLAY3DEN_MOUSEAREA;
		_handlers = uinamespace getvariable ["bis_fnc_3DENControlsHint_handlers",[]];
		_ctrlMouseArea ctrlremoveeventhandler ["mousemoving",_handlers param [0,-1]];
		_ctrlMouseArea ctrlremoveeventhandler ["mouseholding",_handlers param [1,-1]];

		//--- Add new handlers
		_mousemoving = _ctrlMouseArea ctrladdeventhandler ["mousemoving",{'loop' call bis_fnc_3DENControlsHint;}];
		_mouseholding = _ctrlMouseArea ctrladdeventhandler ["mouseholding",{'loop' call bis_fnc_3DENControlsHint;}];
		uinamespace setvariable ["bis_fnc_3DENControlsHint_handlers",[_mousemoving,_mouseholding]];
	};
	case "hide": {
		_ctrlHint ctrlshow false;
		profilenamespace setvariable ["display3DEN_ControlsHint",false];
		saveprofilenamespace;

		_ctrlMouseArea = _display displayctrl IDC_DISPLAY3DEN_MOUSEAREA;
		_handlers = uinamespace getvariable ["bis_fnc_3DENControlsHint_handlers",[]];
		_ctrlMouseArea ctrlremoveeventhandler ["mousemoving",_handlers param [0,-1]];
		_ctrlMouseArea ctrlremoveeventhandler ["mouseholding",_handlers param [1,-1]];
		uinamespace setvariable ["bis_fnc_3DENControlsHint_handlers",nil];
	};
	case "init": {
		_ctrlHint ctrlenable false;
		uinamespace setvariable ["bis_fnc_3DENControlsHint_pos",ctrlposition _ctrlHint];
		uinamespace setvariable ["bis_fnc_3DENControlsHint_handlers",nil]; //--- Reset previous session of handlers
		uinamespace setvariable ["bis_fnc_3DENControlsHint_mouseButtons",[false,false]];

		_mode = ["hide","show"] select (profilenamespace getvariable ["display3DEN_ControlsHint",true]);
		_mode call bis_fnc_3DENControlsHint;
	};
	case "toggle": {
		_mode = ["hide","show"] select !(ctrlshown _ctrlHint);
		_mode call bis_fnc_3DENControlsHint;
	};
};