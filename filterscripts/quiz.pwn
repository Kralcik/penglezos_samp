// Quiz + PM Systems

// Includes
#include <a_samp>
#include <sscanf>

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

// Colours
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_ORANGE 0xFF9900AA
#define COL_RED   "{FF0000}"
#define COL_WHITE "{FFFFFF}"
#define COL_GREEN "{33AA33}"

new isenable, answer, number[4];

public OnFilterScriptInit()
{
  SetTimer("mathQuiz",200000, true);
  return 1;
}

public OnPlayerText(playerid,text[])
{
   new string[128];
   if(isenable && text[0] && answer == strval(text))
   {
      new CName[24];
	  GetPlayerName(playerid, CName, 24);
      isenable = false;
      format(string, sizeof(string),"%s answered the right answer of math Quiz which was "COL_RED"%d "COL_WHITE"and wons 3 Scores, 2000$ Cash",CName,answer);
      SendClientMessageToAll(-1, string);
      SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
      GivePlayerMoney(playerid, 2000);
      return 0;
   }
   return 1;
}

forward mathQuiz();
public mathQuiz()
{
		new string[128];
        if(!isenable)
        {
                switch(random(4))
				{
                        case 0:
						{
                                answer = (number[0]=random(1000)) + (number[1]=random(840));
                                format(string, sizeof(string),"[Quiz System] First one who Solve "COL_GREEN"%d"COL_WHITE" + "COL_GREEN"%d"COL_WHITE" will get 3 Scores, 2000$ Cash",number[0], number[1]);
                        }
                        case 1:
						{
                                do
								{
 								  answer = (number[0]=random(500)) - (number[1]=random(500));
                                }
								while(number[0] < number[1]);
                                format(string, sizeof(string),"[Quiz System] First one who Solve "COL_GREEN"%d"COL_WHITE" - "COL_GREEN"%d"COL_WHITE" will get 3 Scores, 2000$ Cash",number[0], number[1]);
                        }
                        case 2:
						{
                                answer = (number[0]=random(100)) * (number[1]=random(80));
                                format(string, sizeof(string),"[Quiz System] First one who Solve "COL_GREEN"%d"COL_WHITE" * "COL_GREEN"%d"COL_WHITE" will get 3 Scores, 2000$ Cash",number[0], number[1]);
                        }
                        case 3:
						{
                                do
								{
                                        answer = (number[0]=random(1000)+1) / (number[1]=random(600)+1);
                                }
								while(number[0] % number[1]);
                                format(string, sizeof(string),"[Quiz System] First one who Solve "COL_GREEN"%d"COL_WHITE" / "COL_GREEN"%d"COL_WHITE" will get 3 Scores, 2000$ Cash",number[0], number[1]);
                        }
                }
                SendClientMessageToAll(-1, string);
                isenable = true;
        }
        else
		{
                isenable = false;
                format(string, sizeof(string),"No one solved the math Quiz which was "COL_RED"%d"COL_WHITE", so no one wons!", answer);
                SendClientMessageToAll(-1, string);
        }
        return 1;
}

// PM System
enum PlayerInfo
{
        Last,
        NoPM,
}

new pInfo[MAX_PLAYERS][PlayerInfo];

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
