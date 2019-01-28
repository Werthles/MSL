//GetMoneyList.sqf
//Runs on server
//Called from initServer.sqf
//Sets up money list

//pvs
private ["_moneyIndex", "_moneyIndexString", "_moneyName", "_moneyUID", "_moneyMoney", "_moneySteamName", "_count", "_max", "_index", "_next", "_i", "_number", "_money", "_steamName", "_ret","_name","_uid"];

while {true} do
{
	newMoneyMoney = [];
	newMoneyUIDS = [];
	newMoneyNames = [];
	newMoneySteamNames = [];

	_moneyIndex = 0;
	_moneyIndexString = str _moneyIndex;
	_moneyName = ["MoneyList", "Names", _moneyIndexString, "STRING"] call iniDB_read;
	while {_moneyName != ""} do
	{
		moneyNames set [_moneyIndex, _moneyName];
		
		_moneyUID = ["MoneyList", "UIDs", _moneyIndexString, "STRING"] call iniDB_read;
		moneyUIDS set [_moneyIndex,_moneyUID];
		
		_moneyMoney = ["MoneyList", "Money", _moneyIndexString, "SCALAR"] call iniDB_read;
		moneyMoney set [_moneyIndex,_moneyMoney];
		
		_moneySteamName = ["MoneyList", "SteamNames", _moneyIndexString, "STRING"] call iniDB_read;
		moneySteamNames set [_moneyIndex,_moneySteamName];
		
		_moneyIndex = _moneyIndex + 1;
		_moneyIndexString = str _moneyIndex;
		_moneyName = ["MoneyList", "Names", _moneyIndexString, "STRING"] call iniDB_read;
	};

	//sort money list
	//get position of maximum in array 
	_count = count moneyMoney;
	_max = 0;
	_index = 0;
	nextMoney = +_count;
	
	while {_count > 0} do
	{
		{
			if (_forEachIndex == 0) then
			{
				_max = moneyMoney select _forEachIndex;
				_index = 0;
			}
			else
			{
				_next = moneyMoney select _forEachIndex;
				if (_next > _max) then
				{
					_max = _next;
					_index = _forEachIndex;
				};
			};
		}forEach moneyMoney;
		
		newMoneyMoney append [_max];
		newMoneyUIDS append [moneyUIDS select _index];
		newMoneyNames append [moneyNames select _index];
		newMoneySteamNames append [moneySteamNames select _index];
		
		moneyMoney deleteAt _index;
		moneyUIDS deleteAt _index;
		moneyNames deleteAt _index;
		moneySteamNames deleteAt _index;
		
		_count = count moneyMoney;
	};
	
	for [{_i=0},{_i<(count newMoneyMoney)},{_i=_i+1}] do
	{
		_number = str _i;
		_money = newMoneyMoney select _i;
		_uid = newMoneyUIDS select _i;
		_name = newMoneyNames select _i;
		_steamName = newMoneySteamNames select _i;
		_ret = ["MoneyList", "Money", _number, _money] call iniDB_write;
		_ret = ["MoneyList", "UIDs", _number, _uid] call iniDB_write;
		_ret = ["MoneyList", "Names", _number, _name] call iniDB_write;
		_ret = ["MoneyList", "SteamNames", _number, _steamName] call iniDB_write;
	};

	moneyMoney = +newMoneyMoney;
	moneyNames = +newMoneyNames;
	moneyUIDS = +newMoneyUIDS;
	moneySteamNames = +newMoneySteamNames;
	moneyTime = time;
	
	{
	    _firstOccurs = moneyUIDS find _x;
	    if ((_firstOccurs<_forEachIndex) or (_x=="")) then 
	    {
	        moneyNames deleteAt _forEachIndex;
	        moneyUIDS deleteAt _forEachIndex;
	        moneyMoney deleteAt _forEachIndex;
	        moneySteamNames deleteAt _forEachIndex;
	    };
	}forEach moneyUIDS;
	
	publicVariable "moneyMoney";
	publicVariable "moneyNames";
	publicVariable "moneyUIDS";
	publicVariable "moneySteamNames";
	publicVariable "moneyTime";
	
	sleep MoneyListDelay*60;
};