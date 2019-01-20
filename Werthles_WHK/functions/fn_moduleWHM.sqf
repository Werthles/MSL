// Main Module Loop Script for WHM 2.0
if (isNil "WHKSTATUS") then
{
	//function checks
	WHKSTATUS = true;
	WHKCALL = true;

	//params
	params [["_logic",objNull,[objNull]],["_units",[],[[]]],["_activated",true,[true]]];

	//private variables
	private ["_activated", "_recurrent", "_logic", "_timeBetween", "_debug", "_advanced", "_startDelay", "_pause", "_report", "_moreBads", "_debugOnly", "_noDebug", "_moreBadNames", "_badNames", "_arb", "_transfers", "_recurrentCheck", "_ll", "_headlessCount", "_unitsInGroup", "_groupMoving", "_size", "_lead", "_leadOwner", "_leadHeadless", "_waypointAt", "_waypointPos", "_WHKDummyWaypoint1", "_WHKDummyWaypoint2", "_moveToHC", "_bad", "_syncTrigArray", "_syncWayArray", "_wayNum", "_syncedTrigs", "_syncedWays", "_syncObjectsArray", "_syncObjects", "_nameOfSync", "_found", "_zz", "_HC", "_HCName", "_fewest", "_local", "_newSum", "_firstWaypoint", "_balanced", "_maxHC", "_minHC", "_diff", "_maxHCName", "_maxGroupCount", "_maxGroup", "_z"];
	
	// Module specific behavior. Function can extract arguments from logic and use them.
	if (_activated) then
	{
		if (isMultiplayer) then
		{
			//getVars WHM input
			_recurrent =  _logic getVariable "Repeating"; // run repeatedly
			_timeBetween =  _logic getVariable "Wait"; // time between each check
			_debug =  _logic getVariable "Debug"; // debug available for all or just admin
			_advanced =  _logic getVariable "Advanced"; // selects which AI distribution method to use
			_startDelay =  _logic getVariable "Delay"; // how long to wait before running
			_pause =  _logic getVariable "Pause"; // how long to wait between each setGroupOwner, longer aids syncing
			_report =  _logic getVariable "Report"; // turn setup report on or off
			_moreBads =  _logic getVariable "Ignores"; // check for units, groups, classes, vehicles or modules with these words in their name, then ignore the associated unit's group
			_debugOnly = _logic getVariable "DebugOnly"; // only initialise debug
			_noDebug = !(_logic getVariable "NoDebug"); // don't initialise debug
			useServer = _logic getVariable "UseServer"; // split AIs among the server too
			
			//combatibility with v1
			if (isNil "_debugOnly") then {_debugOnly = false;};
			if (isNil "_noDebug") then {_noDebug = false;};
			if (isNil "useServer") then {useServer = false;};
			if (isNil "_units") then {_units = []};
			if (isNil "_moreBads") then {_moreBads = ""};
			
			//setup unit ignoring
			_moreBadNames = [_moreBads,","] call BIS_fnc_splitString;
			_badNames = ["ignore","Ignore"] + _moreBadNames;
			
			//set up arrays
			WHKHeadlessArray = [];
			WHKHeadlessLocalCounts = [];
			WHKHeadlessNames = [];
			
			//JIP Compatible globals
			if (isNil "WHKDEBUGGER") then {WHKDEBUGGER = [];};
			if (isNil "WHKDEBUGHC") then {WHKDEBUGHC = false;};
			if (isNil "WHKHeadlessGroups") then {WHKHeadlessGroups = [];};
			if (isNil "WHKHeadlessGroupOwners") then {WHKHeadlessGroupOwners = [];};

			//debug setup
			if !(_noDebug) then
			{
				//displays number of units local to each client as a hint, if debug is on
				[] spawn Werthles_fnc_WHKDebugLoop;
				
				//for human clients
				//debug hints for humans
				if (hasInterface) then
				{
					//WHK Diary Entries
					[_units,_recurrent,_timeBetween,_debug,_advanced,_startDelay,_pause,_report,_badNames,_debugOnly,_noDebug,useServer] call Werthles_fnc_WHKDiaryEntries;
					
					//Toggle debug action if admin/host
					WHKCondition = "";
					if not (_debug) then
					{
						WHKCondition = "serverCommandAvailable ""#kick""";
					};
					
					//player addAction
					WHKAction = player addAction ["<t color='#C67171'>Toggle WHM Debug</t>",
						{
							[(_this select 3)] call Werthles_fnc_WHKDebugAddAction;
						},_debug,-666,false,true,"",WHKCondition];
						
					//respawn EH
					_arb = player addEventHandler ["respawn",
						{
							[(_this select 0),(_this select 1),_debug] call Werthles_fnc_WHKRespawn;
						}
					];
				}; //if hasInterface
			};//debug setup
			
			if (_debugOnly) then
			{
				WHKHCSELECTION = [];
				WHKSYNCEDHCS = _units;
				{
					if not ((typeOf _x) == "HeadlessClient_F") then
					{
						WHKSYNCEDHCS = WHKSYNCEDHCS - [_x];
					};
				}forEach WHKSYNCEDHCS;

				if ((not (isNil "WHKSYNCEDHCS")) and (count WHKSYNCEDHCS > 0)) then
				{
					WHKHCSELECTION = WHKSYNCEDHCS;
				}
				else
				{
					//WHKHCSELECTION = 0;
					//get id of each HC connected
					{
						_id = owner _x;
						WHKHCSELECTION = WHKHCSELECTION + [_id];
					}forEach (entities "HeadlessClient_F");
				};
				
				//add server to HC list
				if (useServer) then
				{
					WHKHCSELECTION append [2];
				};
				
				//prompt HCs to update the debug icons
				[] spawn {
					while {true} do
					{
						sleep (_pause*5+5);
						//get data from HCs
						[] remoteExec ["Werthles_fnc_WHKSendInfo",WHKHCSELECTION];
					};
				};
			};
			
			//Run only on server
			if (isServer and !_debugOnly) then
			{
				//Inform WHKDEBUGGER WH is running if initial report is turned on
				if (_report) then
				{
					[4,[]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
				};
				
				//initialise checks
				_transfers = -1;
				_recurrentCheck = true;
				
				//get list of entities to offload AI onto
				WHKHCSELECTION = [];
				WHKSYNCEDHCS = _units;
				
				//check all syncs to WHM are HCs
				{
					if not ((typeOf _x) == "HeadlessClient_F") then
					{
						WHKSYNCEDHCS = WHKSYNCEDHCS - [_x];
					};
				}forEach WHKSYNCEDHCS;

				//if HCs are synced to WHM, use only those, else use all HCs
				if ((not (isNil "WHKSYNCEDHCS")) and (count WHKSYNCEDHCS > 0)) then
				{
					WHKHCSELECTION = WHKSYNCEDHCS;
				}
				else
				{
					//get id of each HC connected
					{
						_id = owner _x;
						WHKHCSELECTION = WHKHCSELECTION + [_id];
					}forEach (entities "HeadlessClient_F");
				};
				
				//add server to the list if specified
				if (useServer) then
				{
					WHKHCSELECTION append [2];
				};
				
				//Headless client incrementer
				if not (_advanced) then
				{
					_ll = -1;
				};
				
				//sleep for the length of the start delay
				sleep _startDelay;
						
				//if recurrent, repeat
				while {_recurrentCheck} do
				{
					//reset array
					WHKHeadlessArray = [];
					WHKHeadlessLocalCounts = [];
					WHKHeadlessGroups = [];
					WHKHeadlessGroupOwners = [];
					WHKHeadlessNames = [];
					
					//end if not recurrent
					if not (_recurrent) then
					{
						_recurrentCheck = false;
					};
					
					//causes WHKDEBUGGER to receive hints
					if (WHKDEBUGHC) then
					{
						[5,[]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
					};
					
					//tell HCs to send info
					[] remoteExec ["Werthles_fnc_WHKSendInfo",WHKHCSELECTION];
					
					//wait for replies
					sleep 5;
					
					//broadcast debug stuff
					if (WHKDEBUGHC) then
					{
						publicVariable "WHKHeadlessGroups";
						publicVariable "WHKHeadlessGroupOwners";
					};
					
					//Count the number of headless clients connected
					_headlessCount = count WHKHeadlessArray;
					
					//if there are headless clients connected, split AIs
					if (_headlessCount > 0) then
					{
						//clean up groups
						{
							//check if groups are empty
							_unitsInGroup = count units _x;
							if (_unitsInGroup == 0) then
							{
								deleteGroup _x;
							};
						}forEach allGroups;
						
						//loop all groups				
						{
							//get the group
							_groupMoving = _x;
							_size = count (units _groupMoving);
							_lead = leader _groupMoving;
							_leadOwner = owner _lead;
							_leadHeadless = WHKHeadlessArray find _leadOwner;
							
							//if group leader isn't a human and isn't controlled by a HC
							if (!(isPlayer _lead) and (_leadHeadless == -1) and (_size > 0)) then
							{
								//get current waypoint info
								_waypointAt = currentWaypoint _groupMoving;
								_waypointPos = waypointPosition [_groupMoving,_waypointAt];
								
								//if group has a current waypoint
								if !(_waypointPos isEqualTo [0,0,0]) then
								{
									//_waypointPos = getPos leader _groupMoving;
									
									//add dummy waypoint
									_WHKDummyWaypoint1 = _groupMoving addWaypoint [[((getPos leader _groupMoving) select 0) - 20,((getPos leader _groupMoving) select 1) - 20,0], 1, _waypointAt + 1, "WHKDummyWaypoint1"];
									_WHKDummyWaypoint1 setWaypointTimeout [15,15,15];
									
									//add dummy waypoint
									_WHKDummyWaypoint2 = _groupMoving addWaypoint [_waypointPos, 1, _waypointAt, "WHKDummyWaypoint2"];
									_WHKDummyWaypoint2 setWaypointType "CYCLE";

									sleep _pause/3;

									_WHKDummyWaypoint1 setWaypointPosition _waypointPos;
								};
								
								_moveToHC = false;
								_bad = false;
								
								//Remember syncs from waypoints to other waypoints and triggers
								_syncTrigArray = [];
								_syncWayArray = [];
								{
									_wayNum = _forEachIndex;
									_syncedTrigs = synchronizedTriggers _x;
									_syncTrigArray set [_wayNum,_syncedTrigs];
									_syncedWays = synchronizedWaypoints _x;
									_syncWayArray set [_wayNum,_syncedWays];
								}forEach waypoints _groupMoving;

								//remember syncs to objects
								_syncObjectsArray = [];
								{
									_syncObjects = synchronizedObjects _x;
									_syncObjectsArray = _syncObjectsArray + [_syncObjects];
								}forEach units _groupMoving;
								
								//check for bad modules with ignore
								{
									{
										_nameOfSync = str _x;
										{
											_found = _nameOfSync find _x;
											if (_found>-1) then
											{
												_bad = true;
											};
										}forEach _badNames;
										_nameOfSync = typeOf _x;
										{
											_found = _nameOfSync find _x;
											if (_found>-1) then
											{
												_bad = true;
											};
										}forEach _badNames + ["SupportProvider"];
									}forEach _x;
								}forEach _syncObjectsArray;
								
								//check for units with ignore
								{
									_nameOfSync = str _x;
									{
										_found = _nameOfSync find _x;
										if (_found>-1) then
										{
											_bad = true;
										};
									}forEach _badNames + ["BIS_SUPP_HQ_"];
								}forEach units _groupMoving;
								
								//check for unit type with ignore phrase
								{
									_nameOfSync = typeOf _x;
									{
										_found = _nameOfSync find _x;
										if (_found>-1) then
										{
											_bad = true;
										};
									}forEach _badNames;
								}forEach units _groupMoving;
								
								//check for unit vehicle type with ignore phrase
								{
									_nameOfSync = typeOf (vehicle _x);
									{
										_found = _nameOfSync find _x;
										if (_found>-1) then
										{
											_bad = true;
										};
									}forEach _badNames;
								}forEach units _groupMoving;
								
								//check for unit vehicle with ignore phrase
								{
									_nameOfSync = str (vehicle _x);
									{
										_found = _nameOfSync find _x;
										if (_found>-1) then
										{
											_bad = true;
										};
									}forEach _badNames;
								}forEach units _groupMoving;
								
								//check for groups with ignore
								_nameOfSync = str _x;
								{
									_found = _nameOfSync find _x;
									if (_found>-1) then
									{
										_bad = true;
									};
								}forEach _badNames;
								
								//move it to HC
								if not (_bad) then
								{
									//vars for balancing
									_zz = 0;
									_HC = 0;
									_HCName = objNull;
									
									//balancing modes: find lowest or round robin
									if (_advanced) then
									{
										//find the headless client with the fewest AIs
										_fewest = WHKHeadlessLocalCounts select 0;
										{
											//the total local units for the current HC
											if (_x < _fewest) then
											{
												_zz = _forEachIndex;
												_fewest = _x;
											};
										}forEach WHKHeadlessLocalCounts;
										
										//add group size to _local arrays
										_fewest = WHKHeadlessLocalCounts select _zz;
										_newSum = _fewest + _size;
										WHKHeadlessLocalCounts set [_zz,_newSum];
								
										//select the emptiest Headless Client
										_HC = WHKHeadlessArray select _zz;
										_HCName = WHKHeadlessNames select _zz;
									}
									else
									{
										//increment HC
										_ll = _ll + 1;
										if !(_ll < _headlessCount) then
										{
											_ll = 0;
										};
										
										//select a headless client
										_HC = WHKHeadlessArray select _ll;
										_HCName = WHKHeadlessNames select _ll;
										
										//update WHKHeadlessLocalCounts
										_newSum = WHKHeadlessLocalCounts select _ll;
										_newSum = _newSum + _size;
										WHKHeadlessLocalCounts set [_ll,_newSum];
									};
									
									//Move unit to 
									_moveToHC = _groupMoving setGroupOwner _HC;
									
									sleep (_pause/3);
									
									//reattach triggers and waypoints
									[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray] remoteExec ["Werthles_fnc_WHKSyncArrays"];
									
									//broadcast debug stuff
									if (WHKDEBUGHC and _moveToHC) then
									{
										[] remoteExec ["Werthles_fnc_WHKSendInfo",WHKHCSELECTION];
										[6,[_groupMoving,_HCName]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
										publicVariable "WHKHeadlessGroups";
										publicVariable "WHKHeadlessGroupOwners";
									};
									
									sleep (_pause/3);
																
									//reattach triggers and waypoints
									[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray] remoteExec ["Werthles_fnc_WHKSyncArrays"];
									
									sleep (_pause/3);
								};
									
								//_firstWaypoint = (waypoints _groupMoving) select 1;
								{
									if ((waypointName _x find "WHKDummyWaypoint") > -1) then
									{
										deleteWaypoint _x;
									};
								}forEach waypoints _groupMoving;
							};
						}forEach allGroups;
						
						//show report only after the first cycle
						if (_transfers == -1 and _report) then
						{
							//tell HCs to send info
							[] remoteExec ["Werthles_fnc_WHKSendInfo",WHKHCSELECTION];
							
							sleep 7;
							
							//count units moved to HCs
							_transfers = 0;
							{
								_transfers = _transfers + _x;
							}forEach WHKHeadlessLocalCounts;
							
							//repeated report call for improved visability
							sleep 2;
							[7,[_transfers,_recurrent]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
							sleep 0.5;
							[7,[_transfers,_recurrent]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
							sleep 0.5;
							[7,[_transfers,_recurrent]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
							sleep 0.5;
							[7,[_transfers,_recurrent]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
							sleep 0.5;
							[7,[_transfers,_recurrent]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
							
							//broadcast group locations
							publicVariable "WHKHeadlessGroups";
							publicVariable "WHKHeadlessGroupOwners";
							sleep 10;
						};
						
						//rebalancing
						if (_advanced and _recurrent and (_headlessCount > 1)) then
						{
							_balanced = false;
							while {not _balanced} do
							{
								_maxHC = 0;
								{
									if ((WHKHeadlessLocalCounts select _maxHC) < (WHKHeadlessLocalCounts select _forEachIndex)) then
									{
										_maxHC = _forEachIndex;
									};
								}forEach WHKHeadlessLocalCounts;

								_minHC = 0;
								{
									if ((WHKHeadlessLocalCounts select _minHC) > (WHKHeadlessLocalCounts select _forEachIndex)) then
									{
										_minHC = _forEachIndex;
									};
								}forEach WHKHeadlessLocalCounts;

								_diff = ((WHKHeadlessLocalCounts select _maxHC) - (WHKHeadlessLocalCounts select _minHC));
								
								//if unbalanced, check for a group to move
								if (_diff > 1) then
								{
									//name of HC with the most units
									_maxHCName = str (WHKHeadlessNames select _maxHC);
									_maxGroupCount = 0;
									_maxGroup = 0;
									{
										If (str _x == _maxHCName) then
										{
											//count the units in the related group
											_z = (count units (WHKHeadlessGroups select _forEachIndex));
											
											//if not more than half the diff and the group biggest yet
											if ((_z <= (_diff/2)) and (_z  >_maxGroupCount)) then
											{
												_maxGroup = _forEachIndex;
												_maxGroupCount = _z;
											};
										};
									}forEach WHKHeadlessGroupOwners;

									//if no such group found, exit, else move the group
									if (_maxGroupCount == 0) then
									{
										_balanced = true;
									}
									else
									{
										//get the group
										_groupMoving = (WHKHeadlessGroups select _maxGroup);
										
										//get current waypoint info
										_waypointAt = currentWaypoint _groupMoving;
										_waypointPos = waypointPosition [_groupMoving,_waypointAt];
										
										//if group has a current waypoint
										if !(_waypointPos isEqualTo [0,0,0]) then
										{
											//_waypointPos = getPos leader _groupMoving;
											
											//add dummy waypoint
											_WHKDummyWaypoint1 = _groupMoving addWaypoint [[((getPos leader _groupMoving) select 0) - 20,((getPos leader _groupMoving) select 1) - 20,0], 1, _waypointAt + 1, "WHKDummyWaypoint1"];
											_WHKDummyWaypoint1 setWaypointTimeout [15,15,15];
											
											//add dummy waypoint
											_WHKDummyWaypoint2 = _groupMoving addWaypoint [_waypointPos, 1, _waypointAt, "WHKDummyWaypoint2"];
											_WHKDummyWaypoint2 setWaypointType "CYCLE";

											sleep _pause/3;

											_WHKDummyWaypoint1 setWaypointPosition _waypointPos;
										};
										
										_moveToHC = false;
										_bad = false;

										//Remember syncs from waypoints to other waypoints and triggers
										_syncTrigArray = [];
										_syncWayArray = [];
										{
											_wayNum = _forEachIndex;
											_syncedTrigs = synchronizedTriggers _x;
											_syncTrigArray set [_wayNum,_syncedTrigs];
											_syncedWays = synchronizedWaypoints _x;
											_syncWayArray set [_wayNum,_syncedWays];
										}forEach waypoints _groupMoving;

										//remember syncs to objects
										_syncObjectsArray = [];
										{
											_syncObjects = synchronizedObjects _x;
											_syncObjectsArray = _syncObjectsArray + [_syncObjects];
										}forEach units _groupMoving;

										//check for bad modules with ignore
										{
											{
												_nameOfSync = str _x;
												{
													_found = _nameOfSync find _x;
													if (_found>-1) then
													{
														_bad = true;
													};
												}forEach _badNames;
												_nameOfSync = typeOf _x;
												{
													_found = _nameOfSync find _x;
													if (_found>-1) then
													{
														_bad = true;
													};
												}forEach _badNames + ["SupportProvider"];
											}forEach _x;
										}forEach _syncObjectsArray;

										//check for units with ignore
										{
											_nameOfSync = str _x;
											{
												_found = _nameOfSync find _x;
												if (_found>-1) then
												{
													_bad = true;
												};
											}forEach _badNames + ["BIS_SUPP_HQ_"];
										}forEach units _groupMoving;

										//check for unit type with ignore phrase
										{
											_nameOfSync = typeOf _x;
											{
												_found = _nameOfSync find _x;
												if (_found>-1) then
												{
													_bad = true;
												};
											}forEach _badNames;
										}forEach units _groupMoving;

										//check for unit vehicle type with ignore phrase
										{
											_nameOfSync = typeOf (vehicle _x);
											{
												_found = _nameOfSync find _x;
												if (_found>-1) then
												{
													_bad = true;
												};
											}forEach _badNames;
										}forEach units _groupMoving;

										//check for unit vehicle with ignore phrase
										{
											_nameOfSync = str (vehicle _x);
											{
												_found = _nameOfSync find _x;
												if (_found>-1) then
												{
													_bad = true;
												};
											}forEach _badNames;
										}forEach units _groupMoving;

										//check for groups with ignore
										_nameOfSync = str _x;
										{
											_found = _nameOfSync find _x;
											if (_found>-1) then
											{
												_bad = true;
											};
										}forEach _badNames;

										if not (_bad) then
										{
											//Remember syncs from waypoints to other waypoints and triggers
											_syncTrigArray = [];
											_syncWayArray = [];
											{
												_wayNum = _forEachIndex;
												_syncedTrigs = synchronizedTriggers _x;
												_syncTrigArray set [_wayNum,_syncedTrigs];
												_syncedWays = synchronizedWaypoints _x;
												_syncWayArray set [_wayNum,_syncedWays];
											}forEach waypoints _groupMoving;

											//remember syncs to objects
											_syncObjectsArray = [];
											{
												_syncObjects = synchronizedObjects _x;
												_syncObjectsArray = _syncObjectsArray + [_syncObjects];
											}forEach units _groupMoving;

											//relocate group
											_moveToHC = (WHKHeadlessGroups select _maxGroup) setGroupOwner (WHKHeadlessArray select _minHC);

											sleep (_pause/3);
											
											//reattach triggers and waypoints
											[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray] remoteExec ["Werthles_fnc_WHKSyncArrays"];

											//reattach triggers and waypoints
											//[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray] remoteExec ["Werthles_fnc_WHKSyncArrays"];
											
											//show debug for the moved group
											if (WHKDEBUGHC and _moveToHC) then
											{
												_HCName = WHKHeadlessNames select _minHC;
												[] remoteExec ["Werthles_fnc_WHKSendInfo",WHKHCSELECTION];
												[6,[_groupMoving,_HCName]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
												publicVariable "WHKHeadlessGroups";
												publicVariable "WHKHeadlessGroupOwners";
											};

											//update counts
											if (_moveToHC) then
											{
												WHKHeadlessLocalCounts set [_minHC,(WHKHeadlessLocalCounts select _minHC) + _maxGroupCount];
												WHKHeadlessLocalCounts set [_maxHC,(WHKHeadlessLocalCounts select _maxHC) - _maxGroupCount];
											};
											sleep (_pause/3);

											//delete dummy waypoints
											{
												if ((waypointName _x find "WHKDummyWaypoint") > -1) then
												{
													deleteWaypoint _x;
												};
											}forEach waypoints _groupMoving;
											
											WHKHeadlessGroups deleteAt _maxGroup;
											WHKHeadlessGroupOwners deleteAt _maxGroup;
										}
										else //quit rebalancing
										{
											_balanced = true;
										};
									};
								}
								else
								{
									_balanced = true;
								};
							};
						};
					}
					else
					{
						//no HC data error
						if (WHKDEBUGHC) then
						{
							[11,[]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
							sleep 10;
						};
					};
					
					//causes WHKDEBUGGER to receive hints
					if (WHKDEBUGHC) then
					{
						sleep 2;
						[] remoteExec ["Werthles_fnc_WHKSendInfo",WHKHCSELECTION];
						[8,[]] remoteExec ["Werthles_fnc_WHKDebugHint",WHKDEBUGGER];
						sleep 5;
						
						//broadcast group locations
						publicVariable "WHKHeadlessGroups";
						publicVariable "WHKHeadlessGroupOwners";
					};
					
					//time between checks
					sleep _timeBetween;
					
					//remove non-HCs from the list
					WHKHCSELECTION = [];
					{
						if not ((typeOf _x) == "HeadlessClient_F") then
						{
							WHKSYNCEDHCS = WHKSYNCEDHCS - [_x];
						};
					}forEach WHKSYNCEDHCS;

					//create list of HCs to use
					if ((not (isNil "WHKSYNCEDHCS")) and (count WHKSYNCEDHCS > 0)) then
					{
						WHKHCSELECTION = WHKSYNCEDHCS;
					}
					else
					{
						//get id of each HC connected
						{
							_id = owner _x;
							WHKHCSELECTION = WHKHCSELECTION + [_id];
						}forEach (entities "HeadlessClient_F");
					};
					
					//add server to HC list
					if (useServer) then
					{
						WHKHCSELECTION append [2];
					};
					
					//delete any dummy waypoints left
					{
						{
							if ((waypointName _x find "WHKDummyWaypoint") > -1) then
							{
								deleteWaypoint _x;
							};
						}forEach waypoints _x;
					}forEach allGroups;
				};
			};	
		}
		else
		{
			//Inform players WH is not running
			[9,[]] call Werthles_fnc_WHKDebugHint;
		};

	};
}
else
{
	WHKCALL = false;
	//Inform players WH is not running
	if (isServer or serverCommandAvailable "#kick") then
	{
		[10,[]] call Werthles_fnc_WHKDebugHint;
	};
};
WHKCALL