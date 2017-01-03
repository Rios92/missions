private _spawnPos = [objectivePos, 2500, random 360] call BIS_fnc_relPos;
private _helipad = getPos (selectRandom helipads);
_spawnPos set [2, 150];

private _grp = call tft_dnd_fnc_spawnGroup;
enemiesSpawned pushBack _grp;

private _heli = createVehicle ["O_Heli_Light_02_unarmed_F", _spawnPos, [], 0, "FLY"];
private _pilot = (createGroup east) createUnit ["O_G_Soldier_F", getMarkerPos "ai_spawn", [], 0, "NONE"];
_pilot assignAsDriver _heli;
_pilot moveInDriver _heli;
sleep 1;
_heli flyInHeight 100;

{
    _x assignAsCargo _heli;
    _x moveInCargo _heli;
} forEach units _grp;

sleep 1;
private _wph = (group _pilot) addWaypoint [_helipad, 0];
_wph setWaypointType "TR UNLOAD";
_wph setWaypointSpeed "FULL";
_wph setWaypointCombatMode "RED";
_wph setWaypointBehaviour "COMBAT";
private _wp = (group _pilot) addWaypoint [_spawnPos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "FULL";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "COMBAT";

_wp = _grp addWaypoint [_helipad, 0];
_wp setWaypointType "GETOUT";
_wp setWaypointSpeed "FULL";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "COMBAT";
_wp synchronizeWaypoint [_wph];
_wp = _grp addWaypoint [objectivePos, 20];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "COMBAT";
_wp = _grp addWaypoint [objectivePos, 0];
_wp setWaypointType "SAD";
_wp setWaypointSpeed "FULL";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "COMBAT";

[_heli, _pilot] spawn {
    params ["_heli", "_pilot"];
    waitUntil {(count (crew _heli) == 1) || {!alive _heli}};
    sleep 60;

    deleteVehicle _pilot;
    deleteVehicle _heli;
};
