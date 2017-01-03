_this spawn {
    params ["_vehicle"];

    if (_vehicle isKindOf "Car" || _vehicle isKindOf "Tank" || _vehicle isKindOf "Helicopter") then {
        _fuel = fuel _vehicle;
        _vehicle setFuel 0;
        _vehicle vehicleChat "Servicing started";

        //---------- RE-ARMING
        _vehicle vehicleChat "Rearming ...";
        sleep 4;
        _vehicle setVehicleAmmo 1;

        //---------- REPAIRING
        _vehicle vehicleChat "Repairing ...";
        sleep (10 * damage _vehicle);
        _vehicle setDamage 0;

        //---------- REFUELING
        _vehicle vehicleChat "Refueling ...";
        sleep (10 * (1-_fuel));
        [_vehicle,1] remoteExec ["setFuel"];

        //---------- FINISHED
        sleep 1;
        _vehicle vehicleChat "Service complete.";
    };
};
