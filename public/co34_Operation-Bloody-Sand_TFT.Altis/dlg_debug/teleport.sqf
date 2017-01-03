TelePos = nil;
//player sidechat "teleport.sqf --- START";

hint "Debug console:\n\nClick on map to set coordinates for teleport";
openMap [true, false]; 
onMapSingleClick "TelePos = _pos;";
      
waituntil {!(isNil "TelePos")};
onMapSingleClick "";

player setpos TelePos;
hint format ["Debug console:\n\n%1",TelePos];
TelePos = nil;
openMap [false, false];

if (true) exitWith {};