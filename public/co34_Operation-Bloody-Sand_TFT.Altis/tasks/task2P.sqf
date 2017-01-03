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
 
_taskNumber = 2;
_taskMarker = "Charkia";	// marker name "Agia_Marina"
_taskPlace = "Charkia";		// string "Agia Marina"

_taskMarkerTag = format ["<marker name=""%1"">%2</marker>",_taskMarker,_taskPlace];	
_taskDescription = {format ["ISIS fighters are occupying town %1. Re-take control of this town.",_this select 0]};
_taskDescriptionDiary = [_taskMarkerTag] call _taskDescription;
_taskDescriptionHint = [_taskPlace] call _taskDescription;
_taskTitle = format ["Clear %1",_taskPlace];
_taskDestination = getMarkerPos _taskMarker;
_taskWaypointDescription = format ["Clear %1",_taskPlace];
_taskDesc_Succeed = format ["Good job! %1 is cleared!",_taskPlace];
_taskDesc_Failed = "Damn it!";
_taskType = "P"; // P - primary || S - secondary

_countGrp = 6;
_countUnitsGrp = 5;
_countVehicles = 2 + floor (random 2);
_countArmored = 0;	//_countCar = _countVehicles - _countArmored
_minSurUnits = 6;
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
		
		//CUSTOM UNITS BY FAUST
		["east", [18211.6,15301.9,0.00146484], 347, "ISIS" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [18215.7,15302.8,0.00134277], 346, "ISIS" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [18230.5,15292.1,0.00134659], 87, "ISIS" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;	
		["east", [18230.5,15292.1,0.00134659], 87, "ISIS" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;	
		["east", [18385.1,15364.4,36.7843],35,"","ISIS",game_difficulty] call FFS_FNC_crateStaticVeh;	
		
		{deleteVehicle _x} forEach [bg5,trg5,flg5];
		
		// CAPTURE LIST OF UNITS + LOGGING
		sleep 0.5;
		_missionUnits = +(list _trg);	
		//if (logging_mode) then {["task1.sqf",4,format ["AI skill: %1",skill (_missionUnits select 0)]] spawn FFS_FNC_log;};
		
		// ------------------------------- 1. SUBTASK CLEAR AREA ------------------------------- 
		call compile format ["subtask%1%2_1=""ACTIVE""",_taskNumber,_taskType];
		[_trg,_missionUnits,_minSurUnits,_taskNumber,_taskType] spawn FFS_FNC_clearAreaTask;
		
		// ------------------------------- END OF WHOLE TASK ------------------------------- 
		waitUntil {call compile format ["subtask%1%2_1==""DONE""",_taskNumber,_taskType]};
		
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