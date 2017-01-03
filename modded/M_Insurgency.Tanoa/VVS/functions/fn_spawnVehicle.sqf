/*
	File: fn_spawnVehicle.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Spawns the selected vehicle, if a vehicle is already on the spawn point
	then it deletes the vehicle from the spawn point.
*/
disableSerialization;
private["_position","_direction","_className","_displayName","_spCheck","_cfgInfo"];
if(lnbCurSelRow 38101 == -1) exitWith {hint "You did not select a vehicle to spawn!"};

_className = lnbData[38101,[(lnbCurSelRow 38101),0]];
_displayName = lnbData[38101,[(lnbCurSelRow 38101),1]];
_position = getMarkerPos VVS_SP;
_direction = markerDir VVS_SP;

//Make sure the marker exists in a way.
if(isNil "_position") exitWith {hint "The spawn point marker doesn't exist?";};

_cfgInfo = [_className] call VVS_fnc_cfgInfo;

_spawnPos = [];
_it = 0;
while {(_it < 50) && {count _spawnPos == 0}} do {
    _spawnPos = _position findEmptyPosition [0,10,_className];
    _it = _it + 1;
    sleep 0.1;
};
if(_it >= 50) exitWith { hint "There is no space to spawn a vehicle."; };

_vehicle = _className createVehicle _spawnPos;
_vehicle allowDamage false;
_vehicle setPos _spawnPos; //Make sure it gets set onto the position.
_vehicle setDir _direction; //Set the vehicles direction the same as the marker.

[[_vehicle], { { _x addCuratorEditableObjects [_this, false]; } forEach allCurators; }] remoteExec ["bis_fnc_call", 2];

if((_cfgInfo select 4) == "Autonomous") then
{
	createVehicleCrew _vehicle;
};

if(VVS_Checkbox) then
{
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
};

_vehicle allowDamage true;
hint format["You have spawned a %1",_displayName];
closeDialog 0;

if((!isNull _vehicle) && {alive _vehicle}) then {
    VVS_classname = _className;
    _oldVeh = VVS_unit getVariable ["tft_ins_vvs_veh", objNull];
    if(!isNull _oldVeh) then { deleteVehicle _oldVeh; };
    VVS_unit setVariable ["tft_ins_vvs_lock", time + ((VVS_Cost select {(_x select 0) == VVS_classname}) select 0 select 1)];
    VVS_unit setVariable ["tft_ins_vvs_veh", _vehicle];
};
