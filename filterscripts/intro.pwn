// Intro Textdraw made by BodyBoardVEVO aka Rzzy
// Reworked by khalifakk

#include <a_samp>

new Text:IntroTD0;
new Text:IntroTD1;
new Text:IntroTD2;
new Text:IntroTD3;
new Text:IntroTD4;

new Text:IntroTD5;
new Text:IntroTD6;
new Text:IntroTD7;
new Text:IntroTD8;

#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_LIGHTBLUE 0x33CCFFAA

public OnGameModeInit()
{
    IntroTD0 = TextDrawCreate(645.000000, 2.000000, "_");
    TextDrawBackgroundColor(IntroTD0, 255);
    TextDrawFont(IntroTD0, 1);
    TextDrawLetterSize(IntroTD0, 0.500000, 10.100002);
    TextDrawColor(IntroTD0, -1);
    TextDrawSetOutline(IntroTD0, 0);
    TextDrawSetProportional(IntroTD0, 1);
    TextDrawSetShadow(IntroTD0, 1);
    TextDrawUseBox(IntroTD0, 1);
    TextDrawBoxColor(IntroTD0, 255);
    TextDrawTextSize(IntroTD0, -5.000000, 0.000000);

    IntroTD1 = TextDrawCreate(645.000000, 354.000000, "_");
    TextDrawBackgroundColor(IntroTD1, 255);
    TextDrawFont(IntroTD1, 1);
    TextDrawLetterSize(IntroTD1, 0.500000, 10.100002);
    TextDrawColor(IntroTD1, -1);
    TextDrawSetOutline(IntroTD1, 0);
    TextDrawSetProportional(IntroTD1, 1);
    TextDrawSetShadow(IntroTD1, 1);
    TextDrawUseBox(IntroTD1, 1);
    TextDrawBoxColor(IntroTD1, 255);
    TextDrawTextSize(IntroTD1, -5.000000, 0.000000);

    IntroTD2 = TextDrawCreate(645.000000, 354.000000, "_");
    TextDrawBackgroundColor(IntroTD2, 255);
    TextDrawFont(IntroTD2, 1);
    TextDrawLetterSize(IntroTD2, 0.500000, 0.000000);
    TextDrawColor(IntroTD2, -1);
    TextDrawSetOutline(IntroTD2, 0);
    TextDrawSetProportional(IntroTD2, 1);
    TextDrawSetShadow(IntroTD2, 1);
    TextDrawUseBox(IntroTD2, 1);
    TextDrawBoxColor(IntroTD2, COLOR_LIGHTBLUE);
    TextDrawTextSize(IntroTD2, -5.000000, 0.000000);

    IntroTD3 = TextDrawCreate(645.000000, 93.000000, "_");
    TextDrawBackgroundColor(IntroTD3, 255);
    TextDrawFont(IntroTD3, 1);
    TextDrawLetterSize(IntroTD3, 0.500000, 0.000000);
    TextDrawColor(IntroTD3, -1);
    TextDrawSetOutline(IntroTD3, 0);
    TextDrawSetProportional(IntroTD3, 1);
    TextDrawSetShadow(IntroTD3, 1);
    TextDrawUseBox(IntroTD3, 1);
    TextDrawBoxColor(IntroTD3, COLOR_LIGHTBLUE);
    TextDrawTextSize(IntroTD3, -5.000000, 0.000000);

    IntroTD4 = TextDrawCreate(138.000000, 19.000000, "Khalifakk Development");
    TextDrawBackgroundColor(IntroTD4, COLOR_YELLOW);
    TextDrawFont(IntroTD4, 3);
    TextDrawLetterSize(IntroTD4, 0.699999, 4.599997);
    TextDrawColor(IntroTD4, 255);
    TextDrawSetOutline(IntroTD4, 1);
    TextDrawSetProportional(IntroTD4, 1);

	IntroTD5 = TextDrawCreate(252.000000, 333.000000, "Welcome");
	TextDrawBackgroundColor(IntroTD5, 255);
	TextDrawFont(IntroTD5, 0);
	TextDrawLetterSize(IntroTD5, 0.869999, 4.099998);
	TextDrawColor(IntroTD5, -65281);
	TextDrawSetOutline(IntroTD5, 1);
	TextDrawSetProportional(IntroTD5, 1);

	IntroTD6 = TextDrawCreate(221.000000, 372.000000, "to");
	TextDrawBackgroundColor(IntroTD6, 255);
	TextDrawFont(IntroTD6, 2);
	TextDrawLetterSize(IntroTD6, 0.500000, 1.000000);
	TextDrawColor(IntroTD6, 65535);
	TextDrawSetOutline(IntroTD6, 1);
	TextDrawSetProportional(IntroTD6, 1);

	IntroTD7 = TextDrawCreate(283.000000, 372.000000, "our");
	TextDrawBackgroundColor(IntroTD7, 255);
	TextDrawFont(IntroTD7, 3);
	TextDrawLetterSize(IntroTD7, 0.500000, 1.000000);
	TextDrawColor(IntroTD7, -1);
	TextDrawSetOutline(IntroTD7, 1);
	TextDrawSetProportional(IntroTD7, 1);

	IntroTD8 = TextDrawCreate(320.000000, 372.000000, "Server");
	TextDrawBackgroundColor(IntroTD8, 255);
	TextDrawFont(IntroTD8, 2);
	TextDrawLetterSize(IntroTD8, 0.500000, 1.000000);
	TextDrawColor(IntroTD8, -16776961);
	TextDrawSetOutline(IntroTD8, 1);
	TextDrawSetProportional(IntroTD8, 1);
	return 1;
}
public OnPlayerConnect(playerid)
{
	TextDrawShowForPlayer(playerid,IntroTD0);
    TextDrawShowForPlayer(playerid,IntroTD1);
    TextDrawShowForPlayer(playerid,IntroTD2);
    TextDrawShowForPlayer(playerid,IntroTD3);
    TextDrawShowForPlayer(playerid,IntroTD4);
	TextDrawShowForPlayer(playerid,IntroTD5);
    TextDrawShowForPlayer(playerid,IntroTD6);
    TextDrawShowForPlayer(playerid,IntroTD7);
    TextDrawShowForPlayer(playerid,IntroTD8);
	return 1;
}
public OnPlayerSpawn(playerid)
{
    TextDrawHideForPlayer(playerid, IntroTD0);
    TextDrawHideForPlayer(playerid, IntroTD1);
    TextDrawHideForPlayer(playerid, IntroTD2);
    TextDrawHideForPlayer(playerid, IntroTD3);
    TextDrawHideForPlayer(playerid, IntroTD4);
    TextDrawHideForPlayer(playerid, IntroTD5);
    TextDrawHideForPlayer(playerid, IntroTD6);
    TextDrawHideForPlayer(playerid, IntroTD7);
    TextDrawHideForPlayer(playerid, IntroTD8);
    return 1;
}
