#define ReadAndWrite		0
#define ReadAndCreate		1
#define ReadOnly		2
#define ReadOnlyVerified		3

#define true	1
#define false	0

#define private		0
#define protected		1
#define public		2

#define VSoft		0
#define VArmor		1
#define VAir		2

#define LockNo		0
#define LockCadet		1
#define LockYes		2

#define TEast		0
#define TWest		1
#define TGuerrila		2
#define TCivilian		3
#define TSideUnknown		4
#define TEnemy		5
#define TFriendly		6
#define TLogic		7

// Control types 
#define CT_STATIC 0 
#define CT_BUTTON 1 
#define CT_EDIT 2 
#define CT_SLIDER 3 
#define CT_COMBO 4 
#define CT_LISTBOX 5 
#define CT_TOOLBOX 6 
#define CT_CHECKBOXES 7 
#define CT_PROGRESS 8 
#define CT_HTML 9 
#define CT_STATIC_SKEW 10 
#define CT_ACTIVETEXT 11 
#define CT_TREE 12 
#define CT_STRUCTURED_TEXT 13 
#define CT_CONTEXT_MENU 14 
#define CT_CONTROLS_GROUP 15 
#define CT_SHORTCUT_BUTTON 16 

// Arma 2 - textured button 
#define CT_XKEYDESC 40 
#define CT_XBUTTON 41 
#define CT_XLISTBOX 42 
#define CT_XSLIDER 43 
#define CT_XCOMBO 44 
#define CT_ANIMATED_TEXTURE 45 
#define CT_OBJECT 80 
#define CT_OBJECT_ZOOM 81 
#define CT_OBJECT_CONTAINER 82 
#define CT_OBJECT_CONT_ANIM 83 
#define CT_LINEBREAK 98 
#define CT_USER 99 
#define CT_MAP 100 
#define CT_MAP_MAIN 101 
#define CT_List_N_Box 102 

// Arma 2 - N columns list box 
// Static styles 
#define ST_POS 0x0F 
#define ST_HPOS 0x03 
#define ST_VPOS 0x0C 
#define ST_LEFT 0x00 
#define ST_RIGHT 0x01 
#define ST_CENTER 0x02 
#define ST_DOWN 0x04 
#define ST_UP 0x08 
#define ST_VCENTER 0x0c 
#define ST_TYPE 0xF0 
#define ST_SINGLE 0 
#define ST_MULTI 16 
#define ST_TITLE_BAR 32 
#define ST_PICTURE 48 
#define ST_FRAME 64 
#define ST_BACKGROUND 80 
#define ST_GROUP_BOX 96 
#define ST_GROUP_BOX2 112 
#define ST_HUD_BACKGROUND 128 
#define ST_TILE_PICTURE 144 
#define ST_WITH_RECT 160 
#define ST_LINE 176 
#define ST_SHADOW 0x100 
#define ST_NO_RECT 0x200 
#define ST_KEEP_ASPECT_RATIO 0x800 
#define ST_TITLE ST_TITLE_BAR + ST_CENTER 

// Slider styles 
#define SL_DIR 0x400 
#define SL_VERT 0 
#define SL_HORZ 0x400 
#define SL_TEXTURES 0x10 

// Listbox styles 
#define LB_TEXTURES 0x10 
#define LB_MULTI 0x20 
#define FontM "Zeppelin32"

class DebugCRscText {
	access = ReadAndWrite;
	type = VSoft;
	idc = -1;
	style = 0;
	w = 0.1;
	h = 0.05;
	font = "puristaMedium";
	sizeEx = 0.04;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	text = "";
	fixedWidth = 0;
	shadow = false;
};

class DebugCRscEdit {
	access = ReadAndWrite;
	type = VAir;
	style = 0;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = {0, 0, 0, 0};
	colorDisabled[] = {0.2,0.15,0.1,1};
	colorText[] = {1, 1, 1, 1};
	colorSelection[] = {1, 1, 1, 0.25};
	font = "puristaMedium";
	sizeEx = 0.04;
	autocomplete = "";
	text = "";
	size = 0.2;
	shadow = false;
};

class DebugCRscButton {
	access = ReadAndWrite;
	type = VArmor;
	style = 0;
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.1;
	text = "";
	font = "puristaMedium";
	sizeEx = 0.025;
	colorText[] = {0.90, 0.90, 0.90, 1};
	// 0.69, 0.74, 0.54, 1
	// 0.57, 0.62, 0.44, 1
	colorDisabled[] = {0.20, 0.20, 0.20, 0.8};
	colorBackground[] = {0.20, 0.20, 0.20, 0.8};
	colorBackgroundDisabled[] = {0.20, 0.20, 0.20, 0.8};
	colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.57])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.62])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.44])", 1};
	offsetX = 0.0035;
	offsetY = 0.0035;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorFocused[] = {0.20, 0.20, 0.20, 0.8};
	colorShadow[] = {0, 0, 0, 1};
	shadow = false;
	colorBorder[] = {0, 0, 0, 1};
	borderSize = 0.0;
	soundEnter[] = {"", 0.1, 1};
	soundPush[] = {"", 0.1, 1};
	soundClick[] = {"", 0.1, 1};
	soundEscape[] = {"", 0.1, 1};
};

class DebugCRscGroupBox2
{

	type = 0;
	idc = -1;
	style = 112;
	text = "";
	colorBackground[] = {1, 1, 1, 0.6};
	colorText[] = {0, 0, 0, 0};
	font = "puristaMedium";
	sizeEx = 0.02;
};


//-------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------

class stra_debug
{
	idd = 316000;
	movingEnable = 1;
	onLoad = "_sqf = 'load' spawn compile preprocessfilelinenumbers 'dlg_debug\DBG_init.sqf'; stra_debug_run = true";
	onUnload = "_sqf = 'unload' call compile preprocessfilelinenumbers 'dlg_debug\DBG_init.sqf'; stra_debug_run = false; ";
	class Controls
	{

		class Drag: DebugCRscGroupBox2
		{
			x=0.110;
			y=0.070;
			w=0.780;
			h=0.04;
			//colorbackground[] = {0,0,0,0.8};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.57])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.62])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.44])", 1};
			colortext[] = {0,0,0,0};
			moving = 1;
		};
		class Header : DebugCRscText
		{
			style=2;
			type = CT_STATIC;
			x=0.110;
			y=0.070;
			w=0.780;
			h=0.04;
			text="Debug Console  (modified by FriZY )";
			sizeEx = 0.04;
			colortext[]={0.9,0.9,0.9,1};
		};

		class SubBackground1 : DebugCRscGroupBox2
		{
			x=0.110;
			y=0.115;
			w=0.780;
			h=0.410;
			style=128;
			colorBackground[] = {0, 0, 0, 0.85};
		};
		class SubBackground2 : SubBackground1
		{
			x=0.110;
			y=0.530;
			w=0.780;
			h=0.370;
			style=128;
		};
		class SubBackground3 : SubBackground1
		{
			x = 0.110;
			y = 0.905;
			w=0.780;
			h=0.1480;
			style=128;
		};

		//----- Value check -----
		class ValueInput1 : DebugCRscEdit
		{
			IDC = 316011;
			//style = 16
			x = 0.120;
			y = 0.130;
			w = 0.760;
			h = 0.04;
			autocomplete = "scripting";
		};
		class ValueOutput1 : DebugCRscEdit
		{
			IDC = 316012;
			x = 0.120;
			y = 0.170-0.001;
			w = 0.760;
			h = 0.04;
		};

		class ValueInput2 : ValueInput1
		{
			IDC = 316021;
			y = 0.230;
		};
		class ValueOutput2 : ValueOutput1
		{
			IDC = 316022;
			y = 0.270-0.001;
		};

		class ValueInput3 : ValueInput1
		{
			IDC = 316031;
			y = 0.330;
		};
		class ValueOutput3 : ValueOutput1
		{
			IDC = 316032;
			y = 0.370-0.001;
		};

		class ValueInput4 : ValueInput1
		{
			IDC = 316041;
			y = 0.430;
		};
		class ValueOutpu4 : ValueOutput1
		{
			IDC = 316042;
			y = 0.470-0.001;
		};

		//----- Command lines -----
		class CommandInput1 : DebugCRscEdit
		{
			IDC = 316101;
			//style = 16;
			x = 0.120;
			y = 0.545;
			w = 0.695;
			h = 0.04;
			autocomplete = "scripting";
		};
		class CommandButton1 : DebugCRscButton
		{
			idc = -1;
			x = 0.820;
			y = 0.545;
			w = 0.060;
			h = 0.04;
			text = "Exec";
			action = "call compile (ctrlText 316101);";
			default = 1;
		};

		class CommandInput2 : CommandInput1
		{
			IDC = 316102;
			y = 0.595;
		};
		class CommandButton2 : CommandButton1
		{
			y = 0.595;
			action = "call compile (ctrlText 316102);";
		};

		class CommandInput3 : CommandInput1
		{
			IDC = 316103;
			y = 0.645;
		};
		class CommandButton3 : CommandButton1
		{
			y = 0.645;
			action = "call compile (ctrlText 316103);";
		};

		class CommandInput4 : CommandInput1
		{
			IDC = 316104;
			y = 0.695;
		};
		class CommandButton4 : CommandButton1
		{
			y = 0.695;
			action = "call compile (ctrlText 316104);";
		};

		class CommandInput5 : CommandInput1
		{
			IDC = 316105;
			y = 0.745;
		};
		class CommandButton5 : CommandButton1
		{
			y = 0.745;
			action = "call compile (ctrlText 316105);";
		};

		class CommandInput6 : CommandInput1
		{
			IDC = 316106;
			y = 0.795;
		};
		class CommandButton6 : CommandButton1
		{
			y = 0.795;
			action = "call compile (ctrlText 316106);";
			default = true;
		}; 
		
		class CommandInput7 : CommandInput1
		{
			IDC = 316107;
			y = 0.845;
		};
		class CommandButton7 : CommandButton1
		{
			y = 0.845;
			text = "Prfmnc";
			action = "[""call compile (ctrlText 316107);""] call BIS_fnc_codePerformance;";
			default = true;
		}; 
		
		/*
			x = 0.110;
			y = 0.905;
			w=0.780;
			h=0.1480;
		*/
		
		class button1_1 : DebugCRscButton
		{
			idc = -1;
			x = 0.120;
			y = 0.92;
			w = 0.1825;
			h = 0.05;
			sizeEx = 0.035;
			//colorBackground[] = {0.2,0.15,0.1,1};
			text = "Teleport"; 
			action = "closeDialog 0; execVM ""dlg_debug\teleport.sqf""; ";
			default = true;
		};
		
		class button1_2 : button1_1
		{
			x = 0.120 + (0.1925 * 1);
			text = "Heal";
			action = "player setdammage 0;closeDialog 0; hint ""Debug console:\n\nPlayer was healed."";";
		};
		
		class button1_3 : button1_1
		{
			x = 0.120 + (0.1925 * 2);
			text = "Camera";
			action = "closeDialog 0; [player] call BIS_fnc_cameraOld;";
		}; 
		
		class button1_4 : button1_1
		{
			x = 0.120 + (0.1925 * 3);
			text = "Debug Info";
			action = "execVM ""dlg_debug\debug_info.sqf""; ";
		}; 
		
		class button2_1 : button1_1
		{
			x = 0.120 + (0.1925 * 0);
			y = 0.985;
			text = "Kill EAST";
			action = "closeDialog 0; [""EAST""] execVM ""dlg_debug\kill.sqf""; ";
		}; 
		
		class button2_2 : button2_1
		{
			x = 0.120 + (0.1925 * 1);
			text = "Kill GUER";
			action = "closeDialog 0; [""GUER""] execVM ""dlg_debug\kill.sqf""; ";
		};
		
		class button2_3 : button2_1
		{
			x = 0.120 + (0.1925 * 2);
			text = "Captive";
			action = "execVM ""dlg_debug\captive.sqf""; ";
		};
		
		class button2_4 : button2_1
		{
			x = 0.120 + (0.1925 * 3);
			text = "Exit";
			action = "closeDialog 0;";
		};
	};
};