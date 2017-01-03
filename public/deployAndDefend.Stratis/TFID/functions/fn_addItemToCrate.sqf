params ["_className", "_box"];
private ["_category"];

_category = [_className] call TFID_fnc_getCategory;

switch(_category) do {
	case "weapons": {// type 2= secondary  type 4= handgun type 1= primary
		_box addWeaponCargoGlobal [_className, 1];
	};
	case "magazines": {
		_box addMagazineCargoGlobal [_className, 1];
	};
	case "items": { // Types:  ItemCore = 131072 ;DetectorCore = 4 ; Binocular = 4096 ; Laserdes =
		_box addItemCargoGlobal [_className, 1];
	};
	case "backpacks": {
		_box addBackpackCargoGlobal [_className, 1];
	};
	case "glasses": {
		_box addItemCargoGlobal [_className, 1];
	};
};
