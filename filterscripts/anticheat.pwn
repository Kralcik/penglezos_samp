///////////////////////////////////////////////////////
//// ANTI CHEAT PROTECTION
//// CODED BY KHALIFAKK
///////////////////////////////////////////////////////

#include <a_samp>

new Float:_oldHealth, Float:_oldArmour;
new pMoney[MAX_PLAYERS];
new PlayerPressedJump[MAX_PLAYERS];
new Timer[MAX_PLAYERS];

#define MAX_PING 1000
#define MAX_CAR_SPEED 450

forward CheckPing(playerid);
forward PressJump(playerid);
forward PressJumpReset(playerid);
forward CarSpeed(playerid);

public OnPlayerSpawn(playerid)
{
    Timer[playerid] = SetTimerEx("CheckPing",1000,1,"i",playerid);
    return 1;
}

public OnPlayerConnect(playerid)
{
    pMoney[playerid] = 0;
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    pMoney[playerid] = 0;
    return 1;
}

public OnPlayerUpdate(playerid)
{
    new Float:health, Float:armour;
    GetPlayerHealth(playerid,health);
    GetPlayerArmour(playerid,armour);
    _oldHealth = health;
    _oldArmour = armour;
    new PlayerWeapon[MAX_PLAYERS];
    new gunname[32];
    new string[120];
    PlayerWeapon[playerid] = GetPlayerWeapon(playerid);
    if(PlayerWeapon[playerid] == 38 || PlayerWeapon[playerid] == 39 || PlayerWeapon[playerid] == 36 || PlayerWeapon[playerid] == 35 || PlayerWeapon[playerid] == 37 || PlayerWeapon[playerid] == 40)
    {
        GetWeaponName(PlayerWeapon[playerid],gunname,sizeof(gunname));
        format(string,sizeof(string),"{FF0000}[Warning] {15FF00}Player: {FF0000}%s {15FF00}with ID: {FF0000} %d {15FF00}has been banned by {FF0000}Server BOT || {FFFF00}Reason: {15FF00}Weapon Hack",GetName(playerid),playerid,gunname);
        SendClientMessageToAll(-1,string);
        Ban(playerid);
    }
    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
    {
        new string2[120];
        format(string,sizeof(string),"{FF0000}[Warning] {15FF00}Player: {FF0000}%s {15FF00}with ID: {FF0000} %d {15FF00}has been banned by {FF0000}Server BOT || {FFFF00}Reason: {15FF00}Jetpack Hack",GetName(playerid),playerid);
        SendClientMessageToAll(-1,string2);
        Ban(playerid);
    }
    new pName[MAX_PLAYER_NAME];
    if(GetPlayerMoney(playerid) > pMoney[playerid])
    {
        GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    if(playerid != INVALID_PLAYER_ID)
    {
	    new Float:nHealth, Float:nArmour, localString[128],pName[24];
		GetPlayerHealth(playerid,nHealth);
        GetPlayerArmour(playerid,nArmour);
        GetPlayerName(playerid,pName,24);
        if(nHealth == _oldHealth && nArmour == _oldArmour)
        {
            format(localString,sizeof(localString),"{FF0000}[Warning] {15FF00}Player: {FF0000}%s {15FF00}with ID: {FF0000} %d {15FF00}has been banned by {FF0000}Server BOT || {FFFF00}Reason: {15FF00}Jetpack Hack");
            SendClientMessageToAll(-1,localString);
            Ban(playerid);
        }
    }
    return 1;
}

public CheckPing(playerid)
{
    if(GetPlayerPing(playerid) > MAX_PING) Kick(playerid);
}

public PressJump(playerid)
{
    PlayerPressedJump[playerid] = 0;
    ClearAnimations(playerid);
    return 1;
}

public PressJumpReset(playerid)
{
    PlayerPressedJump[playerid] = 0;
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
    {
        PlayerPressedJump[playerid] ++;
        SetTimerEx("PressJumpReset", 3000, false, "i", playerid);
        if(PlayerPressedJump[playerid] == 3)
        {
            ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
            SetTimerEx("PressJump", 9000, false, "i", playerid);
			SendClientMessage(playerid,-1, "{FF0000}[INFO]: {15FF00}Please, stop {FFFF00}Bunny Hoping !");
        }
    }
    return 1;
}

stock GetName(playerid)
{
    new pName22[68];
    GetPlayerName(playerid, pName22, sizeof(pName22));
    return pName22;
}

stock a_GivePlayerMoney(playerid, money)
{
    pMoney[playerid] += money;
    GivePlayerMoney(playerid, money);
}
stock a_SetPlayerMoney(playerid, money)
{
    pMoney[playerid] = money;
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, money);
}

stock GetPlayerSpeed(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    return floatround(ST[3]);
}
