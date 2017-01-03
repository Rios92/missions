// Desc: A scoreboard dialog
// By: somners
// Version: 1.0
//-----------------------------------------------------------------------------
// Includes
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// IDD's & IDC's
//-----------------------------------------------------------------------------
#define TFID_IDD_ArmoryDialog 600

#define TFID_IDC_Map 601
#define TFID_IDC_Name 630

#define TFID_IDD_AdminDialog 700

#define TFID_IDD_PayrollDialog 800

#define TFID_IDD_PasswordDialog 500
//-----------------------------------------------------------------------------
// Personalisation - Custom modifications to the standard control classes
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class StoreDialog
{
	idd = 1200;
	name = "StoreDialog";

	duration = 90000; // 5 second display time
	fadein = 2; // 2 second fade in - 7 seconds in all.

	movingEnable = true;
	onLoad = "uiNamespace setVariable [""TFID_StoreDialog"", _this select 0]; [] call TFID_fnc_resetStore;";
	class controls {

		class TFID_Title : RscStructuredText {
			idc = 601;
			type = 13;
			style = 0;
			size = 0.05;
			x = 0;
			y = 0;
			w = 1;
			h = 0.08;
			text = "STORE";
			colorBackground[] = {Dlg_Color_Maroon, .7};

			class Attributes {
				font = "TahomaB";
				color = "#000000";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ff0000";
				size = "1";
			};
		};

		class TFID_Background : Dlg_FullBackground {
			colorBackground[] = {Dlg_Color_Black,.6};

			x = 0;
			y = .1;
			w = 1;
			h = .9;
		};

		/*
			Player Info (top right corner)
		*/
		class TFID_Name_Label : RscText {
			idc = 640;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};


			x = .675;
			y = .13;
			w = .3;
			h = .03;
			text = "";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_Rank_NameL : RscText {
			idc = 632;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};


			x = .675;
			y = .19;
			w = .09;
			h = .03;
			text = "Balance";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_Rank_Name : RscText {
			idc = 641;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};


			x = .775;
			y = .19;
			w = .2;
			h = .03;
			text = "";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_UnitL : RscText {
			idc = 633;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};

			x = .675;
			y = .23;
			w = .09;
			h = .03;
			text = "Price";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_Unit : RscText {
			idc = 642;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};

			x = .775;
			y = .23;
			w = .2;
			h = .03;
			text = "";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_CompanyL : RscText {
			idc = 634;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};

			x = .675;
			y = .27;
			w = .09;
			h = .03;
			text = "Remaining";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_Company : RscText {
			idc = 643;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};

			x = .775;
			y = .27;
			w = .2;
			h = .03;
			text = "";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_Button_Close : RscButton {
			idc = 620;
		    default = true;
			text = "Close";
			action = "closeDialog 600;";

			x = .675;
			y = .92;
			w = .3;
			h = .04;
		};

		class TFID_Armory_Label : RscText {
			idc = 604;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};


			x = .025;
			y = .13;
			w = .3;
			h = .03;
			text = "Kill Streak Store";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_Inventory_Label : RscText {
			idc = 605;
			type = 13;
			style = 0;
			size = 0.03;
			colorBackground[] = {Dlg_Color_Black,.4};


			x = .35;
			y = .13;
			w = .3;
			h = .03;
			text = "Package Contents";
			class Attributes {
				align = "center";
				valign = "middle";
			};
		};

		class TFID_LB_1 : RscListBox {
			idc = 607;
			x = .025;
			y = .19;
			w = .3;
			h = .69;
			onLBSelChanged = "[] call TFID_fnc_fillPackageList;";
			onLBDblClick = "";
		};

		class TFID_LB_2 : RscListBox {
			idc = 608;
			x = .35;
			y = .19;
			w = .3;
			h = .69;
			colorSelectBackground[] = {Dlg_Color_Black,0};
			colorSelectBackground2[] = {Dlg_Color_Black,0};
			onLBSelChanged = "";
			onLBDblClick = "";

		};

		class TFID_Button_Weapons : RscButton_Arm_View {
			idc = 635;
		    default = true;
			text = "Purchase Package";
			action = "[] call TFID_fnc_checkout;";

			x = .675;
			y = .36;
			w = .3;
			h = .04;
		};
	};
};

class TFID_ConfirmDialog
{
	idd = 1012;
	name = "TFID_ConfirmDialog";

	duration = 90000; // 5 second display time
	fadein = 2; // 2 second fade in - 7 seconds in all.

	movingEnable = true;
	onLoad = "";
	class controls {

		class TFID_Title : RscStructuredText {
			idc = 501;
			type = 13;
			style = 0;
			size = 0.04;
			x = .3;
			y = .35;
			w = .4;
			h = .06;
			text = "Are You Sure?";
			colorBackground[] = {Dlg_Color_Maroon, .7};

			class Attributes {
				font = "TahomaB";
				color = "#000000";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ff0000";
				size = "1";
			};
		};

		class TFID_Background : Dlg_FullBackground {
			colorBackground[] = {Dlg_Color_Black,.6};

			x = .3;
			y = .4;
			w = .4;
			h = .2;
		};

		class TFID_Edit_Amount : RscText {
			idc = 503;
			colorBackground[] = {Dlg_Color_Black,0};
			text = "";

			x = .3;
			y = .45;
			w = .4;
			h = .04;
		};

		class TFID_Button_YES : RscButton_Arm_view {
			idc = 504;
		    default = true;
			text = "Yes";
			action = "";

			x = .33;
			y = .52;
			w = .15;
			h = .04;
		};

		class TFID_Button_NO : RscButton_Arm_view {
			idc = 505;
		    default = true;
			text = "No";
			action = "";

			x = .52;
			y = .52;
			w = .15;
			h = .04;
		};
	};
};

class TFID_NotificationDialog
{
	idd = 1011;
	name = "TFID_NotificationDialog";

	duration = 90000; // 5 second display time
	fadein = 2; // 2 second fade in - 7 seconds in all.

	movingEnable = true;
	onLoad = "uiNamespace setVariable [""TFID_NotificationDialog"", _this select 0];";
	class controls {

		class TFID_Title : RscStructuredText {
			idc = 501;
			type = 13;
			style = 0;
			size = 0.04;
			x = .3;
			y = .35;
			w = .4;
			h = .06;
			text = "WARNING";
			colorBackground[] = {Dlg_Color_Maroon, .7};

			class Attributes {
				font = "TahomaB";
				color = "#000000";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ff0000";
				size = "1";
			};
		};

		class TFID_Background : Dlg_FullBackground {
			colorBackground[] = {Dlg_Color_Black,.6};

			x = .3;
			y = .4;
			w = .4;
			h = .2;
		};

		class TFID_Edit_Amount : RscText {
			idc = 503;
			colorBackground[] = {Dlg_Color_Black,.4};
			text = "";

			x = .29;
			y = .45;
			w = .4;
			h = .04;
		};

		class TFID_Button_OK : RscButton_Arm_view {
			idc = 1011;
		    default = true;
			text = "OK";
			action = "closeDialog 1011;";

			x = .4;
			y = .52;
			w = .2;
			h = .04;
		};
	};
};
