// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getmixedlist.sqf"
#include "..\..\x_setup.sqf"

params ["_side"];
private _ret_list = [];
{
	_ret_list pushBack ([_x, _side] call d_fnc_getunitlistv);
	false
} count [switch (floor random 2) do {case 0: {"wheeled_apc"};case 1: {"jeep_mg"};}, "tracked_apc", "tank", "aa"];
_ret_list