//JobFinished.sqf
//Runs on server
//Called from server
//Called from LoadTask.sqf or LoadPersonalTask.sqf
//Handles common features of missions when they end

//pvs
private ["_missionFileName", "_theGroup", "_NPC", "_missionNumber", "_task", "_groupArray", "_missionObjectList", "_newtaskState", "_owner", "_pm", "_leaderMoney", "_members", "_memberMoney", "_NPCString", "_questArray", "_ret", "_money", "_onMoneyList", "_nextMoneyNumber", "_nextMoneyNumberString", "_steamName", "_veh", "_location2", "_buildings", "_i", "_num", "_mission","_units","_uid"];

_missionFileName = _this select 0;
_theGroup = _this select 1;
_NPC = _this select 2;
_missionNumber = _this select 3;
_task = _this select 4;
_groupArray = _this select 5;
_missionObjectList = _this select 6;
_newtaskState = _this select 7;
_units = units _theGroup;

MissionEndTime = time;
{
	_owner = owner _x;
	_owner publicVariableClient "MissionEndTime";
}foreach _units;

//decide what type of mission
_pm = false;
if (_missionFileName find "PM" > -1) then
{
	_pm = true;
}
else
{
	if (_missionFileName find "NPC" > -1) then
	{
		_pm = false;
	};
};

//Wipe player's MIP
[] remoteExec["ReceiveCurrentMission",_theGroup];
if (group player == _theGroup) then
{
	CurrentMission = [];
};

//for NPC jobs
if not (_pm) then
{
	//newtaskState = _task call BIS_fnc_taskState;
	if (_newtaskState == "SUCCEEDED") then
	{
		_leaderMoney = round((1.2^(_missionNumber + 1)) * 100);
		_members = count units _theGroup;
		_memberMoney = 0;
		if (_members < (9 max (_missionNumber + 7))) then
		{
			_memberMoney = round((1.2^_missionNumber) * 100);
		}
		else
		{
			_memberMoney = round(((1.2^_missionNumber) * 100) * ((8 max (_missionNumber+6)))/_members);
		};
		{
			if (isPlayer _x) then
			{
				_uid = getPlayerUID _x;
				_NPCString = str _NPC;
								
				//update progress
				_questArray = [_uid, "QUESTDATA", _NPCString, "ARRAY"] call iniDB_read;
				_questArray set [_missionNumber, ((_questArray select _missionNumber) + 1)];
				_ret = [_uid, "QUESTDATA", _NPCString, _questArray] call iniDB_write;
				
				//grant money
				_money = [_uid, "MONEY", "Money", "SCALAR"] call iniDB_read;
				if (leader _theGroup == _x) then
				{
					_money = _money + _leaderMoney;
				}
				else
				{
					_money = _money + _memberMoney;
				};
				_ret = [_uid, "MONEY", "Money", _money] call iniDB_write;
				
				_onMoneyList = moneyUIDS find _uid;
				_nextMoneyNumber = 0;
				_nextMoneyNumberString = "";
				if (_onMoneyList > -1) then
				{
					_nextMoneyNumber = _onMoneyList;
				}
				else
				{
					_nextMoneyNumber = count moneyUIDS;
					//nextMoney = nextMoney + 1;
				};
				
				_nextMoneyNumberString = str _nextMoneyNumber;
				
				//save player id
				_ret = ["MoneyList", "UIDs", _nextMoneyNumberString, _uid] call iniDB_write;
				moneyUIDS set [_nextMoneyNumber,_uid];
				
				//save player name
				_ret = ["MoneyList", "Names", _nextMoneyNumberString, name _x] call iniDB_write;
				moneyNames set [_nextMoneyNumber,name _x];
				
				//save player money
				_ret = ["MoneyList", "Money", _nextMoneyNumberString, _money] call iniDB_write;
				moneyMoney set [_nextMoneyNumber,_money];
				
				//save player steam name
				_steamName = [_uid, "SteamName", "SteamName", "STRING"] call iniDB_read;
				_ret = ["MoneyList", "SteamNames", _nextMoneyNumberString, _steamName] call iniDB_write;
				moneySteamNames set [_nextMoneyNumber,_steamName];
				
				//show player their money
				if (leader _theGroup == _x) then
				{
					[30,[str _money, str _leaderMoney]] remoteExec ["Messages",_x];
				}
				else	
				{
					[30,[str _money, str _memberMoney]] remoteExec ["Messages",_x];
				};
			};
		}forEach _units;

		[false,_NPC,_missionNumber] remoteExec ["AddBreifings",_units];
	};
};

{
	{
		_x allowFleeing 1;
	}forEach units _x;
}foreach _groupArray;

//delete Task
[_task,true] call BIS_fnc_deleteTask;

sleep 5;

//split team up, send AIs back to town
{
	[_x] joinSilent grpNull;
	if !(isPlayer _x) then
	{
		sleep 1;
		[_x] execVM "DismissCiv.sqf";
	};
}forEach _units;

//delete Task
[_task,true] call BIS_fnc_deleteTask;

sleep 45;

//delete spawned objects
{
	{
		_veh = vehicle _x;
		deleteVehicle (vehicle _x);
		deleteVehicle _x;
	}forEach units _x;
}foreach _groupArray;	
{
	_veh = vehicle _x;
	deleteVehicle _veh;
	deleteVehicle _x;
}foreach _missionObjectList;

//fix buildings
_location2 = getMarkerPos ("ZX" + str _NPC + "_" + str _missionNumber);
_buildings = nearestTerrainObjects [_location2, ["TREE", "SMALL TREE", "BUSH", "BUILDING", "HOUSE", "FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE", "CHURCH", "CHAPEL", "CROSS", "ROCK", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "FENCE", "WALL", "HIDE", "BUSSTOP", "ROAD", "FOREST", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "TRACK", "MAIN ROAD", "ROCKS", "POWER LINES", "RAILWAY", "POWERSOLAR", "POWERWAVE", "POWERWIND", "SHIPWRECK", "TRAIL"], 100, false];
{
	_x setDamage 0;
}forEach _buildings;

//wipe MIP file of the job
for [{_i=0}, {_i<7}, {_i=_i+1}] do
{
	_num = format["Mission%1",_i];
	_mission = ["MissionsInProgress", "MISSIONS", _num, "STRING"] call iniDB_read;
	
	if (_mission==_missionFileName) then
	{
		_ret = ["MissionsInProgress", "MISSIONS", _num, ""] call iniDB_write;
	};
};