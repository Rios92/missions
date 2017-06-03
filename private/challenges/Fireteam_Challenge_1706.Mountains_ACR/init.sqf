if(isServer) then {

	//set all civilians to flee on hearing gunfire
	null = [] execVM "civsFlee.sqf";
    {
		_x addCuratorEditableObjects [allUnits + vehicles, true];
    } forEach allCurators;
	{
		_x lock true;
	} forEach vics;
	timer = 0;
	publicVariable "timer";
	message = "";
	hintText = "";
	publicVariable "message";
};
