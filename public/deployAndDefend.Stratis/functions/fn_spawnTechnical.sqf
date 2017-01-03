private _spawnPos = getMarkerPos selectRandom aiSpawns;
private _isWater = surfaceIsWater _spawnPos;

private _dropPos = if(_isWater) then { getMarkerPos format["%1_dz", objective] } else { [objectivePos, 25, random 360] call BIS_fnc_relPos; };
private _vehType = if(_isWater) then { "O_Boat_Armed_01_hmg_F" } else { "O_G_Offroad_01_armed_F" };

private _vehicle = createVehicle [_vehType, _spawnPos, [], 0, "NONE"];
createVehicleCrew _vehicle;
sleep 1;

if(_isWater) then { _vehicle removeMagazinesTurret ["200Rnd_40mm_G_belt", [0]] };

private _wp = (group driver _vehicle) addWaypoint [_dropPos, 0];
_wp setWaypointType "SAD";
_wp setWaypointSpeed "FULL";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "AWARE";
