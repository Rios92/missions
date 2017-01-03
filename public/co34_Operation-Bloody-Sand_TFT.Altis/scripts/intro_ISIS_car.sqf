// [this,driver this, gunner this] execVM "scripts\intro_ISIS_car.sqf"; 

if (isServer) then
{
	if (_this select 0 == "soldier") then
	{
		_soldier = _this select 1;
		
		// - - - - - SOLDIER - - - - - -
		comment "Exported from Arsenal by FriZY";

		comment "Remove existing items";
		removeAllWeapons _soldier;
		removeAllItems _soldier;
		removeAllAssignedItems _soldier;
		removeUniform _soldier;
		removeVest _soldier;
		removeBackpack _soldier;
		removeHeadgear _soldier;
		removeGoggles _soldier;

		comment "Add containers";
		_soldier forceAddUniform "U_BG_Guerrilla_6_1";
		_soldier addVest "V_BandollierB_rgr";
		for "_i" from 1 to 6 do {_soldier addItemToVest "30Rnd_65x39_caseless_green";};
		_soldier addGoggles "G_Balaclava_blk";

		comment "Add weapons";
		_soldier addWeapon "arifle_Katiba_C_F";

		comment "Add items";
		_soldier linkItem "ItemMap";

		comment "Set identity";
		_soldier setFace "GreekHead_A3_09";
		_soldier setSpeaker "Male03PER";
		[_soldier,"FFS_ISIS"] call bis_fnc_setUnitInsignia;
	}else
	{
		_car = _this select 1;
		_driver = _this select 2;
		_gunner = _this select 3;	
		
		// - - - - - GUNER - - - - - -
		comment "Remove existing items";
		removeAllWeapons _gunner;
		removeAllItems _gunner;
		removeAllAssignedItems _gunner;
		removeUniform _gunner;
		removeVest _gunner;
		removeBackpack _gunner;
		removeHeadgear _gunner;
		removeGoggles _gunner;

		comment "Add containers";
		_gunner forceAddUniform "U_BG_leader";
		_gunner addItemToUniform "FirstAidKit";
		for "_i" from 1 to 2 do {_gunner addItemToUniform "30Rnd_65x39_caseless_green";};
		_gunner addVest "V_BandollierB_blk";
		_gunner addItemToVest "30Rnd_65x39_caseless_green";
		_gunner addHeadgear "H_ShemagOpen_khk";

		comment "Add weapons";
		_gunner addWeapon "arifle_Katiba_C_F";

		comment "Add items";
		_gunner linkItem "ItemMap";

		comment "Set identity";
		_gunner setFace "GreekHead_A3_09";
		_gunner setSpeaker "Male03PER";


		// - - - - - DRIVER - - - - - -
		comment "Exported from Arsenal by FriZY";

		comment "Remove existing items";
		removeAllWeapons _driver;
		removeAllItems _driver;
		removeAllAssignedItems _driver;
		removeUniform _driver;
		removeVest _driver;
		removeBackpack _driver;
		removeHeadgear _driver;
		removeGoggles _driver;

		comment "Add containers";
		_driver forceAddUniform "U_BG_Guerrilla_6_1";
		_driver addVest "V_BandollierB_rgr";
		for "_i" from 1 to 6 do {_driver addItemToVest "30Rnd_65x39_caseless_green";};
		_driver addGoggles "G_Balaclava_blk";

		comment "Add weapons";
		_driver addWeapon "arifle_Katiba_C_F";

		comment "Add items";
		_driver linkItem "ItemMap";

		comment "Set identity";
		_driver setFace "GreekHead_A3_09";
		_driver setSpeaker "Male03PER";
		[_driver,"FFS_ISIS"] call bis_fnc_setUnitInsignia;
		
		_flag = "FlagChecked_F" createVehicle getpos _car; 
		_flag setFlagTexture "pics\ISIS_flag3.jpg";
		_flag attachTo [_car, [0.69, -0.04, 0] ];
	};
	
};

if (true) exitWith {};






