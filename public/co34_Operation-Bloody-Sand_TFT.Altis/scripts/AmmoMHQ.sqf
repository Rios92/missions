_ammo = _this;
		
if(isServer) then 
{
	clearMagazineCargoGlobal _ammo;
	clearItemCargoGlobal _ammo; 
	clearWeaponCargoGlobal _ammo;
	clearBackpackCargoGlobal _ammo;
	
	_ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",60];
	_ammo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",60];
	_ammo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",60];
	_ammo addMagazineCargoGlobal ["20Rnd_762x51_Mag",60];
	_ammo addMagazineCargoGlobal ["16Rnd_9x21_Mag",60];
	_ammo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",20];
	_ammo addMagazineCargoGlobal ["HandGrenade",20];
	_ammo addMagazineCargoGlobal ["SmokeShellRed",10];
	_ammo addMagazineCargoGlobal ["SmokeShellGreen",10];
	_ammo addMagazineCargoGlobal ["DemoCharge_Remote_Mag",10];
	
	_ammo addItemCargoGlobal ["FirstAidKit",30];
	_ammo addItemCargoGlobal ["NVGoggles",20];
};		

if (true) exitWith {};