private _dir = floor random 360;
private _spawnPos = [objectivePos, 2500, _dir] call BIS_fnc_relPos;
private _gotoPos = [objectivePos, 50, _dir+180] call BIS_fnc_relPos;
_spawnPos set [2, 150];
_gotoPos set [2, 150];

private _grp = call tft_dnd_fnc_spawnGroup;
enemiesSpawned pushBack _grp;

private _heli = createVehicle ["O_Heli_Light_02_unarmed_F", _spawnPos, [], 0, "FLY"];
createVehicleCrew _heli;
_heli flyInHeight 150;
sleep 1;

{
    removeBackpackGlobal _x;
    _x addBackpackGlobal "B_Parachute";
} forEach units _grp;

private _wp = (group driver _heli) addWaypoint [_gotoPos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "FULL";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "COMBAT";

[_heli, _dropPos, _grp] spawn {
    params ["_heli", "_dropPos", "_grp"];
    waitUntil {(_heli distance2D objectivePos < 150) || {!alive _heli}};

    if(alive _heli) then {
        {
            _x allowDamage false;
            _pos = getPos _heli;
            _pos set [2, (_pos select 2) - 10];
            _x setPos _pos;
            _x doMove objectivePos;
            _x spawn {
                sleep 2;
                _this allowDamage true;
                waituntil {(getPos _this) select 2 < 1};
                _pos = (getPos _this) findEmptyPosition [0, 15];
                _this setPos _pos;
            };
            sleep 1;
        } forEach units _grp;

        _wp = _grp addWaypoint [objectivePos, 20];
        _wp setWaypointType "MOVE";
        _wp setWaypointSpeed "FULL";
        _wp setWaypointCombatMode "RED";
        _wp setWaypointBehaviour "COMBAT";
        _wp = _grp addWaypoint [objectivePos, 0];
        _wp setWaypointType "SAD";
        _wp setWaypointSpeed "FULL";
        _wp setWaypointCombatMode "RED";
        _wp setWaypointBehaviour "AWARE";
    };

    sleep 60;
    {deleteVehicle _x;} forEach crew _heli;
    deleteVehicle _heli;
};
