//---------------- ONLY PILOTS CAN FLY ------------------------------------------------
sleep 2;

waitUntil {!isNull player};

if (typeOf player == "B_soldier_repair_F" or debug_mode) exitwith{}; 

while {alive server} do 
{
 	waitUntil {vehicle player iskindof "helicopter" || vehicle player isKindOf "Plane"};
	if (driver vehicle player == player && typeof vehicle player != "ParachuteWest" ) then {player action ["getout", vehicle player]; hint "You can't pilot helicopters or planes"};
	sleep 5;
};
 




