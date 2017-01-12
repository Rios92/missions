while {true} do {
    _pilots = 0;
    if (typeof (vehicle player) == "B_Helipilot_F") then {
        _pilots = _pilots + 1;
    };
    if (_pilots >= 3) then {
        haloFlag hideObjectGlobal true;
        systemChat "Pilots on station, HALO unavailable at BASE";
    }
    else {
        haloFlag hideObjectGlobal false;
        systemChat "HALO now available at BASE";
    };
    uiSleep 200;
};
