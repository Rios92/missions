// baseObj addAction ["<t color=""#4DB0E2"">" + "Request for Eagle 1 respawn", "scripts\heli_respawnReq.sqf",["h1","Eagle 1"]];

_caller = _this select 1;
_mhq = call compile format ["%1",(_this select 3) select 0];

if (count crew _mhq == 0) then
{
	_mhq setPos [0,0,0];
	sleep 2;
	_mhq setDamage 1;
	//[west,"HQ"] SideChat "MHQ will be respawned.";
	serviceNumber = [2, format ["MHQ will be respawned at base due to %1 request.",name _caller]]; publicvariable "serviceNumber";
}else{
	[west,"HQ"] SideChat "MHQ is using by someone. Therefore it cannot be respawned!";
};

if (true) exitWith {};
