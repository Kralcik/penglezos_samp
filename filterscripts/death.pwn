#define FILTERSCRIPT
#include <a_samp>

// Configs:
#define MAX_OBJ 50 // Limit
#define SAVING // Uncomment this line if you want to save dropped guns to restore them after FS restarts
// -----------------------------------------------------------------------------
enum dGunEnum
{
	Float:ObjPos[3],
	ObjID,
	ObjData[2]
};
new dGunData[MAX_OBJ][dGunEnum];
// -----------------------------------------------------------------------------
new GunNames[48][] = {
	"Nothink", "Brass Knuckles", "Golf Club", "Nitestick", "Knife", "Baseball Bat",
	"Showel", "Pool Cue", "Katana", "Chainsaw", "Purple Dildo", "Small White Dildo",
	"Long White Dildo", "Vibrator", "Flowers", "Cane", "Grenade", "Tear Gas", "Molotov",
	"Vehicle Missile", "Hydra Flare", "Jetpack", "Glock", "Silenced Colt", "Desert Eagle",
	"Shotgun", "Sawn Off", "Combat Shotgun", "Micro UZI", "MP5", "AK47", "M4", "Tec9",
	"Rifle", "Sniper Rifle", "Rocket Launcher", "HS Rocket Launcher", "Flamethrower", "Minigun",
	"Satchel Charge", "Detonator", "Spraycan", "Fire Extinguisher", "Camera", "Nightvision",
	"Infrared Vision", "Parachute", "Fake Pistol"
};
// -----------------------------------------------------------------------------
new GunObjects[47] = {
	0,331,333,334,335,336,337,338,339,341,321,322,323,324,325,326,342,343,344,
	0,0,0,346,347,348,349,350,351,352,353,355,356,372,357,358,359,360,361,362,
	363,364,365,366,367,368,368,371
};
// -----------------------------------------------------------------------------
public OnFilterScriptInit()
{
	for(new n = 0; n < MAX_OBJ; n++) dGunData[n][ObjID] = -1;
 	print("\n");
	print(" Gun System Loaded");
	#if defined SAVING
	new File:file = fopen("DroppedGuns.ini", io_read);
    if(file)
    {
        new buffer[256], FileCoords[5][20];
        for(new g = 0; g < MAX_OBJ; g++)
        {
            fread(file, buffer);
            split(buffer, FileCoords, ',');
            dGunData[g][ObjPos][0] = floatstr(FileCoords[0]);
			dGunData[g][ObjPos][1] = floatstr(FileCoords[1]);
			dGunData[g][ObjPos][2] = floatstr(FileCoords[2]);
			dGunData[g][ObjData][0] = strval(FileCoords[3]);
			dGunData[g][ObjData][1] = strval(FileCoords[4]);
			if(dGunData[g][ObjData][0] > 0 && dGunData[g][ObjData][1] != 0 && dGunData[g][ObjPos][0] != 0)
			{
				dGunData[g][ObjID] = CreateObject(GunObjects[dGunData[g][ObjData][0]], dGunData[g][ObjPos][0], dGunData[g][ObjPos][1], dGunData[g][ObjPos][2]-1, 93.7, 120.0, 120.0);
				printf("* %s loaded: %f,%f,%f", GunNames[dGunData[g][ObjData][0]], dGunData[g][ObjPos][0], dGunData[g][ObjPos][1], dGunData[g][ObjPos][2]-1);
			}
        }
    }
    else print("ERROR: Failed to open \"DroppedGuns.ini\"");
	#endif
	return 1;
}
// -----------------------------------------------------------------------------
public OnFilterScriptExit()
{
    #if defined SAVING
    new File:file = fopen("DroppedGuns.ini", io_append);
    if(file)
    {
        fclose(file);
		for(new g = 0, buffer[50]; g < MAX_OBJ; g++)
		{
			format(buffer, sizeof(buffer), "%f,%f,%f,%d,%d\n",
			dGunData[g][ObjPos][0],
			dGunData[g][ObjPos][1],
			dGunData[g][ObjPos][2],
			dGunData[g][ObjData][0],
			dGunData[g][ObjData][1]);
			if(g == 0) file = fopen("DroppedGuns.ini", io_write);
			else file = fopen("DroppedGuns.ini", io_append);
			fwrite(file, buffer);
			fclose(file);
			if(dGunData[g][ObjData][0] > 0 && dGunData[g][ObjPos][1] != 0)
			{
			    DestroyObject(dGunData[g][ObjID]);
				printf("* %s saved: %f,%f,%f", GunNames[dGunData[g][ObjData][0]], dGunData[g][ObjPos][0], dGunData[g][ObjPos][1], dGunData[g][ObjPos][2]-1);
			}
		}
    }
    else print("ERROR: Failed to open \"DroppedGuns.ini\"");
	#endif
	return 1;
}
// -----------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
    if(strcmp(cmdtext, "/dropgun", true) == 0
	|| strcmp(cmdtext, "/dgun", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
        new GunID = GetPlayerWeapon(playerid);
        new GunAmmo = GetPlayerAmmo(playerid);
        if(GunID > 0 && GunAmmo != 0)
        {
            new f = MAX_OBJ+1;
            for(new a = 0; a < MAX_OBJ; a++)
            {
                if(dGunData[a][ObjPos][0] == 0.0)
                {
                    f = a;
                    break;
                }
            }
            if(f > MAX_OBJ) return SendClientMessage(playerid, 0x33AA3300, "You can not throw weapons at the moment, try back later!");
			RemovePlayerWeapon(playerid, GunID);
			dGunData[f][ObjData][0] = GunID;
			dGunData[f][ObjData][1] = GunAmmo;
            GetPlayerPos(playerid, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]);
            dGunData[f][ObjID] = CreateObject(GunObjects[GunID], dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 93.7, 120.0, 120.0);
            new buffer[50];
			format(buffer, sizeof(buffer), "You threw %s", GunNames[dGunData[f][ObjData][0]]);
			SendClientMessage(playerid, 0x33AA3300, buffer);
        }
        return 1;
    }
    if(strcmp(cmdtext, "/pickupgun", true) == 0
	|| strcmp(cmdtext, "/pgun", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
        new f = MAX_OBJ+1;
		for(new a = 0; a < MAX_OBJ; a++)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 5.0, dGunData[a][ObjPos][0], dGunData[a][ObjPos][1], dGunData[a][ObjPos][2]))
		    {
		        f = a;
		        break;
		    }
		}
		if(f > MAX_OBJ) return SendClientMessage(playerid, 0x33AA3300, "You are not near the weapon which you can pick up!");
		DestroyObject(dGunData[f][ObjID]);
		GivePlayerWeapon(playerid, dGunData[f][ObjData][0], dGunData[f][ObjData][1]);
		dGunData[f][ObjPos][0] = 0.0;
		dGunData[f][ObjPos][1] = 0.0;
		dGunData[f][ObjPos][2] = 0.0;
		dGunData[f][ObjID] = -1;
		//dGunData[f][ObjData][0] = 0;
		dGunData[f][ObjData][1] = 0;
		new buffer[50];
		format(buffer, sizeof(buffer), "You picked up %s", GunNames[dGunData[f][ObjData][0]]);
  		SendClientMessage(playerid, 0x33AA3300, buffer);
  		return 1;
    }
	return 0;
}
// -----------------------------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
    GivePlayerMoney(playerid, -500);
    SendClientMessage(playerid, 0x33AA3300, "You gave 500$ to the medics because they healed you life! Thank them!");
 	new Float:pPosX, Float:pPosY, Float:pPosZ;
	GetPlayerPos(playerid, pPosX, pPosY, pPosZ);
    for(new i_slot = 0, gun, ammo; i_slot != 12; i_slot++)
    {
        GetPlayerWeaponData(playerid, i_slot, gun, ammo);
        if(gun != 0 && ammo != 0) CreateDroppedGun(gun, ammo, pPosX+random(2)-random(2), pPosY+random(2)-random(2), pPosZ);
    }
	return 1;
}
stock CreateDroppedGun(GunID, GunAmmo, Float:gPosX, Float:gPosY, Float:gPosZ)
{
	new f = MAX_OBJ+1;
    for(new a = 0; a < MAX_OBJ; a++)
    {
        if(dGunData[a][ObjPos][0] == 0.0)
        {
            f = a;
            break;
        }
    }
    if(f > MAX_OBJ) return;
    dGunData[f][ObjData][0] = GunID;
	dGunData[f][ObjData][1] = GunAmmo;
	dGunData[f][ObjPos][0] = gPosX;
	dGunData[f][ObjPos][1] = gPosY;
	dGunData[f][ObjPos][2] = gPosZ;
	dGunData[f][ObjID] = CreateObject(GunObjects[GunID], dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 93.7, 120.0, random(360));
	return;
}
// -----------------------------------------------------------------------------
stock RemovePlayerWeapon(playerid, weaponid)
{ 
	new plyWeapons[12] = 0;
	new plyAmmo[12] = 0;
	for(new sslot = 0; sslot != 12; sslot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, sslot, wep, ammo);
		if(wep != weaponid && ammo != 0) GetPlayerWeaponData(playerid, sslot, plyWeapons[sslot], plyAmmo[sslot]);
	}
	ResetPlayerWeapons(playerid);
	for(new sslot = 0; sslot != 12; sslot++) if(plyAmmo[sslot] != 0) GivePlayerWeapon(playerid, plyWeapons[sslot], plyAmmo[sslot]);
	return 1;
}
stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
