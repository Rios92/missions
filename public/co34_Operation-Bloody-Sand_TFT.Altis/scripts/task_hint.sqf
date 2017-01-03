// [] execVM "scripts\task_hint.sqf";
_taskTitle = _this select 0;
_taskText = _this select 1;
sleep 5;
private ["_pilot1", "_pilot2", "_pilot3", "_commander", "_commanderName", "_pilots", "_pilotName1", "_pilotName2", "_pilotName3"];

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
		_commanderName=format ["dead",_commander];
	};
	
} else {
	_commander = "";
	_commanderName= "<br/>   -";
};

// Check for current task
_text="<t align='center' size='1'><t color='#80BF40'>*****************************<br/><t size='1.9' >TASK INFO</t><br/>*****************************<br/></t>"+
"<t align='left'><br/>"+
format ["<t align='center' size='1.5' color='#4DB0E2'>%1</t><br/><br/>",_taskTitle]+
format ["%1<br/><br/>",_taskText]+
format ["Commander is: <t color='#FFCC33'>%1</t><br/>",_commanderName]+
format ["Pilots are: <t color='#FFCC33'>%1</t><br/><br/>",_pilots];


hint parseText _text;

if (true) exitWith {};