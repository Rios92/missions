
// REMOTE EXECUTION OF CODE FROM SERVER		- for debuging purposes
//
//	[{code}] spawn FFS_FNC_serverExec;
//  [{["east", getMarkerPos "test1", 150 , "", true, grpNull , [0.5,0.2] ] call FFS_FNC_crateStaticUnit;}] spawn FFS_FNC_serverExec;
//	return - nothing

FFS_FNC_serverExec = 
{
		_code = format["%1",_this select 0];
		serviceNumberServer = [10,_code]; 
		publicVariableServer "serviceNumberServer";
		if (logging_mode) then {["FNC_client.sqf",4,format ["CLIENT FNC (FFS_FNC_serverExec): %1",_code]] spawn FFS_FNC_log;};
};

// GET VARIABLE FROM SERVER TO CLIENT		- for debuging purposes
//
//	["variable",unit] spawn FFS_FNC_getServerVar;
//  ["CountGrpeast",player] spawn FFS_FNC_getServerVar;
//	return - nothing

FFS_FNC_getServerVar = 
{
		_var = _this select 0;
		_unit = _this select 1;
		serviceNumberServer = [9,_var,_unit]; 
		publicVariableServer "serviceNumberServer";
		if (logging_mode) then {["FNC_client.sqf",4,format ["CLIENT FNC (FFS_FNC_getServerVar): %1 / %2",_var,_unit]] spawn FFS_FNC_log;};
};

// AddAction to object (is conditions are met then action is broadcasted to all client and JIP players)
//
//	[[_ammoBox,["<t color='#ff1111'>Virtual Ammobox</t>", "gear\open.sqf"]], "FFS_FNC_addAction", true, true] spawn BIS_fnc_MP;
//  [_ammoBox,["<t color='#ff1111'>Virtual Ammobox</t>", "gear\open.sqf"]] spawn FFS_FNC_addAction;
//  a = format ["%1",actionTEST select 0];  !isNil _objectSTRG
//	return - nothing

FFS_FNC_addAction = 
{
		_object = _this select 0;
		_action = _this select 1;
		_object addAction _action;
};

// remove all actions from object (is conditions are met then action is broadcasted to all client and JIP players)
//
//	[[_ammoBox], "FFS_FNC_removeAllAction", true, true] spawn BIS_fnc_MP;
//  [_ammoBox] spawn FFS_FNC_removeAllAction;
//	return - nothing

FFS_FNC_removeAllAction = 
{
		_object = _this select 0;
		removeAllActions _object;
};

// Player punishment due to base-raping
//
//	[player] spawn FFS_FNC_BRpunish;
//	return - nothing

FFS_FNC_BRpunish = 
{
	_who = _this select 0;
	
	titleText [format ["You have been punished!", name _who ], "BLACK IN", 6];
	removeallweapons _who;
	removeallassigneditems _who;
	removeallcontainers _who;
	removevest _who;
	removeheadgear _who;
	removegoggles _who;
	removeBackPack _who;
	removeuniform _who;
	BRCCounter = 0;
	
	_who setPos (getMarkerPos "respawn_west");
	hint "DON'T TRY IT AGAIN!";
};

// set vehicle name
//
//	[obj, "obj name"] spawn FFS_FNC_publicObj;
//	return - nothing

FFS_FNC_publicObj = 
{
	_unitObj = _this select 0;
	_unitName = _this select 1;
	call compile format ["_unitObj setVehicleVarName '%1'",_unitName];
	call compile format ["%1 = _unitObj",vehicleVarName _unitObj];

};

if (true) exitWith {};


