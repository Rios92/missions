params ["_className"];
private ["_pos"];

detach TFID_placedObject;
sleep 0.1;

_pos = getPos TFID_placedObject;
_pos set [2, ((getposATL player) select 2) - .1];
TFID_placedObject setPos _pos;

player removeAction TFID_actionConfirm;
player removeAction TFID_actionCancel;
player removeEventHandler ["Killed", TFID_placeEH];

{
    if((_x select 1) isEqualTo _className) exitWith {
        player removeAction (_x select 0);
        TFID_placeActions = TFID_placeActions - _x;
    };
} forEach TFID_placeActions;

TFID_hideActions = false;

sleep 1;
TFID_placedObject allowDamage true;
