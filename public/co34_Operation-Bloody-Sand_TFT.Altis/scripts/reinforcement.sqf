// reinforcement
// [west,25,35,"STATUS1P","ACTIVE","DONE",240,trg_1,[2180.95,5747.72,0.00143862],[2695.62,5804.53,0.00143051],getMarkerPos "Agia_Marina",60,15] execVM "scripts\test.sqf";
// [f side,min units,max units,condition1,conditionOK,conditionEND,sleep,trigger,create pos,unload pos,target pos,patrol diameter, min. units in area] execVM "scripts\test.sqf";

_sleepRandom = 10;

_side = _this select 0;
_minRnfUnits = _this select 1;
_maxRnfUnits = _this select 2;
_condition1 = _this select 3;
_condition2 = _this select 4;
_condition3 = _this select 5;
_sleep = _this select 6;
_trigger = _this select 7;
_createPos = _this select 8;
_unloadPos = _this select 9;
_patrolPos = _this select 10;
_patrolDiameter = _this select 11;
_minUnitsArea = _this select 12;

_enemySide="east";
_typeofUnit="ISIS";
_rnfUnitsCreated = 0; 
_unitInArea = 0;
_rnfUnits = _maxRnfUnits;

// ***************************************** SCRIPT *****************************************************

//player sideChat "START";
if (logging_mode) then {["reinforcement.sqf",2,format ["Reinforcment initialized (%1)",_this]] spawn FFS_FNC_log;};
sleep 0.1;

while {_rnfUnitsCreated < _rnfUnits and ((call compile format ["%1",_condition1]) == _condition2)} do 
{
	waitUntil {("man" countType list _trigger) < _minUnitsArea or ((call compile format ["%1",_condition1]) == _condition3)};
	_countUnits = 5 + (floor random (3));
	_unitInArea = ("man" countType list _trigger);
	_sleepCreate = 60 + random _sleepRandom;
		
	//player sideChat format ["Calling reinforcement.... added delay (%1) - units are less then %4 (%2 - %3)",_sleepCreate,_unitInArea,_sleepCreate+time,_minUnitsArea];
	if (logging_mode) then {["reinforcement.sqf",4,format ["Calling reinforcement.... added delay (%1) - units are less then %4 (%2 units in area / %3 time)",_sleepCreate,_unitInArea,_sleepCreate+time,_minUnitsArea]] spawn FFS_FNC_log;};

	sleep _sleepCreate;
	
	if ((call compile format ["%1",_condition1]) == _condition2) then 
	{
		_unitInArea = ("man" countType list _trigger);
		_rnfUnits = floor (((playersNumber (call compile format ["%1",_side]) / (getNumber (missionconfigfile >> "Header" >> "maxPlayers"))) * (_maxRnfUnits - _minRnfUnits)) + _minRnfUnits);
		[_enemySide,_countUnits,_createPos,_unloadPos,_patrolPos,_patrolDiameter,game_difficulty,_typeofUnit] call FFS_FNC_crateUnitWithTrans;
		_rnfUnitsCreated = _rnfUnitsCreated + _countUnits;
		
		//player sideChat format ["Reinforcment have been created %1/%2 - units: %3",_rnfUnitsCreated,_rnfUnits,_unitInArea];
		if (logging_mode) then {["reinforcement.sqf",4, format ["Reinforcment have been created %1/%2 - units: %3",_rnfUnitsCreated,_rnfUnits,_unitInArea]] spawn FFS_FNC_log;};
	} else {
		//player sideChat format ["Skipping MISION COMPLETE - condition (%3) = %1/%2",(call compile format ["%1",_condition1]),_condition2,((call compile format ["%1",_condition1]) == _condition2)];
		if (logging_mode) then {["reinforcement.sqf",2,format ["Skipping MISION COMPLETE - condition (%3) = %1/%2",(call compile format ["%1",_condition1]),_condition2,((call compile format ["%1",_condition1]) == _condition2)]] spawn FFS_FNC_log;};
	};
	sleep _sleep;
};	
//player sideChat format ["Reinforcment finished - end - %1/%2 (%6) - condition (%5) = %3/%4",_rnfUnitsCreated,_rnfUnits,(call compile format ["%1",_condition1]),_condition2,((call compile format ["%1",_condition1]) == _condition2),_rnfUnitsCreated < _rnfUnits];
if (logging_mode) then {["reinforcement.sqf",4,format ["Reinforcment finished - end - %1/%2 (%6) - condition (%5) = %3/%4",_rnfUnitsCreated,_rnfUnits,(call compile format ["%1",_condition1]),_condition2,((call compile format ["%1",_condition1]) == _condition2),_rnfUnitsCreated < _rnfUnits]] spawn FFS_FNC_log;};
	
if (true) exitWith {};