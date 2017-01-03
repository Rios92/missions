_vehicle = _this select 0;

if !(_vehicle isKindOf "Air" && {!(_vehicle isKindOf "ParachuteBase")}) exitwith {};

_unit = driver _vehicle;

if !(_unit getUnitTrait "derp_pilot") then {
    moveOut _unit;
    "You're not a pilot, you're not allowed to sit here." remoteExec ["hint", _unit];
};
