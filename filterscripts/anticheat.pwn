// Anti-Cheat Guard
// Coded by: khalifakk
// Cheats protected: jetpack,armour,jump(bunny hop),ping
// Version: 1.6

#include <a_samp>
#include <zcmd>

#define MAXPINGS 1000
#define enable 0
#define disable 1

new ping[MAX_PLAYERS];
new JetPack[MAX_PLAYERS];
new LastArmour[MAX_PLAYERS];
new JoueurAppuieJump[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n------------------------------------------------------");
	print(" Anti-Cheat Guard by khalifakk                          ");
	print("------------------------------------------------------\n");
}

public OnPlayerConnect(playerid)
{
    JetPack[playerid] = 0;
    JoueurAppuieJump[playerid] = 0;
	return 1;
}

public OnPlayerUpdate(playerid)
{
// Armour protection
new Float:armour;
GetPlayerArmour(playerid,armour);
new result = armour-LastArmour[playerid];
if(result > 99.0) // leave that 99.0
{
  new string[128], targetid;
  format(string, sizeof(string), "[Anti-Cheat]: %s has been banned for using armour hacks ",GetName(targetid));
  SendClientMessageToAll(-1, string);
  print(string);
  Ban(playerid);
}
else
{
  LastArmour[playerid] = armour;
}
// High Ping protection
if(ping[playerid] != disable)
	{
		if(GetPlayerPing(playerid) > MAXPINGS)
		{
            SetTimerEx("pKick", 10, true, "i", playerid);
			new string[128], targetid;
            format(string, sizeof(string), "[Anti-Cheat]: %s has been kicked for high ping. ",GetName(targetid));
            SendClientMessageToAll(-1, string);
            print(string);
			GameTextForPlayer(playerid,"~r~High~w~ Ping",3000,0);
		}
}
// Jetpack protection
    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
    {
        if(JetPack[playerid] == 0)
        {
        new string[128], targetid;
    	format(string, sizeof(string), "[Anti-Cheat]: %s has been banned for using jetpack hacks ",GetName(targetid));
    	SendClientMessageToAll(-1, string);
     	print(string);
		SetTimerEx("KickTimer", 10, false, "i", playerid);
		BanEx(playerid,string);
        }
        else
            return 1;
    }
    else JetPack[playerid] = 0;
    return 1;
}
// Jump (bunny hop) protection
forward AppuieJump(playerid);
public AppuieJump(playerid)
{
    JoueurAppuieJump[playerid] = 0;
    ClearAnimations(playerid);
    return 1;
}
forward AppuiePasJump(playerid);
public AppuiePasJump(playerid)
{
    JoueurAppuieJump[playerid] = 0;
    return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
    {
        JoueurAppuieJump[playerid] ++;
        SetTimerEx("AppuiePasJump", 900, false, "i", playerid);

        if(JoueurAppuieJump[playerid] == 2)
        {
            ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
			GameTextForPlayer(playerid,"~r~Illegal~w~ Action",3000,0);
			SetTimerEx("AppuieJump", 1100, false, "i", playerid);
        }
    }
    return 1;
}

forward KickTimer(playerid);
public KickTimer(playerid)
{
    Kick(playerid);
    return 1;
}

forward pKick(playerid);
public pKick(playerid)
{
    Kick(playerid);
}

stock GetName(playerid)
{
    new
    pName[MAX_PLAYER_NAME];

    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
    return pName;
}
