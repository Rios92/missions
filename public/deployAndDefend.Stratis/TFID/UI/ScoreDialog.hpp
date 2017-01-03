// Desc: Rifle Range Score Dialog
// By: somners
// Version: 1.0
//-----------------------------------------------------------------------------
// IDD's & IDC's
//-----------------------------------------------------------------------------
#define ID_IDD_ScoreDialog 500

#define ID_IDC__RifleRangeTimerLabel 501
#define ID_IDC_RifleRangeScoreLabel 502
#define ID_IDC__RifleRangeTimerText 503
#define ID_IDC_RifleRangeScoreText 504

//-----------------------------------------------------------------------------
// Personalisation - Custom modifications to the standard control classes
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class TFID_ScoreDialog
{
	idd = 1500;
	name = "TFID_ScoreDialog";

	duration = 90000; // 5 second display time
	fadein = 2; // 2 second fade in - 7 seconds in all.

	movingEnable = false;
	onLoad = "uiNamespace setVariable [""TFID_ScoreDialog"", _this select 0];";
	//controlsBackground[] = { SPWN_Background, SPWN_Frame };2

	class controls {

		class WaveLabel : RscText {
			idc = 1501;
			type = 13;
			style = 0;
			size = 0.06;
			x = safeZoneX + (safeZoneW * (1 - (0.5 / SafeZoneW)));
			y = safeZoneY + (safeZoneH * (1 - (0.25 / SafeZoneH)));
			w = 0.209;
			h = 0.06;
			text = "Wave";
			colorBackground[] = {Dlg_Color_Black,.6};
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};
        class WaveText : RscText {
			idc = 1502;
			type = 13;
			style = 0;
			size = 0.06;
			x = safeZoneX + (safeZoneW * (1 - (0.27 / SafeZoneW)));
			y = safeZoneY + (safeZoneH * (1 - (0.25 / SafeZoneH)));
			w = 0.18;
			h = 0.06;
			text = "";
			colorBackground[] = {Dlg_Color_Black,.6};
			class Attributes {
				color = "#00FF00";
				align = "center";
				valign = "middle";
			};
		};

		class TimeLabel : RscText {
			idc = 1503;
			type = 13;
			style = 0;
			size = 0.06;
			x = safeZoneX + (safeZoneW * (1 - (0.5 / SafeZoneW)));
			y = safeZoneY + (safeZoneH * (1 - (0.185 / SafeZoneH)));
			w = 0.209;
			h = 0.06;
			text = "Time left";
			colorBackground[] = {Dlg_Color_Black,.6};
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};
        class TimeText : RscText {
			idc = 1504;
			type = 13;
			style = 0;
			size = 0.06;
			x = safeZoneX + (safeZoneW * (1 - (0.27 / SafeZoneW)));
			y = safeZoneY + (safeZoneH * (1 - (0.185 / SafeZoneH)));
			w = 0.18;
			h = 0.06;
			text = "";
			colorBackground[] = {Dlg_Color_Black,.6};
			class Attributes {
				color = "#00FF00";
				align = "center";
				valign = "middle";
			};
		};

		class ScoreLabel : RscText {
			idc = 1505;
			type = 13;
			style = 0;
			size = 0.06;
			x = safeZoneX + (safeZoneW * (1 - (0.5 / SafeZoneW)));
			y = safeZoneY + (safeZoneH * (1 - (0.12 / SafeZoneH)));
			w = 0.209;
			h = 0.06;
			text = "Points";
			colorBackground[] = {Dlg_Color_Black,.6};
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};
		class ScoreText : RscText {
			idc = 1506;
			type = 13;
			style = 0;
			size = 0.06;
			x = safeZoneX + (safeZoneW * (1 - (0.27 / SafeZoneW)));
			y = safeZoneY + (safeZoneH * (1 - (0.12 / SafeZoneH)));
			w = 0.18;
			h = 0.06;
			text = "";
			colorBackground[] = {Dlg_Color_Black,.6};
			class Attributes {
				color = "#00FF00";
				align = "center";
				valign = "middle";
			};
		};
	};
};
