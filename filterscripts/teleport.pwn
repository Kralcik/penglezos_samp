// Customized teleport menu by khalifakk (2014)
// /t command to teleport to some chosen areas

#include <a_samp>

new Menu:teleportmenu;

public OnFilterScriptInit()
{
    teleportmenu = CreateMenu("teleport menu", 2, 200.0, 100.0, 150.0, 150.0);
    AddMenuItem(teleportmenu, 0, "LS");

    AddMenuItem(teleportmenu, 1, "Main Area - Grove Street");
    return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:CurrentMenu = GetPlayerMenu(playerid);
    if(CurrentMenu == teleportmenu)
{
    switch(row)
    {
        case 0: // Main Area - Grove Street
        {
            SetPlayerPos(playerid, 2493.9133, -1682.3986, 13.3382);
            SetPlayerInterior(playerid, 0);
            SendClientMessage(playerid, 0xFFFFFFFF, "Welcome to Main Area - Grove Street");
        }
    }
}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/t", true) == 0)
{
    ShowMenuForPlayer(teleportmenu,playerid);
    return 1;
}
	return 0;
}
