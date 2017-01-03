_ammo = _this;
_ammo allowDamage false;
sleep 1;
		
switch (FFS_ammobox_sys) do 
{
	case "Standard": 
	{
		if(isServer) then 
		{
			clearMagazineCargoGlobal _ammo;
			clearItemCargoGlobal _ammo; 
			clearWeaponCargoGlobal _ammo;
			clearBackpackCargoGlobal _ammo;
			
			_ammo addWeaponCargoGlobal ["arifle_MX_F",30];
			_ammo addWeaponCargoGlobal ["arifle_MX_GL_F",30];
			_ammo addWeaponCargoGlobal ["arifle_MX_SW_F",30];
			_ammo addWeaponCargoGlobal ["LMG_Mk200_F",30];
			_ammo addWeaponCargoGlobal ["srifle_EBR_F",30];
			_ammo addWeaponCargoGlobal ["hgun_Pistol_heavy_01_F",30];
			
			_ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",120];
			_ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer",120];
			_ammo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",120];
			_ammo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer",120];
			_ammo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",120];
			_ammo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer",120];
			_ammo addMagazineCargoGlobal ["20Rnd_762x51_Mag",120];
			_ammo addMagazineCargoGlobal ["16Rnd_9x21_Mag",120];
			_ammo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",20];
			_ammo addMagazineCargoGlobal ["HandGrenade",20];
			_ammo addMagazineCargoGlobal ["SmokeShell",20];
			_ammo addMagazineCargoGlobal ["SmokeShellRed",20];
			_ammo addMagazineCargoGlobal ["SmokeShellGreen",20];
			_ammo addMagazineCargoGlobal ["SmokeShellBlue",20];
			_ammo addMagazineCargoGlobal ["SmokeShellYellow",20];
			_ammo addMagazineCargoGlobal ["DemoCharge_Remote_Mag",20];
			
			_ammo addItemCargoGlobal ["FirstAidKit",100];
			_ammo addItemCargoGlobal ["Rangefinder",30];
			_ammo addItemCargoGlobal ["optic_SOS",50];
			_ammo addItemCargoGlobal ["optic_Hamr",50];
			_ammo addItemCargoGlobal ["NVGoggles",50];
			
			_ammo addBackpackCargoGlobal ["B_AssaultPack_khk",30];
			_ammo addBackpackCargoGlobal ["B_Bergen_sgg",30];					
			
			if (logging_mode) then {["AmmoBox.sqf",2,format ["Ammo Box System: %1",FFS_ammobox_sys]] spawn FFS_FNC_log;};
		};		
	};
	case "VAS": 
	{
		clearMagazineCargoGlobal _ammo;
		clearItemCargoGlobal _ammo; 
		clearWeaponCargoGlobal _ammo;
		clearBackpackCargoGlobal _ammo;
		_ammo addAction["<t color='#ff1111'>Virtual Ammobox</t>", "VAS\open.sqf"];
		// https://community.bistudio.com/wiki/Arsenal
		_ammo addaction ["<t color='#ffff00'>Virtual Arsenal</t>", { ["Open",true] call BIS_fnc_arsenal; }, [], 1, false, true, "","alive _target"];
		if (logging_mode and isServer) then {["AmmoBox.sqf",2,format ["Ammo Box System: %1",FFS_ammobox_sys]] spawn FFS_FNC_log;};
	};
	case "Characters": 
	{
		_ammo addAction ["<t color='#00CC00'> Machinegunner</t>","scripts\vybavenie.sqf", ["kulomet"]];
		_ammo addAction ["<t color='#00CC00'> AT-Rifleman</t>","scripts\vybavenie.sqf", ["at"]];
		_ammo addAction ["<t color='#00CC00'> Sniper</t>","scripts\vybavenie.sqf", ["ostrostrelec"]];
		_ammo addAction ["<t color='#00CC00'> Rifleman</t>","scripts\vybavenie.sqf", ["strelec"]];
		_ammo addAction ["<t color='#00CC00'> Radio-Rifleman</t>","scripts\vybavenie.sqf", ["radista"]];
		_ammo addAction ["<t color='#00CC00'> Engineer</t>","scripts\vybavenie.sqf", ["zenista"]];
		_ammo addAction ["<t color='#00CC00'> Medic</t>","scripts\vybavenie.sqf", ["medik"]];
		
		if(isServer) then 
		{
			clearMagazineCargoGlobal _ammo;
			clearItemCargoGlobal _ammo; 
			clearWeaponCargoGlobal _ammo;
			clearBackpackCargoGlobal _ammo;
		
			_ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",120];
			_ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer",120];
			_ammo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",120];
			_ammo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer",120];
			_ammo addMagazineCargoGlobal ["20Rnd_762x51_Mag",120];
			_ammo addMagazineCargoGlobal ["16Rnd_9x21_Mag",120];
			_ammo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",20];
			_ammo addMagazineCargoGlobal ["HandGrenade",20];
			_ammo addMagazineCargoGlobal ["SmokeShell",20];
			_ammo addMagazineCargoGlobal ["SmokeShellRed",20];
			_ammo addMagazineCargoGlobal ["SmokeShellGreen",20];
			_ammo addMagazineCargoGlobal ["SmokeShellBlue",20];
			_ammo addMagazineCargoGlobal ["SmokeShellYellow",20];
			_ammo addMagazineCargoGlobal ["DemoCharge_Remote_Mag",20];
			
			_ammo addItemCargoGlobal ["FirstAidKit",100];
			_ammo addItemCargoGlobal ["Rangefinder",30];
			_ammo addItemCargoGlobal ["optic_SOS",50];
			_ammo addItemCargoGlobal ["optic_Hamr",50];
			_ammo addItemCargoGlobal ["NVGoggles",50];
			
			if (logging_mode) then {["AmmoBox.sqf",2,format ["Ammo Box System: %1",FFS_ammobox_sys]] spawn FFS_FNC_log;};
		};
	};
	default {["AmmoBox.sqf",16,"WRONG INPUT of variable FFS_ammobox_sys!!!"] spawn FFS_FNC_log;};
};
	
if (true) exitWith {};