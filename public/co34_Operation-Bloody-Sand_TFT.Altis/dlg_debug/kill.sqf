_side = _this select 0;		// "EAST", "WEST", "GUER", "CIV", "LOGIC", "ANY"

_size = [configfile >> "CfgWorlds" >> worldname >> "mapSize"] call bis_fnc_returnConfigEntry;
_pos = [_size/2,_size/2];

// CREATE TRIGGER    
_trg=createTrigger["EmptyDetector",_pos];                
_trg setTriggerArea [_size/2,_size/2, 0, true ];                
_trg setTriggerActivation[ _side,"PRESENT",false];                  
_trg setTriggerStatements ["this", "", ""];

sleep 1;
hint format ["Debug console:\n\nKILL %1 \n\nMap: %2\nSize: %3\nTrg pos: %4\n\n %5 units detected!",_side,worldname,_size,_pos, count list _trg];
{_x setdamage 1} foreach list _trg;	
deleteVehicle _trg;

if (true) exitWith {};