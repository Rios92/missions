if (captive player) then 
{
	player setCaptive false;
	hint "Debug console:\n\nPlayer is NOT captive now.";
} else {
	player setCaptive true;
	hint "Debug console:\n\nPlayer is captive now.";
};

if (true) exitWith {};