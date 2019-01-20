//executes on human clients
//function called on server with BIS_fnc_MP
//displays formatted text info regarding module functions and unit locality

//params
params [["_hintType",-1,[1]],["_hintParams",[],[[]]]];

//private variables
private ["_lineString", "_breakString", "_debugString", "_hintArray", "_hintParams1", "_hintParams2", "_stringInfo1", "_stringInfo2", "_stringInfo3", "_stringInfo4", "_strTransfers", "_strRecurrent"];

_lineString = parseText "<t color='#C5C1AA' align='center'>--------------------------------------------------</t>";
_breakString = parseText "<br/>";
_debugString = parseText "<t color='#C67171' align='center'>Debug Mode</t>";

_hintArray = [_lineString,_breakString];

switch (_hintType) do
{
	case 1: {_hintArray append [parseText "<t color='#C67171' align='center'>Debug Mode Activating...</t>"];};
	case 2: {_hintArray append [parseText "<t color='#C67171' align='center'>Debug Mode Deactivating...</t>"];};
	case 3: {
		_hintParams1 = _hintParams select 0;
		_hintParams2 = _hintParams select 1;
		_stringInfo1 = "<t color='#8E8E38' align='center'>" + _hintParams1 + ": " + "</t>";
		_stringInfo2 = "<t color='#FFFACD' align='center'>" + str _hintParams2 + "</t>";
		_stringInfo3 = "<t color='#8E8E38' align='center'>" + " Local Units" + "</t>";
		
		_hintArray append [
			_debugString,
			_breakString,
			parseText _stringInfo1,
			parseText _stringInfo2,
			parseText _stringInfo3
		];
	};
	case 4: {_hintArray append [parseText "<t color='#7D9EC0' align='center'>Werthles Headless Script Is Now Running</t>"];};
	case 5: {
		_hintArray append [
			_debugString,
			_breakString,
			parseText "<t color='#7D9EC0' align='center'>Next Cycle Is Starting...</t>"
		];
	};
	case 6: {
		
		_hintParams1 = _hintParams select 0;
		_hintParams2 = _hintParams select 1;
		
		_stringInfo1 = "<t color='#7D9EC0' align='center'>" + "Group: " + "</t>";
		_stringInfo2 = "<t color='#FFFACD' align='center'>" + str _hintParams1 + "</t>";
		_stringInfo3 = "<t color='#7D9EC0' align='center'>" + "Assigned To: " + "</t>";
		_stringInfo4 = "<t color='#FFFACD' align='center'>" + str _hintParams2 + "</t>";
		
		_hintArray append [
			_debugString,
			_breakString,
			parseText _stringInfo1,
			parseText _stringInfo2,
			_breakString,
			parseText _stringInfo3,
			parseText _stringInfo4
		];
	};
	case 7: {
		
		_hintParams1 = _hintParams select 0;
		_hintParams2 = _hintParams select 1;
		
		_strTransfers = "<t color='#FFFACD' align='center'>" + str _hintParams1 + "</t>";
		_strRecurrent = "";
		
		if (_hintParams2) then
		{
			_strRecurrent = "<t color='#388E8E' align='center'>WHS Will Continue To Check For AI Units Throughout The Mission</t>";
		}
		else
		{
			_strRecurrent = "<t color='#8E388E' align='center'>WHS Will Now Terminate</t>";
		};
		
		_hintArray append [
			parseText "<t color='#7D9EC0' align='center'>Werthles Headless Script</t>",
			_breakString,
			parseText "<t color='#7D9EC0' align='center'>Has Transferred</t>",
			_breakString,
			parseText _strTransfers,
			_breakString,
			parseText "<t color='#7D9EC0' align='center'>Units To Headless Clients</t>",
			_breakString,
			_breakString,
			parseText _strRecurrent
		];
	};
	case 8: {
		_hintArray append [
			_debugString,
			_breakString,
			parseText "<t color='#7D9EC0' align='center'>Cycle Finished</t>"
		];
	};
	case 9: {
		_hintArray append [
			parseText "<t color='#7D9EC0' align='center'>Headless clients can only connect to local multiplayer games or dedicated servers, so Werthles' Headless Module has terminated.</t>"
		];
	};
	case 10: {
		_hintArray append [
			parseText "<t color='#7D9EC0' align='center'>WH Module activation failed. A WH module has already been activated. Only 1 WH module can be activated at a time.</t>"
		];
	};
	case 11 : {
		_hintArray append [
			_debugString,
			_breakString,
			parseText "<t color='#7D9EC0' align='center'>No data received from headless clients. Check that the WHM HCs are connected and that they are running the WHM mod.</t>"
		];
	};
};

_hintArray append [_breakString,_lineString];
hintSilent composeText _hintArray;