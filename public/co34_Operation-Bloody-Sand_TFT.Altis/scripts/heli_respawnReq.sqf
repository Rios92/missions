// baseObj addAction ["<t color=""#4DB0E2"">" + "Request for Eagle 1 respawn", "scripts\heli_respawnReq.sqf",["h1","Eagle 1"]];

_caller = _this select 1;
_heli = call compile format ["%1",(_this select 3) select 0];
_heliName = (_this select 3) select 1;
_pilotType = "B_Helipilot_F";

if (typeof player == _pilotType) then
{
	// is occupied
	if (count crew _heli == 0) then 
	{
		_heli setPos [0,0,0];
		sleep 2;
		_heli setDamage 1;
		[west,"HQ"] SideChat format ["%2 %1 your request has been confirmed. %3 will be respawned up to 1 minute.",name _caller, rank _caller,_heliName];
	}else{
		[west,"HQ"] SideChat format ["%2 %1 Helicopter is using by someone. Therefore helicopter cannot be respawned!",name _caller, rank _caller,_heliName];
	};
}else{
	[west,"HQ"] SideChat format ["%2 %1 you are not pilot! You cannot request it!",name _caller, rank _caller];
};

if (true) exitWith {};
