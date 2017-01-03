// SERVER
if(!(isServer))exitwith{};
if (logging_mode) then {["jip.sqf",4,format ["Initializing (ONLY SERVER)... %1 / %2",_this select 0,_this select 1]] spawn FFS_FNC_log;};
sleep 0.5;

publicvariable "status1P"; 
publicvariable "status2P"; 
publicvariable "status3P"; 
publicvariable "status4P"; 
publicvariable "status5P"; 
publicvariable "status6P"; 
publicvariable "status7P"; 
publicvariable "status8P"; 
publicvariable "status9P"; 
publicvariable "TaskArray";

{_x setMarkerPos (getMarkerPos _x)} forEach markers;
{_x setMarkerColor (getMarkerColor _x)} forEach markers;
{_x setMarkerAlpha (markerAlpha _x)} forEach markers;

if (true) exitWith {};