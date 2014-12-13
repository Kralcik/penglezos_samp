/////////////////////////////////////////////////
// Event engine
// Coded by khalifakk
/////////////////////////////////////////////////

// ONE SHOT DM

#include <a_samp>
#include <zcmd>
#include <sscanf2>

//Random Spawns for ODM arena
new Float:ODMSpawns[][] =
{
    {1595.3594, -777.3535, 1086.8411, 29.1164},
    {1608.2104, -769.7234, 1086.8411, 317.0491},
    {1607.0980,-803.7650,1086.8411,249.6819},
    {1585.4980,-813.2322,1086.8411,359.8079},
    {1590.5016,-804.3522,1089.7648,335.3677}
};

//Variables
new IsInODM[MAX_PLAYERS] = 0;
new ODMOpen = 1;
new weapons[MAX_PLAYERS][13][2];
new Float:HealthBefore[MAX_PLAYERS],Float:ArmourBefore[MAX_PLAYERS];
new Float:xB4[MAX_PLAYERS],Float:yB4[MAX_PLAYERS],Float:zB4[MAX_PLAYERS];
new PlayerSpawned[MAX_PLAYERS] = 0;
//Functions
forward RemovePlayerFromODM(playerid);
public RemovePlayerFromODM(playerid)
{
	SetPlayerPos(playerid, xB4[playerid],yB4[playerid],zB4[playerid]);
	IsInODM[playerid] = 0;
 	SendClientMessage(playerid, -1, "{FF8336}[Info] {FFD1B5}You have left the One Shot deathmatch.");
	return 1;
}

public OnFilterScriptInit()
{
	print("\n------------------------------------------------------");
	print(" Event Engine by khalifakk has been successfully loaded.");
	print(" Events loaded: 3 - One Shot DM,Star Event,Quiz Event");
	print("------------------------------------------------------\n");

	//MAPPING ARENA
	CreateObject(18981, 1604.84070, -773.00464, 1085.34106,   0.00000, 90.00000, 0.00000);
	CreateObject(18981, 1604.84070, -797.72162, 1085.34106,   0.00000, 90.00000, 0.00000);
	CreateObject(18981, 1580.12366, -797.72162, 1085.34106,   0.00000, 90.00000, 0.00000);
	CreateObject(18981, 1580.12366, -773.00458, 1085.34106,   0.00000, 90.00000, 0.00000);
	CreateObject(18981, 1580.13342, -821.82312, 1085.34106,   0.00000, 90.00000, 0.00000);
	CreateObject(18981, 1604.85034, -821.82312, 1085.34106,   0.00000, 90.00000, 0.00000);
	CreateObject(18981, 1567.20837, -773.00409, 1085.34106,   0.00000, 0.00000, 0.00000);
	CreateObject(18981, 1567.20837, -797.82013, 1085.34106,   0.00000, 0.00000, 0.00000);
	CreateObject(18981, 1567.20837, -822.63611, 1085.34106,   0.00000, 0.00000, 0.00000);
	CreateObject(18981, 1579.49341, -834.62878, 1085.34106,   0.00000, 0.00000, 90.00000);
	CreateObject(18981, 1604.30945, -834.62878, 1085.34106,   0.00000, 0.00000, 90.00000);
	CreateObject(18981, 1616.31238, -822.63611, 1085.34106,   0.00000, 0.00000, 0.00000);
	CreateObject(18981, 1616.31238, -797.82013, 1085.34106,   0.00000, 0.00000, 0.00000);
	CreateObject(18981, 1616.31238, -773.00409, 1085.34106,   0.00000, 0.00000, 0.00000);
	CreateObject(18981, 1604.30945, -760.70880, 1085.34106,   0.00000, 0.00000, 90.00000);
	CreateObject(18981, 1579.49341, -760.70880, 1085.34106,   0.00000, 0.00000, 90.00000);
	CreateObject(7921, 1603.07202, -809.10760, 1087.20691,   0.00000, 0.00000, 32.76000);
	CreateObject(7921, 1584.03760, -812.73615, 1087.21155,   0.00000, 0.00000, 105.71999);
	CreateObject(7921, 1593.29712, -790.46918, 1087.20691,   0.00000, 0.00000, 83.04000);
	CreateObject(7921, 1580.71655, -796.63257, 1087.20691,   0.00000, 0.00000, 255.90002);
	CreateObject(7921, 1605.24280, -792.20026, 1087.20691,   0.00000, 0.00000, 255.90002);
	CreateObject(7921, 1595.88721, -777.82336, 1087.20691,   0.00000, 0.00000, 306.12000);
	CreateObject(7921, 1577.60632, -773.16748, 1087.20691,   0.00000, 0.00000, 274.74002);
	CreateObject(7921, 1606.33093, -770.79382, 1087.20691,   0.00000, 0.00000, 191.45999);
	CreateObject(7921, 1579.39783, -785.74951, 1087.20691,   0.00000, 0.00000, 254.94002);
	CreateObject(5777, 1573.58423, -813.86841, 1086.44531,   0.00000, 0.00000, 36.12000);
	CreateObject(5777, 1593.17896, -818.96979, 1086.44531,   0.00000, 0.00000, 37.55999);
	CreateObject(2934, 1590.48621, -804.10767, 1087.31140,   0.00000, 0.00000, 0.00000);
	CreateObject(2934, 1604.07788, -801.04279, 1087.31140,   0.00000, 0.00000, 37.62000);
	CreateObject(2934, 1587.44690, -785.16925, 1087.31140,   0.00000, 0.00000, 88.56001);
	CreateObject(2934, 1571.44873, -782.63721, 1087.31140,   0.00000, 0.00000, 157.86005);
	CreateObject(2934, 1607.96692, -782.00873, 1087.31140,   0.00000, 0.00000, 216.36005);
	return 1;
}
main(){}

//COMMANDS
CMD:odm(playerid, params[])
{
	if(PlayerSpawned[playerid] == 1)
	{
		if(ODMOpen == 1)
		{
			if(IsInODM[playerid] == 0)
			{
			    for (new i = 0; i <= 12; i++)
				{
				    GetPlayerWeaponData(playerid, i, weapons[playerid][i][0], weapons[playerid][i][1]);
				}
			 	GetPlayerHealth(playerid, HealthBefore[playerid]);
			 	GetPlayerArmour(playerid, ArmourBefore[playerid]);
			 	GetPlayerPos(playerid, xB4[playerid],yB4[playerid],zB4[playerid]);
				new Random = random(sizeof(ODMSpawns));
			    SetPlayerPos(playerid, ODMSpawns[Random][0], ODMSpawns[Random][1], ODMSpawns[Random][2]);
			    SetPlayerFacingAngle(playerid, ODMSpawns[Random][3]);
			    IsInODM[playerid] = 1;
			    SendClientMessage(playerid, -1, "{FF8336}[Info] {FFD1B5}You have joined the One Shot deathmatch.");
			    ResetPlayerWeapons(playerid);
			    SetPlayerHealth(playerid, 5);
			    SetPlayerArmour(playerid, 0);
			    GivePlayerWeapon(playerid, WEAPON_SILENCED, 999999);
			}else{
	            RemovePlayerFromODM(playerid);
	            ResetPlayerWeapons(playerid);
	            SetPlayerHealth(playerid, HealthBefore[playerid]);
	            SetPlayerArmour(playerid, ArmourBefore[playerid]);
			    for (new i = 0; i <= 12; i++)
				{
				    GivePlayerWeapon(playerid,weapons[playerid][i][0],  99999);
				}
			}
		}else SendClientMessage(playerid, -1, "{FF8336}[Error] {FFD1B5}ODM is closed at the moment.");
	}else SendClientMessage(playerid, -1, "{FF8336}[Error] {FFD1B5}You must be spawned to do this.");
	return 1;
}

CMD:lockodm(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
	{
		if(ODMOpen == 1)
		{
		    ODMOpen = 0;
		    for(new i = 0; i < MAX_PLAYERS; i++)
		    {
		    	if(IsInODM[playerid] == 1)
				{
				    RemovePlayerFromODM(i);
				    ResetPlayerWeapons(playerid);
		            SetPlayerHealth(playerid, HealthBefore[playerid]);
		            SetPlayerArmour(playerid, ArmourBefore[playerid]);
				    for (new b = 0; b <= 12; b++)
					{
					    GivePlayerWeapon(playerid,weapons[playerid][b][0],  99999);
					}
			        SendClientMessage(i, -1, "{FF8336}[Info] {FFD1B5}The ODM has been closed.");
		        }
		    }
		    SendClientMessage(playerid, -1, "{FF8336}[Info] {FFD1B5}You have locked the ODM.");
		}else if(ODMOpen == 0){
		    ODMOpen = 1;
		    SendClientMessage(playerid, -1, "{FF8336}[Info] {FFD1B5}You have unlocked the ODM.");
		}
	}else SendClientMessage(playerid, -1, "{FF8336}[Error] {FFD1B5}You must be an admin.");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    IsInODM[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	PlayerSpawned[playerid] = 1;
	if(ODMOpen == 1)
	{
		if(IsInODM[playerid] == 1)
		{
			new Random = random(sizeof(ODMSpawns));
		    SetPlayerPos(playerid, ODMSpawns[Random][0], ODMSpawns[Random][1], ODMSpawns[Random][2]);
		    SetPlayerFacingAngle(playerid, ODMSpawns[Random][3]);
		    SendClientMessage(playerid, -1, "{FF8336}[Info] {FFD1B5}You have respawned inside of the ODM arena.");
			SetPlayerHealth(playerid, 5);
			SetPlayerArmour(playerid, 0);
			ResetPlayerWeapons(playerid);
			GivePlayerWeapon(playerid, WEAPON_SILENCED, 999999);
		}
	}
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
    PlayerSpawned[playerid] = 0;
	return 1;
}
///////////////////////////////////////////////////////////////////////
// STAR EVENT
///////////////////////////////////////////////////////////////////////

#include <a_samp>
#include <zcmd>

new Star;

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == Star)
    {
        new name[MAX_PLAYER_NAME];
        GetPlayerName(playerid, name, sizeof(name));
        SendClientMessageToAll(-1, "{FF0000}{FFFF00}STAR {0066CC}was found{15FF00}!");
        SendClientMessage(playerid,-1, "{FF0000}You found the {FFFF00}STAR {0066CC}!");
        SendClientMessage(playerid,-1, "{FF0000}You got {FFFF00}5000 {0066CC}$");
        GivePlayerMoney(playerid, 5000);
        DestroyPickup(Star);
        GameTextForAll("~r~Star Event ~b~ over ~y~!", 5000, 5);
    }
    return 1;
}

CMD:star(playerid,params[])
{
    if(IsPlayerAdmin(playerid))
    {
        SetTimer("Pickup", 1000, false);
    }
    return 1;
}

CMD:stopsevent(playerid,params[])
{
    if(IsPlayerAdmin(playerid))
    {
        GameTextForAll("~r~Star Event ~b~ Destroyed ~y~!", 5000, 5);
        DestroyPickup(Star);
    }
    return 1;
}

forward Pickup(playerid);
public Pickup(playerid)
{
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid,X,Y,Z);
    Star = CreatePickup(1247, 1, X,Y,Z, -1);
    SendClientMessage(playerid,-1,"{FF0000}You have created {FFFF00}a STAR {15FF00}for {0066CC}Star Event");
    GameTextForPlayer(playerid, "~r~Star Event ACTIVATED!You have plenty time to find star and win the money!Admins will give you tips about the location!", 1000000, 5);
    
}
///////////////////////////////////////////////////////////////////////
// QUIZ EVENT
///////////////////////////////////////////////////////////////////////

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

// Colours
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_ORANGE 0xFF9900AA
#define COL_RED   "{FF0000}"
#define COL_WHITE "{FFFFFF}"
#define COL_GREEN "{33AA33}"

new isenable, answer, number[4];

public OnFilterScriptInit2()
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

