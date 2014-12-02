// Anti-Cheat Guard
// Coded by: khalifakk
// Cheats protected: jetpack,armour
// Version: 1.2

#include <a_samp>

new JetPack[MAX_PLAYERS];
new LastArmour[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n------------------------------------------------------");
	print(" Anti-Cheat Guard by khalifakk                          ");
	print("\n------------------------------------------------------");
}

// Jetpack protection
public OnPlayerConnect(playerid)
{
    JetPack[playerid] = 0;
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

forward KickTimer(playerid);
public KickTimer(playerid)
{
    Kick(playerid);
    return 1;
}

stock GetName(playerid)
{
    new
    pName[MAX_PLAYER_NAME];

    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
    return pName;
}
