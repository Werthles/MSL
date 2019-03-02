_this spawn {
	_fontID = param [0,7,[0]];

	disableserialization;
	_allDisplays = alldisplays - [finddisplay 12];
	_displayParent = _allDisplays select (count _allDisplays - 1);
	_displayParent createDisplay "displaySimulated";
	sleep 0.1;
	startloadingscreen [""];
	_allDisplays = alldisplays - [finddisplay 12];
	_display = _allDisplays select (count _allDisplays - 1);

	_pxW = 1 / (getResolution select 2);
	_pxH = 1 / (getResolution select 3);

	_ctrl = _display ctrlcreate ["ctrlStatic",-1];
	_ctrl ctrlsetposition [safezoneX,safezoneY,safezoneW,safezoneH];
	_ctrl ctrlcommit 0;
	_ctrl ctrlsetbackgroundcolor [0,0,0,1];

	// LucidaConsoleB	1.6
	// TahomaB	1.6
	// EtelkaMonospacePro	1.55
	// EtelkaNarrowMediumPro	1.55
	// PuristaBold	1.8
	// PuristaLight	1.8
	// PuristaMedium	1.8
	// PuristaSemiBold	1.8

	_coef = 1.8;
	_cfgFonts = configproperties [configfile >> "cfgfontfamilies","isclass _x"];
	_cfgFonts = [_cfgFonts select _fontID];
	_columnW = safezoneW / count _cfgFonts;
	{
		_font = configname _x;
		_fontIndex = _foreachindex;
		_y = safezoneY;
		{
			_path = _x;
			if (_path isequaltype []) then {_path = _path select 0;};
			_sizeEx = parsenumber (_path select [count _path - 3]);
			if (_sizeEx == 0) then {_sizeEx = parsenumber (_path select [count _path - 2]);};
			//if (_sizeEx == 0) then {_sizeEx = parsenumber (_path select [count _path - 1]);};
			_sizeExPx = _pxH * _sizeEx;

			_ctrl = _display ctrlcreate ["ctrlStatic",-1];
			_ctrl ctrlsetposition [
				safezoneX + _columnW * _fontIndex,
				_y,
				_columnW,
				_sizeExPx * _coef
			];
			_ctrl ctrlsetbackgroundcolor [1,1,1,[0,0.05] select (_foreachindex % 2)];
			_ctrl ctrlcommit 0;
			_ctrl ctrlsetfont _font;
			_ctrl ctrlsetfontheight (_sizeExPx * _coef);
			_ctrl ctrlsettext format ["%2 %3 %1 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",_font,_sizeEx,(_sizeEx * _coef),_sizeEx / 0.85];
			_y = _y + _sizeExPx * _coef;
		} foreach getarray (_x >> "fonts");
	} foreach _cfgFonts;
	endloadingscreen;
};