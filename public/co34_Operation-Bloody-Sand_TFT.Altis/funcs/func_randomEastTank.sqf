_typesVehicles =["O_APC_Wheeled_02_rcws_F"];
_cnt = count _typesVehicles;
_selectedVehicle = _typesVehicles select (floor (random count _typesVehicles));

if (true) exitWith {_selectedVehicle};