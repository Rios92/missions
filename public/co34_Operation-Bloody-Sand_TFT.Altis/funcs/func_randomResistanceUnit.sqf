_leader = ["I_Soldier_TL_F"];
_soldier1 = ["I_Soldier_F"];
_MG = ["I_Soldier_AR_F"];
_sniper = ["I_soldier_M_F"];
_AT1 = ["I_Soldier_LAT_F"];
_AA = ["I_Soldier_AA_F"];
_medic = ["I_medic_F"];


_types =  _leader + _soldier1 + _soldier1 + _soldier1 + _soldier1 + _soldier1 + _soldier1 + _soldier1 + _soldier1 + _AT1 + _sniper + _MG + _AA + _medic;
_cnt = count _types;
_selectedUnit = _types select (floor (random count _types));

if (true) exitWith {_selectedUnit};
