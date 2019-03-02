/*
	Author: Karel Moricky

	Description:
	Initialize slider with edit box showing its value

	Parameter(s):
		0: CONTROL - slider
		1: CONTROL - edit box
		2: STRING - measurement unit added behind the number ("%" by default)
		3: NUMBER - default value. When present, only the value is set, functionality is not initialized

	Returns:
	NOTHING
*/

private _ctrlSlider = param [0,controlnull,[controlnull]];
private _ctrlEdit = param [1,controlnull,[controlnull]];
private _symbol = param [2,"%",[""]];
private _value = param [3,false,[0]];

private _coef = if (_symbol == "%") then {100} else {1};
private _coefDecimals = switch true do {
	case (_coef >= 100): {1};
	case (_coef >= 10): {10};
	default {100};
};

if (_value isequaltype false) then {
	_ctrlSlider ctrladdeventhandler [
		"sliderPosChanged",
		format [
			"
				_ctrlSlider = _this select 0;
				_ctrlGroup = ctrlParentControlsGroup _ctrlSlider;
				_ctrlEdit = _ctrlGroup controlsgroupctrl %1;
				_value = sliderposition _ctrlSlider;
				_value = round (_value * %3 * %4) / %4;
				_ctrlEdit ctrlsettext format [localize 'STR_3DEN_percentageUnit',_value,'%2'];
			",
			ctrlidc _ctrlEdit,
			_symbol,
			_coef,
			_coefDecimals
		]
	];

	_ctrlEdit ctrladdeventhandler [
		"killFocus",
		format [
			"
				_ctrlEdit = _this select 0;
				_ctrlGroup = ctrlParentControlsGroup _ctrlEdit;
				_ctrlSlider = _ctrlGroup controlsgroupctrl %1;
				_textArray = toarray ctrltext _ctrlEdit;
				_value = parsenumber tostring (_textArray - (_textArray - (toarray '.01234567892')));
				_value = _value max ((sliderrange _ctrlSlider select 0) * %3) min ((sliderrange _ctrlSlider select 1) * %3);
				_value = round (_value * %4) / %4;
				_ctrlEdit ctrlsettext format [localize 'STR_3DEN_percentageUnit',_value,'%2'];
				_value = _value / %3;
				_ctrlSlider slidersetposition _value;
			",
			ctrlidc _ctrlSlider,
			_symbol,
			_coef,
			_coefDecimals
		]
	];
} else {
	//--- Set default value
	_value = _value max (sliderrange _ctrlSlider select 0) min (sliderrange _ctrlSlider select 1);
	_value = round (_value * _coef * _coefDecimals) / _coefDecimals;
	_ctrlEdit ctrlsettext (str _value + _symbol);
	_ctrlSlider slidersetposition (_value / _coef);
};