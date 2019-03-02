if (count (supportInfo "n:pixelW") == 0) then {
	//--- Get unified UI scale
	_coefUIScale = getResolution select 5;
	_coefUIScale = switch true do {
		case (_coefUIScale < 0.500):	{0.500};
		case (_coefUIScale < 0.625):	{0.625};
		case (_coefUIScale < 0.750):	{0.750};
		case (_coefUIScale < 0.875):	{0.875};
		default				{1.00};
	};

	//--- Calculate pixel scale based on UI scale and vertical resolution
	_coefRes = ((round ((getResolution select 1) / 180)) / 4) max 1;
	_pixelScale = _coefRes * _coefUIScale;

	//--- Save variables to all name spaces
	{
		//_x setvariable ["pixelW",1 / (getResolution select 2)];
		//_x setvariable ["pixelH",1 / (getResolution select 3)];
		_x setvariable ["pixelScale",_pixelScale];
	} foreach [missionnamespace,uinamespace,parsingnamespace];
};