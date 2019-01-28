//MoneyList.sqf
//Runs on players
//Called from player
//Called from GUI when MoneyList requested
//Sets up data in money list graphic

//pvs
private ["_control", "_lbID", "_i", "_money", "_moneyNum", "_steamName", "_chars", "_spaces", "_j", "_string", "_rankArray","_name"];

disableSerialization;
_control = _this select 0;
_lbID = 10002;

//formats row text
for [{_i = 0},{_i < count moneyMoney},{_i=_i+1}] do
{
	_money = str (moneyMoney select _i);
	_moneyNum = moneyMoney select _i;
	moneynum = _moneyNum;
	_name = moneyNames select _i;
	_steamName = moneySteamNames select _i;
	_chars = count (_money + _name + _steamName);
	_spaces = "";
	for [{_j = 0},{_j < (50 - _chars)},{_j=_j+1}] do
	{
		_spaces = _spaces + " ";
	};
	
	//name, gap, money
	_string = format["     %4.   %1 (%5)%2T$ %3",_name,_spaces,_money,(_i+1),_steamName];
	lbAdd[_lbID,_string+"000"];
};

//assigns rank to money list
_rankArray = ("isClass _x" configClasses (configFile >> "CfgRanks"));
{
	if (_x < 122) then
	{
		(_control displayCtrl _lbID) lbSetPicture [_foreachindex,"\A3\ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_toolbox_units_ca.paa"];
		(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,"Civilian"];
	}
	else
	{
		if (_x < 243) then
		{
			(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 0) >> "texture")];
			(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 0) >> "displayName")];
		}
		else
		{
			if (_x < 487) then
			{
				(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 1) >> "texture")];
				(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 1) >> "displayName")];
			}
			else
			{
				if (_x < 973) then
				{
					(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 2) >> "texture")];
					(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 2) >> "displayName")];
				}
				else
				{
					if (_x < 1947) then
					{
						(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 3) >> "texture")];
						(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 3) >> "displayName")];
					}
					else
					{
						if (_x < 3894) then
						{
							(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 4) >> "texture")];
							(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 4) >> "displayName")];
						}
						else
						{
							if (_x < 7788) then
							{
								(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 5) >> "texture")];
								(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 5) >> "displayName")];
							}
							else
							{
								if (_x < 15575) then
								{
									(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 6) >> "texture")];
									(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 6) >> "displayName")];
								}
								else
								{
									(_control displayCtrl _lbID) lbSetPicture [_foreachindex,getText ((_rankArray select 7) >> "texture")];
									(_control displayCtrl _lbID) lbSetTooltip [_foreachindex,getText ((_rankArray select 7) >> "displayName")];

								};
							};
						};
					};
				};
			};
		};
	};
	(_control displayCtrl _lbID) lbSetPictureColor [_foreachindex, [1,1,1,0.7]];
	(_control displayCtrl _lbID) lbSetPictureColorSelected [_foreachindex, [0.4,0.4,0,0.7]];
}forEach moneyMoney;

//Header with last update info
(_control displayCtrl 423) ctrlSetText format["Top Earners - Updated: %1 Minute(s) Ago",ceil((time - moneyTime)/60)];