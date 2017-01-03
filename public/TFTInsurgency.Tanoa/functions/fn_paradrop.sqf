openMap true;

["tft_ins_paradrop_mapclick", "onMapSingleClick", {
    _this setPos [_pos select 0, _pos select 1, 1000];
    _this addAction ["Open parachute", {
        _this params ["_target", "", "_id"];
        _velocity = velocity _target;
        private _parachute = createVehicle ["Steerable_Parachute_F", [(getPos _target) select 0, (getPos _target) select 1, ((getPos _target )select 2) + 1], [], 0, "NONE"];
        _target moveInDriver _parachute;
        _target removeAction _id;
        _parachute setVelocity _velocity;
    }];
    openMap false;
}, _this] call BIS_fnc_addStackedEventHandler;

["tft_ins_paradrop_visibleMap", "onEachFrame", {
    if !(visibleMap) then {
        ["tft_ins_paradrop_mapclick", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
        ["tft_ins_paradrop_visibleMap", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
        hint "Paradrop cancelled";
    };
}]  call BIS_fnc_addStackedEventHandler;
