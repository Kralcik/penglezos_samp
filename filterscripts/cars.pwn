// Car System
// Coded by zeruel_angel
// Reworked by khalifakk (2014)

#include <a_samp>

#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_RED 0xAA3333AA
#define COLOR_WHITE 0xFFFFFFAA
#define CAR_COST 50000

new owner[MAX_VEHICLES];
new ownedcar[MAX_PLAYERS];
new lockedCar[MAX_VEHICLES];
new wasInVehicle[MAX_PLAYERS];

//------------------------------------------------------------------------------
public OnFilterScriptInit()
        {
        print(" ");
        print(" ---------------------------------- ");
        print("       Car System Loaded            ");
        print(" ---------------------------------- ");
        print(" ");
        for (new i=0;i<MAX_PLAYERS;i++)
            {
            ownedcar[i]=-1;
            wasInVehicle[i]=-1;
            }
        for (new i=0;i<MAX_VEHICLES;i++)
            {
            owner[i]=-1;
            lockedCar[i]=0;
            }
        }
//------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
        {
        SendClientMessage(playerid,COLOR_YELLOW,"For car commands press: /carhelp");
        for (new i=0;i<700;i++)
            {
            if	(lockedCar[i]==1)
                {
                SetVehicleParamsForPlayer( i, playerid, 0, 1);
                }
            }
        }
//------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
	{
	new idx;
	new cmd[255];
	new tmp[255];
	cmd = strtok(cmdtext,idx);

	if  (strcmp(cmdtext, "/carhelp", true)==0)
            {
            SendClientMessage(playerid, COLOR_GREEN,"Available commands:");
            SendClientMessage(playerid, COLOR_YELLOW,"/lock, /unlock, /purchase, /sellmycar, /callmycar, /ejectcar, /ejectcarall");
            return 1;
            }

	if	(strcmp(cmdtext, "/lock", true)==0)
        {
        if	(IsPlayerInAnyVehicle(playerid))
        	{
            new State=GetPlayerState(playerid);
            if  (State!=PLAYER_STATE_DRIVER)
                {
                SendClientMessage(playerid,0xFFFF00AA,"You can only lock the doors as the driver.");
                return 1;
                }
            lockedCar[GetPlayerVehicleID(playerid)]=1;
            new i;
	        for (i=0;i<MAX_PLAYERS;i++)
	            {
	                if(i != playerid)
	                {
	                SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
	                }
	            }
	        SendClientMessage(playerid, 0xFFFF00AA, "Vehicle locked!");
	        new Float:pX, Float:pY, Float:pZ;
	        GetPlayerPos(playerid,pX,pY,pZ);
	        PlayerPlaySound(playerid,1056,pX,pY,pZ);
	        }
        else
            {
            SendClientMessage(playerid, 0xFFFF00AA, "You're not in a vehicle!");
            }
        return 1;
        }

    if  (strcmp(cmdtext, "/unlock", true)==0)
        {
        if	(IsPlayerInAnyVehicle(playerid))
            {
            new State=GetPlayerState(playerid);
            if  (State!=PLAYER_STATE_DRIVER)
                {
                SendClientMessage(playerid,0xFFFF00AA,"You can only unlock the doors as the driver.");
                return 1;
                }
            new i;
            lockedCar[GetPlayerVehicleID(playerid)]=0;
            for	(i=0;i<MAX_PLAYERS;i++)
                {
                SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
                }
            SendClientMessage(playerid, 0xFFFF00AA, "Vehicle unlocked!");
            new Float:pX, Float:pY, Float:pZ;
            GetPlayerPos(playerid,pX,pY,pZ);
            PlayerPlaySound(playerid,1057,pX,pY,pZ);
            }
        else
            {
            SendClientMessage(playerid, 0xFFFF00AA, "You're not in a vehicle!");
            }
        return 1;
        }
    if	(strcmp(cmdtext, "/purchase", true)==0) // to set the vehicle that you register to be teleported
        {
        if (GetPlayerMoney(playerid) < CAR_COST)
            {
            SendClientMessage(playerid,COLOR_YELLOW,"Sorry, you don't have enough money to buy a car.");
            return 1;
            }
        if  (!(IsPlayerInAnyVehicle(playerid)))
            {
            SendClientMessage(playerid,COLOR_YELLOW,"Please get in a vehicle to buy it.");
            return 1;
            }
        if  (owner[GetPlayerVehicleID(playerid)]!=-1)
            {
            SendClientMessage(playerid,COLOR_YELLOW,"This car already have an owner");
            return 1;
            }
        if  (ownedcar[playerid]!=-1)
            {
            SendClientMessage(playerid,COLOR_YELLOW,"You already have a car, use /sellmycar to sell it in any moment.");
            return 1;
            }
        ownedcar[playerid] = GetPlayerVehicleID(playerid);
        owner[ownedcar[playerid]] = playerid;
        SendClientMessage(playerid,COLOR_YELLOW,"Congragulations! You have purchased a new car.");
        GivePlayerMoney(playerid,-CAR_COST);
        return 1;
        }
    if	(strcmp(cmdtext, "/sellmycar", true)==0)
        {
        if  (ownedcar[playerid]==-1)
            {
            SendClientMessage(playerid,COLOR_YELLOW,"You don't have any car...");
            return 1;
            }
		if 	(lockedCar[ownedcar[playerid]]==1)
		    {
	 	    lockedCar[ownedcar[playerid]]=0;
	     	for	(new i=0;i<MAX_PLAYERS;i++)
	            {
	            SetVehicleParamsForPlayer(ownedcar[playerid],i, 0, 0);
	            }
		    }
        owner[ownedcar[playerid]] = -1;
        ownedcar[playerid] = -1;
        SendClientMessage(playerid,COLOR_YELLOW,"You have sold your car, you get back half of your money");
        GivePlayerMoney(playerid,CAR_COST/2);
        return 1;
        }
    if  (strcmp(cmdtext, "/callmycar", true)==0)
        {
        if	(ownedcar[playerid] != -1)
            {
            if  (GetPlayerMoney(playerid) < 1000)
                {
                SendClientMessage(playerid,COLOR_YELLOW,"Sorry, you don't have enough money to use the car teleport service.");
                }
             else
                {
                new Float:playerpos[4];
                GetPlayerPos(playerid,playerpos[0],playerpos[1],playerpos[2]);
                GetPlayerFacingAngle(playerid,playerpos[3]);
                SetVehicleZAngle(ownedcar[playerid],playerpos[3]+90.0);
                SetVehiclePos(ownedcar[playerid],playerpos[0]+3.0*floatsin(-playerpos[3],degrees),playerpos[1]+3.0*floatcos(-playerpos[3],degrees),playerpos[2]+0.5); // This one is cool that I am using trigo functions to set the vehicle just before you.
                SendClientMessage(playerid,COLOR_YELLOW,"Thank you for using car teleport service. Your car has came.");
                GivePlayerMoney(playerid,-1000);
                }
            }
        }

    if	(strcmp(cmd,"/ejectcar", true)==0){
		new vehicleid;
		new pid;
		new playerstate = GetPlayerState(playerid);
		tmp = strtok(cmdtext,idx);
		if	(!IsPlayerInAnyVehicle(playerid))
			{
			SendClientMessage(playerid,COLOR_YELLOW,"You're not in a vehicle");
			return 1;
			}
		if	(playerstate == PLAYER_STATE_PASSENGER)
			{
			SendClientMessage(playerid,COLOR_RED,"Passengers can't use This!");
			return 1;
			}
		vehicleid = GetPlayerVehicleID(playerid);
		if	(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"USAGE: /ejectcar [playerid]");
			return 1;
			}
		pid = strval(tmp);
		if	(!IsPlayerConnected(pid))
			{
			SendClientMessage(playerid,COLOR_RED,"That Player Is Not Connected...");
			return 1;
			}
		if	(!IsPlayerInVehicle(pid,vehicleid))
			{
			SendClientMessage(playerid,COLOR_RED,"That Player Is Not In Your Vehicle...");
			return 1;
			}
		else
			{
			RemovePlayerFromVehicle(pid);
			GameTextForPlayer(pid,"~r~YOU'VE BEEN EJECTED!",3000,5);
			return 1;
			}
		}
    if	(strcmp(cmd,"/ejectcarall", true)==0){
		new vehicleid;
		new playerstate = GetPlayerState(playerid);
		if	(!IsPlayerInAnyVehicle(playerid))
			{
			SendClientMessage(playerid,COLOR_YELLOW,"You're not in a vehicle");
			return 1;
			}
		if	(playerstate == PLAYER_STATE_PASSENGER)
			{
			SendClientMessage(playerid,COLOR_RED,"Passengers can't use This!");
			return 1;
			}
		vehicleid = GetPlayerVehicleID(playerid);
		for (new i=0;i<MAX_PLAYERS;i++)
		    {
			if	((IsPlayerConnected(i))&&(IsPlayerInVehicle(i,vehicleid)))
				{
				RemovePlayerFromVehicle(i);
				GameTextForPlayer(i,"~r~YOU'VE BEEN EJECTED!",3000,5);
				return 1;
				}
			}
		}
    return 0;
    }
//------------------------------------------------------------------------------
public OnPlayerStateChange(playerid, newstate, oldstate)
	{
	if 	(newstate==PLAYER_STATE_DRIVER)
	    {
		wasInVehicle[playerid]=GetPlayerVehicleID(playerid);
		if	((owner[GetPlayerVehicleID(playerid)]!=-1)&&(owner[GetPlayerVehicleID(playerid)]!=playerid))
		    {
		    new name[MAX_PLAYER_NAME];
		    new msg[256];
		    GetPlayerName(owner[GetPlayerVehicleID(playerid)],name,sizeof(name));
		    format(msg,sizeof(msg),"This vehicle belongs to: %s",name);
		    }
	    }
	if 	(newstate==PLAYER_STATE_PASSENGER)
		{
		if	((owner[GetPlayerVehicleID(playerid)]!=-1)&&(owner[GetPlayerVehicleID(playerid)]!=playerid))
		    {
		    new name[MAX_PLAYER_NAME];
		    new msg[256];
		    GetPlayerName(owner[GetPlayerVehicleID(playerid)],name,sizeof(name));
		    format(msg,sizeof(msg),"This vehicle belongs to: %s",name);
		    SendClientMessage(playerid,COLOR_YELLOW,msg);
		    }
		}
	if 	(newstate==PLAYER_STATE_ONFOOT)
	    {
	    if 	((wasInVehicle[playerid]!=ownedcar[playerid])&&(lockedCar[wasInVehicle[playerid]]==1))
	        {
            lockedCar[GetPlayerVehicleID(playerid)]=0;
            for	(new i=0;i<MAX_PLAYERS;i++)
                {
                SetVehicleParamsForPlayer(ownedcar[playerid],i, 0, 0);
                }
            SendClientMessage(playerid, 0xFFFF00AA, "Vehicle unlocked!");
            new Float:pX, Float:pY, Float:pZ;
            GetPlayerPos(playerid,pX,pY,pZ);
            PlayerPlaySound(playerid,1057,pX,pY,pZ);
	        }
	    }
	return 1;
	}
//------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid, reason)
	{
	if 	((ownedcar[playerid]!=-1)&&(lockedCar[ownedcar[playerid]]=1))
	    {
	    lockedCar[ownedcar[playerid]]=0;
     	for	(new i=0;i<MAX_PLAYERS;i++)
            {
            SetVehicleParamsForPlayer(ownedcar[playerid],i, 0, 0);
            }
	    }
	if	(ownedcar[playerid]!=-1)
	    {
    	owner[ownedcar[playerid]]=-1;
    	ownedcar[playerid]=-1;
    	}
    wasInVehicle[playerid]=-1;
	return 1;
	}

//------------------------------------------------------------------------------
 strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
//------------------------------------------------------------------------------
