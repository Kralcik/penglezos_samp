// PM SYSTEM

// Includes
#include <a_samp>
#include <sscanf>

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

// Colours
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_ORANGE 0xFF9900AA

// Player Variable
enum PlayerInfo
{
        Last,
        NoPM,
}

new pInfo[MAX_PLAYERS][PlayerInfo];

public OnFilterScriptInit()
{
        print("\n--------------------------------------------");
        print(" private messages System");
        print("--------------------------------------------\n");
        return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------------");
        print(" private messages system");
        print("--------------------------------------------\n");
        return 1;
}

public OnPlayerConnect(playerid)
{
        pInfo[playerid][Last] = -1;
        pInfo[playerid][NoPM] = 0;
        return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    pInfo[playerid][Last] = -1;
        pInfo[playerid][NoPM] = 0;
        return 1;
}

stock PlayerName(playerid)
{
        new pName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pName, sizeof(pName));
        return pName;
}

dcmd_blockpm(playerid, params[])
{
        #pragma unused params
        if(pInfo[playerid][NoPM] == 0)
        {
            pInfo[playerid][NoPM] = 1;
            SendClientMessage(playerid, COLOR_YELLOW, "Your have been blocked your  private messages.");
        }
        else
        {
            pInfo[playerid][NoPM] = 0;
            SendClientMessage(playerid, COLOR_YELLOW, "Your have been unblocked your private messages.");
        }
}

dcmd_pm(playerid, params[])
{
        new pID, text[128], string[128];
        if(sscanf(params, "us", pID, text)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /pm (nick/id) (message) - Enter a valid Nick / ID");
        if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_RED, "Player is not connected.");
        if(pID == playerid) return SendClientMessage(playerid, COLOR_RED, "You cannot PM yourself.");
        format(string, sizeof(string), "%s (%d) is not accepting private messages at the moment.", PlayerName(pID), pID);
        if(pInfo[pID][NoPM] == 1) return SendClientMessage(playerid, COLOR_RED, string);
        format(string, sizeof(string), "PM to %s: %s", PlayerName(pID), text);
        SendClientMessage(playerid, COLOR_YELLOW, string);
        format(string, sizeof(string), "PM from %s: %s", PlayerName(playerid), text);
        SendClientMessage(pID, COLOR_YELLOW, string);
        pInfo[pID][Last] = playerid;
        return 1;
}

dcmd_reply(playerid, params[])
{
        new text[128], string[128];
        if(sscanf(params, "s", text)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /reply (message) - Enter your message");
        new pID = pInfo[playerid][Last];
        if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_RED, "Player is not connected.");
        if(pID == playerid) return SendClientMessage(playerid, COLOR_RED, "You cannot PM yourself.");
        format(string, sizeof(string), "%s (%d) is not accepting private messages at the moment.", PlayerName(pID), pID);
        if(pInfo[pID][NoPM] == 1) return SendClientMessage(playerid, COLOR_RED, string);
        format(string, sizeof(string), "PM to %s: %s", PlayerName(pID), text);
        SendClientMessage(playerid, COLOR_YELLOW, string);
        format(string, sizeof(string), "PM from %s: %s", PlayerName(playerid), text);
        SendClientMessage(pID, COLOR_YELLOW, string);
        pInfo[pID][Last] = playerid;
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        dcmd(pm, 2, cmdtext);
        dcmd(reply, 5, cmdtext);
        dcmd(blockpm, 4, cmdtext);
        return 0;
}
