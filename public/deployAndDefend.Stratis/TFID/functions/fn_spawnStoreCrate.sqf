params["_items"];
private ["_boxPos", "_box", "_chute", "_mark"];

_boxPos = objectivePos;
_boxPos set [2, 50];

_box = createVehicle ["B_supplyCrate_F", _boxPos,[], 0, "CAN_COLLIDE"];
_box allowDamage false;

_chute= "B_Parachute_02_F" createVehicle (getPos _box);
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;

{[_x, _box] call TFID_fnc_addItemToCrate;} forEach _items;

_chute setPos (getPos _box);
_box attachTo [_chute, [0,0,0]];

waituntil {(getPos _chute) select 2 < 0.5};
_boxPos = (getPos _box) findEmptyPosition [0, 8, "B_supplyCrate_F"];
detach _box;
_box setPos _boxPos;

if(!isNil "_chute" && {!isNull _chute}) then {
    deleteVehicle _chute;
};

_name = format ["tft_dnd_boxMarker%1", count allMapMarkers];
_mark = createMarker [_name, _boxPos];
_mark setMarkerShape "ICON";
_mark setMarkerType "hd_dot";
_mark setMarkerText "Ammobox";

sleep 180;
deleteVehicle _box;
deleteMarker _mark;
