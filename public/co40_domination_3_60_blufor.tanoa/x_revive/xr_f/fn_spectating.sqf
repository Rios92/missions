// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_spectating.sqf"
#include "..\..\x_macros.sqf"

if (isDedicated) exitWith {};

__TRACE("start")
xr_MouseCoord = [0.5,0.5];
xr_MouseScroll = 0;
xr_MouseButtons = [false,false];
xr_mouseDeltaPos = [0,0];
xr_mouseLastX = 0.5;
xr_mouseLastY = 0.5;
xr_maxDistance = 50;
xr_sdistance = 1;
xr_szoom = 0.976;
xr_fangle = 0;
xr_fangleY = 15;
xr_mousecheckon = false;
disableSerialization;
if (!isNil "xr_stopspect" && {!xr_stopspect}) then  {
	waitUntil {xr_stopspect};
	sleep 0.2;
};
xr_stopspect = false;
enableRadio false;
params ["_withresp"];
__TRACE_1("","_withresp")
if (_withresp) then {
	__TRACE("_withresp, cutText")
	"xr_revtxt2" cutText [localize "STR_DOM_MISSIONSTRING_921","PLAIN", 0];
	sleep 3;
};
__TRACE("black in 3")
"xr_revtxt" cutText ["","BLACK IN", 3];
xr_pl_no_lifes = [false, player getVariable "xr_lives" == -1] select (xr_max_lives > -1);
__TRACE_1("","xr_pl_no_lifes")
xr_camnvgon = false;
d_x_loop_end = false;
createDialog "xr_SpectDlg";
private _disp = uiNamespace getVariable "xr_SpectDlg";
#define __dspctrl(ctrlid) (_disp displayCtrl ctrlid)
__dspctrl(1000) ctrlShow false;
__dspctrl(3000) ctrlShow false;
#define __spectdlg1006e ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006)
if (!_withresp) then {
	__dspctrl(1020) ctrlShow false;
	__dspctrl(1021) ctrlShow false;
	__dspctrl(1005) ctrlShow false;
	__dspctrl(1006) ctrlShow false;
} else {
	if (xr_respawn_available) then {
		__spectdlg1006e ctrlSetText (localize "STR_DOM_MISSIONSTRING_922");
		__spectdlg1006e ctrlSetTextColor [1,1,0,1];
		__spectdlg1006e ctrlCommit 0;
	};
};

private _helperls = [];
if (!xr_pl_no_lifes) then {
	if(_withresp) then {
		_helperls pushBack [-100, xr_name_player, xr_strpl];
	};
	
	private _vecpplxp = vehicle player;
	{
		private _u = missionNamespace getVariable _x;
		//if (!isNil "_u" && {alive _u} && {side (group _u) == xr_side_pl} && {_u != player} && {!(_u getVariable ["xr_pluncon", false])}) then {
		if (!isNil "_u" && {alive _u && {_u != player}}) then {
			private _dist = (vehicle _u) distance2D _vecpplxp;
			_helperls pushBack [_dist, format [name _u + " (%1 m) %2", round _dist, ["", " (Uncon)"] select (_u getVariable ["xr_pluncon", false])], str _u];
		};
		false
	} count d_player_entities;
} else {
	private _sfm = markerPos "xr_playerparkmarker";
	{
		private _u = missionNamespace getVariable _x;
		//if (!isNil "_u" && {alive _u} && {side (group _u) == xr_side_pl} && {_u != player}) then {
		if (!isNil "_u" && {alive _u && {_u != player}}) then {
			private _distup = (vehicle _u) distance2D _sfm;
			if (_distup > 100) then {
				_helperls pushBack [_distup, name _u, str _u];
			};
		};
		false
	} count d_player_entities;
};

__TRACE_1("","_helperls")
__TRACE_1("","xr_strpl")

private _lbctr = (uiNamespace getVariable "xr_SpectDlg") displayCtrl 1000;
lbClear _lbctr;
{
	__TRACE_1("","_x")
	private _idx = _lbctr lbAdd (_x select 1);
	__TRACE_1("","_idx")
	_lbctr lbSetData [_idx, _x select 2];
	_lbctr lbSetValue [_idx, _x select 0];
	false
} count _helperls;
if !(_helperls isEqualTo []) then {
	__TRACE("LB Sort By Value")
	lbSortByValue _lbctr;
	_lbctr lbSetCurSel 0;
};

_aaa = lbSize _lbctr;
__TRACE_1("","_aaa")

__TRACE_1("","xr_pl_no_lifes")
showCinemaBorder false;
if (!xr_pl_no_lifes) then {
	private _nposvis = ASLToATL (visiblePositionASL (vehicle player));
	xr_spectcam = "camera" camCreate [(_nposvis select 0) - 1 + random 2, (_nposvis select 1) - 1 + random 2, 2];
	xr_spectcamtarget = player;
	xr_spectcamtargetstr = xr_strpl;
	xr_spectcam cameraEffect ["INTERNAL", "Back"];
	xr_spectcam camCommit 0;
	__dspctrl(1010) ctrlSetText xr_name_player;
	
	call xr_fnc_nearplayercheckui
} else {
	__dspctrl(9998) ctrlEnable false;
	
	private _sfm = markerPos "xr_playerparkmarker";
	private _visobj = objNull;
	{
		private _u = missionNamespace getVariable _x;
		//if (!isNil "_u" && {alive _u} && {side (group _u) == xr_side_pl} && {_u != player} && {_u distance2D _sfm > 100}) exitWith {
		if (!isNil "_u" && {alive _u && {_u != player && {_u distance2D _sfm > 100}}}) exitWith {
			_visobj = _u;
		};
		false
	} count d_player_entities;
	if (isNull _visobj) then {_visobj = player};
	private _nposvis = ASLToATL (visiblePositionASL (vehicle _visobj));
	xr_spectcam = "camera" camCreate [(_nposvis select 0) - 1 + random 2, (_nposvis select 1) - 1 + random 2, 2];
	xr_spectcamtarget = _visobj;
	xr_spectcamtargetstr = str _visobj;
	xr_spectcam cameraEffect ["INTERNAL", "Back"];
	xr_spectcam camCommit 0;
	__dspctrl(1010) ctrlSetText (name _visobj);
};

xr_x_updatelb = false;
xr_spect_timer = time + 10;
xr_x_withresp = _withresp;
xr_x_loc_922 = localize "STR_DOM_MISSIONSTRING_922";
__TRACE("main one frame loop starts")
["itemAdd", ["dom_xr_spect_of", {
	if (!xr_stopspect) then {
		call xr_fnc_spect_oneframe;
	} else {
		["itemRemove", ["dom_xr_spect_of"]] call bis_fnc_loop;
		d_x_loop_end = true;
		closeDialog 0;
		player switchCamera "INTERNAL";
		xr_spectcam cameraEffect ["Terminate", "Back"];
		camDestroy xr_spectcam;
		enableRadio true;
		xr_x_withresp = nil;
		xr_x_updatelb = nil;
		xr_spect_timer = nil;
		xr_hhx = nil;
		__TRACE("spectating ended, one frame removed")
	};
}, 0.01]] call bis_fnc_loop;
