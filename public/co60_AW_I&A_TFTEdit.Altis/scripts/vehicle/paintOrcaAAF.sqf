private ["_veh"];
_veh = _this select 0;

if (typeOf _veh != "O_Heli_Light_02_F") exitWith {};

_veh setObjectTextureGlobal [0, "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa"];
_veh removeWeaponTurret ["missiles_DAGR", [-1]];
_veh addWeaponTurret ["missiles_DAR", [-1]];
_veh addMagazineTurret ["12Rnd_missiles", [-1]];









