// by Xeno
#define THIS_FILE "fn_sidearrest.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

params ["_officer"];

private _offz_at_base = false;
private _is_dead = false;
private _rescued = false;

if (d_with_ranked) then {d_sm_p_pos = nil};

d_sm_arrest_not_failed = true;

while {!_offz_at_base && {!_is_dead && {d_sm_arrest_not_failed}}} do {
	call d_fnc_mpcheck;
	if (!alive _officer) exitWith {_is_dead = true;};
	if (!_rescued) then {
		if (d_with_ai || {d_with_ai_features == 0 || {d_tt_ver}}) then {
			private _nobjs = (_officer nearEntities ["CAManBase", 20]) select {isPlayer _x && {alive _x && {!(_x getVariable ["xr_pluncon", false])}}};
			if !(_nobjs isEqualTo []) then {
				private _rescuer = _nobjs select 0;
				_rescued = true;
				_officer enableAI "PATH";
				[_officer] join _rescuer;

				[_officer, true] remoteExecCall ["setCaptive", _officer];

				d_sm_arrest_mp_unit = _rescuer;
				d_sm_arrest_mp_unit setVariable ["d_sm_ar_mpk_eh_idx",
					_rescuer addMPEventhandler ["MPKilled", {
						if (!isNil "d_sm_arrest_mp_unit") then {
							d_sm_arrest_not_failed = false;
							d_sm_arrest_mp_unit removeMPEventHandler ["MPKilled", d_sm_arrest_mp_unit getVariable "d_sm_ar_mpk_eh_idx"];
							d_sm_arrest_mp_unit setVariable ["d_sm_ar_mpk_eh_idx", nil];
							d_sm_arrest_mp_unit = nil;
						};
					}]
				];
			};
		} else {
			for "_i" from 1 to 5 do {
				private _res = missionNamespace getVariable format ["d_artop_%1", _i];
				if (!isNil "_res" && {alive _res && {!(_res getVariable ["xr_pluncon", false]) && {_res distance2D _officer < 20}}}) exitWith {
					_rescued = true;
					_officer enableAI "PATH";
					[_officer] join _res;
					[_officer, true] remoteExecCall ["setCaptive", _officer];
				};
			};
		};
	} else {
#ifndef __TT__
		if (_officer distance2D d_FLAG_BASE < 50) then {
#else
		if (_officer distance2D d_WFLAG_BASE < 50 || {_officer distance2D d_EFLAG_BASE < 50}) then {
#endif
			_offz_at_base = true;
		};
	};

	sleep 5.621;
};

if (!d_sm_arrest_not_failed) then {_is_dead = true};

if (_is_dead) then {
	d_sm_winner = -500;
} else {
	if (_offz_at_base) then {
#ifndef __TT__
		if (d_with_ranked) then {
			[missionNamespace, ["d_sm_p_pos", getPosATL d_FLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
		};
		d_sm_winner = 2;
#else
		if (_officer distance2D d_WFLAG_BASE < 50) then {
			if (d_with_ranked) then {
				[missionNamespace, ["d_sm_p_pos", getPosATL d_WFLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
			};
			d_sm_winner = 2;
		} else {
			if (_officer distance2D d_EFLAG_BASE < 50) then {
				if (d_with_ranked) then {
					[missionNamespace, ["d_sm_p_pos", getPosATL d_EFLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
				};
				d_sm_winner = 1;
			} else {
				d_sm_winner = -500;
			};
		};
#endif
	};
};

if (!isNull objectParent _officer) then {
	(objectParent _officer) deleteVehicleCrew _officer;
} else {
	deleteVehicle _officer;
};
sleep 0.5;

d_sm_arrest_not_failed = nil;
if (!isNil "d_sm_arrest_mp_unit") then {
	d_sm_arrest_mp_unit removeMPEventHandler ["MPKilled", d_sm_arrest_mp_unit getVariable "d_sm_ar_mpk_eh_idx"];
	d_sm_arrest_mp_unit setVariable ["d_sm_ar_mpk_eh_idx", nil];
	d_sm_arrest_mp_unit = nil;
};

d_sm_resolved = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};