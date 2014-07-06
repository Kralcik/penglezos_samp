//=========================INCLUDE==============================================
#include <a_samp>
//=========================DEFINEE==============================================
#define FILTERSCRIPT
#if defined FILTERSCRIPT
//=========================NEW==================================================
new Text:Textdraww;
new Text:Textdrawww;
new Text:Textdrawwww;
new Text:randommsg;
//=========================FORWARD==============================================
forward RandomMessage();
//=========================RANDMES==============================================
new RandomMessages[][] =
{
    "~y~SERVER: ~w~Welcome player to KK Gamemode!",
    "~y~SERVER: ~w~This is a script developed by khalifakk",
    "~y~SERVER: ~w~Visit www.khalifakk.info for more info!",
    "~y~SERVER: ~w~Have fun!"
};
public RandomMessage()
{
        TextDrawSetString(randommsg, RandomMessages[random(sizeof(RandomMessages))]);
        return 1;
}
//==============================================================================
public OnFilterScriptInit()
{
	Textdraww = TextDrawCreate(646.200134, 430.818939, "usebox");
	TextDrawLetterSize(Textdraww, 0.000000, 0.991666);
	TextDrawTextSize(Textdraww, -2.999998, 0.000000);
	TextDrawAlignment(Textdraww, 1);
	TextDrawColor(Textdraww, 0);
	TextDrawUseBox(Textdraww, true);
	TextDrawBoxColor(Textdraww, 102);
	TextDrawSetShadow(Textdraww, 0);
	TextDrawSetOutline(Textdraww, 0);
	TextDrawFont(Textdraww, 0);

	Textdrawww = TextDrawCreate(-0.350000, 426.475219, "LD_SPAC:white");
	TextDrawLetterSize(Textdrawww, 0.000000, 0.000000);
	TextDrawTextSize(Textdrawww, 640.000000, 2.187500);
	TextDrawAlignment(Textdrawww, 1);
	TextDrawColor(Textdrawww, -5963521);
	TextDrawSetShadow(Textdrawww, 0);
	TextDrawSetOutline(Textdrawww, 0);
	TextDrawFont(Textdrawww, 4);

	Textdrawwww = TextDrawCreate(-0.649999, 441.394042, "LD_SPAC:white");
	TextDrawLetterSize(Textdrawwww, 0.000000, 0.000000);
	TextDrawTextSize(Textdrawwww, 640.000000, 2.187500);
	TextDrawAlignment(Textdrawwww, 1);
	TextDrawColor(Textdrawwww, -5963521);
	TextDrawSetShadow(Textdrawwww, 0);
	TextDrawSetOutline(Textdrawwww, 0);
	TextDrawFont(Textdrawwww, 4);
	SetTimer("RandomMessage",8000,1);
    randommsg = TextDrawCreate(7.000000, 427.000000, "AAAA");
	TextDrawBackgroundColor(randommsg, 255);
	TextDrawFont(randommsg, 3);
	TextDrawLetterSize(randommsg, 0.379999, 1.499999);
	TextDrawColor(randommsg, -1);
	TextDrawSetOutline(randommsg, 1);
	TextDrawSetProportional(randommsg, 1);
	return 1;
}
//=========================INCLUDE==============================================
public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Welcome Message by khalifakk for kk");
	print("----------------------------------\n");
}

#endif
//==============================================================================
public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}
//==============================================================================
public OnPlayerSpawn(playerid)
{
    TextDrawShowForPlayer(playerid, randommsg);
    TextDrawShowForPlayer(playerid, Textdraww);
    TextDrawShowForPlayer(playerid, Textdrawww);
    TextDrawShowForPlayer(playerid, Textdrawwww);
	return 1;
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}
//==============================================================================
public OnVehicleSpawn(vehicleid)
{
	return 1;
}
//==============================================================================
public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}
//==============================================================================
public OnPlayerText(playerid, text[])
{
	return 1;
}
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}
//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}
//==============================================================================
public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}
//==============================================================================
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}
//==============================================================================
public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}
//==============================================================================
public OnRconCommand(cmd[])
{
	return 1;
}
//==============================================================================
public OnPlayerRequestSpawn(playerid)
{
	return 1;
}
//==============================================================================
public OnObjectMoved(objectid)
{
	return 1;
}
//==============================================================================
public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}
//==============================================================================
public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}
//==============================================================================
public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}
//==============================================================================
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}
//==============================================================================
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}
//==============================================================================
public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}
//==============================================================================
public OnPlayerExitedMenu(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}
//==============================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}
//==============================================================================
public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}
//==============================================================================
public OnPlayerUpdate(playerid)
{
	return 1;
}
//==============================================================================
public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}
//==============================================================================
public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}
//==============================================================================
public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}
//==============================================================================
public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}
//==============================================================================
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
//==============================================================================
