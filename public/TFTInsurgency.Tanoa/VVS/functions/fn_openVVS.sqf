/*
	File: fn_openVVS.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens the VVS menu and fills in the blanks.
*/
params ["", "_unit", "", ["_sp", "", ["", []]]];

_lockTime = _unit getVariable ["tft_ins_vvs_lock", 0];
if(time < _lockTime) exitWith { hint format["Logistics denied your request.\nWait %1sec for next opportunity", floor (_lockTime - time)] };

if(typeName _sp == "STRING") then
{
	if(_sp == "") exitWith {closeDialog 0};
	VVS_SP = _sp;
}
	else
{
	if(typeName _sp == "ARRAY") then
	{
		if(count _sp == 0) exitWith {closeDialog 0;};
		VVS_SP = _sp select 0;
		VVS_Cfg = _sp select 1;
	};
};

VVS_unit = _unit;

disableSerialization;
if(!(createDialog "VVS_Menu")) exitWith {}; //Couldn't create the menu
