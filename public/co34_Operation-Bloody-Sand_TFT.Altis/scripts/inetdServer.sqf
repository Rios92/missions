//serviceNumberServer = [1,"TEST"]; publicVariableServer "serviceNumberServer";
//typeName serviceNumberServer = ARRAY
//if(isServer and isMultiplayer)exitwith{};
sleep 2;

while {alive server} do 
{
	waituntil {(serviceNumberServer select 0) > 0};
	 
	switch (serviceNumberServer select 0) do 
	{
		// DEFAULT MESSAGE
		case 1: {
			if (logging_mode) then {["inetdServer.sqf",2,format ["SERVER recieved request: 1 / SERVER > CLIENTS / TEXT:%3",serviceNumberServer select 1]] spawn FFS_FNC_log;};
		};
		// UPDATE VARIABLE
		case 2: {	
			(owner (serviceNumberServer select 1)) publicVariableClient (serviceNumberServer select 2);
			if (logging_mode) then {["inetdServer.sqf",4,format ["SERVER recieved request: 2 / SERVER >  1CLIENT / Update reporterFound: %1 / Client : %2 ",reporterFound,(serviceNumberServer select 1)]] spawn FFS_FNC_log;};
		};
		// TASK 7 - CHAGE REPORTER BEHAVIOUR
		case 3: { 
			reporter enableAI "ANIM"; 
			reporter setCaptive false;
			[reporter," U.S. reporter"] execVM "tasks\t7_reporterMarker.sqf";
			if (logging_mode) then {["inetdServer.sqf",4,format ["SERVER recieved request: 3 / SERVER > CLIENTS / change of reporter behaviour for reporter: %1 ",reporter]] spawn FFS_FNC_log;};
		};
		// 
		case 4: {
		};
		// TEST  1 CLIENT MESSAGE
		// serviceNumberServer = [5,player]; publicVariableServer "serviceNumberServer";
		case 5: { 
			serviceNumber = [99, (serviceNumberServer select 1)]; (owner (serviceNumberServer select 1)) publicVariableClient "serviceNumber";
			if (logging_mode) then {["inetdServer.sqf",4,format ["SERVER recieved request: 5 from %1 / SERVER > 1 CLIENT",(serviceNumberServer select 1)]] spawn FFS_FNC_log;};
		};
		// TEST
		// serviceNumberServer = [6,[q1,player]]; publicVariableServer "serviceNumberServer";
		case 6: { 
			hint "server 6";
			if (logging_mode) then {["inetdServer.sqf",4,format ["SERVER recieved request: 6 / SERVER > 1 CLIENT / %1",(serviceNumberServer select 1)]] spawn FFS_FNC_log;};
			{_x playMove "AmovPercMstpSsurWnonDnon"} foreach (serviceNumberServer select 1); // AinjPfalMstpSnonWnonDnon_carried_Up
			{_x disableAI "ANIM"} foreach (serviceNumberServer select 1); 
			{_x setCaptive true} foreach (serviceNumberServer select 1);
		};
		// 
		case 7: { 
		};
		// LOGGING MESSAGE
		case 8: {
			["inetdServer.sqf",serviceNumberServer select 1,format ["%1",serviceNumberServer select 2]] spawn FFS_FNC_log;
		};
		// SEND TO REQUESTOR (1 client) VARIABLE FROM SERVER
		// serviceNumberServer = [9,"CountGrpeast",player]; publicVariableServer "serviceNumberServer";
		case 9: { 
			[(serviceNumberServer select 1),(serviceNumberServer select 2)] spawn {
				_string = _this select 0;
				_client = _this select 1;
				_clientID = owner _client;
				_result = call compile format ["%1",_string];
				serviceNumber = [1,_result];
				_clientID publicVariableClient "serviceNumber";
				_clientID publicVariableClient _string;
				if (logging_mode) then {["inetdServer.sqf",4,format ["SERVER recieved request: 9 / STRING: %1",_string]] spawn FFS_FNC_log;};
			};
		};
		// REMOTE EXEC ON SERVER - CODE IS RECIEVED FROM CLIENT
		// serviceNumberServer = [10,{code}]; publicVariableServer "serviceNumberServer";
		case 10: { 
			[serviceNumberServer select 1] spawn {
				_code = call compile (_this select 0);
				call _code;				
				if (logging_mode) then {["inetdServer.sqf",4,format ["SERVER recieved request: 10 / SERVER EXEC: %1 / %2 ",_code,typeName _code]] spawn FFS_FNC_log;};
			};
		};
		// 
		case 11: {		
		};
		// default
		default {
			hint "serviceNumberServer ERROR";
			if (logging_mode) then {["inetdServer.sqf",16,"serviceNumber ERROR"] spawn FFS_FNC_log;};
		};
	}; 	 
	serviceNumberServer = [0,""];
}; 
