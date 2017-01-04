while {true} do {
	
	_pilots = 0;
	if (typeof (vehicle player) == "B_Helipilot_F") then {
		_pilots = _pilots + 1;
	};

	if (_pilots >= 3) then {
		haloFlag hideObjectGlobal true;
	}
	else {
		haloFlag hideObjectGlobal false;
	};
	uiSleep 300;
};
