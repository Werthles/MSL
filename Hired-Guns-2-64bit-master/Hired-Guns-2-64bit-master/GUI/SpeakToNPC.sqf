//SpeakToNPC.sqf
//Runs on player
//Called from GUI Offer/Request
//Determines what interaction player has

//pvs
private ["_firstUncompleted", "_allowSecond", "_secondUncompleted", "_fU", "_sU", "_NPCNumber", "_crit1", "_crit2", "_crit3"];

closeDialog 0;
sleep 0.05;
closeDialog 0;

if !(isNil "_this") then
{
	GUITargetObject = _this select 0;
	GUITarget = name GUITargetObject;
};

if !(isNull GUITargetObject) then
{
	if (GUITargetObject distance player < 11) then
	{//if in range
		if ((str GUITargetObject) find "NPC">-1) then
		{//if target is NPC
			Progress = [];
			SendProgress = [player,GUITargetObject];
			PublicVariableServer "SendProgress";
			
			sleep 5;
			
			//get mission details
			MissionsInfo = [];
			SendMissions = [player,GUITargetObject];
			publicVariableServer "SendMissions";

			waitUntil{count(MissionsInfo)>0};

			_firstUncompleted = (Progress find 0) + 1;
			_allowSecond = true;
			if (count (MissionsInfo select 1) > 0) then
			{
				_secondUncompleted = (MissionsInfo select 1) select 1;
				
				_fU = _firstUncompleted;
				_sU = _secondUncompleted;
				_NPCNumber = parseNumber((str GUITargetObject) select [3,1]);
				_crit1 = (NPCCriticalJobs select _NPCNumber) select 0;
				_crit2 = (NPCCriticalJobs select _NPCNumber) select 1;
				_crit3 = (NPCCriticalJobs select _NPCNumber) select 2;
				
				if ((_fU<=_crit1 and _sU>=_crit1) or (_fU<=_crit2 and _sU>=_crit2) or (_fU<=_crit3 and _sU>=_crit3)) then
				{
					_allowSecond = false;
				};
			};
			
			//show available missions
			if (_allowSecond and (count (MissionsInfo select 1) > 0)) then
			{//2 missons available
				createdialog "HG_TwoMissions";
			}
			else
			{
				if (count (MissionsInfo select 0) > 0) then
				{//only 1 mission
					createdialog "HG_OneMission";
				}
				else
				{
					[25,GUITarget] call Messages;
				};
			};
			[GUITargetObject] execVM "SaveLocation.sqf";
		}
		else //not an NPC
		{
			if (isPlayer GUITargetObject) then
			{
				execVM "GUI\HirePlayer.sqf";
			}
			else
			{
				if (side GUITargetObject == CIVILIAN) then
				{
					execVM "GUI\HireCiv.sqf";
				}
				else
				{//won't talk
					[26,GUITarget] call Messages;
				};
			};
		};
	}
	else
	{//out of range
		[27,GUITarget] call Messages;
	};
}
else
{//no target
	[28,nil] call Messages;
};