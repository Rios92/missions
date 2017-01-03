// ----------------------------------------------------------------------------------
// 								NOTES
// ----------------------------------------------------------------------------------
/*

*************************************************************************
				M I S S I O N   A D J U S T M E N T 
*************************************************************************

========================
========= TODO =========
========================

MP TEST

*/

// ----------------------------------------------------------------------------------
// 								SHARED VARIABLES
// ----------------------------------------------------------------------------------
player_INIT = false;
player_JIP = false;
_mission="";
client="";
_server="";
serviceNumber = [0,""];
serviceNumberServer = [0,""];
//serviceNumberTest = [0,""];
markers = ["Poliakko","Alikampos","Lakka","Rodopoli","Charkia","Dorida","Pyrgos","Chalkeia","t7_extrArea","storage_area","t8_ammo_area","t9_base","t9_AAF_base","t7_area1","leaderHouse","area1","area2"];
vehOnMap=[["p1","Tango 1"],["h1","Razor 1"],["h2","Razor 2"],["h3","Razor 3"],["h4","Razor 4"],["repairTruck1","Repair Truck #1"],["repairTruck2","Repair Truck #2"],["ammoTruck2","Ammo Truck #2"],["fuelTruck2","Fuel Truck #2"]];
noDriverName=["mhq"];	// marker.sqf will not display driver name of vehicle on the map

// ----------------------------------------------------------------------------------
// 								CHECK GAME ENVIRONMENT 
// ----------------------------------------------------------------------------------
if (isNull player) then {
	player_JIP = true;
	client="JIP";	
} else { 
	player_INIT = true;
	client="INIT";
};

if (isServer) then {
	if (isDedicated) then {
		_server="DEDICATED";
		client="NO";
		execVM "init_Server.sqf";
	}else{
		_server="HOST";
		execVM "init_Server.sqf";
		execVM "init_client.sqf";
	};
}else{
	_server="NO";
	execVM "init_client.sqf";
};

// ----------------------------------------------------------------------------------
// 								PARAMETERS
// ----------------------------------------------------------------------------------

if (isMultiplayer) then {
	_mission="MP";
	
	// --------- GAME DIFFICULTY --------------
	switch (paramsArray select 0) do 
	{
		case 0: {game_difficulty = [0,0]};	// DEBUG
		case 1: {game_difficulty = [0.50,0.1]};
		case 2: {game_difficulty = [0.70,0.2]};	// DEFAULT
		case 3: {game_difficulty = [0.80,0.5]};
		case 4: {game_difficulty = [0.90,0.7]};
		default {game_difficulty = [0.70,0.2]};
	};
	
	// --------- VAS --------------
	switch (paramsArray select 1) do 
	{
		case 0: {FFS_ammobox_sys = "Standard";};
		case 1: {FFS_ammobox_sys = "VAS";};
		case 2: {FFS_ammobox_sys = "Characters";};
		default {FFS_ammobox_sys = "VAS";};
	};
	
	// --------- TIME --------------
	FFS_hours = paramsArray select 2;
	
	// --------- REVIVE --------------
	if (paramsArray select 3 == 1) then 
	{
		FFS_revive = true;
	}else{
		FFS_revive = false;
	};	
	
	// --------- REVIVE - WHO CAN REVIVE --------------
	if (paramsArray select 4 == 1) then 
	{
		FFS_who_can_revive = ["B_medic_F"];
	}else{
		FFS_who_can_revive = ["Man"];
	};
	
	// --------- REVIVE - LIVES --------------
	switch (paramsArray select 5) do 
	{
		case 0: {FFS_active_lifes = 0;FFS_lifes = 10;};
		case 1: {FFS_active_lifes = 1;FFS_lifes = 1;};
		case 2: {FFS_active_lifes = 1;FFS_lifes = 3;};
		case 3: {FFS_active_lifes = 1;FFS_lifes = 5;};
		case 4: {FFS_active_lifes = 1;FFS_lifes = 10;};
		case 5: {FFS_active_lifes = 1;FFS_lifes = 15;};
		default {FFS_active_lifes = 0;FFS_lifes = 10;};
	};
	
	// --------- REVIVE - RESPAWN TIME --------------
	switch (paramsArray select 6) do 
	{
		case 0: {FFS_respawn_time = 1;};
		case 1: {FFS_respawn_time = 5;};
		case 2: {FFS_respawn_time = 15;};
		case 3: {FFS_respawn_time = 30;};
		case 4: {FFS_respawn_time = 60;};
		case 5: {FFS_respawn_time = 120;};
		default {FFS_respawn_time = 5;};
	};
	
	// --------- REVIVE - MOBILE RESPAWN --------------
	if (paramsArray select 7 == 1) then 
	{
		FFS_mobile_resp = [1,[MHQ],[altisMap]];
	}else{
		FFS_mobile_resp = [0,[],[]];
	};
	
	// --------- NUMBERS OF TASKS --------------
	numTasks = paramsArray select 8;
	
	// --------- DEBUG MODE --------------
	if (paramsArray select 9 == 2) then 
	{
		debug_mode = true;
		logging_mode = true;
	}else
	{
		if (paramsArray select 9 == 1) then
		{
			debug_mode = false;
			logging_mode = true;
		}else{
			debug_mode = false;
			logging_mode = false;
		};
	};
	
	// --------- REVIVE --------------
	if (paramsArray select 10 == 1) then 
	{
		playIntroISIS = true;
	}else{
		playIntroISIS = false;
	};
	
}else{
	_mission="SP";
	debug_mode = false;
	logging_mode = true;
	game_difficulty = [0.7,0.2];
	FFS_ammobox_sys = "VAS";	// "Standard","VAS","Characters"
	FFS_hours = 7;
	FFS_active_lifes = 0;
	FFS_lifes = 10;
	FFS_who_can_revive = ["Man"];
	FFS_respawn_time = 5;
	FFS_revive = true;
	FFS_mobile_resp = [1,[MHQ],[altisMap]];
	numTasks = 6;
	playIntroISIS = false;
};

["init.sqf",2,format ["MISSION MODE: %1 | CLIENT: %2 | SERVER: %3 | DEBUG MODE: %4 | LOGGING MODE: %5 | DATE: %6",_mission, client, _server, debug_mode,logging_mode,date]] spawn FFS_FNC_log;


// ----------------------------------------------------------------------------------
// 								SHARED SCRIPTS
// ----------------------------------------------------------------------------------

if (FFS_revive) then 														// Revive script
{
	call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf";
};
nul=[] execVM "funcs\KRON_Strings.sqf"; 									// String library
execVM "tasks\taskManager.sqf";												// Task Manager
_igiload = execVM "IgiLoad\IgiLoadInit.sqf"; 								// IgiLoad script - logistical support
_nil = [] execVM "scripts\group_manager.sqf";								// Group management
[] execVM "scripts\zlt_fieldrepair.sqf";				

if (true) exitWith {};