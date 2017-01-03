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
 
_taskNumber = 9;
_taskMarker = "t9_AAF_base";	// marker name "Agia_Marina"
_taskMarker2 = "t9_base";	// marker name "Agia_Marina"
_taskPlace = "AAF base";		// string "Agia Marina"

_taskMarkerTag = format ["<marker name=""%1"">%2</marker>",_taskMarker,_taskPlace];	
_taskMarkerTag2 = "<marker name=""t9_base"">airport</marker>";	
_taskDescription = {format ["Our allies Altian Armed Forces (AAF) need resupply their units in Charkia. Transport at least 3 cargo boxes from %2 and unload them at %1. Use HEMTT transport truck to load boxes.",_this select 0,_this select 1]};
_taskDescriptionDiary = [_taskMarkerTag,_taskMarkerTag2] call _taskDescription;
_taskDescriptionHint = [_taskPlace,"base"] call _taskDescription;
_taskTitle = format ["Transport boxes to AAF base",_taskPlace];
_taskDestination = getMarkerPos _taskMarker;
_taskWaypointDescription = format ["Transport boxes",_taskPlace];
_taskDesc_Succeed = format ["Good job! Weapon boxes are in AAF base.",_taskPlace];
_taskDesc_Failed = "Damn it!";
_taskType = "P"; // P - primary || S - secondary

_countGrp = 2;
_countUnitsGrp = 2;
_countVehicles = 0 + floor (random 0);
_countArmored = 0;	//_countCar = _countVehicles - _countArmored
_minSurUnits = 0;
_rnfArray = [];	// friendly side,	min.units,max.units,sleep(loop),create pos,unload pos, min.units in area for activation	

//------------------------------------------------
//				MISSION ADJUSTMENT
//------------------------------------------------

_enemySide = "resistance";					// "west", "east", "resistance", "civilian"
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
call compile format ["obj_%1 setSimpleTaskDestination %2",_taskNumber,getMarkerPos _taskMarker2];

if ((call compile format ["status%1%2",_taskNumber,_taskType] != "DONE") && (call compile format ["status%1%2",_taskNumber,_taskType] != "FAILED")) then
{                
	playsound "telegraph";
	["TaskAssigned",["",_taskTitle]] call bis_fnc_showNotification;
	_taskMarker setMarkerAlpha 1;
	_taskMarker2 setMarkerAlpha 1;		
	_taskMarker setmarkercolor "colorgreen"; 
	_taskMarker2 setmarkercolor "colorgreen"; 
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
		[_enemySide,_countGrp,_countUnitsGrp,( getMarkerPos _taskMarker ),( getMarkerPos _taskMarker ),200 ,80 , game_difficulty, ""] call FFS_FNC_crateSquadsPatrol;        
		
		// CREATE VEHICLES
		// [side , number of vehicles , create pos. , target pos. , max distance from target pos. for patrol ,  min distance from target pos. for patrol]
		if (_countVehicles > 0) then 
		{
			[_enemySide,_countVehicles,( getMarkerPos _taskMarker ),( getMarkerPos _taskMarker ),_markerSize * 1.5 , _markerSize * 0.8, game_difficulty, ""] call FFS_FNC_crateVehsPatrol;
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
		
		// CREATE BOXES	 43          	
		box1 = "Land_CargoBox_V1_F" createVehicle [15125.2,17314.8,0.0306206]; box1 setDir 43;
		box2 = "Land_CargoBox_V1_F" createVehicle [15128.8,17311.4,0.0306454]; box2 setDir 43;
		box3 = "Land_CargoBox_V1_F" createVehicle [15132.9,17307.7,0.030571]; box3 setDir 43;
		box4 = "Land_CargoBox_V1_F" createVehicle [15137.1,17303.6,0.0305386]; box4 setDir 43;
		box5 = "Land_CargoBox_V1_F" createVehicle [15140.7,17300.2,0.0305347]; box5 setDir 43;
		box6 = "Land_CargoBox_V1_F" createVehicle [15121.8,17311.7,0.0306168]; box6 setDir 43;
		box7 = "Land_CargoBox_V1_F" createVehicle [15125.9,17308.2,0.0306072]; box7 setDir 43;
		box8 = "Land_CargoBox_V1_F" createVehicle [15129.8,17304.6,0.0305595]; box8 setDir 43;
		box9 = "Land_CargoBox_V1_F" createVehicle [15134.2,17301,0.0305557]; box9 setDir 43;
		box10 = "Land_CargoBox_V1_F" createVehicle [15138.3,17297.6,0.0305462]; box10 setDir 43;
		
		// ENEMY & FRIENDLY UNITS
		["resistance", [18305,15275.3,29.696], 351, "" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		["resistance", [18313.6,15275.9,29.6912], 314, "" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		["resistance", [18388,15255,27.1141], 338, "" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		["resistance", [18385.6,15365.1,36.8304], 39, "" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		["resistance", [18407.3,15283.5,27.259], 50, "" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		["resistance", [18399.7,15355.6,35.7045], 36, "" , true , grpNull, game_difficulty ] call FFS_FNC_crateStaticUnit;
		
		_truck1 = ["resistance",[18378.6,15337.9,34.4526],37,"I_APC_Wheeled_03_cannon_F","",game_difficulty] call FFS_FNC_crateStaticVeh; _truck1 lock true;
		_truck2 = ["resistance",[18379.8,15289.2,27.6962] ,261,"I_MRAP_03_hmg_F","",game_difficulty] call FFS_FNC_crateStaticVeh;	_truck2 lock true;
		
		_truck3 = "I_Truck_02_transport_F" createVehicle [18417.8,15256.8,26.959]; _truck3 setdir 341; _truck3 lock true;

		_veh1 = "B_APC_Wheeled_01_cannon_F" createVehicle [15134.7,17242.7,0]; 
		_veh1 setDir 131;
		
		// CAPTURE LIST OF UNITS + LOGGING
		sleep 0.5;
		_missionUnits = +(list _trg);	
		//if (logging_mode) then {["task9.sqf",4,format ["AI skill: %1",skill (_missionUnits select 0)]] spawn FFS_FNC_log;};
		
		// ENEMY ATTACK
		[_taskMarker] spawn 
		{
			private ["_rndArray"];
			_taskMarker = _this select 0;
			_targetPos = getMarkerPos _taskMarker;
			_rndArray = floor random 2;
			_createPos = [[18826.7,16320.3,0],[17523,14416.7,0]] select _rndArray; 
			_unloadPos = [[18421.3,15510.9,0],[18192.2,15045.9,0]] select _rndArray;
			
			sleep 400 + (random 200);
			if (logging_mode) then {["task9.sqf",4,format ["ISIS attack to AAF base is beginning. CPos:(%1) TPos:(%2) ",_createPos,_targetPos]] spawn FFS_FNC_log;};
			["east",7,_createPos,_unloadPos, _targetPos ,400,game_difficulty,"ISIS"] call FFS_FNC_crateUnitWithTrans;
			sleep 10;
			["east",1,_createPos,_targetPos,20,0,game_difficulty,"ISIS_AT"] call FFS_FNC_crateVehsPatrol;
			sleep 10;
			["east",1,_createPos,_targetPos,20,0,game_difficulty,"ISIS"] call FFS_FNC_crateVehsPatrol;
		};
		["east",2,[17419.2,13747.1,0],[17201.2,15186.5,21.8238],500,0,game_difficulty,"ISIS"] call FFS_FNC_crateVehsPatrol; 
		["east",1,5,[17703,15000.3,17.0105],[17703,15000.3,17.0105],200 ,80 , game_difficulty, "ISIS"] call FFS_FNC_crateSquadsPatrol;     
		
		// ------------------------------- 1. SUBTASK ------------------------------- 
		call compile format ["subtask%1%2_1=""ACTIVE""",_taskNumber,_taskType];
		[_taskNumber,_taskType] spawn 
		{ 
			_taskNumber = _this select 0;
			_taskType = _this select 1;
			waitUntil { {(_x distance getMarkerPos "t9_AAF_base" < 30) and (alive _x) and (isNull (attachedTo _x)) } count [box1,box2,box3,box4,box5,box6,box7,box8,box9,box10] >= 3};
			// CONDITION FOR RESULT! "DONE" or "FAILED"
			call compile format ["subtask%1%2_1=""DONE""",_taskNumber,_taskType];
		};
		
		// ------------------------------- 2. SUBTASK ------------------------------- 
		call compile format ["subtask%1%2_2=""ACTIVE""",_taskNumber,_taskType];
		[_taskNumber,_taskType] spawn 
		{ 
			_taskNumber = _this select 0;
			_taskType = _this select 1;
			waitUntil { {alive _x } count [box1,box2,box3,box4,box5,box6,box7,box8,box9,box10] < 3};
			// CONDITION FOR RESULT! "DONE" or "FAILED"
			call compile format ["subtask%1%2_2=""FAILED""",_taskNumber,_taskType];
		};
		
		// ------------------------------- END OF WHOLE TASK ------------------------------- 
		waitUntil {call compile format ["subtask%1%2_1==""DONE"" or subtask%1%2_2==""FAILED""",_taskNumber,_taskType]};
		
		// RESULT OF TASK
		_removeUnitDelay = 1;
		if (call compile format ["subtask%1%2_1==""DONE""",_taskNumber,_taskType]) then 
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
	
	_taskMarker setMarkerAlpha 0;
	_taskMarker2 setMarkerAlpha 0;
	call compile format ["obj_%1 setTaskState ""%2"" ",_taskNumber,_taskState];
	[format ["%1",_notifyResult],["",_notifyDesc]] call bis_fnc_showNotification;
}else
{	
	_taskMarker setmarkercolor "colorgreen";
	_taskMarker setMarkerAlpha 0;		
	call compile format [" if (status%1%2 == ""DONE"") then {obj_%3 setTaskState ""SUCCEEDED"";}; ",_taskNumber,_taskType,_taskNumber];
	call compile format [" if (status%1%2 == ""FAILED"") then {obj_%3 setTaskState ""FAILED"";}; ",_taskNumber,_taskType,_taskNumber];	
};

if (true) exitWith {};