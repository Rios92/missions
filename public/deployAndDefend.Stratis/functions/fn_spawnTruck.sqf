private _spawnPos = getMarkerPos selectRandom aiSpawns;
private _isWater = surfaceIsWater _spawnPos;

private _dropPos = if(_isWater) then { getMarkerPos format["%1_dz", objective] } else { objectivePos findEmptyPosition [0, 50 + random 50, "O_G_Van_01_transport_F"]; };
private _vehType = if(_isWater) then { "O_Boat_Transport_01_F" } else { "O_G_Van_01_transport_F" };

private _grp = call tft_dnd_fnc_spawnGroup;
enemiesSpawned pushBack _grp;

private _vehicle = createVehicle [_vehType, _spawnPos, [], 0, "NONE"];
private _driver = (createGroup east) createUnit ["O_G_Soldier_F", getMarkerPos "ai_spawn", [], 0, "NONE"];
_driver assignAsDriver _vehicle;
_driver moveInDriver _vehicle;
sleep 1;

{
    _x assignAsCargo _vehicle;
    _x moveInCargo _vehicle;
} forEach units _grp;
sleep 1;

private _wpv = (group driver _vehicle) addWaypoint [_dropPos, 0];
_wpv setWaypointType "TR UNLOAD";
_wpv setWaypointSpeed "FULL";
_wpv setWaypointCombatMode "RED";
_wpv setWaypointBehaviour "SAFE";

private _wp = _grp addWaypoint [_dropPos, 0];
_wp setWaypointType "GETOUT";
_wp setWaypointSpeed "FULL";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "COMBAT";
_wp synchronizeWaypoint [_wpv];

_wp = _grp addWaypoint [objectivePos, 0];
_wp setWaypointType "SAD";
_wp setWaypointSpeed "FULL";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "AWARE";

[_vehicle, _spawnPos] spawn {
    params ["_vehicle", "_spawnPos"];
    waitUntil {((count crew _vehicle) == 1) || {!alive _vehicle}};

    if(alive _vehicle) then {
        _wp = (group driver _vehicle) addWaypoint [_spawnPos, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointSpeed "FULL";
        _wp setWaypointCombatMode "RED";
        _wp setWaypointBehaviour "COMBAT";
    };

    sleep 180;
    if (alive _vehicle) then {
        deleteVehicle _driver;
        deleteVehicle _vehicle;
    };
};
