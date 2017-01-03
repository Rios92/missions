if (!IntroFinish and !debug_mode) then
{
	waitUntil {preloadEnd};
	titleRsc ["IntroTxt1", "BLACK", 0];
	disableSerialization;
	_display = uiNamespace getVariable "FFS_intro_display";
	_pic  = _display displayCtrl 445001;
	_text1  = _display displayCtrl 445002;
	_missionName  = _display displayCtrl 445003;
	sleep 1;
	playsound "intro_sound";
	sleep 0.4;

	_pic ctrlSetText "pics\FFS_logo_white_512.paa";
	_text1 ctrlSetStructuredText parseText "<t size='1.00' font='TahomaB' >P R E S E N T S</t>";
	_i=1;
	_timer = time + 2.5;
	while {time < _timer} do
	{
		_i=_i+0.018;
		_text1 ctrlSetStructuredText parseText format ["<t size='%1' font='TahomaB' >P R E S E N T S</t>",_i];
		sleep 0.001;
	};

	_pic ctrlSetText "";
	_text1 ctrlSetText "";
	playsound "intro_sound";
	sleep 0.4;

	_missionName ctrlSetStructuredText parseText "<t size='1.30' font='TahomaB' >O P E R A T I O N   B L O O D Y  S A N D</t>";
	_i=1.3;
	_timer = time + 2.15;
	while {time < _timer} do
	{
		_i=_i+0.007;
		_missionName ctrlSetStructuredText parseText format ["<t size='%1' font='TahomaB' >O P E R A T I O N   B L O O D Y  S A N D</t>",_i];
		sleep 0.001;
	};
	sleep 1.5;
	titleText ["", "BLACK IN", 1];
	
	if (playIntroISIS) then
	{
		_script_handler = execVM "scripts\intro_ISIS.sqf";
		waitUntil { scriptDone _script_handler };
	};
	
	IntroFinish = true;
	sleep 1;
	//[ [ [format ["%1",getText (missionconfigfile >> "onLoadName")],"<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"], [format [" Authors: %1",getText (missionconfigfile >> "author")]], [format ["Date: %3.%2.%1",date select 0,date select 1,date select 2], "<t align = 'center' shadow = '1' size = '0.7' font='puristaMedium'>%1</t>", 90] ] ,0.7, 0.8, "<t align = 'center' shadow = '1' size = '1.3'>%1</t>" ] spawn BIS_fnc_typeText;
} else {
	IntroFinish = true;
};

if (true) exitWith {};











