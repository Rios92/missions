/*
 * Author: Ampers
 * Adds to vehicle(s) cargo a standard load of infantry munitions and supplies.
 *
 * Arguments:
 * 0: Objects to add supplies to
 *
 * Return Value:
 * -
 *
 * Example:
 * [_veh1, _veh2] call TFT_fnc_loadSupplies;
 */

 private "_vics";
 _vics = _this;
 
{
  _TFT_itemsKitbagMedical = ["ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_morphine","ACE_morphine","ACE_morphine","ACE_morphine","ACE_morphine","ACE_morphine","ACE_morphine","ACE_morphine","ACE_tourniquet","ACE_tourniquet","ACE_tourniquet","ACE_tourniquet","ACE_tourniquet","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_salineIV_500","ACE_salineIV_500","ACE_surgicalKit","ACE_surgicalKit","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_morphine","ACE_morphine","ACE_salineIV","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_250","ACE_EarPlugs","ACE_EarPlugs","ACE_EarPlugs","ACE_EarPlugs","ACE_EarPlugs","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_CableTie","ACE_CableTie","ACE_CableTie","ACE_CableTie","ACE_CableTie","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_salineIV","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_250","ACE_salineIV_500","ACE_salineIV_500","ACE_surgicalKit","ACE_surgicalKit","ACE_surgicalKit"];
  _TFT_itemsMedicPack = ["ACE_EarPlugs","ACE_EarPlugs","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_epinephrine","ACE_morphine","ACE_morphine","ACE_morphine","ACE_morphine","ACE_morphine","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_tourniquet","ACE_tourniquet","ACE_tourniquet","ACE_tourniquet","ACE_tourniquet","ACE_surgicalKit","ACE_surgicalKit","ACE_salineIV","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_250","ACE_salineIV_500","ACE_salineIV_500","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_elasticBandage","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing"];
	
  comment "___ clear everything ___";
	clearWeaponCargoGlobal _x;
	clearmagazineCargoGlobal _x;
	clearitemCargoGlobal _x;
	clearBackpackCargoGlobal _x;
	comment "___ weapons ___";
  _x addItemCargoGlobal ["ACE_EarPlugs",10];
  _x addItemCargoGlobal ["TFAR_anprc152_2",1];
  _x addItemCargoGlobal ["CUP_launch_M72A6",2];
  _x addItemCargoGlobal ["CUP_MAAWS_HEAT_M",2];
  _x addItemCargoGlobal ["CUP_MAAWS_HEDP_M",2];
	_x addItemCargoGlobal ["ACE_M26_Clacker",1];
	_x addItemCargoGlobal ["HandGrenade",10];
	_x addItemCargoGlobal ["SmokeShell",15];
	_x addItemCargoGlobal ["SmokeShellGreen",10];
	_x addItemCargoGlobal ["DemoCharge_Remote_Mag",6];
	_x addItemCargoGlobal ["ACE_HandFlare_Green",6];
	_x addItemCargoGlobal ["Chemlight_green",10];
	_x addItemCargoGlobal ["ACE_EntrenchingTool",2];
	_x addItemCargoGlobal ["1Rnd_HE_Grenade_shell",20];
	_x addItemCargoGlobal ["30Rnd_556x45_Stanag",40];
	_x addItemCargoGlobal ["200Rnd_556x45_Box_Tracer_Red_F",10];
	_x addBackpackGlobal "B_AssaultPack_rgr";
	comment "___ medical backpack ___";
	_x addBackpackCargoGlobal ["B_Kitbag_rgr", 1];
  _x addBackpackCargoGlobal ["CUP_B_MedicPack_ACU", 1];
	{
		if (typeof _x == "B_Kitbag_rgr") then {
			_medpack = _x;
      {
        _medpack addItemCargoGlobal [_x,1];
      } forEach _TFT_itemsKitbagMedical;
		};
		if (typeof _x == "CUP_B_MedicPack_ACU") then {
			_medpack = _x;
      {
        _medpack addItemCargoGlobal [_x,1];
      } forEach _TFT_itemsMedicPack;
		};
	} forEach (everyBackpack _x);
	comment "___ backpacks ___";
	_x addBackpackCargoGlobal ["B_AssaultPack_rgr", 2];
	_x addBackpackCargoGlobal ["tf_rt1523g_ocp_big", 1];
	_x addBackpackCargoGlobal ["B_UAV_01_backpack_F", 1];
} forEach _vics;