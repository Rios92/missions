// ONLY SERVER
// rndUnit = call (compile loadFile "funcs\func_randomCivUnit.sqf" );
if(!isServer)exitwith{};
sleep 1;
CountGrpEast = 1;
CountVehEast = 1;
CountGrpWest = 1;
CountVehWest = 1;
CountGrpCivilian = 1;
CountGrpResistance = 1;
CountVehResistance = 1;
creweast = "O_Soldier_F";
crewwest = "B_Soldier_F";
crewresistance = "I_Soldier_F";
tankcreweast = "O_Soldier_F";
tankcrewwest = "B_Soldier_F";

// ********************************************************
//
//						S O L D I E R S 
//
// ********************************************************

// CREATE SQUADS TO PATROL AREA	(used in tasks!!!)
//
//	[side , number of squads , number units in group , create pos. , target pos. , max distance from target pos. for patrol ,  min distance from target pos. for patrol, difficulty , String ]
//	["east",6,3,getMarkerPos "test3",getMarkerPos "test3",200,0,[0.7,0.2],"ISIS"] call FFS_FNC_crateSquadsPatrol;
//	return: ARRAY  => created GROUPS

FFS_FNC_crateSquadsPatrol = 
{
	private ["_enemySide","_countGroups","_sizeGroup","_createPos","_targetPos","_areaSizeMax","_areaSizeMin","_AIskill","_AIacc","_pathFuncUnit","_pathFuncCust","_groupName","_localCountGrp","_rndPos","_rndUnit","_rndUnitInit","_grpARRAY","_argumentSTR"];
	_enemySide = _this select 0;
	_countGroups = _this select 1;
	_sizeGroup = _this select 2;
	_createPos = _this select 3;
	_targetPos = _this select 4;
	_areaSizeMax = _this select 5;
	_areaSizeMin = _this select 6;
	_AIskill = (_this select 7) select 0;
	_AIacc = (_this select 7) select 1;
	_argumentSTR = _this select 8;
	_grpARRAY = [];
	_rndUnitInit = {};
	
	_pathFuncUnit = format ["funcs\func_random%1Unit.sqf",_enemySide];
	_pathFuncCust = format ["funcs\func_random%1UnitCustom.sqf",_enemySide];
	_groupName = format ["grp%1_",_enemySide];
	
	for [{_m = 1},{_m <= _countGroups},{_m = _m+1}] do 
	{       
		_localCountGrp = call compile format ["CountGrp%1",_enemySide];
		call compile format ["%1%2 = createGroup %3; %1%2 allowFleeing 0; _grpARRAY = _grpARRAY +[%1%2];",_groupName,_localCountGrp,_enemySide];
		call compile format ["CountGrp%1 = CountGrp%1 + 1",_enemySide];
		_rndPos = [ _createPos , _areaSizeMax , 0 ] call (compile preprocessFile "funcs\func_randomPos.sqf");
		switch (_argumentSTR) do 
		{
			case "ISIS": {
				_rndUnitInit = [] call (compile loadFile _pathFuncCust);
				_rndUnit = "O_Soldier_F";
			};
			default {
				_rndUnit = [] call (compile loadFile _pathFuncUnit );
				_rndUnitInit = {};
			};
		};
		call compile format [" _unitFNC = ""%2"" createUnit [ %3, %4%1 , ""this setSkill %5;this setskill [""""aimingAccuracy"""",%6]; call _rndUnitInit"" , %5 ,""PRIVATE""] ",_localCountGrp,_rndUnit,_rndPos,_groupName,_AIskill,_AIacc];
		sleep 0.1;
		for [{_p = 1},{_p < _sizeGroup},{_p = _p+1}] do 
		{       
			switch (_argumentSTR) do 
			{
				case "ISIS": {
					_rndUnitInit = [] call (compile loadFile _pathFuncCust);
					_rndUnit = "O_Soldier_F";
				};
				default {
					_rndUnit = [] call (compile loadFile _pathFuncUnit );
					_rndUnitInit = {};
				};
			};
			call compile format [" ""%2"" createUnit [ %3 , %4%1 , ""this setSkill %5;this setskill [""""aimingAccuracy"""",%6];call _rndUnitInit"" , %5 ,""PRIVATE""] ",_localCountGrp,_rndUnit,_rndPos,_groupName,_AIskill,_AIacc];
			sleep 0.05;
		};
		sleep 1;  
		call compile format [" [ leader %1%2 , %3 , %4 , %5 ] execVM ""scripts\Soldierwalkguard.sqf"" ",_groupName,_localCountGrp,_areaSizeMax,_areaSizeMin,_targetPos];          // MAX | MIN | CENTER
	};
	_grpARRAY
};

// CREATE STATIC UNIT (ON ASL POSITION)
//
//	[side , create ASL pos., direction, unitClass or string, UP unitPos, group, difficulty]  call FNC_crateEASTUnitWithTrans;
//	unit = ["east", getMarkerPos "test1", 150 , "", true, grpNull , [0.5,0.2] ] call FFS_FNC_crateStaticUnit;
//	return: OBJECT => created UNIT

FFS_FNC_crateStaticUnit = 
{
	private ["_enemySide","_unitClass","_createPos","_upUnitPos","_dir""_AIskill","_AIacc","_grp","_pathFuncUnit","_pathFuncCust","_groupName","_localCountGrp","_rndPos","_rndUnit","_rndUnitInit","_grp"];
	_enemySide = _this select 0;
	_createPos = _this select 1;
	_dir = _this select 2;
	_unitClass = _this select 3;
	_upUnitPos = _this select 4;
	_grp = _this select 5;
	_AIskill = (_this select 6) select 0;
	_AIacc = (_this select 6) select 1;
	_pathFuncCust = "";
	_rndUnitInit = {};
	_rndUnit = "";	
	
	if (_unitClass == "") then 
	{
		
	} else {
		if (_unitClass == "ISIS") then
		{
			
		}else{
			_rndUnit = _unitClass;
		};
	};
	
	switch (_unitClass) do 
	{
		case "ISIS": {
			_rndUnit = "O_Soldier_F";
			_pathFuncCust = format ["funcs\func_random%1UnitCustom.sqf",_enemySide];
			_rndUnitInit = [] call (compile loadFile _pathFuncCust);		
			};
		case "reporter": {
			_rndUnit = "C_man_1";
			_pathFuncCust = format ["funcs\func_random%1UnitCustom.sqf",_enemySide];
			_rndUnitInit = [] call (compile loadFile _pathFuncCust);		
			};
		case "ISIS_leader": {
			_rndUnit = "O_Soldier_F";
			_pathFuncCust = format ["funcs\func_random%1UnitCustom.sqf",_enemySide];
			_rndUnitInit = ["ISIS_leader"] call (compile loadFile _pathFuncCust);		
			};
		default {
			_pathFuncUnit = format ["funcs\func_random%1Unit.sqf",_enemySide];
			_rndUnit = [] call (compile loadFile _pathFuncUnit );
		};
	};
	
	_groupName = format ["grp%1_",_enemySide];
	_localCountGrp = call compile format ["CountGrp%1",_enemySide];
	if (isNull _grp) then 
	{
		call compile format ["%1%2 = createGroup %3; _grp = %1%2;",_groupName,_localCountGrp,_enemySide];
	};
	call compile format ["CountGrp%1 = CountGrp%1 + 1",_enemySide];
	_rndPos = _createPos;
	
	call compile format [" ""%2"" createUnit [ %3, _grp , ""this setSkill %6;this setskill [""""aimingAccuracy"""",%7];call _rndUnitInit; this setDir %8; this setPosASL %5; (group this) setFormDir %8"" , %6 ,""PRIVATE""]; _grp allowFleeing 0;",_localCountGrp,_rndUnit,_rndPos,_groupName,_createPos,_AIskill,_AIacc,_dir];
	if (_upUnitPos) then 
	{
		call compile format ["(leader %4%1) setUnitPos ""UP""",_localCountGrp,_rndUnit,_rndPos,_groupName,_createPos];
	};
	leader _grp
};

// CREATE GROUP
//
//	[side ]  call FFS_FNC_crateGroup;
//	["east"] call FFS_FNC_crateGroup;
//	return: OBJECT => created GROUP

FFS_FNC_crateGroup = 
{
	private ["_grp","_enemySide","_groupName","_localCountGrp"];
	_grp = grpNull;
	_enemySide = _this select 0;
	_groupName = format ["grp%1_",_enemySide];
	_localCountGrp = call compile format ["CountGrp%1",_enemySide];
	call compile format ["%1%2 = createGroup %3; %1%2 allowFleeing 0; _grp = %1%2",_groupName,_localCountGrp,_enemySide];
	call compile format ["CountGrp%1 = CountGrp%1 + 1;",_enemySide];
	_grp
};

// DELETE GROUP
//
//	[]  call FFS_FNC_deleteGroup;
//	[] call FFS_FNC_deleteGroup;
//	return: nothing

FFS_FNC_deleteGroup = 
{
	private ["_allgroups"];
	_allgroups = allGroups;
	
	for [{_i = 1}, {_i <= count _allgroups},{_i = _i + 1}] do
	{
		if (count units (_allgroups select _i) == 0) then 
		{
			deleteGroup (_allgroups select _i);
		};
	};
};

// ********************************************************
//
//						V E H I C L E S
//
// ********************************************************

// CREATE STATIC VEHICLE
//
//	[side , create pos. , dir, vehicleClass,  string, difficulty]
//	veh = ["east",getMarkerPos "test1",50,"","",[0.6,0.25]] call FFS_FNC_crateStaticVeh; 
//	return: OBJECT => created VEHICLE

FFS_FNC_crateStaticVeh = 
{
	private ["_enemySide","_createPos","_vehClass","_argumentSTR","_dir","_AIskill","_AIacc","_crew","_pathFuncVeh","_vehName","_pathFuncUnit","_pathFuncCust","_groupName","_localCountGrp","_rndPos","_rndUnit","_rndUnitInit","_localCountVeh"];
	_enemySide = _this select 0;
	_createPos = _this select 1;
	_dir = _this select 2;
	_vehClass = _this select 3;
	_argumentSTR = _this select 4;
	_AIskill = (_this select 5) select 0;
	_AIacc = (_this select 5) select 1;
	
	_crew = "";
	_rndUnitInit = {};
	_pathFuncVeh = format ["funcs\func_random%1Veh.sqf",_enemySide];
	_pathFuncCust = "";
	_vehName = format ["veh%1_",_enemySide];
	_groupName = format ["grp%1_",_enemySide];   
	_localCountGrp = call compile format ["CountGrp%1",_enemySide];
	call compile format ["%1%2 = createGroup %3; %1%2 allowFleeing 0; _grp = %1%2",_groupName,_localCountGrp,_enemySide];
	call compile format ["CountGrp%1 = CountGrp%1 + 1",_enemySide];	
	_rndPos = _createPos;
	if (_vehClass == "") then {_vehClass = [] call (compile loadFile _pathFuncVeh);};
	_localCountVeh = call compile format ["CountVeh%1",_enemySide];
	call compile format ["%1%2 = ""%3"" createVehicle %4",_vehName,_localCountVeh,_vehClass,_rndPos];
	switch (_argumentSTR) do 
	{
		case "ISIS": {
			_pathFuncCust = format ["funcs\func_random%1UnitCustom.sqf",_enemySide];
			_rndUnitInit = [] call (compile loadFile _pathFuncCust);
			call compile format ["%1%2_flag = ""FlagChecked_F"" createVehicle %3; %1%2_flag setFlagTexture ""pics\ISIS_flag3.jpg""; %1%2_flag attachTo [%1%2, [0.69, -0.04, 0] ];%1%2 addEventHandler [""Killed"", {deleteVehicle %1%2_flag}]",_vehName,_localCountVeh,_rndPos];
		};
		default {
		};
	};
	call compile format ["CountVeh%1 = CountVeh%1 + 1",_enemySide];
	call compile format ["%1%2 lock false; %1%2 setDir %4; _crew = crew%3",_vehName,_localCountVeh,_enemySide,_dir];
	call compile format [" _crew createUnit [ %5, %1%2 , ""this moveindriver %3%4;this setSkill %7;this setskill [""""aimingAccuracy"""",%8];call _rndUnitInit; (group this) setFormDir %9;"", %7 ,""PRIVATE""] ",_groupName,_localCountGrp,_vehName,_localCountVeh,_rndPos,_enemySide,_AIskill,_AIacc,_dir];
	call compile format [" _crew createUnit [ %5, %1%2 , ""this moveingunner %3%4;this setSkill %7;this setskill [""""aimingAccuracy"""",%8];call _rndUnitInit; (group this) setFormDir %9;"", %7 ,""PRIVATE""] ",_groupName,_localCountGrp,_vehName,_localCountVeh,_rndPos,_enemySide,_AIskill,_AIacc,_dir];
	call compile format ["%1%2",_vehName,_localCountVeh]
};

// CREATE VEHICLES TO PATROL AREA (used in tasks!!!)
//
//	[side , number of vehicles , create pos. , target pos. , max distance from target pos. for patrol ,  min distance from target pos. for patrol, difficulty, string argument]
//	["east",1,getMarkerPos "test1",getMarkerPos "test3",20,0,[0.7,0.2],"ISIS"] call FFS_FNC_crateVehsPatrol;
//	return: ARRAY => created VEHICLES

FFS_FNC_crateVehsPatrol = 
{
	private ["_enemySide","_countGroups","_sizeGroup","_createPos","_targetPos","_areaSizeMax","_areaSizeMin","_AIskill","_AIacc","_crew","_pathFuncUnit","_pathFuncCust","_groupName","_localCountGrp","_rndPos","_rndUnit","_rndUnitInit","_argumentSTR","_veh","_flag","_vehArray"];
	_enemySide = _this select 0;
	_countVeh = _this select 1;
	_createPos = _this select 2;
	_targetPos = _this select 3;
	_areaSizeMax = _this select 4;
	_areaSizeMin = _this select 5;
	_AIskill = (_this select 6) select 0;
	_AIacc = (_this select 6) select 1;
	_argumentSTR = _this select 7;
	
	_crew = "";
	_pathFuncVeh = format ["funcs\func_random%1Veh.sqf",_enemySide];
	_pathFuncCust = format ["funcs\func_random%1UnitCustom.sqf",_enemySide];
	_vehName = format ["veh%1_",_enemySide];
	_groupName = format ["grp%1_",_enemySide];
	_vehArray=[];
	
	for [{_m = 1},{_m <= _countVeh},{_m = _m+1}] do 
	{       
		private ["_veh","_flag","_ATgun","_gunVehicle","_grp"];

		_veh = objNull;
		_flag = objNull;
		_ATgun = objNull;
		_gunVehicle = objNull;
		_grp = grpNull;
		_localCountGrp = call compile format ["CountGrp%1",_enemySide];
		call compile format ["%1%2 = createGroup %3; %1%2 allowFleeing 0; _grp = %1%2; ",_groupName,_localCountGrp,_enemySide];
		call compile format ["CountGrp%1 = CountGrp%1 + 1",_enemySide];	
		_rndPos = [ _createPos , _areaSizeMax , 0 ] call (compile preprocessFile "funcs\func_randomPos.sqf");
		_rndVehicle = [] call (compile loadFile _pathFuncVeh );
		_localCountVeh = call compile format ["CountVeh%1",_enemySide];
		
		switch (_argumentSTR) do 
		{
			case "ISIS": {
				call compile format ["%1%2 = _rndVehicle createVehicle _rndPos; _veh=%1%2; _gunVehicle=%1%2",_vehName,_localCountVeh,_rndVehicle,_rndPos];
				//_flag = "FlagChecked_F" createVehicle _rndPos; _flag setFlagTexture "pics\ISIS_flag3.jpg"; _flag attachTo [_veh, [0.69, -0.04, 0] ]; %1%2 addEventHandler [""Hit"", { [%1%2,%1%2_flag] execVM ""scripts\EH_flagDelete.sqf"" };];
				//_veh addEventHandler ["Hit", {hint format ["Vehicle: %1\nDamage: %2 \nFlag: %3",_this select 0, getDammage (_this select 0),_flag];if (getDammage (_this select 0) > 0.8 ) then {deleteVehicle _flag;};}];
				call compile format ["%1%2_flag = ""FlagChecked_F"" createVehicle %3; %1%2_flag setFlagTexture ""pics\ISIS_flag3.jpg"";%1%2_flag attachTo [%1%2, [0.69, -0.04, 0] ];%1%2 addEventHandler [""Killed"", {deleteVehicle %1%2_flag}]",_vehName,_localCountVeh,_rndPos];
			};
			case "ISIS_AT": {
				_rndVehicle = "B_G_Offroad_01_F";
				call compile format ["%1%2 = _rndVehicle createVehicle _rndPos; _veh=%1%2",_vehName,_localCountVeh,_rndVehicle,_rndPos];
				call compile format ["%1%2_flag = ""FlagChecked_F"" createVehicle %3; %1%2_flag setFlagTexture ""pics\ISIS_flag3.jpg"";%1%2_flag attachTo [%1%2, [0.69, -0.04, 0.55] ];%1%2 addEventHandler [""Killed"", {deleteVehicle %1%2_flag}]",_vehName,_localCountVeh,_rndPos];
				_pallet = "Land_Pallet_F" createVehicle _rndPos; _pallet setDir 90; _pallet attachTo [_veh, [0, -1.6, -0.475] ];
				_veh addEventHandler ["Killed", {deleteVehicle _flag}];	
				_ATgun = "O_static_AT_F" createVehicle _rndPos; _ATgun attachTo [_veh, [0, -2, 0.6] ];
				_gunVehicle	= _ATgun;	
			};
			default {
				call compile format ["%1%2 = _rndVehicle createVehicle _rndPos; _veh=%1%2; _gunVehicle=%1%2",_vehName,_localCountVeh,_rndVehicle,_rndPos];
			};
		};
		call compile format ["CountVeh%1 = CountVeh%1 + 1",_enemySide];
		call compile format ["%1%2 lock false; _crew = crew%3",_vehName,_localCountVeh,_enemySide];
		_rndUnitInit = [] call (compile loadFile _pathFuncCust);
		call compile format [" _crew createUnit [ %5, %1%2 , ""this setSkill %7;this setskill [""""aimingAccuracy"""",%8];call _rndUnitInit"", %7 ,""PRIVATE""] ",_groupName,_localCountGrp,_vehName,_localCountVeh,_rndPos,_enemySide,_AIskill,_AIacc];
		(units _grp select 0) moveindriver _veh;
		_rndUnitInit = [] call (compile loadFile _pathFuncCust);
		call compile format [" _crew createUnit [ %5, %1%2 , ""this setSkill %7;this setskill [""""aimingAccuracy"""",%8];call _rndUnitInit"", %7 ,""PRIVATE""] ",_groupName,_localCountGrp,_vehName,_localCountVeh,_rndPos,_enemySide,_AIskill,_AIacc];
		(units _grp select 1) moveingunner _gunVehicle;
		call compile format [" [ leader %1%2 , %3 , %4 , %5 ] execVM ""scripts\ArmourGuard.sqf"" ",_groupName,_localCountGrp,_areaSizeMax,_areaSizeMin,_targetPos];          // MAX | MIN | CENTER
		_vehArray = _vehArray + [_veh];
	};
	_vehArray
};

// CREATE PATROL SQUAD WHIT TRANSPORT TRUCK
//
//	[enemy side, num.soldiers , create pos. , unload pos. , target pos. , patrol area , difficulty, type unit]  call FFS_FNC_crateUnitWithTrans;
//	["east",7,getMarkerPos "test1",getMarkerPos "test2",getMarkerPos "test3",400,[0.7,0.2],"ISIS"] call FFS_FNC_crateUnitWithTrans;
//	return: ARRAY => created UNITS

FFS_FNC_crateUnitWithTrans = 
{	
	private ["_enemySide","_truck","_pathFuncUnit","_localCountGrp","_localCountVeh","_sizeGroup","_unloadPos","_targetPos","_sizeArea","_AIskill","_AIacc","_typofUnit","_pathFuncCust","_grpCurrent","_vehCurrent","_rndPos","_rndUnit","_vehName","_groupName","_rndUnitInit"];
	
	_enemySide = _this select 0;
	_sizeGroup = _this select 1;
	createPosFNC = _this select 2;
	_unloadPos = _this select 3;
    _targetPos = _this select 4;
    _sizeArea = _this select 5;
	_AIskill = (_this select 6) select 0;
	_AIacc = (_this select 6) select 1;
	_typofUnit = _this select 7; 
	_grpCurrent = grpNull;
	_vehCurrent = objNull;
	_vehName = format ["veh%1_",_enemySide];
	_groupName = format ["grp%1_",_enemySide];
	_rndUnitInit={};
	_rndUnit=objNull;
	
	_pathFuncUnit = format ["funcs\func_random%1Unit.sqf",_enemySide];
	_localCountGrp = call compile format ["CountGrp%1",_enemySide];
	call compile format ["CountGrp%1 = CountGrp%1 + 1",_enemySide];	
	_localCountVeh = call compile format ["CountVeh%1",_enemySide];
	call compile format ["CountVeh%1 = CountVeh%1 + 1",_enemySide];
	
	switch (_enemySide) do 
	{
		case "east": {_truck = "O_Truck_02_transport_F";};
		case "west": {_truck = "B_Truck_01_transport_F";};
		default {_truck = "O_Truck_02_transport_F";};
	};
	
	_rndPos = [ ( createPosFNC ) , 40 , 0 ] call (compile preprocessFile "funcs\func_randomPos.sqf");
	call compile format ["%1%2 = createGroup %3; %1%2 allowFleeing 0; _grpCurrent=%1%2; %5%2=_truck createVehicle _rndPos;_vehCurrent=%5%2;",_groupName,_localCountGrp,_enemySide,_localCountVeh,_vehName];
	_rndPos = [ ( createPosFNC ) , 40 , 0 ] call (compile preprocessFile "funcs\func_randomPos.sqf");
	for [{_n = 0},{_n <= _sizeGroup},{_n = _n+1}] do {
		if (_typofUnit == "ISIS") then 
		{
			_rndUnit = "O_Soldier_F";
			_pathFuncCust = format ["funcs\func_random%1UnitCustom.sqf",_enemySide];
			_rndUnitInit = [] call (compile loadFile _pathFuncCust);				
		} else {
			_rndUnit = [] call (compile loadFile _pathFuncUnit ); 
		};
		call compile format [" ""%2"" createUnit [ %3 , %4%1 , ""this setSkill %5;this setskill [""""aimingAccuracy"""",%6];call _rndUnitInit"" , %5 ,""PRIVATE""] ",_localCountGrp,_rndUnit,_rndPos,_groupName,_AIskill,_AIacc];
	};
	leader _grpCurrent moveInDriver _vehCurrent; {_x moveInCargo _vehCurrent} forEach units _grpCurrent;
	_unloadPosFNRndm = [ ( _unloadPos ) , 100 , 0 ] call (compile preprocessFile "funcs\func_randomPos.sqf");	
	_grpCurrent addWaypoint [_unloadPosFNRndm,0]; 
	[_grpCurrent, 1] setWaypointStatements ["true","[group this,vehicle this,createPosFNC] call subFNC_transState"];
	[ leader _grpCurrent , _sizeArea , _sizeArea/4 , _targetPos ] execVM "scripts\Soldierwalkguard.sqf";	// MAX | MIN | CENTER
	(units _grpCurrent)
};

subFNC_transState = 
{	
	private ["_grpCurrent","_vehCurrent","_createPos"];
	_grpCurrent = _this select 0;
	_vehCurrent = _this select 1;
	_createPos = _this select 2;
	
	[driver _vehCurrent] join grpNull; 
	{unassignVehicle _x} forEach units _grpCurrent;
	(units _grpCurrent) allowGetIn false;
	(group driver _vehCurrent) addWaypoint [_createPos,0];
	[group driver _vehCurrent, 1] setWaypointStatements ["true", "_tmpGrp=group this; _tmpVeh=vehicle this;{deleteVehicle _x} foreach crew _tmpVeh; deleteVehicle _tmpVeh; deleteGroup _tmpGrp;"];
};

// ********************************************************
//
//						H E L I C O P T E R S
//
// ********************************************************

// Pick up for unit afterwards all untis and groups are deleted (used in tasks!!!)
//
//	[ create heli position, extraction point , unit for extraction ]
//	[getMarkerPos "test2",getMarkerPos "test3",q1] spawn FFS_FNC_pickupRemove;
//	return - nothing

FFS_FNC_pickupRemove =
{ 
	_heliCreatePosFN = _this select 0;
	_extrPointFN = _this select 1;
	_unitFN = _this select 2;
	
	_unloadPosFN = _heliCreatePosFN;
	_groupHeliFN = createGroup west;
	_groupUnitFN = group _unitFN;
	_heliTypeFN = "B_Heli_Light_01_F";
	_pilotTypeFN = "B_Helipilot_F";

	_heliPadFN = "Land_HelipadEmpty_F" createVehicle _extrPointFN;	//Land_HelipadSquare_F,Land_HelipadEmpty_F
	_heliFN = _heliTypeFN createVehicle _heliCreatePosFN; 
	heliPickupFN = _heliFN;
	_heliFN lock true;
	_pilotTypeFN createUnit [_heliCreatePosFN,_groupHeliFN,"",1,"CAPTAIN"];
	_pilotFN = leader _groupHeliFN;
	_pilotFN assignAsDriver _heliFN;
	_pilotFN moveInDriver _heliFN;
	_groupHeliFN addWaypoint [_extrPointFN,0];
	[_groupHeliFN, 1] setWaypointBehaviour "CARELESS";
	[_groupHeliFN, 1] setWaypointType "MOVE";

	waitUntil {getpos _heliFN distance _extrPointFN < 220 };

	_unitFN assignAsCargo _heliFN;
	[_unitFN] orderGetIn true;
	[_unitFN] join (_pilotFN);
	_groupHeliFN selectLeader _pilotFN;
	_groupHeliFN addWaypoint [_extrPointFN,0];
	[_groupHeliFN, 2] setWaypointType "LOAD";
	_groupHeliFN addWaypoint [_unloadPosFN,0];
	[_groupHeliFN, 3] setWaypointType "MOVE";

	waitUntil {getpos _heliFN distance _unloadPosFN < 1000 };

	{deleteVehicle _x} forEach [_heliPadFN,_unitFN,_pilotFN,_heliFN];
	{deleteGroup _x} forEach [_groupHeliFN,_groupUnitFN];
};

//  CREATE HELI AND MOVE TO POSITION
//
//	[ create heli position, extraction point ]
//	[getMarkerPos "test2",getMarkerPos "test3"] spawn FFS_FNC_createMoveHeli;
//	return - HELI

FFS_FNC_pickup =
{ 
	_heliCreatePosFN = _this select 0;
	_extrPointFN = _this select 1;
	
	_unloadPosFN = [0,0,0];
	_groupHeliFN = createGroup west;
	_heliTypeFN = "B_Heli_Transport_01_camo_F";
	_pilotTypeFN = "B_Helipilot_F";

	_heliPadFN = "Land_HelipadEmpty_F" createVehicle _extrPointFN;	//Land_HelipadSquare_F,Land_HelipadEmpty_F
	_heliFN = _heliTypeFN createVehicle _heliCreatePosFN; 
	_heliFN lock false;
	_pilotTypeFN createUnit [_heliCreatePosFN,_groupHeliFN];
	_pilotFN = leader _groupHeliFN;
	_pilotFN assignAsDriver _heliFN;
	_pilotFN moveInDriver _heliFN;
	_groupHeliFN addWaypoint [_extrPointFN,0];
	[_groupHeliFN, 1] setWaypointType "MOVE";

	waitUntil {getpos _heliFN distance _extrPointFN < 220 };

	_groupHeliFN addWaypoint [_extrPointFN,0];
	[_groupHeliFN, 2] setWaypointType "LOAD";
};


// ********************************************************
//
//						S T A T I C   W E A P O N S
//
// ********************************************************

// CREATE STATIC WEAPON
//
//	[side , create pos. ASL , dir , type <class or "">, AI difficulty]
//	gun = ["east",getMarkerPos "test1",50,"",[0.6,0.25]] call FFS_FNC_crateStaticGun; 
//	return: ARRAY => created STATIC WEAPON

FFS_FNC_crateStaticGun = 
{
	private ["_enemySide","_createPos","_typofUnit","_dir","_AIskill","_AIacc","_vehName","_pathFuncCust","_groupName","_localCountGrp","_rndPos","_rndUnit","_rndUnitInit","_localCountVeh","_pathFuncUnit"];
	_enemySide = _this select 0;
	_createPos = _this select 1;
	_dir = _this select 2;
	_typofUnit = _this select 3;
	_AIskill = (_this select 4) select 0;
	_AIacc = (_this select 4) select 1;
	
	_vehName = format ["veh%1_",_enemySide];
	_groupName = format ["grp%1_",_enemySide];   
	_localCountGrp = call compile format ["CountGrp%1",_enemySide];
	call compile format ["%1%2 = createGroup %3; %1%2 allowFleeing 0; _grp = %1%2;",_groupName,_localCountGrp,_enemySide];
	call compile format ["CountGrp%1 = CountGrp%1 + 1",_enemySide];	
	_rndPos = _createPos;
	_rndUnitInit={};
	_rndUnit=objNull;
	_vehClass="O_HMG_01_high_F";
	
	if (_typofUnit == "") then 
	{
		_pathFuncUnit = format ["funcs\func_random%1Unit.sqf",_enemySide];
		_rndUnit = [] call (compile loadFile _pathFuncUnit );
	} else {
		if (_typofUnit == "ISIS") then
		{
			_rndUnit = "O_Soldier_F";
			_pathFuncCust = format ["funcs\func_random%1UnitCustom.sqf",_enemySide];
			_rndUnitInit = [] call (compile loadFile _pathFuncCust);
		}else{
			_rndUnit = _typofUnit;
		};
	};			
			
	_localCountVeh = call compile format ["CountVeh%1",_enemySide];
	call compile format ["%1%2 = ""%3"" createVehicle %4",_vehName,_localCountVeh,_vehClass,_rndPos];
	call compile format ["CountVeh%1 = CountVeh%1 + 1",_enemySide];
	call compile format ["%1%2 setPosASL _rndPos; %1%2 lock false; %1%2 setDir %4;",_vehName,_localCountVeh,_enemySide,_dir];
	call compile format [" _rndUnit createUnit [ %5, %1%2 , ""this moveingunner %3%4;this setSkill %7;this setskill [""""aimingAccuracy"""",%8];call _rndUnitInit; (group this) setFormDir %9;"", %7 ,""PRIVATE""] ",_groupName,_localCountGrp,_vehName,_localCountVeh,_rndPos,_enemySide,_AIskill,_AIacc,_dir];
	call compile format ["[%1%2]",_vehName,_localCountVeh]
};

// ********************************************************
//
//						M I S C E L L A N E O U S
//
// ********************************************************

// MAKE A REST OF UNITS SURRENDED AND REMOVE THEM AFTER WHILE (used in tasks!!!)_trg,_missionUnits
//
//	[trigger , array of units, delay]
//	[trg1,[a1,a2],1] spawn FFS_FNC_surrendAndRemove;
//	return: nothing

FFS_FNC_surrendAndRemove = 
{ 
	_trg = _this select 0;
	_missionUnits = _this select 1;
	_delay = _this select 2;
	
	sleep _delay;
	_missionUnits = _missionUnits + (list _trg);
	sleep 0.1;
	_missionSurUnits = +(list _trg);
	{_x playMove "AmovPercMstpSsurWnonDnon"} foreach _missionSurUnits; 
	{_x disableAI "ANIM"} foreach _missionSurUnits; 
	{removeallweapons _x}foreach _missionSurUnits;
	{_x setCaptive true} foreach _missionSurUnits;
	
	deleteVehicle _trg;
	sleep 360;	
	{_x setdammage 1}forEach _missionUnits;
	sleep 30; 
	{deleteVehicle _x} foreach _missionUnits;
	sleep 1;
	[] call FFS_FNC_deleteGroup;
};

// Wait until area is cleard and update status (used in tasks!!!)
//
//	[trigger , array of units, min.number foe surrend, task number, type of task("P","S") ]
//	[_trg,_missionUnits,_minSurUnits,_taskNumber,_taskType] spawn FFS_FNC_clearAreaTask;
//	return: nothing

FFS_FNC_clearAreaTask =
{ 
	_trg = _this select 0;
	_missionUnits = _this select 1;
	_minSurUnits =  _this select 2;
	_taskNumber = _this select 3;
	_taskType = _this select 4;
	_subtaskResult = "";
	_surUnit = "";
	
	//waituntil {((("LandVehicle" countType list _trg) == 0))};
	waituntil {{gunner _x != objNull && alive gunner _x && _x isKindOf "LandVehicle"} count (list _trg) < 2};
	sleep 4;
	waituntil {((count list _trg) <= _minSurUnits)}; 
	_listSurUnits = list _trg;
	for [{_n = 0},{_n < count _listSurUnits},{_n = _n+1}] do {	
		_surUnit = _listSurUnits select _n;
		if (!isNil "_surUnit") then
		{
			if (_surUnit isKindOf "LandVehicle") then
			{
				{_x leaveVehicle vehicle _x} forEach crew _surUnit;
			};
		};
		sleep 0.1;
	};
	sleep 4;
	// CONDITION FOR RESULT! "DONE" or "FAILED"
	call compile format ["subtask%1%2_1=""DONE""",_taskNumber,_taskType];
};

if (true) exitWith {};


