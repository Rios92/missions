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
 
_taskNumber = 8;
_taskMarker = "t8_ammo_area";	// marker name "Agia_Marina"
_taskPlace = "area";		// string "Agia Marina"

_taskMarkerTag = format ["<marker name=""%1"">%2</marker>",_taskMarker,_taskPlace];	
_taskDescription = {format ["Locate and destroy ISIS arms store in %1.",_this select 0]};
_taskDescriptionDiary = [_taskMarkerTag] call _taskDescription;
_taskDescriptionHint = [_taskPlace] call _taskDescription;
_taskTitle = format ["Find and destroy ammo boxes",_taskPlace];
_taskDestination = getMarkerPos _taskMarker;
_taskWaypointDescription = format ["Find ammo boxes",_taskPlace];
_taskDesc_Succeed = format ["Good job! Arms store has been destroyed!",_taskPlace];
_taskDesc_Failed = "Damn it!";
_taskType = "P"; // P - primary || S - secondary

_countGrp = 4;
_countUnitsGrp = 5;
_countVehicles = 1 + floor (random 0);
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
		
		//CUSTOM UNITS
		["east", [20746.3,13396.5,38.7490], 325, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [20744.9,13392.8,38.6096], 306, "ISIS" , true , grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", [20773.0,13364.3,36.9857], 219, "ISIS" , false, grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;	
		["east", [20973.7,13136.3,31.9667], 145, "ISIS" , false, grpNull , game_difficulty ] call FFS_FNC_crateStaticUnit;	
		
		//["east",[18220.5,15289.9,0.0014267],93,"","ISIS",game_difficulty] call FFS_FNC_crateStaticVeh;	
		
		// CREATE AMMO BOXES
		_rndPosAmmo = [[[20773.8,13368.3,37.2071], [20777.2,13365.7,37.2042]]];					// 
		_rndPosAmmo = _rndPosAmmo + [[[20840.7,13281.7,33.0685], [20837.9,13284.3,33.0685]]];		//
		_rndPosAmmo = _rndPosAmmo + [[[20875.3,13235.6,32.4126], [20877.1,13233.4,32.4098]]];		//
		_rndPosAmmo = _rndPosAmmo + [[[20990.7,13218.4,34.6095], [20988.1,13220.4,34.6085]]];		//
		_rndPosAmmo = _rndPosAmmo + [[[20869.4,13354.4,31.7059], [20865.9,13352.4,31.7080]]];		//
		_rndAtr = floor random count _rndPosAmmo;
		_posARRAY = _rndPosAmmo select _rndAtr;
		
		if (logging_mode) then {["task8.sqf",4,format ["_rndAtr: %1 / _posARRAY: %2 ",_rndAtr,_posARRAY]] spawn FFS_FNC_log;};
		
		_ammo1 = "Box_FIA_Wps_F" createVehicle (_posARRAY select 0); _ammo1 setPosASL (_posARRAY select 0);
		_ammo2 = "Box_FIA_Ammo_F" createVehicle (_posARRAY select 1); _ammo2 setPosASL (_posARRAY select 1);
		T8_ammoArray=[_ammo1,_ammo2];
		flag2 setFlagTexture "pics\ISIS_flag3.jpg";
		
		//if (logging_mode) then {["task8.sqf",4,format ["_rndAtr: %1 / _posARRAY: %2 / T8_ammoArray: %3",_rndAtr,_posARRAY,T8_ammoArray]] spawn FFS_FNC_log;};
		
		// CAPTURE LIST OF UNITS + LOGGING
		sleep 0.5;
		_missionUnits = +(list _trg);	
		//if (logging_mode) then {["task1.sqf",4,format ["AI skill: %1",skill (_missionUnits select 0)]] spawn FFS_FNC_log;};
		
		// ------------------------------- 1. SUBTASK CLEAR AREA ------------------------------- 
		call compile format ["subtask%1%2_1=""ACTIVE""",_taskNumber,_taskType];
		[_trg,_missionUnits,_minSurUnits,_taskNumber,_taskType] spawn FFS_FNC_clearAreaTask;
		
		// ------------------------------- 2. SUBTASK DESTROY AMMO BOXES ------------------------------- 
		call compile format ["subtask%1%2_2=""ACTIVE""",_taskNumber,_taskType];
		[_taskNumber,_taskType] spawn 
		{ 
			_taskNumber = _this select 0;
			_taskType = _this select 1;
			
			waitUntil { ({alive _x} count T8_ammoArray) < 1};
			
			// CONDITION FOR RESULT! "DONE" or "FAILED"
			call compile format ["subtask%1%2_2=""DONE""",_taskNumber,_taskType];

		};
		
		// ------------------------------- END OF WHOLE TASK ------------------------------- 
		waitUntil {call compile format ["subtask%1%2_2==""DONE""",_taskNumber,_taskType]};
		
		// RESULT OF TASK
		_removeUnitDelay = 1;
		if (call compile format ["subtask%1%2_1==""DONE""",_taskNumber,_taskType]) then 
		{
			_resultStatus = "DONE";
			_removeUnitDelay = 1;	
		}else{
			_resultStatus = "DONE";
			_removeUnitDelay = 360;	
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
	
	flag2 setFlagTexture "";
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