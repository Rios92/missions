// initialized by ACTION

if (isNil "Status7P") then 
{
	["t7_reporter_end.sqf",16,"Status7P is not defined so far - waiting for variable!!!"] spawn FFS_FNC_log;
	waitUntil {!isNil "Status7P"};
	["t7_reporter_end.sqf",4,format ["Status7P is updated (%1) !!!",Status7P]] spawn FFS_FNC_log;
};

if (Status7P == "ACTIVE") then
{
	_reporter = _this select 0;
	_caller = _this select 1;
	_callerName = name (_this select 1);

	//[[[_reporter,_callerName],"tasks\t7_reporter_end.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;
	if (isNil "reporterFound") then 
	{
		serviceNumberServer = [2,player,"reporterFound"]; publicVariableServer "serviceNumberServer";
		hint "Request to server has been send to update missing variable1. Wait a moment please. ";
		["t7_reporter_end.sqf",16,"reporterFound is not defined so far - waiting for variable!!!"] spawn FFS_FNC_log;
		waitUntil {!isNil "reporterFound"};
		["t7_reporter_end.sqf",4,format ["reporterFound is updated (%1) !!!",Status7P]] spawn FFS_FNC_log;
	};
	if (!reporterFound) then
	{
		_caller playMove "AinvPknlMstpSlayWrflDnon_medic";
		[_caller] join grpNull;
		sleep 4;
		reporterFound=true; 
		publicVariable "reporterFound";
		serviceNumber=[2,format ["U.S. reporter has been found by %1. Move to extraction point at %2 and cover him! Over.",_callerName,mapGridPosition getMarkerPos  "t7_extrArea"],_reporter]; publicvariable "serviceNumber";
		serviceNumberServer = [3,""]; publicVariableServer "serviceNumberServer";
		[_reporter] join _caller;
		doStop _reporter;
		//[[[_pilot,_callerName],"tasks\t4_pilot_end.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;
		sleep 5;
		titleText [format ["Hello reporter, we came here to rescue you ass. Follow me!",mapGridPosition getMarkerPos  "t7_extrArea"], "PLAIN"];
		if (logging_mode) then {["t7_reporter_action.sqf",4,format ["Action has been activated by %2 - Reporter has been found",_reporter,_callerName]] spawn FFS_FNC_log;};
	}else{
		if (isNil "reporterInLZ") then 
		{
			serviceNumberServer = [2,player,"reporterInLZ"]; publicVariableServer "serviceNumberServer";
			hint "Request to server has been send to update missing variable1. Wait a moment please. ";
			["t7_reporter_end.sqf",16,"reporterInLZ is not defined so far - waiting for variable!!!"] spawn FFS_FNC_log;
			waitUntil {!isNil "reporterInLZ"};
			["t7_reporter_end.sqf",4,format ["reporterInLZ is updated (%1) !!!",Status7P]] spawn FFS_FNC_log;
		};
	
		if (!reporterInLZ) then
		{
			[_reporter] join _caller;
			_reporter doFollow _caller;
			if (logging_mode) then {["t7_reporter_action.sqf",16,format ["Reporter action has been activated by %2. Reporter is joining to group. / reporterInLZ: %1",reporterInLZ,_callerName]] spawn FFS_FNC_log;};
		} else {
			titleText ["It is over there! I don't need to follow you anymore.", "PLAIN"];
			if (logging_mode) then {["t7_reporter_action.sqf",16,format ["Reporter action has been activated by reporterInLZ is TRUE => removing action is not works / reporterInLZ: %1",reporterInLZ]] spawn FFS_FNC_log;};
		};
	};
	
}else{
	if (logging_mode) then {["t7_reporter_action.sqf",4,format ["Status7P is not ACTIVE / Status4P: %1 !!!",Status4P]] spawn FFS_FNC_log;};
};

if (true) exitWith {};