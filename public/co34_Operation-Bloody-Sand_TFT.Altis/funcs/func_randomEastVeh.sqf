_typesVehicles =["O_G_Offroad_01_armed_F"];
_cnt = count _typesVehicles;
_selectedVehicle = _typesVehicles select (floor (random count _typesVehicles));

if (true) exitWith {_selectedVehicle};
