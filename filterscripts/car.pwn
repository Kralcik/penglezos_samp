// Car System
// /lock
// /unlock
// /xunlock (admin)

#include <a_samp>

new
	MaxPlayers,
	VehicleLocked[MAX_VEHICLES] = { -1, ... };

stock
	Un_Lock_Car(playerid, bool:locked)
{
	if(GetPlayerVehicleSeat(playerid) != 0) SendClientMessage(playerid, 0x0099FFAA, "You are not a driver!");
	else
	{
		new
			vehicleid = GetPlayerVehicleID(playerid);
		if(VehicleLocked[vehicleid - 1] == ((locked)?(playerid):(-1))) SendClientMessage(playerid, 0x0099FFAA, (locked)?("Already vehicle locked!"):("The vehicle not locked!"));
		else
		{
			VehicleLocked[vehicleid - 1] = (locked)?(playerid):(-1);
			for(new p; p < MaxPlayers; p++)
			{
				if(IsPlayerConnected(p) && p != playerid) { SetVehicleParamsForPlayer(vehicleid, p, false, locked);	}
			}
			SendClientMessage(playerid, 0x0099FFAA, (locked)?("Vehicle locked!"):("Vehicle unlocked!"));
		}
	}
}

stock
	UnLockAllCar(playerid)
{
	for(new vehicleid = 1; vehicleid <= MAX_VEHICLES; vehicleid++)
	{
		if(VehicleLocked[vehicleid - 1] != playerid)
		{
			VehicleLocked[vehicleid - 1] = -1;
			for(new p; p < MaxPlayers; p++)
			{
				if(IsPlayerConnected(p)) { SetVehicleParamsForPlayer(vehicleid, p, false, false); }
			}
		}
	}
}


public
	OnPlayerDisconnect(playerid, reason)
{
	UnLockAllCar(playerid);
	return 1;
}

public
	OnVehicleStreamIn(vehicleid, forplayerid)
{
	if(VehicleLocked[vehicleid - 1] != -1 && VehicleLocked[vehicleid - 1] != forplayerid)
	{
		SetVehicleParamsForPlayer(vehicleid, forplayerid, false, true); // Relock vehicle
	}
	return 1;
}

public
	OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp("/lock", cmdtext, true))
	{
		Un_Lock_Car(playerid, true);
		return 1;
	}

	if(!strcmp("/unlock", cmdtext, true))
	{
		Un_Lock_Car(playerid, false);
		return 1;
	}

	if(!strcmp("/xunlock", cmdtext, true))
	{
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0x0099FFAA, "You are not rcon admin!");
		UnLockAllCar(-1);
		SendClientMessage(playerid, 0x0099FFAA, "All Vehicle unlocked!");
		return 1;
	}
	return 0;
}

public
	OnFilterScriptExit()
{
	UnLockAllCar(-1);
	return 1;
}
