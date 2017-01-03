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

// RANDOM LOCATION FOR TAKS
_locGuards = [];
_reporterPos = [];
_heliCreatePos = [];

if(isServer) then  
{
	_rnd = floor random 2;

	if (_rnd == 1) then
	{
		// NEW POS
		"t7_area1" setMarkerPos [20624,17634,0];
		"t7_extrArea" setMarkerPos [20311.5,17942.4,0];
		_reporterPos = [20628.9,17671.6,53.7284];
		_locGuards = [ [[20631,17668.5,53.4251],130],[[20631.8,17673.6,53.5117],53] ];
		_heliCreatePos = [18278.6,17933.4,0]; 
	} else{
		// OLD POS
		_reporterPos = [20947.1,16028.1,24.1012];
		_locGuards = [ [[20951.3,16024.8,23.3811],134],[[20945.2,16034.9,23.5765],310] ];
		_heliCreatePos = [18798.1,18055.2,0];
	};
	if (logging_mode) then {["task7.sqf",4,format ["Location is: %1 / Heli Pos: %2",_rnd,_heliCreatePos]] spawn FFS_FNC_log;};
	// 
};
	
_taskNumber = 7;
_taskMarker = "t7_area1";	// marker name "Agia_Marina"
_taskPlace = "area";		// string "Agia Marina"

_taskMarkerTag = format ["<marker name=""%1"">%2</marker>",_taskMarker,_taskPlace];
_taskMarkerTag2 = "<marker name=""t7_extrArea"">extraction point</marker>";
_taskDescription = {format ["U.S. reporter has been arrested by ISIS fighters. They hold him in this %1 according Military Intelligence Corps. Yours task is find the reporter take him to %2 at grid %3. Helicopter will pickup him from LZ.<br/><br/><br/>John Fowler<br/><img image=""pics\t7_reporter.jpg""/>.",_this select 0,_this select 1,mapGridPosition getMarkerPos  "t7_extrArea"]};
_taskDescriptionDiary = [_taskMarkerTag,_taskMarkerTag2] call _taskDescription;
_taskDescriptionHint = [_taskPlace,"extraction point"] call _taskDescription;
_taskTitle = format ["Rescue reporter",_taskPlace];
_taskDestination = getMarkerPos _taskMarker;
_taskWaypointDescription = format ["Rescue reporter",_taskPlace];
_taskDesc_Succeed = format ["Good job! U.S. reporter has been rescued.",_taskPlace];
_taskDesc_Failed = "Damn it! U.S. reporter is dead!";
_taskType = "P"; // P - primary || S - secondary

_countGrp = 5;
_countUnitsGrp = 5;
_countVehicles = 1 + floor (random 0);
_countArmored = 0;	//_countCar = _countVehicles - _countArmored
_minSurUnits = 2;
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
	"t7_extrArea" setMarkerAlpha 1;
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
		
		sleep 1;
		
		// CREATE REPORTER CHARACTER
		reporter = ["civilian", _reporterPos,158,"reporter" , true, grpNull , game_difficulty] call FFS_FNC_crateStaticUnit;
		_reporter = reporter;
		_reporter setIdentity "John_Fowler";	
		_reporter setCaptive true;
		//serviceNumber = [4,reporter]; publicvariable "serviceNumber";
		_reporter playMove "AmovPsitMstpSnonWnonDnon_smoking_trans";		// animation is broadcated to all players even if command is executed only on server
		_reporter disableAI "ANIM"; 
		reporterFound = false;
		publicVariable "reporterFound";
		reporterInLZ = false;
		publicVariable "reporterInLZ";
		
		// CREATE GUARDS [[[20951.3,16024.8,23.3811],134],[[20945.2,16034.9,23.5765],310]];
		["east", _locGuards select 0 select 0, _locGuards select 0 select 1, "ISIS" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		["east", _locGuards select 1 select 0, _locGuards select 1 select 1, "ISIS" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		
		// HOW TO MANAGE COMMANDS using BIS_fnc_MP in MP on SERVER/CLIENTS/JIP
		[[[reporter],"tasks\t7_reporter_init.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;
		/*
		1. initialization 	- COMMANDS 		- init commands + spawn 1.BIS_fnc_MP	/ SERVER / 			global commnds on SERVER (setCaptive,removeAllWeapons)
		2. prepare 			- BIS_fnc_MP 	- init commands + addAction  			/ ALL / 			local commands on CLIENTS (setIdentity,addAction)
		3. action 			- SQF 			- local commnds	+ spawn 2.BIS_fnc_MP	/ 1 CLIENT /		local commnds on 1 CLIENT (hint + titleText)
		4. finish 			- BIS_fnc_MP 	- remove action + finish action			/ ALL /				global commands on SERVER (addWaypoint/switchMove) and local on CLIENTS (removeAllActions,enableAI) 
		*/
		
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
		
		// CAPTURE LIST OF UNITS + LOGGING
		sleep 0.5;
		_missionUnits = +(list _trg);		
		//if (logging_mode) then {["task7.sqf",4,format ["AI skill: %1",skill (_missionUnits select 0)]] spawn FFS_FNC_log;};
		
		// ------------------------------- 1. SUBTASK CLEAR AREA ------------------------------- 
		call compile format ["subtask%1%2_1=""ACTIVE""",_taskNumber,_taskType];
		[_trg,_missionUnits,_minSurUnits,_taskNumber,_taskType] spawn FFS_FNC_clearAreaTask;
			
		// ------------------------------- 2. SUBTASK RESCUE REPORTER ------------------------------- 
		call compile format ["subtask%1%2_2=""ACTIVE""",_taskNumber,_taskType];
		[_taskNumber,_taskType,_heliCreatePos] spawn 
		{ 
			_taskNumber = _this select 0;
			_taskType = _this select 1;
			_heliCreatePos = _this select 2;
			heliPickupFN=objNull;
			
			waitUntil {(!alive reporter ) or ((getPos reporter ) distance (getMarkerPos "t7_extrArea") < 220 )};
			if (alive reporter ) then 
			{
				[reporter] join grpNull;
				reporterInLZ = true;
				reporter doMove getMarkerPos "t7_extrArea";
				serviceNumber = [4,reporter]; publicvariable "serviceNumber";	// TASK 7 - REMOVE ACTION FROM REPORTER
				publicVariable "reporterInLZ";
				sleep 1;
				[_heliCreatePos,getMarkerPos "t7_extrArea",reporter ] spawn FFS_FNC_pickupRemove;
				if (logging_mode) then {["task7.sqf",4,format ["Helicopter has been created for pickup reporter from EZ at grid %1",mapGridPosition getMarkerPos  "t7_extrArea"]] spawn FFS_FNC_log;};
				serviceNumber = [8]; publicVariable "serviceNumber";	// RESCUED REPORTER SENT HELICOPTER
			};	
			sleep 5;
			waitUntil {(!alive reporter ) or (reporter in heliPickupFN)};
			// CONDITION FOR RESULT! "DONE" or "FAILED"
			if (alive reporter ) then 
			{
				if (alive reporter ) then 
				{
					call compile format ["subtask%1%2_2=""DONE""",_taskNumber,_taskType];
					if (logging_mode) then {["task7.sqf",4,format ["Reporter is in chopper - %1 / %2",vehicle leader group reporter,reporter]] spawn FFS_FNC_log;};
				}else{
					call compile format ["subtask%1%2_2=""FAILED""",_taskNumber,_taskType];
					if (logging_mode) then {["task7.sqf",4,format ["Reporter is dead - %1",reporter]] spawn FFS_FNC_log;};
				};
			} else {
				call compile format ["subtask%1%2_2=""FAILED""",_taskNumber,_taskType];
			};	
		};
		
		// ------------------------------- 3. SUBTASK TIME ------------------------------- 
		call compile format ["subtask%1%2_3=""ACTIVE""",_taskNumber,_taskType];
		[_taskNumber,_taskType] spawn 
		{ 
			_taskNumber = _this select 0;
			_taskType = _this select 1;

			waitUntil {call compile format ["subtask%1%2_1==""DONE"" or reporterInLZ",_taskNumber,_taskType]};
			sleep 600;
			if (status7P == "ACTIVE") then
			{
				if (logging_mode) then {["task7.sqf",16,format ["TIMEOUT close task! => subtask7P_3: %1 / reporterInLZ: %2",subtask7P_3,reporterInLZ]] spawn FFS_FNC_log;};
				call compile format ["subtask%1%2_3=""DONE""",_taskNumber,_taskType];
			};
		};
		
		// ------------------------------- END OF WHOLE TASK ------------------------------- 
		waitUntil {call compile format ["subtask%1%2_3==""DONE"" or subtask%1%2_2==""DONE"" or subtask%1%2_2==""FAILED"" ",_taskNumber,_taskType]};
		
		// RESULT OF TASK
		_removeUnitDelay = 0;
		if (call compile format ["subtask%1%2_3==""DONE"" ",_taskNumber,_taskType]) then 
		{
			_resultStatus = "DONE";
			_removeUnitDelay = 1;
			serviceNumber = [6,_reporter]; publicvariable "serviceNumber";	// removeAllActions
		}else{
			if (call compile format ["subtask%1%2_2==""DONE"" ",_taskNumber,_taskType]) then
			{	
				_resultStatus = "DONE";
				_removeUnitDelay = 180;	
			}else{
				_resultStatus = "FAILED";
				_removeUnitDelay = 180;
			};	
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
	_taskMarker setMarkerAlpha 0;
	"t7_extrArea" setMarkerAlpha 0;	
	call compile format ["obj_%1 setTaskState ""%2"" ",_taskNumber,_taskState];
	[format ["%1",_notifyResult],["",_notifyDesc]] call bis_fnc_showNotification;
}else
{	
	_taskMarker setmarkercolor "colorgreen";
	_taskMarker setMarkerAlpha 0;
	"t7_extrArea" setMarkerAlpha 0;	
	call compile format [" if (status%1%2 == ""DONE"") then {obj_%3 setTaskState ""SUCCEEDED"";}; ",_taskNumber,_taskType,_taskNumber];
	call compile format [" if (status%1%2 == ""FAILED"") then {obj_%3 setTaskState ""FAILED"";}; ",_taskNumber,_taskType,_taskNumber];	
};

if (true) exitWith {};