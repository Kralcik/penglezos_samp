// Anti-Cheat Guard
// Coded by: khalifakk
// Cheats protected: jetpack
// Version: 1.1 (only one anti-cheat included)

#include <a_samp>

new JetPack[MAX_PLAYERS];

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
