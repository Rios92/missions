//************************************************
//				TASK
//************************************************

/*
=========== PREREQUISITES FOR NEW TASK ===========
- declare variable statusXX in "init_Server.sqf"
- broadcast variable statusXX in "scripts\jip.sqf"
- add marker to editor
- add marker name to array variable "markers"
- modify script "tasks\taskManager.sqf"
- modify TASK ADJUSTMENT part below
==================================================
*/

//------------------------------------------------
//				TAKS ADJUSTMENT
//------------------------------------------------
 
_taskNumber = 6;
_taskMarker = "storage_area";	// marker name "Agia_Marina"
_taskPlace = "storage area";		// string "Agia Marina"

_taskMarkerTag = format ["<marker name=""%1"">%2</marker>",_taskMarker,_taskPlace];
_taskDescription = {format ["Islamic state fighters hold 4 hostages in %1 near Charkia. Clear this area and rescue all civilians.",_this select 0]};
_taskDescriptionDiary = [_taskMarkerTag] call _taskDescription;
_taskDescriptionHint = [_taskPlace] call _taskDescription;
_taskTitle = format ["Clear and rescue",_taskPlace];
_taskDestination = getMarkerPos _taskMarker;
_taskWaypointDescription = format ["Clear %1",_taskPlace];
_taskDesc_Succeed = format ["Good job! All hostages have been rescued!",_taskPlace];
_taskDesc_Failed = "Damn it! We didnt rescue all hostages!";
_taskType = "P"; // P - primary || S - secondary

_countGrp = 4;
_countUnitsGrp = 5;
_countVehicles = 0 + floor (random 0);
_countArmored = 0;	//_countCar = _countVehicles - _countArmored
_minSurUnits = 3;
_rnfArray = [];	// friendly side,	min.units,max.units,sleep(loop),create pos,unload pos, min.units in area for activation	

//------------------------------------------------
//				MISSION ADJUSTMENT
//------------------------------------------------

_enemySide = "east";					// "west", "east", "resistance", "civilian"
_enemyTrgSide = _enemySide;				// "EAST", "WEST", "GUER", "CIV", "LOGIC", "ANY"
_trg = objNull;
_markerSize = (getMarkerSize _taskMarker) select 0;
_markerPos = getMarkerPos _taskMarker;
_rndunit = "";
_rndVehicle = "";		
_missionUnits = [];
_resultStatus = "";
_taskState = "";
_notifyResult = "";
_notifyDesc = "";

// ------------------------------- SCRIPT -------------------------------

//create task
call compile format ["obj_%1 = player createSimpleTask [""%2""]",_taskNumber,_taskTitle];
call compile format ["obj_%1",_taskNumber] setSimpleTaskDescription [_taskDescriptionDiary, _taskTitle, _taskWaypointDescription];
call compile format ["obj_%1 setSimpleTaskDestination %2",_taskNumber,_taskDestination];

if ((call compile format ["status%1%2",_taskNumber,_taskType] != "DONE") && (call compile format ["status%1%2",_taskNumber,_taskType] != "FAILED")) then
{                
	playsound "telegraph";
	["TaskAssigned",["",_taskTitle]] call bis_fnc_showNotification;
	_taskMarker setMarkerAlpha 1;	
	_taskMarker setmarkercolor "colorred"; 
	call compile format ["player setCurrentTask obj_%1",_taskNumber]; 
	[_taskTitle, _taskDescriptionHint] execVM "scripts\task_hint.sqf";
	
    // ------------------------------- SERVER ------------------------------- 
     if(isServer) then  
	{
		// CHANGE TASK STATUS TO ACTIVE
		call compile format ["status%1%2=""ACTIVE""",_taskNumber,_taskType];
		call compile format ["publicvariable ""status%1%2""",_taskNumber,_taskType];	
		
		// CREATE TRIGGER    
		_trg=createTrigger["EmptyDetector",getmarkerpos _taskMarker];                
		_trg setTriggerArea [_markerSize*2, _markerSize*2, 0, false ];                
		_trg setTriggerActivation[ _enemyTrgSide,"NOT PRESENT",false];                  
		call compile format ["_trg setTriggerStatements[""this and status%1%2 == """"ACTIVE"""""","""",""""];",_taskNumber,_taskType];
		trg = _trg;
		
		// CREATE GROUPS + UNITS 
		// [ side , number of squads , number units in group , create pos. , target pos. , max distance from target pos. for patrol ,  min distance from target pos. for patrol]
		[_enemySide,_countGrp,_countUnitsGrp,( getMarkerPos _taskMarker ),( getMarkerPos _taskMarker ),_markerSize * 1.3 ,_markerSize * 0.25 , game_difficulty, "ISIS"] call FFS_FNC_crateSquadsPatrol;        
		
		// CREATE VEHICLES
		// [side , number of vehicles , create pos. , target pos. , max distance from target pos. for patrol ,  min distance from target pos. for patrol]
		if (_countVehicles > 0) then 
		{
			[_enemySide,_countVehicles,( getMarkerPos _taskMarker ),( getMarkerPos _taskMarker ),_markerSize * 1.5 , _markerSize * 0.8, game_difficulty, "ISIS"] call FFS_FNC_crateVehsPatrol;
		};
		
		// CREATE ARMORED
		// [side , number of vehicles , create pos. , target pos. , max distance from target pos. for patrol ,  min distance from target pos. for patrol]
		if (_countArmored > 0) then 
		{
			[_enemySide,_countArmored,( getMarkerPos _taskMarker ),( getMarkerPos _taskMarker ),_markerSize * 1.5 , _markerSize * 0.8, game_difficulty] call FFS_FNC_crateTanksPatrol;
		};
		
		// REINFORCEMENT
        if (count _rnfArray == 7) then 
		{
				//[f side,min units,max units,condition1,conditionOK,conditionEND,sleep,trigger,create pos,unload pos,target pos,patrol diameter,e side] execVM "scripts\test.sqf";
				[_rnfArray select 0,_rnfArray select 1,_rnfArray select 2,format ["STATUS%1%2",_taskNumber,_taskType],"ACTIVE","DONE",_rnfArray select 3,_trg,_rnfArray select 4,_rnfArray select 5,_markerPos,_markerSize * 0.9,_rnfArray select 6] execVM "scripts\reinforcement.sqf";
		};	
		
		//CUSTOM UNITS - ENEMY
		["east", [18404.9,15512.9,0.00136185], 53, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;	// gate
		["east", [18405.5,15519,0.00148392] , 136, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; // gate 
		["east", [18442.3,15568.6,0.00139618], 136, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; // gap wall
		["east", [18283.2,15553.9,0.00144196], 35, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; // center
		["east", [18225.6,15524.6,0.00139999], 276, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; // truck
		["east", [18374.1,15494.2,0.0014267], 349, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; // in front of warehouse
		["east", [18386,15494.2,52.1451] , 34, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; // balcony
		["east", [18368.1,15480.2,0.00148392], 157, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; // behind warehouse
		["east",[18396.2,15497.7,48.9768],356,"","ISIS",game_difficulty] call FFS_FNC_crateStaticVeh;
		
		_unit = ["east", [18383.9,15488.2,48.8967], 266, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; [_unit,"SAFE",15] execVM "scripts\HousePatrol.sqf"; sleep 0.2; // house patrol
		_unit = ["east", [18365.7,15483.4,48.8966], 353, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; [_unit,"SAFE",15] execVM "scripts\HousePatrol.sqf"; sleep 0.2; // house patrol

		// CREATING HOSTAGES
		_mainB_2ndRooms = [[18360.8,15485,52.2],[18360.6,15490.4,52.2],[18368.1,15490.8,52.2],[18376.3,15485.7,52.2],[18376.1,15491.3,52.2],[18381.4,15491,52.2],[18382.4,15485.6,52.2]];
		_mainB_2nd = [[18357.3,15487.3,52.2],[18365.3,15487.4,52.2],[18369.5,15484,52.2]];
		_mainB_1stRooms = [[18360.6,15485,49],[18360.2,15490.7,49],[18368.6,15490.2,49],[18376.2,15485.6,49],[18375.5,15491,49],[18383.3,15490.6,49],[18382,15485.4,49]];
		_mainB_1st = [[18367.5,15482.6,49],[18366.2,15488.7,49]];
		_oldBLD = [];
		_area = [];
		_c1 = objNull;	
		_c2 = objNull;
		_c3 = objNull;
		_c4 = objNull;	
		
		_rndArray = floor random count _mainB_2ndRooms;
		_rndHostagePos = _mainB_2ndRooms select _rndArray;
		_c1 = ["civilian",[(_rndHostagePos select 0)-0.5,(_rndHostagePos select 1)+0.5,(_rndHostagePos select 2)],0,"", true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		_c2 = ["civilian",[(_rndHostagePos select 0)+0.5,(_rndHostagePos select 1)+0.5,(_rndHostagePos select 2)],0,"", true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		_c3 = ["civilian",[(_rndHostagePos select 0)-0.5,(_rndHostagePos select 1)-0.5,(_rndHostagePos select 2)],0,"", true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		_c4 = ["civilian",[(_rndHostagePos select 0)+0.5,(_rndHostagePos select 1)-0.5,(_rndHostagePos select 2)],0,"", true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;	
		_civUnits = [_c2, _c1, _c3, _c4];
		civUnitsT3 = _civUnits;
			
		{_x disableAI "MOVE"} forEach _civUnits;
		{_x disableAI "ANIM"} foreach _civUnits; 
		{_x playMove "AmovPercMstpSsurWnonDnon"} foreach _civUnits; 
		{_x setCaptive true} foreach _civUnits;
		[[[civUnitsT3],"tasks\t6_hostages.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;
		
		sleep 0.2;
		_mainB_2ndRooms set [_rndArray,-1];
		_mainB_2ndRooms = _mainB_2ndRooms - [-1];
		
		// CREATING ENEMIES
		
		// main building ROOMS 2nd floor
		for [{_i = 0}, {_i < count _mainB_2ndRooms},{_i = _i + 1}] do
		{
			if (floor random 2 > 0) then 
			{
				["east",(_mainB_2ndRooms select _i),0,"ISIS", true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
			};
		};
		sleep 0.2;
		
		// main building 2nd floor
		for [{_i = 0}, {_i < count _mainB_2nd},{_i = _i + 1}] do
		{
			if (floor random 2 > 0) then 
			{
				["east",(_mainB_2nd select _i),0,"ISIS", true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
			};
		};
		sleep 0.2;
		
		// main building 1st ROOM floor
		for [{_i = 0}, {_i < count _mainB_1stRooms},{_i = _i + 1}] do
		{
			if (floor random 2 > 0) then 
			{
				["east",(_mainB_1stRooms select _i),0,"ISIS", true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
			};
		};
		sleep 0.2;
		
		// main building 1st floor
		for [{_i = 0}, {_i < count _mainB_1st},{_i = _i + 1}] do
		{
			if (floor random 2 > 0) then 
			{
				["east",(_mainB_1st select _i),0,"ISIS", true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
			};
		};
		sleep 0.2;		
		
		// CAPTURE LIST OF UNITS + LOGGING
		sleep 0.5;
		_missionUnits = +(list _trg);	
		
		// ------------------------------- 1. SUBTASK CLEAR AREA ------------------------------- 
		call compile format ["subtask%1%2_1=""ACTIVE""",_taskNumber,_taskType];
		[_trg,_missionUnits,_minSurUnits,_taskNumber,_taskType] spawn FFS_FNC_clearAreaTask;
		
		// ------------------------------- 2. SUBTASK RESCUE HOSTAGES ------------------------------- 
		call compile format ["subtask%1%2_2=""ACTIVE""",_taskNumber,_taskType];
		[_taskNumber,_taskType,_civUnits] spawn 
		{ 
			_taskNumber = _this select 0;
			_taskType = _this select 1;
			_civUnits = _this select 2;
			
			waitUntil {call compile format ["subtask%1%2_1==""DONE""",_taskNumber,_taskType] or ({alive _x } count _civUnits == 0)};
			// CONDITION FOR RESULT! "DONE" or "FAILED"
			if ({alive _x } count _civUnits == 4) then 
			{
				call compile format ["subtask%1%2_2=""DONE""",_taskNumber,_taskType];
			} else {
				call compile format ["subtask%1%2_2=""FAILED""",_taskNumber,_taskType];
			};	
		};
		
		// ------------------------------- END OF WHOLE TASK ------------------------------- 
		waitUntil {call compile format ["subtask%1%2_2==""DONE"" or subtask%1%2_2==""FAILED""",_taskNumber,_taskType]};
		
		// RESULT OF TASK
		_removeUnitDelay = 1;
		if (call compile format ["subtask%1%2_2==""DONE""",_taskNumber,_taskType]) then 
		{
			_resultStatus = "DONE";
			_removeUnitDelay = 1;	
		}else{
			_resultStatus = "FAILED";
			_removeUnitDelay = 180;	
		};
		
		// BROADCAST STATUS
		call compile format ["status%1%2=""%3""",_taskNumber,_taskType,_resultStatus];
		call compile format ["publicvariable ""status%1%2""",_taskNumber,_taskType];
		
		
		// TAKE CARE FOR SURRENDERS AND TRIGGER
		[_trg,_missionUnits,_removeUnitDelay] spawn FFS_FNC_surrendAndRemove;
	};

	// ------------------------------- CLIENT & SERVER -------------------------------
         
	waituntil {call compile format ["status%1%2 == ""DONE"" or status%1%2 == ""FAILED"" ",_taskNumber,_taskType]};
	
	// RESULT OF TASK
	if (call compile format ["status%1%2 == ""DONE"" ",_taskNumber,_taskType]) then 
	{
		_resultStatus = "DONE";
		_taskState = "SUCCEEDED";
		_notifyResult = "TaskSucceeded";
		_notifyDesc = _taskDesc_Succeed;
	}else{
		_resultStatus = "FAILED";
		_taskState = "Failed";
		_notifyResult = "TaskFailed";
		_notifyDesc = _taskDesc_Failed;
	};
	
	_taskMarker setmarkercolor "colorgreen";
	call compile format ["obj_%1 setTaskState ""%2"" ",_taskNumber,_taskState];
	[format ["%1",_notifyResult],["",_notifyDesc]] call bis_fnc_showNotification;
}else
{	
	_taskMarker setmarkercolor "colorgreen";
	_taskMarker setMarkerAlpha 1;			
	call compile format [" if (status%1%2 == ""DONE"") then {obj_%3 setTaskState ""SUCCEEDED"";}; ",_taskNumber,_taskType,_taskNumber];
	call compile format [" if (status%1%2 == ""FAILED"") then {obj_%3 setTaskState ""FAILED"";}; ",_taskNumber,_taskType,_taskNumber];	
};

if (true) exitWith {};