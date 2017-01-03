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
 
_taskNumber = 5;
_taskMarker = "Chalkeia";	// marker name "Agia_Marina"
_taskPlace = "Chalkeia";		// string "Agia Marina"

_taskMarkerTag = format ["<marker name=""%1"">%2</marker>",_taskMarker,_taskPlace];	
_taskMarkerTag2 = format ["<marker name=""%1"">%2</marker>","leaderHouse","house"];	
_taskDescription = {format ["Kill ISIS leader who is at this moment in his %2 and clear area near this town %1.",_this select 0,_this select 1]};
_taskDescriptionDiary = [_taskMarkerTag,_taskMarkerTag2] call _taskDescription;
_taskDescriptionHint = [_taskPlace,"house"] call _taskDescription;
_taskTitle = format ["Kill leader and clear %1",_taskPlace];
_taskDestination = getMarkerPos _taskMarker;
_taskWaypointDescription = format ["Kill leader %1",_taskPlace];
_taskDesc_Succeed = format ["Good job! ISIS leader is dead and %1 is cleared!",_taskPlace];
_taskDesc_Failed = "Damn it!";
_taskType = "P"; // P - primary || S - secondary

_countGrp = 6;
_countUnitsGrp = 5;
_countVehicles = 2 + floor (random 2);
_countArmored = 0;	//_countCar = _countVehicles - _countArmored
_minSurUnits = 8;
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
	"leaderHouse" setMarkerAlpha 1;		
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
		
		// CUSTOM UNITS
		["east", [17259.8,12634.5,0.00143814], 99, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [17422.5,13706.8,0.00141811], 16, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [17034.7,12676.7,0.00158501], 40, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [17043.3,12665.7,0.00145626], 72, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [16962.8,12820.8,0.00145721], 66, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [16961.9,12829.4,0.00147247], 63, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;

		["east", [20194.7,11450.7,61.9754], 71, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [20240.6,11435.5,55.7019], 165, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [20185.1,11456.8,61.4204], 36, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east",[20179,11466.4,61.4374],68,"ISIS",game_difficulty] call FFS_FNC_crateStaticGun; 
		 		 
		 _unit = ["east", [20184.3,11457.4,58.014], 46, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; [_unit,"SAFE",15] execVM "scripts\HousePatrol.sqf"; sleep 0.2; // house patrol
		 _unit = ["east", [20178.4,11456.5,58.0204], 86, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit; [_unit,"SAFE",15] execVM "scripts\HousePatrol.sqf"; sleep 0.2; // house patrol
		 
		// CREATE leader
		ISIS_leader = ["east", [20180.3,11458.7,61.4257], 140, "ISIS_leader" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		
		// CAPTURE LIST OF UNITS + LOGGING
		sleep 0.5;
		_missionUnits = +(list _trg);	
		//if (logging_mode) then {["task1.sqf",4,format ["AI skill: %1",skill (_missionUnits select 0)]] spawn FFS_FNC_log;};
		
		// ------------------------------- 1. SUBTASK CLEAR AREA ------------------------------- 
		call compile format ["subtask%1%2_1=""ACTIVE""",_taskNumber,_taskType];
		[_trg,_missionUnits,_minSurUnits,_taskNumber,_taskType] spawn FFS_FNC_clearAreaTask;
		
		// ------------------------------- 2. SUBTASK RESCUE HOSTAGES ------------------------------- 
		call compile format ["subtask%1%2_2=""ACTIVE""",_taskNumber,_taskType];
		[_taskNumber,_taskType] spawn 
		{ 
			_taskNumber = _this select 0;
			_taskType = _this select 1;
			_civUnits = _this select 2;
			
			waitUntil { !alive ISIS_leader };
			sleep 5;
			serviceNumber = [1,"Local leader from Islamic state has been killed."]; publicvariable "serviceNumber"; 
			
			call compile format ["subtask%1%2_2=""DONE""",_taskNumber,_taskType];
		};
		
		// ------------------------------- END OF WHOLE TASK ------------------------------- 
		waitUntil {call compile format ["subtask%1%2_1==""DONE"" and subtask%1%2_2==""DONE""",_taskNumber,_taskType]};
		
		// RESULT OF TASK
		_removeUnitDelay = 1;
		if (true) then 
		{
			_resultStatus = "DONE";
		}else{
			_resultStatus = "FAILED";
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
	"leaderHouse" setMarkerAlpha 0;		
	call compile format ["obj_%1 setTaskState ""%2"" ",_taskNumber,_taskState];
	[format ["%1",_notifyResult],["",_notifyDesc]] call bis_fnc_showNotification;
}else
{	
	_taskMarker setmarkercolor "colorgreen";
	_taskMarker setMarkerAlpha 1;	
	"leaderHouse" setMarkerAlpha 0;			
	call compile format [" if (status%1%2 == ""DONE"") then {obj_%3 setTaskState ""SUCCEEDED"";}; ",_taskNumber,_taskType,_taskNumber];
	call compile format [" if (status%1%2 == ""FAILED"") then {obj_%3 setTaskState ""FAILED"";}; ",_taskNumber,_taskType,_taskNumber];	
};

if (true) exitWith {};