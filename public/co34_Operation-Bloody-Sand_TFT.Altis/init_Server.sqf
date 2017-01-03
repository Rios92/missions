Status1P = "NONE";
Status2P = "NONE";
Status3P = "NONE";
Status4P = "NONE";
Status5P = "NONE";
Status6P = "NONE";
Status7P = "NONE";
Status8P = "NONE";
Status9P = "NONE";

execVM "scripts\Markers.sqf";
execVM "funcs\FNC_server.sqf";	
execVM "scripts\inetdServer.sqf";
["area1","area2",6] execVM "scripts\randomPatrol.sqf";
[] execVM "scripts\randomEnemyAttack.sqf";
onPlayerConnected "[_id, _name] execVM ""scripts\jip.sqf""";

{_x setMarkerAlpha 0} foreach markers;
1 setWindDir 180;

waitUntil {!isNil "FFS_hours"};

/*
if (!debug_mode) then 
{
	deleteVehicle trg1;	
};
*/

if ((FFS_mobile_resp select 0) == 0) then 
{
	deleteVehicle MHQ;	
};

setDate [2030, 7, 6, FFS_hours, 0];

if (logging_mode) then {["init_Server.sqf",2,format ["Date: %1",date]] spawn FFS_FNC_log;};

if (true) exitWith {};
