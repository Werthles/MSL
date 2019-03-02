

//executes on human clients
//function called on server with BIS_fnc_MP
//displays formatted text info regarding module functions and unit locality

//params
params [["_hintType",-1,[1]],["_hintParams",[],[[]]]];

//private variables
private ["_lineString", "_breakString", "_debugString", "_hintArray"];

_lineString = parseText "<t color='#C5C1AA' align='center'>--------------------------------------------------</t>";
_breakString = parseText "<br/>";
_debugString = parseText "<t color='#C67171' align='center'>Debug Mode</t>";

_hintArray = [_lineString,_breakString];

switch (_hintType) do
{
	case 1: {_hintArray append [parseText "<t color='#C67171' align='center'>Debug Mode Activating...</t>"];};
};

_hintArray append [_breakString,_lineString];
hintSilent composeText _hintArray;