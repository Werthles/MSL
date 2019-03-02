#include "\A3\Modules_f\Environment\EditTerrainObject\defines.inc"

#define COLOR_DOOR_PROPS				[1,0.8,0,1]

/*--------------------------------------------------------------------------------------------------

	attributeLoad = "['attributeLoad',get3DENSelected 'object' select 0,_this,_value] call bis_fnc_3DENAttributeDoorStates";
	attributeSave = "['attributeSave',get3DENSelected 'object' select 0,_this] call bis_fnc_3DENAttributeDoorStates";
	expression = "['init',_this,_value] call bis_fnc_3DENAttributeDoorStates";

--------------------------------------------------------------------------------------------------*/
private _mode = param [0,"",[""]];
private _object = param [1,objNull,[objNull]]; if (isNull _object) exitWith {};

switch _mode do
{
	// Default object init
	case "init":
	{
		if (!is3DEN && !isServer) exitWith {};

		private _value = param [2,[0,0,0],[123,[]]];

		//set door states
		private _flags = ["decodeDoorFlags",_object,_value] call bis_fnc_3DENAttributeDoorStates;

		{
			if (is3DEN) then
			{
				SETUP_DOOR_PREVIEW(_object,_forEachIndex,_x);
			}
			else
			{
				SETUP_DOOR(_object,_forEachIndex,_x);
			};
		}
		forEach _flags;

		if (is3DEN) then
		{
			//add 'Draw3D' eh to ease operations with object doors
			private _ehDraw3D = missionNamespace getVariable ["bis_fnc_3DENAttributeDoorStates_ehDraw3D",-1];
			if (_ehDraw3D == -1) then
			{
				_ehDraw3D = addMissionEventHandler ["Draw3D",
				{
					private _object = (get3DENSelected "object") param [0,objNull]; if (isNull _object) exitWith {};

					//get positions of door 3D icons
					private _doorPositions = GET_OBJVAR(_object,"#doorPositions",nil);
					if (isNil{_doorPositions}) then
					{
						_doorPositions = ["#doorPositions",_object] call bis_fnc_3DENAttributeDoorStates;
						SET_OBJVAR(_object,"#doorPositions",_doorPositions);
					};

					//exit if no doors were detected
					if (count _doorPositions == 0) exitWith {};

					//draw 3d icons on door positions
					if (get3DENCamera distance _object > DISTANCE_HIGHLIGHT) exitWith {};

					private _value = (_object get3DENAttribute "DoorStates") param [0,0];
					private _doorFlags = ["decodeDoorFlags",_object,_value] call bis_fnc_3DENAttributeDoorStates;

					private ["_icon","_state","_color"];

					{
						_state = _doorFlags select _forEachIndex;

						_icon = [ICON3D_DOOR_CLOSED,ICON3D_DOOR_LOCKED,ICON3D_DOOR_OPENED] select _state;
						_color = [COLOR_DOOR_CLOSED,COLOR_DOOR_PROPS,COLOR_DOOR_PROPS] select _state;

						drawIcon3D ["", _color, _x, 0.6, -0.85, 0, str (_forEachIndex + 1), 2, 0.045, "RobotoCondensedBold","right",false];
						drawIcon3D [_icon, _color, _x, 0.8, 0.8, 0, "", 2];

					}
					forEach (_doorPositions apply {_object modelToWorld (_object selectionPosition _x)});
				}];

				missionNamespace setVariable ["bis_fnc_3DENAttributeDoorStates_ehDraw3D",_ehDraw3D];
			};
		};
	};

	//["encodeDoorFlags",_object,[0,1,3,1,1,0,1,3,1,1,0,1,3,1,1,..]] call bis_fnc_3DENAttributeDoorStates;
	case "encodeDoorFlags":
	{
		private _flags = param [2,DOOR_FLAGS_EMPTY,[[]]];

		/*
		//safechecking should not be needed
		if (count _flags != DOOR_INDEX_MAX) then
		{
			_flags resize DOOR_INDEX_MAX;
			_flags = _flags apply {if (isNil{_x}) then {DOOR_STATE_CLOSED} else {_x}};
		};
		*/

		private _value = [(_flags select [0,8]) call bis_fnc_encodeFlags4,(_flags select [8,8]) call bis_fnc_encodeFlags4,(_flags select [16,8]) call bis_fnc_encodeFlags4];

		_value
	};
	//["decodeDoorFlags",_object,[256,52,104]] call bis_fnc_3DENAttributeDoorStates;
	//["decodeDoorFlags",_object,256] call bis_fnc_3DENAttributeDoorStates;
	case "decodeDoorFlags":
	{
		private _value = param [2,[0,0,0],[123,[]]];
		private _flags = [];

		//retype from old tech using single numeric value (with indexes from 0-15), each index can have one ot the 2 values (opened/closed)
		if (_value isEqualType 123) then
		{
			_flags = ([_value,DOOR_INDEX_MAX] call bis_fnc_decodeFlags2) apply {if (_x == 0) then {DOOR_STATE_CLOSED} else {DOOR_STATE_OPENED}};
		}
		//handle new tech with 3 values with indexes 0-7 (3 rows & 8 columns), each index can have one ot the 3 values (opened/locked/closed)
		else
		{
			{_flags append ([_x,DOOR_COLUMNS] call bis_fnc_decodeFlags4);} forEach _value;
		};

		_flags
	};

	case "onMouseButtonUp":
	{
		(_this select 2) params ["_ctrlAttribute","_mouseButton","","","_shiftKey","_ctrlKey","_altKey"];

		/*
		LMB 	- cycle: DOOR_STATE_CLOSED - DOOR_STATE_LOCKED - DOOR_STATE_OPENED
		RMB 	- DOOR_STATE_CLOSED

		Ctrl 	- DOOR_STATE_CLOSED
		Shift 	- DOOR_STATE_LOCKED
		Alt		- DOOR_STATE_OPENED
		*/

		private _state = _ctrlAttribute getVariable ["#state",DOOR_STATE_CLOSED];

		if (_shiftKey || _ctrlKey || _altKey) then
		{
			_state = switch (true) do
			{
				case _altKey: {DOOR_STATE_OPENED};
				case _shiftKey: {DOOR_STATE_LOCKED};
				case _ctrlKey: {DOOR_STATE_CLOSED};
			};
		}
		else
		{
			if (_mouseButton == 0) then
			{
				_state = [DOOR_STATE_CLOSED,DOOR_STATE_LOCKED,DOOR_STATE_OPENED] select ((_state + 1) % 3);
			}
			else
			{
				_state = DOOR_STATE_CLOSED;
			};
		};

		_ctrlAttribute setVariable ["#state",_state];
		_ctrlAttribute ctrlSetText ([TEXTURE_DOOR_CLOSED,TEXTURE_DOOR_LOCKED,TEXTURE_DOOR_OPENED] select _state);
		_ctrlAttribute ctrlSetTooltip ([TEXT_DOOR_CLOSED,TEXT_DOOR_LOCKED,TEXT_DOOR_OPENED] select _state);
	};

	case "attributeLoad":
	{
		private _ctrlAttribute = param [2,controlNull,[controlNull]]; if (isNull _ctrlAttribute) exitWith {};
		private _value = param [3,[0,0,0],[123,[]]];

		private _flags = ["decodeDoorFlags",_object,_value] call bis_fnc_3DENAttributeDoorStates;

		private _ctrlCheckboxes = _ctrlAttribute controlsGroupCtrl 100;

		{
			private _ctrlCheckbox = _ctrlCheckboxes controlsGroupCtrl (101+_forEachIndex);

			if (_x != 0) then
			{
				_ctrlCheckbox setVariable ["#state",_x];
				_ctrlCheckbox ctrlSetText ([TEXTURE_DOOR_CLOSED,TEXTURE_DOOR_LOCKED,TEXTURE_DOOR_OPENED] select _x);
			};

			_ctrlCheckbox ctrlSetTooltip ([TEXT_DOOR_CLOSED,TEXT_DOOR_LOCKED,TEXT_DOOR_OPENED] select _x);
		}
		forEach _flags;

		private _available = getNumber(configfile >> "CfgVehicles" >> typeOf _object >> "numberOfDoors");

		_available = _available min DOOR_INDEX_MAX;

		//adjust control height according to number of doors detected
		private _pos = ctrlPosition _ctrlAttribute;

		//hide completely if no doors detected
		if (_available == 0) exitWith
		{
			_pos set [3,0];
			_ctrlAttribute ctrlSetPosition _pos;
			_ctrlAttribute ctrlCommit 0;
		};

		//shrink if there is no need for all door rows
		if (_available <= DOOR_INDEX_MAX - DOOR_COLUMNS) then
		{
			private _heightMultiplier = (ceil(_available / DOOR_COLUMNS))/DOOR_ROWS;

			_pos set [3,(_pos select 3) * _heightMultiplier];
			_ctrlAttribute ctrlSetPosition _pos;
			_ctrlAttribute ctrlCommit 0;

			private _ctrlTitle = _ctrlAttribute controlsGroupCtrl 99;
			_ctrlTitlePos = ctrlPosition _ctrlTitle;
			_ctrlTitlePos set [3,(_ctrlTitlePos select 3) * _heightMultiplier];
			_ctrlTitle ctrlSetPosition _ctrlTitlePos;
			_ctrlTitle ctrlCommit 0;
		};

		private ["_ctrlCheckbox","_ctrlCheckboxBackground","_ctrlSubtitle"];

		for "_doorID" from 1 to DOOR_INDEX_MAX do
		{
			_ctrlCheckbox = _ctrlCheckboxes controlsGroupCtrl (100+_doorID);
			_ctrlCheckboxBackground = _ctrlCheckboxes controlsGroupCtrl (125+_doorID);
			_ctrlSubtitle = _ctrlCheckboxes controlsGroupCtrl (150+_doorID);
			if (_doorID <= _available) then
			{
				_ctrlCheckbox ctrlSetFade 0;
				_ctrlCheckboxBackground ctrlSetFade 0;
				_ctrlSubtitle ctrlSetFade 0;
			}
			else
			{
				_ctrlCheckbox ctrlSetFade 1;
				_ctrlCheckboxBackground ctrlSetFade 1;
				_ctrlSubtitle ctrlSetFade 1;
			};
			_ctrlCheckbox ctrlCommit 0;
			_ctrlCheckboxBackground ctrlCommit 0;
			_ctrlSubtitle ctrlCommit 0;
		};
	};
	case "attributeSave":
	{
		private _ctrlAttribute = param [2,controlNull,[controlNull]];
		private _ctrlCheckboxes = _ctrlAttribute controlsGroupCtrl 100;

		private _flags = [];

		for "_idc" from 101 to (100+DOOR_INDEX_MAX) do
		{
			_flags pushBack ((_ctrlCheckboxes controlsGroupCtrl _idc) getVariable ["#state",DOOR_STATE_CLOSED]);
		};

		private _value = ["encodeDoorFlags",_object,_flags] call bis_fnc_3DENAttributeDoorStates;

		_value
	};
	case "#doorPositions":
	{
		private _cfg = configfile >> "CfgVehicles" >> typeOf _object >> "UserActions";
		if !(isClass _cfg) exitWith {[]};

		private _positions = [];
		private _position = "";

		for "_doorID" from DOOR_INDEX_MIN to DOOR_INDEX_MAX do
		{
			_position = getText(_cfg >> format["OpenDoor_%1",_doorID] >> "position");

			if (_position == "") exitWith {};

			_positions pushBack _position;
		};

		if (count _positions == 0) exitWith {[]};

		_positions
	};
};