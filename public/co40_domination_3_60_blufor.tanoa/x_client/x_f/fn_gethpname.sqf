// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_gethpname.sqf"
#include "..\..\x_setup.sqf"

params ["_u"];
private _n = _u getVariable "d_phname";
if (isNil "_n") then {
	_n = name _u;
	if (!d_with_ai && {d_with_ai_features == 1}) then {
		_n = _n + (["", d_phud_loc884] select (_u getUnitTrait "Medic"));
	};
	_u setVariable ["d_phname", _n];
};
_n
