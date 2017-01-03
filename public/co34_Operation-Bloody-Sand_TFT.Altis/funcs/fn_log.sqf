// ["init.sqf",2,"some log"] spawn FFS_fnc_log;

_file = _this select 0;
_priority = _this select 1;
_logText = _this select 2;
diag_log format ["MP LOG - [%2] %1 <%4> %3 :	%5", missionname, time, _file, _priority, _logText];
