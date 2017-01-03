//execVM "scripts\mission_hint.sqf";
private ["_pilot1", "_pilot2", "_pilot3", "_commander", "_commanderName", "_pilots", "_pilotName1", "_pilotName2", "_pilotName3", "_playerHint", "_playerType","_caller"];

if (!isNil "_this") then 
{
	_caller = true;
}else{
	_caller = false;
};

if (!_caller) then {sleep 2;};
//waitUntil {format ["%1",currentTask player] != "No task"};
//if (!_caller) then {sleep 10;};

_pilotName1 = "";
_pilotName2 = "";
_pilotName3 = "";
_pilot1STRG="a32";
_pilot2STRG="a33";
_pilot3STRG="a34";
_commanderSTRG="a31";
_pilots = "";

// <NULL-object> 	=> 		Error: No vehicle

// any 				=> 		Error: No unit

// Check for pilots
if (!isNil _pilot1STRG) then 
{
	_pilot1 = call compile format ["%1",_pilot1STRG];
	if (!(format ["%1",name _pilot1] == "Error: No unit" or format ["%1",name _pilot1] == "Error: No vehicle")) then
	{
		_pilotName1=name _pilot1;
	} else {
		_pilotName1=format ["-",_pilot1];
	};
} else {
	_pilot1 = "";
};
if (!isNil _pilot2STRG) then 
{
	_pilot2 = call compile format ["%1",_pilot2STRG];
	if (!(format ["%1",name _pilot2] == "Error: No unit" or format ["%1",name _pilot2] == "Error: No vehicle")) then 
	{
		_pilotName2=name _pilot2;
	} else {
		_pilotName2=format ["-",_pilot2];
	};
} else {
	_pilot2 = "";
};
if (!isNil _pilot3STRG) then 
{
	_pilot3 = call compile format ["%1",_pilot3STRG];
	if (!(format ["%1",name _pilot3] == "Error: No unit" or format ["%1",name _pilot3] == "Error: No vehicle")) then
	{
		_pilotName3=name _pilot3;
	} else {
		_pilotName3=format ["-",_pilot3];
	};
} else {
	_pilot3 = "";
};
if (_pilotName1 == "" and _pilotName2 == "" and _pilotName3 == "") then
{
	_pilots = "<br/>   -<br/>   -<br/>   -";
} else {
	_pilotsArray = [_pilotName1,_pilotName2,_pilotName3];
	for [{_i = 0},{_i < count _pilotsArray},{_i = _i+1}] do 
	{       
		if (_pilotsArray select _i != "") then 
		{
			_pilots = _pilots + "<br/>   " +(_pilotsArray select _i);
		};	
	};
};

// Check for commander
if (!isNil _commanderSTRG) then 
{
	_commander = call compile format ["%1",_commanderSTRG];
	if (!(format ["%1",name _commander] == "Error: No unit" or format ["%1",name _commander] == "Error: No vehicle")) then
	{
		_commanderName=format ["<br/>   %1",name _commander];
	} else {
		_commanderName=format ["<br/>   -",_commander];
	};
	
} else {
	_commander = "";
	_commanderName= "<br/>   -";
};

// Check for current task
//_currentTask = [format ["%1",currentTask player],5,7] call FFS_StrLRSub;

_header1="<t align='center' size='1'><t color='#80BF40'>*****************************<br/><t size='1.9' >MISSION INFO</t><br/>*****************************<br/></t>"+
format ["%2 %1<br/>(",name player, rank player];
_header2=")<t align='left'><br/><br/>";

_trans="<t size='1.3' color='#4DB0E2'>TRANSPORT</t><br/>"+
"- use helicopters, cars, MHQ or quads for transportation<br/>"+
"- only pilots can fly<br/>"+
format ["- pilots are: <t color='#FFCC33'>%1</t><br/>",_pilots];

_tasks="<br/>"+
"<t size='1.3' color='#4DB0E2'>TASKS</t><br/>"+
"- tasks will be gradually assigned during a play<br/>"+
//format ["- current task: %1 <br/>",_currentTask]+
format ["- commander is: <t color='#FFCC33'>%1</t><br/>",_commanderName];

_hints="<br/>"+
"<t size='1.3' color='#4DB0E2'>HINTS</t><br/>"+
"- you can revive your teammates<br/>"+
"- you can save/load your weapons and items gear using VAS or Virtual Arsenal at ammo boxes<br/>"+
"- vehicles and helicopters are respawned after damage<br/>";

if (player in [_commander]) then 
{
	_playerType="Commander";
	_playerHint=_header1+_playerType+_header2+_trans+_tasks+_hints+"- you can call artilery support (0-8)";
}else
{
	if (player in [_pilot1,_pilot2]) then
	{
		_playerType="Pilot";
		_playerHint=_header1+_playerType+_header2+_trans+"- you can request respawn of helicopters from HQ (only for pilots) <br/>"+"- turn off engine of helicopter on helipad for rearm and refuel (only for pilots) <br/>"+_tasks+_hints;
	}else{
		_playerType="Soldier";
		_playerHint=_header1+_playerType+_header2+_trans+_tasks+_hints;
	};
};
hint parseText _playerHint;

if (true) exitWith {};
