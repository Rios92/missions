private ["_veh"];
_veh = _this select 0;

if (typeOf _veh != "I_MRAP_03_F") exitWith {};

_veh setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa']; 
_veh setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa']; 




