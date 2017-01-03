params ["_className"];
private ["_details", "_cfg", "_category", "_type", "_itemInfo", "_cfg", "_vc"];

_details = [_className] call TFID_fnc_VAS_fetchCfgDetails;
_category = "";
if (count _details > 0) then {
	_cfg = _details select 6;
	switch (_cfg) do {
		case "CfgWeapons": {
			_details = [_className,_cfg] call TFID_fnc_VAS_fetchCfgDetails;
			_type = _details select 4;
			_itemInfo = _details select 5;
			switch (true) do
			{
				case (_type in [1,2,4,5,4096]):
				{
						if(_itemInfo == 616 && _type == 4096) then
						{
							_category = "items";
						}
							else
						{
							_category = "weapons";
						};
				};

				case (_type == 131072):
				{
					_category = "items";
				};
				default {
					_category = "items";
				};
			};
		};
		case "CfgMagazines": {
			_category = "magazines";
		};
		case "CfgVehicles": {
			_details = [_className,_cfg] call TFID_fnc_VAS_fetchCfgDetails;
			_type = _details select 4;
			if(_type == "Backpacks") then
			{
				_category = "backpacks";
			};
			_vc = ["Autonomous","Car","Armored","Support","Air","Ship","Submarine"];
			if(_type in _vc) then
			{
				_category = "vehicles";
			};

		};
		case "CfgGlasses": {
			_category = "glasses";
		};
	};
};

_category
