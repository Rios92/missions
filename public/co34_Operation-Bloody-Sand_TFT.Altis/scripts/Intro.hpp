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
#define CT_MAP_MAIN 101 // Static styles
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
#define FontA3 "puristaMedium"

// ####
class RscText
{
	type = CT_STATIC;
	idc = -1;
	style = ST_LEFT;
  
	x = 0.0;
	y = 0.0;
	w = 0.3;
	h = 0.3;
	sizeEx = 0.023;
  
	colorBackground[] = {0.5, 0.5, 0.5, 1};
	colorText[] = { 0, 0, 0, 1 };
	font = FontA3;
  
	text = "";
};

class MyRscStructuredText {
	idc = 445004; 
	type = CT_STRUCTURED_TEXT;  // defined constant
	style = ST_LEFT;            // defined constant
	colorBackground[] = { 0, 0, 0, 0 }; 
	x = 0.1; 
	y = 0.1; 
	w = 0.3; 
	h = 0.2; 
	size = 0.018;
	text = "";
	class Attributes {
	  font = "TahomaB";
	  color = "#ffffff";
	  align = "center";
	  valign = "middle";
	  shadow = false;
	  shadowColor = "#0000";
	  size = "1";
	};
};


class RscTitles
{
	class IntroTxt1
	{
		idd=445000;
		movingEnable=0;
		duration=60;
		name="IntroTxt1";
		controls[]={"background_black","FFS_logo","MissionNmae","text1","BG1","BG2_white"};
		onLoad = "uiNamespace setVariable [""FFS_intro_display"", _this select 0];";
		
		class background_black : RscText
		{
			type=CT_STATIC;	
			style = ST_PICTURE;			
			idc=-1;	 
			colorBackground[]={0,0,0,0.95};
			colorText[]={1,1,1,1};
			font="TahomaB";
			size=1;			 
			text="";
			sizeEx = 0.02;
	  	  	x=SafeZoneX;
	  	  	y=SafeZoneY;
	  	  	w=SafeZoneW;
	  	  	h=SafeZoneH;
		};
	
		class FFS_logo : RscText
		{
			idc=445001;	
			type=CT_STATIC;	
			style = ST_PICTURE;			 
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,1};
			font="TahomaB";
			size=1;			 
			text="";
			sizeEx = 0.02;
	  	  	x=(0.5 * SafeZoneW + SafeZoneX)-0.2;
	  	  	y=(0.5 * SafeZoneH + SafeZoneY)-0.3;
	  	  	w=0.4;
	  	  	h=0.4;
		};
		
		class text1 : MyRscStructuredText
		{
			idc=445002;	
			text="";		
	  	  	x=SafeZoneX;
	  	  	y=(0.5 * SafeZoneH + SafeZoneY)+0.15;
			w=SafeZoneW;
			h=0.1;
			size = 0.05;
		};
		
		class MissionNmae : MyRscStructuredText
		{
			idc=445003;	
			text="";		
			x=SafeZoneX;
	  	  	y=(0.5 * SafeZoneH + SafeZoneY);
			w=SafeZoneW;
			h=0.1;
			size = 0.05;
		};
		class BG1 : RscText
		{
			type=CT_STATIC;	
			style = ST_PICTURE;			
			idc=-1;	 
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,1};
			font="TahomaB";
			size=1;			 
			text="\a3\ui_f\data\gui\cfg\LoadingScreens\loadingnoise_ca.paa";  
			sizeEx = 0.02;
	  	  	x=SafeZoneX;
	  	  	y=SafeZoneY;
	  	  	w=SafeZoneW;
	  	  	h=SafeZoneH;
		};
		class BG2_white : RscText
		{
			type=CT_STATIC;	
			style = ST_PICTURE;			
			idc=-1;	 
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,0.11};
			font="TahomaB";
			size=1;			 
			text="pics\whiteStrip.jpg";	
			sizeEx = 0.02;
	  	  	x=SafeZoneX;
	  	  	y=SafeZoneY;
	  	  	w=SafeZoneW;
	  	  	h=SafeZoneH;
		};
	};
	
	class FFS_logo
	{
		idd=0;
		movingEnable=0;
		duration=150000;
		name="FFS_logo";
		controls[]={"FFS_logo"};

		class FFS_logo : RscText
		{
			type=CT_STATIC;	
			style = ST_PICTURE;			
			idc=-1;	 
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,1};
			font="TahomaB";
			size=1;			 
			text="pics\FFS_logo_white_512.paa";	
			sizeEx = 0.02;
	  	  	x=(0.5 * SafeZoneW + SafeZoneX)-0.25;
	  	  	y=(0.5 * SafeZoneH + SafeZoneY)-0.25;
	  	  	w=0.5;
	  	  	h=0.5;
		};
	};
	
	class testGB
	{
		idd=0;
		movingEnable=0;
		duration=150000;
		name="testGB";
		controls[]={"testGB"};

		class BG1 : RscText
		{
			type=CT_STATIC;	
			style = ST_PICTURE;			
			idc=-1;	 
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,1};
			font="TahomaB";
			size=1;			 
			text="\a3\ui_f\data\gui\cfg\LoadingScreens\loadingnoise_ca.paa";  
			sizeEx = 0.02;
	  	  	x=SafeZoneX;
	  	  	y=SafeZoneY;
	  	  	w=SafeZoneW;
	  	  	h=SafeZoneH;
		};
	};
	
	class debug_mode
	{
		idd=0;
		movingEnable=0;
		duration=150000;
		name="IntroTxt2";
		controls[]={"IntroTxt2"};

		class IntroTxt2 : RscText
		{
			style="16+2+512";
			lineSpacing=0.9;
			text="Debug Mode";		
			x=0;
			y=-0.28;
			w=0.85;
			h=0.85;
			colorBackground[]={0,0,0,0};
			colorText[]={0.3,0.3,0.3,1};
			size=1;
			sizeEx = 0.04;
		};

	};

};
