IntroFinish = false;
preloadEnd=false;
BRCCounter = 0;
{_x setMarkerAlphaLocal 0} foreach markers;
execVM "briefing.sqf";
execVM "scripts\intro.sqf";
execVM "funcs\FNC_client.sqf";

["1", "onPreloadFinished", {
	preloadEnd=true;
}, ""] call BIS_fnc_addStackedEventHandler;

waitUntil {!isNull player};
if (logging_mode) then {["init_Client.sqf",2,format ["Player is alive / Time: %1 / Date: %2",time,date]] spawn FFS_FNC_log;};

if (debug_mode) then 
{
		IntroFinish = true;
		_actDebug = player addAction ["Debug Console", "dlg_debug\activateDLG.sqf", [], 0,false, true, "", "true"];
		titleRsc ["Debug_mode", "PLAIN"];
		//player sidechat format ["debug_mode / preloadEnd: %1",preloadEnd];	
};

if ((FFS_mobile_resp select 0) == 0) then 
{
	deleteMarkerLocal "MHQ_teleport";	
};

execVM "scripts\inetdClient.sqf";
execVM "scripts\getOut.sqf";
execVM "scripts\3d_markers.sqf";
["loop"] execVM "scripts\sound_allah.sqf";

_KilledHandler = player addEventHandler ["killed", {_this execVM "scripts\playerkilled.sqf"}];

// BASE-RAPING CONTROL 
player addEventHandler ["Fired", {
	PF=_this;
	if ((_this select 0) distance getMarkerPos "respawn_west" < 50 ) then
	{
		deleteVehicle (_this select 6);
		titleText [format ["%1 stop shooting at BASE! Otherwise you will be punished !", name (_this select 0) ], "PLAIN", 3];
		BRCCounter = BRCCounter + 1;
		if (BRCCounter > 5) then 
		{
			[player] spawn FFS_FNC_BRpunish;
		};
	};
}];

if (logging_mode) then {
	waitUntil {date select 3 == FFS_hours};
	["init_Client.sqf",2,format ["Adjusted Date: %1",date]] spawn FFS_FNC_log;
}else{
	sleep 1;
	["init_Client.sqf",2,format ["Time: %1 / Date: %2",time,date]] spawn FFS_FNC_log;
};

waitUntil {IntroFinish};
sleep 5;
execVM "scripts\mission_hint.sqf";

if (true) exitWith {};
