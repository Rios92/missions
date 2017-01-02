/*
@filename: init.sqf
Author:
	
	Quiksilver

Last modified:

	12/05/2014
	
Description:

	Things that may run on both server and client.
	Deprecated initialization file, still using until the below is correctly partitioned between server and client.
______________________________________________________*/

execVM "scripts\NRE_earplugs.sqf";
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";		// revive

if(isServer) then {
    _curator = (createGroup sideLogic) createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"]; 
    _curator setVariable ["Addons", 3, true]; 
    _curator setVariable ["Owner", "#adminLogged", true];
	_curator addEventHandler ["curatorPinged",{_this call QS_fnc_pingCurator}];
};

