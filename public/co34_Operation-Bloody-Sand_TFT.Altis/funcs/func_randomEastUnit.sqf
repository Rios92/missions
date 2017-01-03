_leader = ["O_Soldier_TL_F"];
_soldier1 = ["O_Soldier_F"];
_soldier2 = ["O_Soldier_lite_F"];
_MG = ["O_Soldier_AR_F"];
_sniper = ["O_soldier_M_F"];
_AT1 = ["O_Soldier_LAT_F"];
_AA = ["O_Soldier_AA_F"];
_medic = ["O_medic_F"];


_types =  _leader + _soldier1 + _soldier1 + _soldier1 + _soldier1 + _soldier1 + _soldier2 + _soldier2 + _soldier2 + _AT1 + _AT1 + _AT1 + _sniper + _sniper + _MG + _MG +  _medic +  _medic;
_cnt = count _types;
_selectedUnit = _types select (floor (random count _types));

if (true) exitWith {_selectedUnit};
