params ["_player"];

deleteVehicle TFID_placedObject;
_player removeAction TFID_actionConfirm;
_player removeAction TFID_actionCancel;
_player removeEventHandler ["Killed", TFID_placeEH];

TFID_hideActions = false;
