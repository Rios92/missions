//serviceNumber = [2,[q1]]; publicvariable "serviceNumber";
//typeName serviceNumber = ARRAY
//if(isServer and isMultiplayer)exitwith{};
sleep 2;

while {alive server} do 
{
	waituntil {(serviceNumber select 0) > 0};
	 
	switch (serviceNumber select 0) do 
	{
		// DEFAULT MESSAGE
		case 1: {
			[west,"HQ"] sidechat format ["%1",serviceNumber select 1];
			if (logging_mode) then {["inetdClient.sqf",4,format ["CLIENT recieved request: 1 / MESSAGE: %1",serviceNumber select 1]] spawn FFS_FNC_log;};
		};
		// TASK 7 - REPORTER HAS BEEN FOUND
		case 2: {
			[west,"HQ"] sidechat format ["%1",serviceNumber select 1];
			(serviceNumber select 2) enableAI "ANIM"; 
			if (logging_mode) then {["inetdClient.sqf",4,format ["CLIENT recieved request: 2 / REPORTER HAS BEEN FOUND / Reporter: %1",serviceNumber select 2]] spawn FFS_FNC_log;};
		};
		// HELI REQUEST
		case 3: {
			[serviceNumber select 1] execVM "scripts\requestHeliMSG.sqf";
		};
		// TASK 7 - REMOVE ACTION FROM REPORTER
		case 4: {
			removeAllActions (serviceNumber select 1);
			if (logging_mode) then {["inetdClient.sqf",4,format ["CLIENT recieved request: 4 / REMOVE ACTION FROM REPORTER / Reporter: %1",serviceNumber select 2]] spawn FFS_FNC_log;};
		};
		// 
		case 5: {
		};
		// TASK 7 - CHAINED REPORTER AFTER CLEAR AREA
		case 6: {
			removeAllActions (serviceNumber select 1); 
			(serviceNumber select 1) enableAI "ANIM";
		};
		// 
		case 7: {
		};
		// TASK 7 - RESCUED REPORTER SENT HELICOPTER
		case 8: {
			[west,"HQ"] SideChat format ["Helicopter is on the way to extraction point at grid %1. Over.",mapGridPosition getMarkerPos  "t7_extrArea"];
		};
		// DEFAULT MESSAGE WITH LOGGING
		case 9: {
			[west,"HQ"] sidechat format ["%1",serviceNumber select 1];
			["inetdClient.sqf",16,format ["%1",(serviceNumber select 1)]] spawn FFS_FNC_log;
		};
		case 99: {
			[west,"HQ"] SideChat "You have recived ""SERVER > 1 CLIENT"" request";
			["inetdClient.sqf",8,format ["CLIENT recieved request: 99 / You have recived ""SERVER > 1 CLIENT"" request TO: %3 PLAYER: %4",(serviceNumber select 1),player]] spawn FFS_FNC_log;
		};
		// default
		default {
			hint "serviceNumber ERROR";
			if (logging_mode) then {["inetdClient.sqf",16,"serviceNumber ERROR"] spawn FFS_FNC_log;};
		};
	}; 	 
	serviceNumber = [0,""];
}; 
