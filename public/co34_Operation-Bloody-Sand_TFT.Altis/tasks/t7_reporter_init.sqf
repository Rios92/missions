// initialized by BIS_FNC_MP (1)

_unitObj = _this select 0;
reporter = _unitObj;
_unitObj setIdentity "John_Fowler";
t7_rescue = _unitObj addAction ["<t color='#ff1111'>Follow me!</t>","tasks\t7_reporter_action.sqf"];

if (logging_mode) then {["t7_reporter_init.sqf",4,format ["BIS_FNC_MP (1) - Identity and action have been added for reporter (%1) on client",_unitObj]] spawn FFS_FNC_log;};

if (true) exitWith {};


