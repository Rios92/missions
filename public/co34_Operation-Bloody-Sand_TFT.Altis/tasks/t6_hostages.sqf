// initialized by BIS_FNC_MP (1)

_units = _this select 0;

{_x playMove "AmovPercMstpSsurWnonDnon"} foreach _units; 
{_x disableAI "ANIM"} foreach _units; 
{_x setCaptive true} foreach _units;	

if (logging_mode) then {["t6_hostages.sqf",4,format ["BIS_FNC_MP (1) - Update hostages (%1) on clients",_units]] spawn FFS_FNC_log;};

if (true) exitWith {};


