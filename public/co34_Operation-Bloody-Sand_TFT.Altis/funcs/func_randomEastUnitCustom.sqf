_trst_TL={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerrilla_6_1";
for "_i" from 1 to 2 do {this addItemToUniform "30Rnd_65x39_caseless_green";};
this addItemToUniform "6Rnd_45ACP_Cylinder";
this addVest "V_TacVest_khk";
this addItemToVest "30Rnd_65x39_caseless_green";
for "_i" from 1 to 2 do {this addItemToVest "6Rnd_45ACP_Cylinder";};
for "_i" from 1 to 6 do {this addItemToVest "30Rnd_65x39_caseless_green_mag_Tracer";};
this addItemToVest "MiniGrenade";
this addHeadgear "H_Bandanna_mcamo";
this addGoggles "G_Aviator";

comment "Add weapons";
this addWeapon "arifle_Katiba_F";
this addPrimaryWeaponItem "optic_Aco";
this addWeapon "hgun_Pistol_heavy_02_F";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";

comment "Set identity";
this setFace "PersianHead_A3_02";
this setSpeaker "Male03PER";
[this,"FFS_ISIS"] call bis_fnc_setUnitInsignia;

};

_trst_soldier1={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_leader";
this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {this addItemToUniform "30Rnd_65x39_caseless_green";};
this addVest "V_BandollierB_blk";
this addItemToVest "30Rnd_65x39_caseless_green";
this addHeadgear "H_ShemagOpen_khk";

comment "Add weapons";
this addWeapon "arifle_Katiba_C_F";

comment "Add items";
this linkItem "ItemMap";

comment "Set identity";
this setFace "GreekHead_A3_09";
this setSpeaker "Male03PER";
};

_trst_soldier2={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerrilla_6_1";
this addVest "V_BandollierB_rgr";
for "_i" from 1 to 6 do {this addItemToVest "30Rnd_65x39_caseless_green";};
this addGoggles "G_Balaclava_blk";

comment "Add weapons";
this addWeapon "arifle_Katiba_C_F";

comment "Add items";
this linkItem "ItemMap";

comment "Set identity";
this setFace "GreekHead_A3_09";
this setSpeaker "Male03PER";
[this,"FFS_ISIS"] call bis_fnc_setUnitInsignia;

};

_trst_soldier3={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerilla1_1";
this addVest "V_BandollierB_cbr";
for "_i" from 1 to 6 do {this addItemToVest "30Rnd_65x39_caseless_green";};
this addHeadgear "H_Shemag_olive";

comment "Add weapons";
this addWeapon "arifle_Katiba_C_F";

comment "Add items";
this linkItem "ItemMap";

comment "Set identity";
this setFace "GreekHead_A3_09";
this setSpeaker "Male03PER";

};

_trst_soldier4={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerilla2_3";
this addVest "V_TacVest_blk";
for "_i" from 1 to 6 do {this addItemToVest "30Rnd_65x39_caseless_green";};
this addGoggles "G_Balaclava_blk";

comment "Add weapons";
this addWeapon "arifle_Katiba_C_F";

comment "Add items";
this linkItem "ItemMap";

comment "Set identity";
this setFace "PersianHead_A3_01";
this setSpeaker "Male02PER";


};

_trst_MG={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerilla3_1";
this addItemToUniform "FirstAidKit";
this addBackpack "B_AssaultPack_rgr";
this addItemToBackpack "FirstAidKit";
for "_i" from 1 to 3 do {this addItemToBackpack "150Rnd_762x51_Box";};
this addItemToBackpack "HandGrenade";
this addGoggles "G_Balaclava_blk";

comment "Add weapons";
this addWeapon "LMG_Zafir_F";

comment "Add items";
this linkItem "ItemMap";

comment "Set identity";
this setFace "WhiteHead_05";
this setSpeaker "Male03PER";


};

_trst_AT={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerilla2_1";
this addItemToUniform "FirstAidKit";
this addVest "V_BandollierB_khk";
for "_i" from 1 to 6 do {this addItemToVest "30Rnd_9x21_Mag";};
this addBackpack "B_AssaultPack_blk";
for "_i" from 1 to 2 do {this addItemToBackpack "RPG32_HE_F";};
this addGoggles "G_Bandanna_blk";

comment "Add weapons";
this addWeapon "hgun_PDW2000_F";
this addWeapon "launch_RPG32_F";

comment "Add items";

comment "Set identity";
this setFace "GreekHead_A3_09";
this setSpeaker "Male03PER";

};

_trst_AT2={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerilla2_1";
this addItemToUniform "FirstAidKit";
this addVest "V_BandollierB_khk";
for "_i" from 1 to 6 do {this addItemToVest "30Rnd_9x21_Mag";};
this addBackpack "B_Carryall_khk";
for "_i" from 1 to 2 do {this addItemToBackpack "Titan_AT";};
this addGoggles "G_Bandanna_blk";

comment "Add weapons";
this addWeapon "hgun_PDW2000_F";
this addWeapon "launch_O_Titan_short_F";

comment "Add items";

comment "Set identity";
this setFace "GreekHead_A3_09";
this setSpeaker "Male03PER";
};


_trst_medic={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_leader";
this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {this addItemToUniform "30Rnd_9x21_Mag";};
this addBackpack "B_FieldPack_cbr";
this addItemToBackpack "Medikit";
for "_i" from 1 to 4 do {this addItemToBackpack "FirstAidKit";};
this addItemToBackpack "MiniGrenade";
for "_i" from 1 to 5 do {this addItemToBackpack "30Rnd_9x21_Mag";};
this addGoggles "G_Balaclava_blk";

comment "Add weapons";
this addWeapon "hgun_PDW2000_F";

comment "Add items";
this linkItem "ItemMap";

comment "Set identity";
this setFace "PersianHead_A3_03";
this setSpeaker "Male01PER";


};

_trst_sniper={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerilla2_3";
this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {this addItemToUniform "10Rnd_762x51_Mag";};
this addVest "V_BandollierB_rgr";
this addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {this addItemToVest "10Rnd_762x51_Mag";};
this addItemToVest "SmokeShellYellow";
this addGoggles "G_Bandanna_blk";

comment "Add weapons";
this addWeapon "srifle_DMR_01_F";
this addPrimaryWeaponItem "optic_SOS";

comment "Add items";
this linkItem "ItemMap";

comment "Set identity";
this setFace "WhiteHead_05";
this setSpeaker "Male03PER";
};

_trst_AA={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_BG_Guerilla1_1";
this addItemToUniform "FirstAidKit";
this addVest "V_BandollierB_khk";
for "_i" from 1 to 6 do {this addItemToVest "30Rnd_9x21_Mag";};
this addBackpack "B_AssaultPack_blk";
this addItemToBackpack "FirstAidKit";
this addItemToBackpack "Titan_AA";
for "_i" from 1 to 6 do {this addItemToBackpack "16Rnd_9x21_Mag";};
this addGoggles "G_Balaclava_blk";

comment "Add weapons";
this addWeapon "hgun_PDW2000_F";
this addWeapon "launch_O_Titan_F";

comment "Add items";

comment "Set identity";
this setFace "GreekHead_A3_09";
this setSpeaker "Male03PER";
};

_ISIS_leader={
comment "Exported from Arsenal by FriZY";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_O_OfficerUniform_ocamo";
for "_i" from 1 to 3 do {this addItemToUniform "30Rnd_556x45_Stanag";};
this addItemToUniform "6Rnd_GreenSignal_F";
this addHeadgear "H_Bandanna_khk";
this addGoggles "G_Aviator";

comment "Add weapons";
this addWeapon "arifle_SDAR_F";
this addWeapon "hgun_Pistol_Signal_F";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";

comment "Set identity";
this setFace "PersianHead_A3_02";
this setSpeaker "Male01PERVR";
};

_leader = _trst_TL;
_soldier1 = _trst_soldier1;
_soldier2 = _trst_soldier2;
_soldier3 = _trst_soldier3;
_soldier4 = _trst_soldier4;
_MG = _trst_MG;
_sniper = _trst_sniper;
_AT1 = _trst_AT;
_AT2 = _trst_AT2;
_AA = _trst_AA;
_medic = _trst_medic;
_selectedUnit = {};

if (count _this == 0) then
{
	_types =  [_leader, _leader, _soldier1, _soldier1, _soldier1, _soldier2, _soldier2, _soldier2, _soldier3, _soldier3, _soldier3, _soldier4, _soldier4, _soldier4, _AT1, _AT2, _sniper, _MG, _MG, _medic, _medic ];
	_cnt = count _types;
	_selectedUnit = _types select (floor (random count _types));
} else {
	_type = _this select 0;
	switch (_type) do 
	{
		case "ISIS_leader": {
			_selectedUnit = _ISIS_leader;	
			};
		default {
			_selectedUnit = _trst_TL;
		};
	};
};
if (true) exitWith {_selectedUnit};
