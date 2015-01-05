/* AFK SYSTEM */
#include <a_samp>
#include <foreach>
#include <streamer>
#include <zcmd>
new IsPaused[MAX_PLAYERS], pTick[MAX_PLAYERS], IsPunished[MAX_PLAYERS],Text3D:pauseLaber[MAX_PLAYERS],pKilled[MAX_PLAYERS],pTimer;
forward CheckPlayer();
public OnFilterScriptInit()
{
	pTimer = SetTimer("CheckPlayer", 1000, 1);
	return 1;
}

public OnFilterScriptExit()
{
    print("Anti pause system unloaded");
    KillTimer(pTimer);
    foreach(Player, i)
    if(IsPlayerConnected(i) && IsPaused[i] == 1)
	DestroyDynamic3DTextLabel(pauseLaber[i]);
	return 1;
}
public OnPlayerConnect(playerid)
{
    SetPVarInt(playerid, "spawned", 0);
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
    SetPVarInt(playerid, "spawned", 0);
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
    SetPVarInt(playerid, "spawned", 0);
}
public OnPlayerSpawn(playerid)
{
    SetPVarInt(playerid, "spawned", 1);
	return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    if(IsPaused[damagedid] == 1 && damagedid != INVALID_PLAYER_ID && GetPlayerTeam(playerid) != GetPlayerTeam(damagedid) && amount > 5 && pKilled[damagedid]== 0){
    pKilled[damagedid]=1;
    SendDeathMessage( playerid,damagedid, weaponid);
    SetPlayerScore(playerid,GetPlayerScore(playerid)+1); //Remove this you aren't using a score system
    SetPlayerVirtualWorld(damagedid,107);
    SpawnPlayer(damagedid);
    }
    return 1;
}
public OnPlayerUpdate(playerid)
{
    pTick[playerid] = GetTickCount();
    return 1;
}
public CheckPlayer()
{
    foreach(Player, i){
        if(!IsPlayerConnected(i)) continue;
        if(GetTickCount() - pTick[i] > 1500 ){
            if(IsPaused[i] == 0 && GetPVarInt(i, "spawned") == 1){
			pauseLaber[i] = CreateDynamic3DTextLabel("AFK, i'm pausing", 0xFB0404C8, 0, 0, 0, 25, i,INVALID_VEHICLE_ID, 0, -1, -1, -1, 100.0);
			IsPaused[i] = 1;
			pKilled[i]=0;
			}
        }
        else{
            if(IsPaused[i] == 1) DestroyDynamic3DTextLabel(pauseLaber[i]);
            if(IsPunished[i] == 1) SetPlayerVirtualWorld(i,GetPVarInt(i, "world"));
            IsPaused[i] = 0;
            IsPunished[i] = 0;
        }
        if(GetTickCount() - pTick[i] > 8000 && GetPVarInt(i, "spawned") == 1){
            if(IsPunished[i] == 0){
            IsPunished[i] = 1;
            SetPVarInt(i, "world", GetPlayerVirtualWorld(i));
            SetPlayerVirtualWorld(i,107);
            }
        }
    }
    return 1;
}
CMD:pausers(playerid)
{
return cmd_afklist(playerid);
}
CMD:afklist(playerid)
{
    new count=0;
	new string[256],temp[50],Name[MAX_PLAYER_NAME];
	strcat(string, "{33FF00}");
	foreach(Player, i){
	   if (IsPlayerConnected(i)){
	      if(IsPaused[i] == 1){
              GetPlayerName(i,Name,sizeof(Name));
	          format(temp, 60, "%s(Id:%i)\n",Name,i);
			  strcat(string, temp);
			  count++;
          }
	   }
	}
	format(temp, 60, "{00FFE6}AFK players, count: %d",count);
	if (count > 0)ShowPlayerDialog(playerid,3221,DIALOG_STYLE_MSGBOX,temp,string ,"OK","");
	else ShowPlayerDialog(playerid,3222,DIALOG_STYLE_MSGBOX,"{00FFE6}AFK Players","{FF0000}none is afk" ,"OK","");
	return 1;
}
