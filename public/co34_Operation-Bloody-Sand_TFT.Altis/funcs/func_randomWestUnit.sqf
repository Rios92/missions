_soldier1 = ["B_Soldier_F"];
_MG = ["B_Soldier_AR_F"];
_sniper = ["B_soldier_M_F"];
_AT1 = ["B_Soldier_LAT_F"];


_types =  _soldier1 + _soldier1 + _soldier1 + _soldier1 + _AT1 + _sniper + _MG;
_cnt = count _types;
_selectedUnit = _types select (floor (random count _types));

if (true) exitWith {_selectedUnit};
