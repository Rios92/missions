/*
 * Author: Frankie
 * Adds extra supplies to vehicles 100m around respawn_west marker
 *
 * Arguments:
 * -
 *
 * Return Value:
 * -
 *
 * Example:
 * call TFT_fnc_vehEquipment;
 */

private _vics = nearestObjects [getMarkerPos "respawn_west", ["AllVehicles"], 100];

/* TODO
{
    private _type = typeOf _x;

    // vehicle side == west
    if (getnumber (configFile >> "cfgVehicles" >> _type >> "scope") == 2) then {
        clearItemCargoGlobal _x;
        clearMagazineCargoGlobal _x;
        clearBackpackCargoGlobal _x;
        clearWeaponCargoGlobal _x;
        _x addWeaponCargoGlobal ["hlc_rifle_Colt727",1];
        _x addWeaponCargoGlobal ["tf47_at4_heat",2];
        _x addItemCargoGlobal ["ACE_M26_Clacker",1];
        _x addItemCargoGlobal ["NVGoggles_OPFOR",2];
        _x addItemCargoGlobal ["HandGrenade",15];
        _x addItemCargoGlobal ["SmokeShell",15];
        _x addItemCargoGlobal ["SmokeShellGreen",4];
        _x addItemCargoGlobal ["DemoCharge_Remote_Mag",6];
        _x addItemCargoGlobal ["ACE_HandFlare_Green",6];
        _x addItemCargoGlobal ["Chemlight_green",4];
        _x addItemCargoGlobal ["ACE_EntrenchingTool",1];
        _x addItemCargoGlobal ["hlc_30rnd_556x45_EPR",40];
        _x addItemCargoGlobal ["hlc_200rnd_556x45_M_SAW",4];
        _x addItemCargoGlobal ["hlc_100Rnd_762x51_Barrier_M60E4",4];
        _x addItemCargoGlobal ["hlc_20Rnd_762x51_B_M14",10];
        _x addItemCargoGlobal ["29rnd_300BLK_STANAG",15];
        _x addBackpackCargoGlobal ["B_AssaultPack_cbr",2];
    };
    // medical vehicle
    if (_type in ["B_mas_HMMWV_MEV_des","B_mas_HMMWV_MEV","B_mas_cars_LR_Med","B_mas_UH60M_MEV","B_Truck_01_medical_F"]) then {
        {
            _x addItemCargoGlobal ["ACE_fieldDressing",20];
            _x addItemCargoGlobal ["ACE_elasticBandage",30];
            _x addItemCargoGlobal ["ACE_tourniquet",10];
            _x addItemCargoGlobal ["ACE_morphine",10];
            _x addItemCargoGlobal ["ACE_epinephrine",10];
            _x addItemCargoGlobal ["ACE_salineIV_500",6];
            _x addItemCargoGlobal ["ACE_quikclot",10];
        } forEach (everybackpack _x);
    };
} forEach _vics;*/
