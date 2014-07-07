#if defined _H_admin_included
#endinput
#endif
#define _H_admin_included
#pragma library H_admin

#include "Hadmin/DDD.inc" //dini, DUDB, dutils
#include <a_samp>


new WeaponNames[][] = {
	{"Unarmed (Fist)"},{"Brass Knuckles"}, {"Golf Club"}, {"Night Stick"}, {"Knife"}, {"Baseball Bat"}, {"Shovel"}, {"Pool Cue"}, {"Katana"}, {"Chainsaw"},
	{"Purple Dildo"}, {"Big White Vibrator"}, {"Medium White Vibrator"}, {"Small White Vibrator"}, {"Flowers"}, {"Cane"}, {"Grenade"}, {"Teargas"},{"Molotov"},
	{" "},{" "},{" "},{"Colt "},{"Colt  (Silenced)"},{"Desert Eagle"},{"Normal Shotgun"},{"Sawnoff Shotgun"},{"Combat Shotgun"}, {"Micro Uzi (Mac )"},
	{"MP"},{"AK"},{"M4"},{"Tec"},{"Country Rifle"},{"Sniper Rifle"},{"Rocket Launcher"},{"Heat-Seeking Rocket Launcher"},{"Flamethrower"}, {"Minigun"},
	{"Satchel Charge"},{"Detonator"},{"Spray Can"},{"Fire Extinguisher"},{"Camera"},{"Night Vision Goggles"},{"Infrared Vision Goggles"},{"Parachute"},{"Fake Pistol"}
};
new aVehicleNames[212][] = {	// Vehicle Names - Betamaster
	{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},{"Firetruck"},
	{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},{"Cheetah"},{"Ambulance"},
	{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},
	{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},
	{"Hotknife"},{"Trailer 1"},{"Previon"},{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},
	{"Packer"},{"Monster"},{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
	{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},{"Skimmer"},
	{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},{"Sanchez"},{"Sparrow"},
	{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},
	{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},
	{"FBI Rancher"},{"Virgo"},{"Greenwood"},{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},
	{"Boxville"},{"Benson"},{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
	{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},{"Tanker"},{"Roadtrain"},
	{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},
	{"Fortune"},{"Cadrona"},{"FBI Truck"},{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
	{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},{"Firetruck LA"},{"Hustler"},{"Intruder"},
	{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},
	{"Uranus"},{"Jester"},{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},{"Bandito"},
	{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},
	{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},
	{"Freight Carriage"},{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},{"Sadler"},{"Luggage Trailer A"},
	{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},{"Utility Trailer"}
};

enum PlayerInfo
{
	Registered,
	AdminLevel,
	logged,
	Jailed,
	Muted,
	Warnings,
	Frozen
};

stock Info[MAX_PLAYERS][PlayerInfo];

stock GetConfig(config[])
{
	return dini_Int("/Hadmin/config/configuration.ini",config);
}

stock GetSConfig(config[])
{
	return dini_Get("/Hadmin/config/configuration.ini",config);
}

stock SetConfig(config[],to)
{
	return dini_IntSet("/Hadmin/config/configuration.ini",config,to);
}

stock SetSConfig(config[],to[])
{
	return dini_Set("/Hadmin/config/configuration.ini",config,to);
}

stock GetFile(playerid)
{
	new string[256];
	format(string,256,"/Hadmin/users/%s.ini",udb_encode(Name(playerid)));
	return string;
}

Name(playerid)
{
    new pname[24];
    GetPlayerName(playerid, pname, 24);
    return pname;
}


stock SetInfo(playerid,info[],to)
{
	return dini_IntSet(GetFile(playerid),info,to);
}
stock GetInfo(playerid,info[])
{
	return dini_Int(GetFile(playerid),info);
}
stock SetSInfo(playerid,info[],to[])
{
	return dini_Set(GetFile(playerid),info,to);
}

stock IsPlayerHAdmin(playerid)
{
	if(GetInfo(playerid,"AdminLevel")>=1 && Info[playerid][logged]==1) return 1;
	if(IsPlayerAdmin(playerid)) return 1;
	else return 0;
}

stock PlayerIp(playerid)
{
    new PIP[16];
    GetPlayerIp(playerid,PIP,16);
    return PIP;
}

stock IsAdminLevel(playerid,level)
{
	if(GetInfo(playerid,"AdminLevel")>=level && Info[playerid][logged]==1) return 1;
	if(IsPlayerAdmin(playerid)) return 1;
	return 0;
}

stock CmdLevelCheck(playerid,cmd[])
{
	if(!dini_Exists("/Hadmin/config/commands.ini")) return SendClientMessage(playerid,LIGHTRED,"Sorry there are some problems with this command (cmd file not exites)"),0;
	if(!dini_Isset("/Hadmin/config/commands.ini",cmd)) return SendClientMessage(playerid,LIGHTRED,"Sorry there are some problems with this command (cmd/level not set)"),0;
	if(GetInfo(playerid,"AdminLevel")>=dini_Int("/Hadmin/config/commands.ini",cmd) && Info[playerid][logged]==1) return 1;
	return 0;
}

stock CmdLevelError(playerid,cmd[])
{
	new string[128];
	format(string,sizeof(string),"You need level %d to use the command /%s",dini_Int("/Hadmin/config/commands.ini",cmd),cmd);
	return SendClientMessage(playerid,RED,string);
}

stock SendMessageToAdmins(COLOR,text[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			if(Info[i][AdminLevel] >= 1)
			{
			    SendClientMessage(i,COLOR,text);
			}
		}
	}
	return 1;
}

stock SaveToLog(log[],what[])
{
	new file[256],text[256],File:logfile,hour,mins,day,month,year;
	format(file,sizeof(file),"/Hadmin/Logs/%s.ini",log);
	if(!dini_Exists(file)) return dini_Create(file);
	gettime(hour,mins),getdate(year,month,day);
	format(text,sizeof(text),"[%d,%d,%d][%d,%d] %s \r\n",day,month,year,hour,mins,what);
	logfile = fopen(file,io_append);
	fwrite(logfile,text);
	fclose(logfile);
	return 1;
}

stock AdminName(playerid)
{
	new pname[24];
	if(GetInfo(playerid,"ShowName")==0) GetPlayerName(playerid, pname, 24);
	else if(GetInfo(playerid,"ShowName")==1) format(pname,sizeof(pname),"**secret**");
	return pname;
}


stock GetWeaponID(name[])
{
    for(new wps=0; wps < 48; wps++)
	{
        if (wps==19||wps==20||wps== 21) continue;
		if (strfind(WeaponNames[wps],name, true) != -1) {
			return wps;
		} // thanks to debug
	}
	return -1;
}
stock GetVehicleID(name[]) { for(new i = 0; i < 211; i++) if(strfind(aVehicleNames[i], name, true) != -1 ) return i + 400; return -1; } // thanks to debug
stock CreateVehicleHere(playerid,vehicleid)
{
	if(IsPlayerInAnyVehicle(playerid)) return 0;
	new Float:X,Float:Y,Float:Z,Float:A,CAR;
	GetPlayerPos(playerid,X,Y,Z);
	CAR = CreateVehicle(vehicleid,X,Y,Z,A,-1,-1,99999999);
	if(GetPlayerInterior(playerid)) LinkVehicleToInterior(CAR,GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(CAR,GetPlayerVirtualWorld(playerid));
	PutPlayerInVehicle(playerid,CAR,0);
	return 1;
}

stock SendCommandMsg(id,command[])
{
	new string[128];
	format(string,sizeof(string),"Admin: %s has used the command /%s",Name(id),command);
	if(GetConfig("cmdmsg")==1) SendMessageToAdmins(0x00FFFFAA,string);
	if(GetConfig("cmdprint")==1) print(string);
	if(GetConfig("logcmd")==1) SaveToLog("commandlog",string);
	return 1;
}

stock IsVehicleACar(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);
    switch(modelid)
    {
	    case 448,461,462,463,468,471,481,509,510,521,522,523,581,586, //bikes
		590, 569, 537, 538, 570, 449, //trains
		472, 473, 493, 595, 484, 430, 453, 452, 446, 454, //boats
		592, 577, 511, 512, 593, 520,553,464,476,519, 460,513,539,548,425,417,487,497,563,501,465, 447,469,488: return 0;
		default: return 1;
	}
	return 0;
}

stock IsSkinWrong(skin) { switch(skin) { case 3,4,5,6,8,42,65,74,86,119,149,208,273,289: return 1; } return 0; }
