_ctrlAttribute = _this select 0;
_config = _this select 1;

_ctrlText = (_ctrlAttribute controlsGroupCtrl 101) controlsGroupCtrl 100;

_cfgHierarchy = confighierarchy _config;
_cfgVehicleBase = _cfgHierarchy select (count _cfgHierarchy - 3);
_cfgModuleBase = _cfgVehicleBase >> "ModuleDescription";
_cfgModuleCore = configfile >> "cfgvehicles" >> "module_f" >> "moduledescription";
_cfgVehicle = _cfgVehicleBase;
_cfgModule = _cfgVehicle >> "ModuleDescription";

//--- Get info about position and direction
_position = [_cfgModule >> "position",nil,0] call bis_fnc_returnConfigEntry;

_position = if (isArray(_cfgVehicle >> "AttributeValues" >> "size3") || {isArray(_cfgVehicle >> "AttributeValues" >> "size2")}) then
{
	gettext (_cfgModuleCore >> "positionEnabled")
}
else
{
	switch (typename _position) do {
		case (typename 00): {if (_position > 0) then {gettext (_cfgModuleCore >> "positionEnabled")} else {gettext (_cfgModuleCore >> "positionDisabled")};};
		case (typename ""): {_position};
		case (typename []): {gettext (_cfgModuleCore >> "positionDisabled")};
	};
};

_direction = [_cfgModule >> "direction",nil,0] call bis_fnc_returnConfigEntry;
_direction = switch (typename _direction) do {
	case (typename 00): {if (_direction > 0) then {gettext (_cfgModuleCore >> "positionEnabled")} else {gettext (_cfgModuleCore >> "positionDisabled")};};
	case (typename ""): {_direction};
	case (typename []): {gettext (_cfgModuleCore >> "positionDisabled")};
};
_duplicate = getnumber (_cfgModule >> "duplicate");
_duplicate = if (_duplicate > 0) then {gettext (_cfgModuleCore >> "duplicateEnabled")} else {gettext (_cfgModuleCore >> "duplicateDisabled")};
if (_dis == 0) then {_duplicate = "";};

//--- Process description
_descriptionRaw = [_cfgModule >> "description"] call bis_fnc_returnConfigEntry;
if (isnil {_descriptionRaw}) then {_descriptionRaw = [_cfgVehicle >> "moduledescription" >> "description",nil,""] call bis_fnc_returnConfigEntry;};
_description = "";
switch (typename _descriptionRaw) do {
	case (typename []): {{_description = _description + _x + "<br />";} foreach _descriptionRaw;};
	case (typename ""): {_description = _descriptionRaw;};
	case (typename 00): {_description = "";};
};
if (_description != "") then {_description = _description + "<br />"};
_description = format [
	//"%1<br /><t color='#99cccccc' size='0.8'>%2</t><t size='1'>%3<br />%4: %5<br />%6: %7<br />%8</t>",
	"<t size='1'>%3<br />%4: %5<br />%6: %7<br />%8</t>",
	_displayName,
	_path,
	_description,
	localize "STR_A3_RscDisplayArcadeModules_position",
	_position,
	localize "STR_A3_RscDisplayArcadeModules_direction",
	_direction,
	_duplicate
];


_ctrlText ctrlsetstructuredtext parsetext _description;//parsetext gettext (_cfgModule >> "ModuleDescription" >> "description");

//--- Resize text area
_controlPos = ctrlposition _ctrlText;
_controlPos set [3,(_controlPos select 3) max (ctrltextheight _ctrlText)];
_ctrlText ctrlsetposition _controlPos;
_ctrlText ctrlcommit 0;

