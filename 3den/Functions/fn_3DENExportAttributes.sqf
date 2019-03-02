#include "\a3\3DEN\UI\resincl.inc"

_class = param [0,"Object",[""]];
_cfg = configfile >> "Cfg3DEN" >> _class >> "AttributeCategories";
if !(isclass _cfg) then {_cfg = configfile >> "Cfg3DEN" >> "Mission" >> _class >> "AttributeCategories";};

startloadingscreen [""];
_br = tostring [13,10];
_text = "";
_fnc_addLine = {_text = _text + _this + _br;};

format ["<!-- Exported from the game by %1. Manual edits may be replaced by future exports. -->",_fnc_scriptName] call _fnc_addLine;
//"<onlyinclude>" call _fnc_addLine;
"{| class=""wikitable sortable""" call _fnc_addLine;
"! colspan=""3"" | <big>Info</big>" call _fnc_addLine;
"! colspan=""2"" | <big>[[Eden Editor: Setting Attributes|Development]]</big>" call _fnc_addLine;
"|-" call _fnc_addLine;
"! Name" call _fnc_addLine;
"! Category" call _fnc_addLine;
"! class=""unsortable"" | Description" call _fnc_addLine;
"! Property" call _fnc_addLine;
"! Type" call _fnc_addLine;

_fnc_replaceLineBreaks = {
	_thisArray = (_this select 0) splitstring "\";
	{
		if (_foreachindex > 0) then {_thisArray set [_foreachindex,_x select [1]];};
	} foreach _thisArray;
	_thisArray joinstring (_this select 1);
};

{
	_categoryName = gettext (_x >> "displayName");
	if (_categoryName != "") then {
		{
			_data = gettext (_x >> "data");
			if (_data == "") then {_data = gettext (_x >> "property")};
			_meta = getarray (_x >> "meta");

			//--- Add listbox contents
			_list = "";
			_control = gettext (_x >> "control");
			_cfgValue = configfile >> "Cfg3DEN" >> "Attributes" >> _control >> "Controls" >> "Value";
			switch getnumber (_cfgValue >> "type") do {
				case CT_COMBO: {
					if !(isclass (_cfgValue >> "ItemsConfig")) then {
						_listAggregated = [];
						{
							_title = gettext (_x >> "text");
							_description = gettext (_x >> "tooltip");
							_descriptionID = _listAggregated find _description;
							if (_descriptionID < 0 || _description == "") then {
								_listAggregated append [_description,[_title]];
							} else {
								_titles = _listAggregated select (_descriptionID + 1);
								_titles pushback _title;
							};
						} foreach configproperties [_cfgValue >> "Items","isclass _x"];

						for "_i" from 0 to (count _listAggregated - 2) step 2 do {
							_description = _listAggregated select _i;
							if (_description != "") then {_description = " - " + _description;};

							_title  = "";
							{
								if (_foreachindex > 0) then {_title = _title + ", ";};
								_title = _title + _x;
							} foreach (_listAggregated select (_i + 1));
							_list = _list + format ["* '''%1'''%2",_title,_description] + _br;
						};
/*
						{
							_description = gettext (_x >> "tooltip");
						} foreach configproperties [_cfgValue >> "Items","isclass _x"];
*/
					};
				};
				case CT_TOOLBOX: {
					_strings = getarray (_cfgValue >> "strings");
					_tooltips = getarray (_cfgValue >> "tooltips");
					_style = getnumber (_cfgValue >> "style");
					if ((_style % ST_PICTURE) != _style) then {
						{
							_list = _list + format ["* '''%1'''",_x] + _br;
						} foreach _tooltips;
					} else {
						{
							_description = _tooltips param [_foreachindex,""];
							if (_description != "") then {_description = " - " + _description;};
							_list = _list + format ["* '''%1'''%2",_x,_description] + _br;
						} foreach _strings;
					};
				};
			};
			if (_list != "") then {
				_list = _br + "Available options:" + _br + _list;
				_list = [_list,_br + ":"] call _fnc_replaceLineBreaks;
			};

			//--- Replace \n with <br />
			_tooltip = gettext (_x >> "tooltip") + _list;
			_tooltip = [_tooltip,_br] call _fnc_replaceLineBreaks;

			"|-" call _fnc_addLine;
			format ["| '''%1'''",gettext (_x >> "displayName")] call _fnc_addLine;
			format ["| %1",_categoryName] call _fnc_addLine;
			format ["| %1",_tooltip] call _fnc_addLine;
			format ["| <small><tt>%1</tt></small>",_data] call _fnc_addLine;
			format ["| %1",gettext (_x >> "wikiType")] call _fnc_addLine;
			//format ["| <tt>[[Eden_Editor:_Configuring_Attributes:_Controls#%1|%1]]</tt>",gettext (_x >> "control")] call _fnc_addLine;
		} foreach configproperties [_x >> "Attributes","isclass _x"];
	};
} foreach configproperties [_cfg,"isclass _x"];

"|}" call _fnc_addLine;
//"</onlyinclude>" call _fnc_addLine;

copytoclipboard _text;
endloadingscreen;