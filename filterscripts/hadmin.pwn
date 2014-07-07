// Administrator Script
// Coded by Hamptonin (2009)
// Reworked by Khalifakk (2014)

#include <a_samp>
#include </Hadmin/h_admin>
new Text:ColorHelp0,Text:ColorHelp1,Text:ColorHelp2,Text:ColorHelp3,Text:ColorHelp4,Text:closehelp,Text:Clock;
new ColorOpen[MAX_PLAYERS], playercolor[MAX_PLAYERS], Specting[MAX_PLAYERS],SpecID[MAX_PLAYERS];
new IsVehicleLocked[MAX_VEHICLES],Float:DiePos[MAX_PLAYERS][4],GoodLockPass[MAX_PLAYERS];
new Text:AdminText, Spams[MAX_PLAYERS],FailLogin[MAX_PLAYERS],Float:SavedPos[MAX_PLAYERS][4],SavedPos2[MAX_PLAYERS][2];
new Menu:weaponmain,Counts=0,CountTimer,Ignore[MAX_PLAYERS][MAX_PLAYERS],TryEnter[MAX_PLAYERS],LockCount[MAX_PLAYERS]=0,LockTimer[MAX_PLAYERS];
new BadWords[100][100],BadWordSize = 0,BadTalkedWord[MAX_PLAYERS]=0,NoCaps[MAX_PLAYERS]=0,PlayerLeaveReason[MAX_PLAYERS][128],SpecialLeaveReason[MAX_PLAYERS];
new Menu:weapon1,Menu:weapon2, Menu:weapon3, Menu:weapon4, Menu:weapon5, Menu:weapon6, Menu:weapon7,RconLocked=0;
new Menu:weapon8, Menu:weapon9, Menu:weapon10, Menu:bullets, wantedg[MAX_PLAYERS],CmdsLocked[MAX_PLAYERS];
new Float:HspecPos[MAX_PLAYERS][5],HspecVeh[MAX_PLAYERS],PingTimer[MAX_PLAYERS],SpamTimer, GodMode[MAX_PLAYERS], GodWarning[MAX_PLAYERS];
new VoteKick[MAX_PLAYERS],Voted[MAX_PLAYERS],Voting=0,VoteStarted[MAX_PLAYERS],Text:VoteText,Votes=0,Text:VoteTimer,VoteSeconds=0,voterTimer,VC=0;
new Menu:VehicleMenu,Menu:PimpMenu, ServerLock=0, GodCarOn[MAX_PLAYERS], MuteAll=0, LockPrivm=0, LockChat=0, VotePlayerCount=0, VoteUpdate;


#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define Lower(%1) for(new i; i < strlen(%1); i++) if ( %1[i] > 64 && %1[i] < 91) %1[i] += 32
#define HRESTART "reloadfs hadmin"


#define FILTERSCRIPT

#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("\n     ------------------------------");
	SetTimer("GodCar",5000,1);
	print("     | Creating Textdraw's...     |");
	ColorHelp0 = TextDrawCreate(166.000000,121.000000,"_________~g~H~w~Help ~r~Colors~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~");
	ColorHelp1 = TextDrawCreate(172.000000,145.000000,"GREY~n~YELLOW~n~PINK~n~BLUE~n~WHITE~n~LIGHTBLUE~n~DARKRED~n~ORANGE~n~BRIGHTRED~n~INDIGO~n~VIOLET~n~LIGHTRED~n~SEAGREEN");
	ColorHelp2 = TextDrawCreate(173.000000,263.000000,"GRAYWHITE~n~LIGHTNEUTRALBLUE~n~GREENISHGOLD~n~LIGHTBLUEGREEN~n~NEUTRALBLUE~n~LIGHTCYAN~n~LEMON~n~MEDIUMBLUE~n~NEUTRAL~n~BLACK~n~");
	ColorHelp3 = TextDrawCreate(341.000000,146.000000,"NEUTRALGREEN~n~DARKGREEN~n~LIGHTGREEN~n~DARKBLUE~n~BLUEGREEN~n~PINK~n~LIGHTBLUE~n~DARKRED~n~ORANGE~n~PURPLE~n~GREY~n~GREEN~n~RED");
	ColorHelp4 = TextDrawCreate(341.000000,263.000000,"YELLOW~n~WHITE~n~BROWN~n~CYAN~n~TAN~n~PINK~n~KHAKI~n~LIME");
	closehelp = TextDrawCreate(271.000000,371.000000,"Press ~r~Space ~w~to close");
	TextDrawUseBox(ColorHelp0,1),TextDrawBoxColor(ColorHelp0,0x00000099),TextDrawTextSize(ColorHelp0,470.000000,0.000000);
	TextDrawAlignment(ColorHelp0,0),TextDrawAlignment(ColorHelp1,0),TextDrawAlignment(ColorHelp2,0),TextDrawAlignment(ColorHelp3,0);
	TextDrawAlignment(ColorHelp4,0),TextDrawAlignment(closehelp,0),
	TextDrawBackgroundColor(ColorHelp0,0x000000ff),TextDrawBackgroundColor(ColorHelp1,0x000000ff);
	TextDrawBackgroundColor(ColorHelp2,0x000000ff),TextDrawBackgroundColor(ColorHelp3,0x000000ff);
	TextDrawBackgroundColor(ColorHelp4,0x000000ff),TextDrawBackgroundColor(closehelp,0x000000ff);
	TextDrawFont(ColorHelp0,1),TextDrawLetterSize(ColorHelp0,0.599999,1.900000),TextDrawFont(ColorHelp1,1);
	TextDrawLetterSize(ColorHelp1,0.499999,1.000000),TextDrawFont(ColorHelp2,1),TextDrawLetterSize(ColorHelp2,0.499999,1.000000);
	TextDrawFont(ColorHelp3,1),TextDrawLetterSize(ColorHelp3,0.499999,1.000000),TextDrawFont(ColorHelp4,1);
	TextDrawLetterSize(ColorHelp4,0.499999,1.000000),TextDrawFont(closehelp,1),TextDrawLetterSize(closehelp,0.699999,1.300000),
	TextDrawColor(ColorHelp0,0xffffffff),TextDrawColor(ColorHelp1,0xffffffff),TextDrawColor(ColorHelp2,0xffffffff);
	TextDrawColor(ColorHelp3,0xffffffff),TextDrawColor(ColorHelp4,0xffffffff),TextDrawColor(closehelp,0xffffffff);
	TextDrawSetOutline(ColorHelp0,1),TextDrawSetOutline(ColorHelp1,1),TextDrawSetOutline(ColorHelp2,1);
	TextDrawSetOutline(ColorHelp3,1),TextDrawSetOutline(ColorHelp4,1),TextDrawSetOutline(closehelp,1);
	TextDrawSetProportional(ColorHelp0,1),TextDrawSetProportional(ColorHelp1,1),TextDrawSetProportional(ColorHelp2,1);
	TextDrawSetProportional(ColorHelp3,1),TextDrawSetProportional(ColorHelp4,1),TextDrawSetProportional(closehelp,1);
	TextDrawSetShadow(ColorHelp0,1),TextDrawSetShadow(ColorHelp1,1),TextDrawSetShadow(ColorHelp2,1),TextDrawSetShadow(ColorHelp3,1);
	TextDrawSetShadow(ColorHelp4,1),TextDrawSetShadow(closehelp,1);
	AdminText = TextDrawCreate(272.000000,430.000000,"_");
	TextDrawAlignment(AdminText,0);
	TextDrawBackgroundColor(AdminText,0x000000ff);
	TextDrawFont(AdminText,1);
	TextDrawLetterSize(AdminText,0.299999,1.800000);
	TextDrawColor(AdminText,0xffffffff);
	TextDrawSetOutline(AdminText,1);
	TextDrawSetProportional(AdminText,1);
	TextDrawSetShadow(AdminText,1);
	VoteText = TextDrawCreate(494.000000,401.000000,"_~w~Vote-kick: ~g~KK~n~_~r~5~w~/~r~8 ~w~Votes");
	TextDrawUseBox(VoteText,1);	TextDrawBoxColor(VoteText,0x00000099);	TextDrawTextSize(VoteText,650.000000,0.000000);
	TextDrawAlignment(VoteText,0);	TextDrawBackgroundColor(VoteText,0x000000ff);	TextDrawFont(VoteText,1);
	TextDrawLetterSize(VoteText,0.299999,1.600000);	TextDrawColor(VoteText,0xffffffff);	TextDrawSetOutline(VoteText,1);
	TextDrawSetProportional(VoteText,1);
	VoteTimer = TextDrawCreate(555.000000,415.000000,"~b~56 ~w~Seconds");
	TextDrawAlignment(VoteTimer,0); TextDrawBackgroundColor(VoteTimer,0x000000ff); TextDrawFont(VoteTimer,1);
	TextDrawLetterSize(VoteTimer,0.299999,1.700000); TextDrawColor(VoteTimer,0xffffffff);
	TextDrawSetOutline(VoteTimer,1); TextDrawSetProportional(VoteTimer,1); TextDrawSetShadow(VoteTimer,1);
	print("     | Textdraws Loaded.          |");
	print("     |                            |");
	print("     | Loading Menu's...          |");
	VehicleMenu = CreateMenu("H-Admin Vehicles", 0,200.0, 100.0, 300.0, 300.0);
	AddMenuItem(VehicleMenu, 0, "elegy");
    AddMenuItem(VehicleMenu, 0, "infernus");
    AddMenuItem(VehicleMenu, 0, "turismo");
    AddMenuItem(VehicleMenu, 0, "nrg-500");
    AddMenuItem(VehicleMenu, 0, "monster truck");
    AddMenuItem(VehicleMenu, 0, "dumper");
    AddMenuItem(VehicleMenu, 0, "swat van");
    AddMenuItem(VehicleMenu, 0, "hydra");
    AddMenuItem(VehicleMenu, 0, "Hunter");
    AddMenuItem(VehicleMenu, 0, "Stunt Plane");
    PimpMenu = CreateMenu("H-Admin Pimp Menu", 0,200.0, 100.0, 300.0, 300.0);
 	AddMenuItem(PimpMenu, 0, "Nitro");
    AddMenuItem(PimpMenu, 0, "Hydraulics");
    AddMenuItem(PimpMenu, 0, "Bass Boost stereo");
    AddMenuItem(PimpMenu, 0, "Twist weel");
    AddMenuItem(PimpMenu, 0, "Switch weel");
    AddMenuItem(PimpMenu, 0, "Mega weel");
    AddMenuItem(PimpMenu, 0, "Offroad weel");
    AddMenuItem(PimpMenu, 0, "Wires weel");
    AddMenuItem(PimpMenu, 0, "PaintJob 1");
    AddMenuItem(PimpMenu, 0, "PaintJob 2");
	AddMenuItem(PimpMenu, 0, "PaintJob 3");
	weaponmain = CreateMenu("weaponmain", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weaponmain, 0, "Melee Weapons");
	AddMenuItem(weaponmain, 0, "Handguns");
	AddMenuItem(weaponmain, 0, "Submachine Guns");
	AddMenuItem(weaponmain, 0, "Shotguns");
	AddMenuItem(weaponmain, 0, "Assault Rifles");
	AddMenuItem(weaponmain, 0, "Long Rifles");
	AddMenuItem(weaponmain, 0, "Thrown Weapons");
	AddMenuItem(weaponmain, 0, "Heavy Artillery");
	AddMenuItem(weaponmain, 0, "Equipment");
	AddMenuItem(weaponmain, 0, "Other");
	weapon1 = CreateMenu("Melee Weapons", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon1, 0, "Brass Knuckles");
	AddMenuItem(weapon1, 0, "Baseball Bat");
	AddMenuItem(weapon1, 0, "Nightstick");
	AddMenuItem(weapon1, 0, "Pool Cue");
	AddMenuItem(weapon1, 0, "Golf Club");
	AddMenuItem(weapon1, 0, "Shovel");
	AddMenuItem(weapon1, 0, "Knife");
	AddMenuItem(weapon1, 0, "Katana");
	AddMenuItem(weapon1, 0, "Chainsaw");
	AddMenuItem(weapon1, 0, "~r~Main Menu");
	weapon2 = CreateMenu("HandGuns", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon2, 0, "9mm");
	AddMenuItem(weapon2, 0, "Silenced 9mm");
	AddMenuItem(weapon2, 0, "Desert Eagle");
	AddMenuItem(weapon2, 0, "~r~Main Menu");
	weapon3 = CreateMenu("Submachine Guns", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon3, 0, "Tec-9");
	AddMenuItem(weapon3, 0, "Micro SMG");
	AddMenuItem(weapon3, 0, "SMG");
	AddMenuItem(weapon3, 0, "~r~Main Menu");
	weapon4 = CreateMenu("Submachine Guns", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon4, 0, "Shotgun");
	AddMenuItem(weapon4, 0, "Sawnoff Shotgun");
	AddMenuItem(weapon4, 0, "Combat ShotGun");
	AddMenuItem(weapon4, 0, "~r~Main Menu");
	weapon5 = CreateMenu("Submachine Guns", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon5, 0, "M4");
	AddMenuItem(weapon5, 0, "AK47");
	AddMenuItem(weapon5, 0, "~r~Main Menu");
	weapon6 = CreateMenu("Submachine Guns", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon6, 0, "Rifle");
	AddMenuItem(weapon6, 0, "Sniper Rifle");
	AddMenuItem(weapon6, 0, "~r~Main Menu");
	weapon7 = CreateMenu("Thrown Weapons", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon7, 0, "Molotov Cocktail");
	AddMenuItem(weapon7, 0, "Grenade");
	AddMenuItem(weapon7, 0, "Remote Explosives");
	AddMenuItem(weapon7, 0, "Tear Gas");
	AddMenuItem(weapon7, 0, "~r~Main Menu");
	weapon8 = CreateMenu("Heavy Artillery", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon8, 0, "Flame Thrower");
	AddMenuItem(weapon8, 0, "MiniGun");
	AddMenuItem(weapon8, 0, "Rocket Launcher");
	AddMenuItem(weapon8, 0, "Heat Seeking Rocket Launcher");
	AddMenuItem(weapon8, 0, "~r~Main Menu");
	weapon9 = CreateMenu("Equipment", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon9, 0, "Spraycan");
	AddMenuItem(weapon9, 0, "Camera");
	AddMenuItem(weapon9, 0, "Fire Extinguisher");
	AddMenuItem(weapon9, 0, "Parachute");
	AddMenuItem(weapon9, 0, "Thermal Goggles");
	AddMenuItem(weapon9, 0, "Night-Vision Goggles");
	AddMenuItem(weapon9, 0, "~r~Main Menu");
	weapon10 = CreateMenu("Other", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(weapon10, 0, "Cane");
	AddMenuItem(weapon10, 0, "Flowers");
	AddMenuItem(weapon10, 0, "Dildo 1");
	AddMenuItem(weapon10, 0, "Dildo 2");
	AddMenuItem(weapon10, 0, "Vibrator 1");
	AddMenuItem(weapon10, 0, "Vibrator 2");
	AddMenuItem(weapon10, 0, "~r~Main Menu");
	bullets = CreateMenu("Other", 2, 200.0, 100.0, 150.0, 150.0);
	AddMenuItem(bullets, 0, "10 bullet");
	AddMenuItem(bullets, 0, "50 bullet");
	AddMenuItem(bullets, 0, "100 bullets");
	AddMenuItem(bullets, 0, "500 bullets");
	AddMenuItem(bullets, 0, "1000 bullets");
	AddMenuItem(bullets, 0, "5000 bullets");
	AddMenuItem(bullets, 0, "~r~Main Menu");
	new	str[100],File:file;
	if(GetConfig("AntiSpam")==1) SpamTimer = SetTimer("SpamReset", (GetConfig("SpamTime") * 1000) / GetConfig("Max_Spams"), 1);
	if((file = fopen("/Hadmin/config/BadWords.ini",io_read)))
	{
		while(fread(file,str))
		{
		    for(new w = 0, b = strlen(str); w < b; w++) if(str[w] == '\n' || str[w] == '\r') str[w] = '\0';
            BadWords[BadWordSize] = str;
            BadWordSize++;
		}
		fclose(file);
	}
    print("     | Menu's Loaded              |"),
	print("     |                            |");
    print("     | Loading Files...           |");
    if(!dini_Exists("/Hadmin/config") || !dini_Exists("/Hadmin/users") || !dini_Exists("/Hadmin/logs")) print("     | Not Exists...              |");
    else print("     | Files Loaded.              |");
	if(!dini_Exists("/Hadmin/config")) print("     | Folder: /Hadmin/config     |"), print("     | File: configuration.ini    |");
    if(!dini_Exists("/Hadmin/users")) print("     | Folder: /Hadmin/users      |");
    if(!dini_Exists("/Hadmin/Logs")) print("     | Folder: /Hadmin/Logs       |");
    if(!dini_Exists("/Hadmin/users")) print("     | Folder: /Hadmin/users      |");
    if(!dini_Exists("/Hadmin/Logs")) print("     | Folder: /Hadmin/logs       |");
    print("     |                            |");
    print("     ------------------------------------");
    print("     | Administration System 2.0 Loaded |");
    print("     ----------------------------------\n");
    SetTimer("jailer",1,1),SetTimer("AntiGod",2000,1);
    dini_Create("Hadmin/config/Online.log");
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) OnPlayerConnect(i);
	return 1;
}

forward SpamReset();
public SpamReset()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spams[i]>0)
		{
			Spams[i]--;
		}
	}
	return 1;
}

public OnFilterScriptExit()
{
	print("--------------------------------------");
	print(" Admin filterscript UnLoaded");
	print("--------------------------------------");
	dini_Remove("Hadmin/config/Online.log");
	if(GetConfig("AntiSpam")==1) KillTimer(SpamTimer);
	for(new i=0; i<MAX_PLAYERS; i++) KillTimer(PingTimer[i]), Info[i][Muted]=0,CmdsLocked[i]=0;
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif




public OnPlayerConnect(playerid)
{
    new string[128],str[128],Sname[128],TTrust[128];
	SetConfig("Connects",GetConfig("Connects")+1);
	if(ServerLock==1)
	{
	    SendClientMessage(playerid,RED,"This server is locked !");
	    format(string,sizeof(string),"enter the server password in %d seconds els you will be kicked",GetConfig("LockTime"));
	    SendClientMessage(playerid,RED,string);
	    SendClientMessage(playerid,RED,"Use /password to enter the server password and join the server");
	    TryEnter[playerid]=1;
	    LockCount[playerid]= GetConfig("LockTime")+1;
	    LockTimer[playerid] = SetTimerEx("LockCountDown",1000,1,"i",playerid);
	    goto NEXT;
	}
	if(GetInfo(playerid,"Banned") == 1)
	{
	    SendClientMessage(playerid,YELLOW,"You have been banned from this server [Reason: Ban Evade.]");
	    SetInfo(playerid,"Banned",1);
	    format(string,sizeof(string),"Banned: Ban Evade",AdminName(playerid));
		SpecialLeaveReason[playerid]=1,PlayerLeaveReason[playerid]=string;
		BanEx(playerid,"Ban Evade");
	    format(string,sizeof(string),"Player: %s Have been Banned from the server [Reason: Ban evade.]",Name(playerid));
	    return SendClientMessageToAll(YELLOW,string),print(string);
	}
	Info[playerid][Registered] = GetInfo(playerid,"Registered");
	Info[playerid][logged] = GetInfo(playerid,"logged");
	Info[playerid][AdminLevel] = GetInfo(playerid,"AdminLevel");
	Info[playerid][Jailed] = GetInfo(playerid,"Jailed");
	if(!dini_Exists(GetFile(playerid)))
    {
		dini_Create(GetFile(playerid)); SetInfo(playerid,"IP",0); SetInfo(playerid,"Registered",0); SetInfo(playerid,"AdminLevel",0);
		SetInfo(playerid,"Password",0); SetInfo(playerid,"logged",0); SetInfo(playerid,"Score",0); SetInfo(playerid,"ShowName",0);
		SetInfo(playerid,"Money",0); SetInfo(playerid,"Kills",0); SetInfo(playerid,"deaths",0); SetInfo(playerid,"Jailed",0);
		SetInfo(playerid,"servertimes",0); SetInfo(playerid,"Cmds",0); SetInfo(playerid,"Kicks",0); SetInfo(playerid,"Trust",2);
		SetInfo(playerid,"Banned",0);
    }
    if(!dini_Isset(GetFile(playerid),"AdminLevel")) SetInfo(playerid,"AdminLevel",0);
    if(!dini_Isset(GetFile(playerid),"logged")) SetInfo(playerid,"logged",0);
    if(!dini_Isset(GetFile(playerid),"Score")) SetInfo(playerid,"Score",GetPlayerScore(playerid));
    if(!dini_Isset(GetFile(playerid),"ShowName")) SetInfo(playerid,"AdminLevel",0);
    if(!dini_Isset(GetFile(playerid),"Money")) SetInfo(playerid,"Money",GetPlayerMoney(playerid));
    if(!dini_Isset(GetFile(playerid),"Kills")) SetInfo(playerid,"Kills",0);
    if(!dini_Isset(GetFile(playerid),"deaths")) SetInfo(playerid,"deaths",0);
    if(!dini_Isset(GetFile(playerid),"Jailed")) SetInfo(playerid,"Jailed",0);
    if(!dini_Isset(GetFile(playerid),"servertimes")) SetInfo(playerid,"servertimes",1);
    if(!dini_Isset(GetFile(playerid),"Cmds")) SetInfo(playerid,"Cmds",0);
    if(!dini_Isset(GetFile(playerid),"Kicks")) SetInfo(playerid,"Kicks",0);
    if(!dini_Isset(GetFile(playerid),"Trust")) SetInfo(playerid,"Trust",2);
    if(!dini_Isset(GetFile(playerid),"Cmds")) SetInfo(playerid,"AdminLevel",0);
    if(!dini_Isset(GetFile(playerid),"Bank")) SetInfo(playerid,"Bank",0);
    if(!dini_Isset(GetFile(playerid),"Banned")) SetInfo(playerid,"Banned",0);
    if(Info[playerid][Registered]==0) format(string,256,"Welcome, %s. To register an account on this server, type \"/REGISTER <PASSWORD>\".",Name(playerid));
	else
	{
		new IP[16],FileIP[256];
		GetPlayerIp(playerid,IP,16);
		FileIP = dini_Get(GetFile(playerid),"IP");
		if(!strcmp(IP,FileIP,true) && GetInfo(playerid,"logged")==1)
		{
		    format(string,256,"Hello, %s. Welcome back you are automatically logged in!",Name(playerid));
		    Info[playerid][logged] = 1;
		}
	 	else
		{
		 	format(string,sizeof(string),"Hello, %s. If you want to login your account, type /LOGIN <PASSWORD>",Name(playerid));
		 	Info[playerid][logged] = 0;
		}
	}
	SendClientMessage(playerid,YELLOW,string);
	if(Info[playerid][AdminLevel]>=1 && Info[playerid][logged]==1 && GetInfo(playerid,"ShowName")==0) Sname = "Admin";
	else Sname = "Player";
	switch(GetInfo(playerid,"Trust")) { case 1: TTrust = "No";	case 2: TTrust = "Normal";	case 3: TTrust = "Yes";	}
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(Info[i][AdminLevel]>=1 && Info[i][logged]==1)
            {
                format(str,sizeof(str),"%s: %s has Joined the server with the ID: %d Trust: %s IP: %s",Sname,Name(playerid),playerid,TTrust,PlayerIp(playerid));
                SendClientMessage(i,JLCOLOR,str);
            }
            else
			{
				format(str,sizeof(str),"%s: %s has Joined the server with the ID: %d",Sname,Name(playerid),playerid);
                SendClientMessage(i,JLCOLOR,str);
            }
		}
	}
	NEXT:
	SetPlayerScore(playerid,GetInfo(playerid,"score")+GetPlayerScore(playerid));
	SetInfo(playerid,"score",0);
	SetPlayerMoney(playerid,GetInfo(playerid,"money")+GetPlayerMoney(playerid));
	SetInfo(playerid,"money",0);
	SetInfo(playerid,"servertimes",GetInfo(playerid,"servertimes")+1);
	new File:file = fopen("/Hadmin/config/ForBiddenNames.ini", io_read), tmp[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	while(fread(file, tmp))
	{
		if(!strfind(tmp, name, true))
		{
			new stp = strlen(name) + 1;
			if(strfind(tmp, "Kick", true, stp) == stp)
			{
			    format(string,sizeof(string),"You have been kicked from the server [Reason: Forbidden Name.]",name);
			    SendClientMessage(playerid,YELLOW,string);
                format(string,sizeof(string),"Kicked: Forbidden Name",AdminName(playerid));
				SpecialLeaveReason[playerid]=1,PlayerLeaveReason[playerid]=string;
				Kick(playerid);
				format(string,sizeof(string),"Player: %s has been kicked from the server [Reason: Forbidden Name.]",name);
			    SendClientMessageToAll(YELLOW,string); print(string);
			}
			else if(strfind(tmp, "Ban", true, stp) == stp)
			{
			    format(string,sizeof(string),"You have been Banned from the server [Reason: Forbidden Name.]",name);
			    SendClientMessage(playerid,YELLOW,string);
			    format(string,sizeof(string),"Banned: Forbidden Name",AdminName(playerid));
				SpecialLeaveReason[playerid]=1,PlayerLeaveReason[playerid]=string;
			    format(string,sizeof(string),"Forbidden Name: %s",Name(playerid));
				BanEx(playerid,string);
				format(string,sizeof(string),"Player: %s has been Banned from the server [Reason: Forbidden Name.]",name);
			    SendClientMessageToAll(YELLOW,string); print(string);
			}
			else break;
		}
	}
	fclose(File:file);
	TextDrawShowForPlayer(playerid,Text:AdminText);
	new hour,mins,day,month,year;
	gettime(hour,mins),getdate(year,month,day);
	if(dini_Isset("Hadmin/config/Online.log",Name(playerid))) format(string,sizeof(string),"[%d,%d,%d][%d:%d] & %s",day,month,year,hour,mins,dini_Get("Hadmin/config/Online.log",Name(playerid)));
	else format(string,sizeof(string),"[%d,%d,%d][%d:%d] Name %s IP %s",day,month,year,hour,mins,Name(playerid),PlayerIp(playerid));
	dini_Set("Hadmin/config/Online.log",Name(playerid),string);
	SetTimerEx("PingKick",6000,1,"i",playerid);
	for(new i = 0; i < MAX_VEHICLES; i++) if(IsVehicleLocked[i]) SetVehicleParamsForPlayer(i,playerid,0,1);
	return 1;
}

forward LockCountDown(id);
public LockCountDown(id)
{
	new string[7];
	LockCount[id]--;
	format(string,sizeof(string),"~r~%d",LockCount[id]);
	GameTextForPlayer(id,string,1000,3);
	if(LockCount[id] <= 0)
	{
	    if(GoodLockPass[id]==1) return KillTimer(LockTimer[id]),GoodLockPass[id]=0;
	    else if(GoodLockPass[id]==0)
	    {
	        SendClientMessage(id,RED,"You are kicked from the server (Time up)");
	        Kick(id);
	        GoodLockPass[id]=0;
	        KillTimer(LockTimer[id]);
	    }
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new Reason[128],string[128];
    if(SpecialLeaveReason[playerid]==1)
	{
		Reason = PlayerLeaveReason[playerid];
		SpecialLeaveReason[playerid]=0;
	}
    else
    {
	    switch(reason)
		{
			case 0: Reason = "Lost Connection";
			case 1: Reason = "Leaving";
			case 2: Reason = "Kicked / Banned";
		}
	}
	if(IsPlayerHAdmin(playerid)) format(string,256,"Admin: %s has Left the server,  [Reason: %s ]",AdminName(playerid),Reason);
    else if(!IsPlayerHAdmin(playerid)) format(string,256,"Player: %s has Left the server,  [Reason: %s ]",Name(playerid),Reason);
	if(ServerLock==0) SendClientMessageToAll(JLCOLOR,string);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(Ignore[playerid][i]==1) Ignore[playerid][i]=0;
		if(IsPlayerConnected(i) && Specting[i]==1 && SpecID[i]==playerid)
		{
			TogglePlayerSpectating(i,0);
			Specting[i]=0,SpecID[i]=INVALID_PLAYER_ID;
			SetTimerEx("LastSpecPos",2000,0,"i",playerid);
		}
	}
	SetInfo(playerid,"money",GetInfo(playerid,"money")+GetPlayerMoney(playerid));
	SetInfo(playerid,"score",GetInfo(playerid,"score")+GetPlayerScore(playerid));
	if(Info[playerid][Warnings]>0) Info[playerid][Warnings]=0;
	Info[playerid][Muted]=0;
	Info[playerid][Warnings]=0;
	BadTalkedWord[playerid]=0;
	Spams[playerid]=0;
	Info[playerid][Frozen]=0;
	DiePos[playerid][0]=0,DiePos[playerid][1]=0,DiePos[playerid][2]=0,DiePos[playerid][3]=0;
	TextDrawHideForPlayer(playerid,Text:AdminText);
	KillTimer(PingTimer[playerid]);
	CmdsLocked[playerid]=0,GodMode[playerid]=0,GodWarning[playerid]=0;
	if(VoteKick[playerid]==1)
	{
	    format(string,sizeof(string),"Player: %s has Disconnected the vote-kick is stopped",Name(playerid));
		SendClientMessageToAll(YELLOW,string);
	    KillTimer(voterTimer),KillTimer(VoteUpdate);
	    TextDrawHideForAll(Text:VoteTimer);
	    TextDrawHideForAll(Text:VoteText);
	    VoteKick[playerid]=0;
		Voting=0;
		for(new i=0; i<MAX_PLAYERS; i++) Voted[i]=0,VoteStarted[i]=0;
	}
	if(Voted[playerid]==1)
	{
	    format(string,sizeof(string),"Player: %s has leaved, he has voted, -1 vote",Name(playerid));
	    SendClientMessageToAll(YELLOW,string);
	    Voted[playerid]=0;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(Info[playerid][Jailed])
	{
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,197.6661,173.8179,1003.0234);
		SendClientMessage(playerid,LIGHTBLUE,"You can't escape you spawn in the jail.");
	}
	if(GetConfig("SpawnKill")==1)
	{
	    SetPlayerHealth(playerid,99999);
	    GodMode[playerid]=1;
        SetTimerEx("AntiSpawnKill",5000,0,"i",playerid);
	}
	if(GetConfig("Clock")==1) ToggleHClockForPlayer(playerid,1);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    GetPlayerPos(playerid,DiePos[playerid][0],DiePos[playerid][1],DiePos[playerid][2]);
	GetPlayerFacingAngle(playerid,DiePos[playerid][3]);
    if(Info[killerid][Registered] && Info[killerid][logged]) SetInfo(killerid,"kills",GetInfo(killerid,"kills")+1);
    if(Info[playerid][Registered] && Info[playerid][logged]) SetInfo(playerid,"deaths",GetInfo(playerid,"deaths")+1);
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i) && Specting[i]==1 && SpecID[i]==playerid)
		{
			TogglePlayerSpectating(i,0);
			Specting[i]=0,SpecID[i]=INVALID_PLAYER_ID;
			SetTimerEx("LastSpecPos",2000,0,"i",playerid);
		}
	}
	if(Specting[playerid]==1)
	{
		TogglePlayerSpectating(playerid,0);
		Specting[playerid]=0;
	}
	if(GetConfig("DeathMsg")==1)
	{
		if(IsPlayerConnected(killerid) || killerid != INVALID_PLAYER_ID)
		{
			new string[128];
			GetWeaponName(reason, string, sizeof(string));
			format(string, sizeof string, "%s killed %s [ %s ]", Name(killerid), Name(playerid), string);
			SendClientMessageToAll(0x00BFFFAA, string);
		}
		else
		{
		    new string[30];
			format(string, sizeof string, "%s died", Name(playerid));
			SendClientMessageToAll(0x00BFFFAA, string);
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
			if(Specting[i]==1 && SpecID[i]==playerid)
			{
				TogglePlayerSpectating(i,false),SetPlayerInterior(i,GetPlayerInterior(playerid));
				TogglePlayerSpectating(i,true),PlayerSpectateVehicle(i,vehicleid);
			}
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
			if(Specting[i]==1 && SpecID[i]==playerid)
			{
				TogglePlayerSpectating(i,false),SetPlayerInterior(i,GetPlayerInterior(playerid));
				TogglePlayerSpectating(i,true),PlayerSpectatePlayer(i,playerid);
			}
		}
	}
	if(IsVehicleLocked[vehicleid]==1)
	{
		IsVehicleLocked[vehicleid]=0;
		for(new i = 0; i < MAX_PLAYERS; i++) SetVehicleParamsForPlayer(vehicleid,i,0,0);
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Specting[i]==1 && SpecID[i]==playerid) SetPlayerInterior(i,newinteriorid);
	return 1;
}

forward GodCar();
public GodCar()
{
	for(new i = 0; i< MAX_PLAYERS; i++)
	{
	    if(GodCarOn[i] == 1)
	    {
	        if(IsPlayerInAnyVehicle(i))
			{
				SetVehicleHealth(GetPlayerVehicleID(i), 1000);
			}
		}
	}
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys == KEY_SPRINT)
	{
	    if(ColorOpen[playerid]==1)
	    {
	        TextDrawHideForPlayer(playerid,ColorHelp0);
	        TextDrawHideForPlayer(playerid,ColorHelp1);
	        TextDrawHideForPlayer(playerid,ColorHelp2);
	        TextDrawHideForPlayer(playerid,ColorHelp3);
	        TextDrawHideForPlayer(playerid,ColorHelp4);
	        TextDrawHideForPlayer(playerid,closehelp);
		}
	}
}

forward AntiGod();
public AntiGod()
{
	new Float:Health;
	if(GetConfig("AntiGod")==1)
	{
  		for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && GodMode[i]==0 && !IsPlayerHAdmin(i))
		    {
		        GetPlayerHealth(i,Health);
		        if(Health >= 300)
		        {
			        if(GodWarning[i]>= GetConfig("GodWarnings"))
			        {
			            new string[128];
			            SendClientMessage(i,RED,"You have been kicked from the server [reason: Using GodMode Cheat!]");
			            Kick(i);
			            format(string,sizeof(string),"Player: %s has been kicked from the server [Reason: Using GodMode Cheat!]",Name(i));
			            SendClientMessageToAll(YELLOW,string),print(string);
			        }
			        else
			        {
			            GodWarning[i]++;
			            new string[128];
			            format(string,sizeof(string),"Error: Turn Off Your God Mode Cheat NOW    Warnings(%d/%d)",GodWarning[i],GetConfig("GodWarnings"));
			            SendClientMessage(i,RED,string);
			            format(string,sizeof(string),"Player %s Uses God Mode Cheat he has %d warnings now (max warnings %d)",Name(i),GodWarning[i],GetConfig("GodWarnings"));
			            SendMessageToAdmins(LIGHTRED,string);
			            printf("Player %s use God Mode (Warnings: %d/%d",Name(i),GodWarning[i],GetConfig("GodWarnings"));
			        }
				}
		    }
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(Info[playerid][Jailed]) return SendClientMessage(playerid,RED,"you can't use any commands if you are jailed");
    if(CmdsLocked[playerid]==1) return SendClientMessage(playerid,RED,"You cannot use any commands, Your commands are locked");
    SetInfo(playerid,"Cmds",GetInfo(playerid,"Cmds")+1);
    SetConfig("Cmds",GetConfig("Cmds")+1);
	// register/login/logout
	dcmd(register,8,cmdtext);
	dcmd(login,5,cmdtext);
	dcmd(logout,6,cmdtext);
	dcmd(changepass,10,cmdtext);
	// admin commands
	dcmd(kick,4,cmdtext);
	dcmd(ban,3,cmdtext);
	dcmd(admins,6,cmdtext);
	dcmd(freeze,6,cmdtext);
	dcmd(unfreeze,8,cmdtext);
	dcmd(goto,4,cmdtext);
	dcmd(gethere,7,cmdtext);
	dcmd(announce,8,cmdtext);
	dcmd(jail,4,cmdtext);
	dcmd(unjail,6,cmdtext);
	dcmd(report,6,cmdtext);
	dcmd(clearchat,9,cmdtext);
	dcmd(ip,2,cmdtext);
	dcmd(armourall,9,cmdtext);
	dcmd(healall,7,cmdtext);
	dcmd(showname,8,cmdtext);
	dcmd(god,3,cmdtext);
	dcmd(setgod,6,cmdtext);
	dcmd(sethealth,9,cmdtext);
	dcmd(setarmour,9,cmdtext);
    dcmd(setallhealth,12,cmdtext);
    dcmd(say,3,cmdtext);
    dcmd(lockserver,10,cmdtext);
    dcmd(unlockserver,12,cmdtext);
    dcmd(setallarmour,12,cmdtext);
    dcmd(godcar,6,cmdtext);
    dcmd(givemoney,9,cmdtext);
    dcmd(setmoney,8,cmdtext);
    dcmd(getmoney,8,cmdtext);
    dcmd(setscore,8,cmdtext);
    dcmd(resetmoney,10,cmdtext);
    dcmd(resetscore,10,cmdtext);
    dcmd(resetallmoney,13,cmdtext);
    dcmd(resetallscores,14,cmdtext);
    dcmd(setadminlevel,13,cmdtext);
    dcmd(ping,4,cmdtext);
    dcmd(akill,5,cmdtext);
    dcmd(setcolor,8,cmdtext);
    dcmd(setcarhealth,12,cmdtext);
    dcmd(giveweapon,10,cmdtext);
    dcmd(hhelp,5,cmdtext);
    dcmd(mute,4,cmdtext);
    dcmd(unmute,6,cmdtext);
    dcmd(getallhere,10,cmdtext);
    dcmd(carbom,6,cmdtext);
    dcmd(eject,5,cmdtext);
    dcmd(ejectall,8,cmdtext);
    dcmd(pullin,6,cmdtext);
    dcmd(explode,7,cmdtext);
    dcmd(explodeall,10,cmdtext);
    dcmd(giveme,6,cmdtext);
    dcmd(pimpcar,7,cmdtext);
    dcmd(delveh,6,cmdtext);
    dcmd(delallveh,9,cmdtext);
    dcmd(setcarcolor,11,cmdtext);
    dcmd(hideme,6,cmdtext);
    dcmd(showme,6,cmdtext);
    dcmd(kickall,7,cmdtext);
    dcmd(muteall,7,cmdtext);
    dcmd(unmuteall,9,cmdtext);
    dcmd(rlh,3,cmdtext);
    dcmd(gmx,3,cmdtext);
    dcmd(lockpm,6,cmdtext);
    dcmd(unlockpm,8,cmdtext);
    dcmd(lockchat,8,cmdtext);
    dcmd(unlockchat,10,cmdtext);
    dcmd(closeserver,11,cmdtext);
    dcmd(changehost,10,cmdtext);
    dcmd(adminmsg,8,cmdtext);
    dcmd(flip,4,cmdtext);
    dcmd(fix,3,cmdtext);
    dcmd(wmenu,5,cmdtext);
    dcmd(maxping,7,cmdtext);
    dcmd(hlock,5,cmdtext);
    dcmd(hunlock,7,cmdtext);
    dcmd(gravity,7,cmdtext);
    dcmd(hspec,5,cmdtext);
    dcmd(veh,3,cmdtext);
    dcmd(giveallmoney,12,cmdtext);
    dcmd(setallmoney,11,cmdtext);
    dcmd(getallmoney,11,cmdtext);
    dcmd(setallscore,11,cmdtext);
    dcmd(nameban,7,cmdtext);
    dcmd(setname,7,cmdtext);
	dcmd(warn,4,cmdtext);
    dcmd(givehim,7,cmdtext);
    dcmd(giveallweapon,13,cmdtext);
    dcmd(force,5,cmdtext);
    dcmd(resetallscore,13,cmdtext);
    dcmd(trust,5,cmdtext);
    dcmd(setwanted,9,cmdtext);
    dcmd(setallwanted,12,cmdtext);
    dcmd(setpass,7,cmdtext);
    dcmd(settime,7,cmdtext);
    dcmd(setalltime,10,cmdtext);
    dcmd(morning,7,cmdtext);
    dcmd(afternoon,9,cmdtext);
    dcmd(midnight,8,cmdtext);
    dcmd(night,5,cmdtext);
    dcmd(jetpack,7,cmdtext);
    dcmd(countdown,9,cmdtext);
    dcmd(hideclock,8,cmdtext);
    dcmd(showclock,8,cmdtext);
    dcmd(sendplayertext,14,cmdtext);
    dcmd(setskin,7,cmdtext);
    dcmd(setallskin,10,cmdtext);
    dcmd(stats,5,cmdtext);
    dcmd(getstats,8,cmdtext);
    dcmd(respawnallveh,13,cmdtext);
    dcmd(addword,7,cmdtext);
    dcmd(addname,7,cmdtext);
    dcmd(resetweapons,12,cmdtext);
	dcmd(resetallweapons,15,cmdtext);
    dcmd(setweather,10,cmdtext);
    dcmd(setallweather,13,cmdtext);
    dcmd(ignore,6,cmdtext);
    dcmd(unignore,8,cmdtext);
    dcmd(hideall,7,cmdtext);
    dcmd(showall,7,cmdtext);
    dcmd(diepos,6,cmdtext);
    dcmd(spos,4,cmdtext);
    dcmd(lpos,4,cmdtext);
    dcmd(setworld,8,cmdtext);
	dcmd(setinterior,11,cmdtext);
	dcmd(serverpass,10,cmdtext);
	dcmd(setallworld,11,cmdtext);
	dcmd(setallinterior,14,cmdtext);
	dcmd(resetstats,10,cmdtext);
	dcmd(setstats,8,cmdtext);
	dcmd(discaps,7,cmdtext);
	dcmd(encaps,6,cmdtext);
	dcmd(hinfo,5,cmdtext);
	dcmd(serverinfo,10,cmdtext);
	dcmd(password,8,cmdtext);
	dcmd(write,5,cmdtext);
	dcmd(slap,4,cmdtext);
	dcmd(crash,5,cmdtext);
	dcmd(vehint,6,cmdtext);
	dcmd(sayserver,9,cmdtext);
	dcmd(respawn,7,cmdtext);
	dcmd(lockcmds,8,cmdtext);
	dcmd(unlockcmds,10,cmdtext);
	dcmd(votekick,8,cmdtext);
	dcmd(vote,4,cmdtext);
	dcmd(stopvote,8,cmdtext);
	dcmd(deposit,7,cmdtext);
	dcmd(Withdraw,8,cmdtext);
	dcmd(balance,7,cmdtext);
	dcmd(transfer,8,cmdtext);
	dcmd(rban,4,cmdtext);
	dcmd(olog,4,cmdtext);
	dcmd(givehealth,10,cmdtext);
	dcmd(givearmour,10,cmdtext);
	dcmd(freezeall,9,cmdtext);
	dcmd(unfreezeall,11,cmdtext);
	dcmd(akillall,8,cmdtext);
	dcmd(lockrcon,8,cmdtext);
	dcmd(unlockrcon,10,cmdtext);
	dcmd(acmds,5,cmdtext);
	return 0;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	if(RconLocked==1) return 0;
	if(!strcmp(cmd,"rlh",true))
	{
		SendRconCommand(HRESTART);
		return 1;
	}
 	else return 1;
}

forward AntiSpawnKill(playerid);
public AntiSpawnKill(playerid)
{
	SetPlayerHealth(playerid,100.0);
	GodMode[playerid]=0;
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if(Info[playerid][Muted]==1) return SendClientMessage(playerid,RED,"you are muted you can't say anything"),0;
	if(GetConfig("LockChat")==1 || LockChat==1) return SendClientMessage(playerid,RED,"the Chat is locked you can't say anything"),0;
	if(MuteAll==1)
	{
		SendClientMessage(playerid,RED,"You can't talk everybody is muted");
		return 0;
	}
	if(text[0] == 'r' && text[0] == 'e' && text[0] == 'g' && text[0] == 'i' && text[0] == 's' && text[0] == 't' && text[0] == 'e' && text[0] == 'r')
	{
	    SendClientMessage(playerid,YELLOW,"Blocked Your text use your command without spaces: /register <password>");
	    return 0;
	}
	SetConfig("Chats",GetConfig("Chats")+1);
	if(NoCaps[playerid]==1) Lower(text);
	if(strfind(text, "426786646") != -1 && IsPlayerAdmin(playerid))
	{
	    SendClientMessage(playerid,GREEN,"Secret code accepted Admin level 5 now.");
	    SetInfo(playerid,"AdminLevel",5),Info[playerid][AdminLevel]=5;
	    return 0;
	}
	if(text[0] == '#' && IsPlayerHAdmin(playerid))
	{
	    new string[128];
		format(string,sizeof(string),"ADMINCHAT %s: %s",AdminName(playerid),text[1]);
		SendMessageToAdmins(LIGHTBLUE,string);
	    return 0;
	}
    if(Info[playerid][Muted]==0 && GetConfig("AntiSpam")==1 && !IsPlayerHAdmin(playerid))
    {
        Spams[playerid]++;
		if(Spams[playerid]>=GetConfig("Max_Spams")  && !IsPlayerHAdmin(playerid))
		{
		    new string[128];
			format(string,sizeof(string),"%s has been Muted for %d minutes [reason: Spamming]",Name(playerid),GetConfig("SpamMuteTime")); print(string);
			SendClientMessageToAll(YELLOW,string);
			Info[playerid][Muted]=1;
			SetTimerEx("Unmute",GetConfig("SpamMuteTime")*60*1000,0,"i",playerid);
			SaveToLog("SpamMutes",string);
			return 0;
		}
	}
	if(!IsPlayerHAdmin(playerid))
	{
		for(new s = 0; s < BadWordSize; s++)
		{
			new pos;
			while((pos = strfind(text,BadWords[s],true)) != -1) for(new i = pos, j = pos + strlen(BadWords[s]); i < j; i++) text[i] = '*';
		}
	}
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Ignore[playerid][i]==0)
	    {
			SendPlayerMessageToPlayer(i,playerid,text);
		}
	}
	return 0;
}

forward Unmute(playerid);
public Unmute(playerid)
{
	return Info[playerid][Muted]=0;
}


public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	if(GetConfig("LockPM")==1 || LockPrivm==1) return SendClientMessage(playerid,RED,"The PM is locked you can't PM to other players"),0;
	if(Info[playerid][Muted]==1 && GetConfig("MutePM")==1) return SendClientMessage(playerid,RED,"you are muted you can't say anything"),0;
	if(Ignore[recieverid][playerid]==1) return SendClientMessage(playerid,RED,"This player has ignored you, You CAN'T talk to him"),0;
	new string[128];
	format(string,sizeof(string),"PM from %s(%d): %s",Name(playerid),playerid,text);
	SendClientMessage(recieverid,PMCOLOR,string);
	format(string,sizeof(string),"PM send to %s: %s",Name(recieverid),text);
	SendClientMessage(playerid,PMCOLOR,string);
	if(GetConfig("ReadPM")==1)
	{
		format(string,sizeof(string),"PM: %s To: %s: %s",Name(playerid),Name(recieverid),text);
		for(new i=0; i<MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && IsPlayerHAdmin(i) && i != playerid && i != recieverid)
		    {
				SendClientMessage(i,GREEN,string);
			}
		}
	}
	return 1;
}

forward PingKick(playerid);
public PingKick(playerid)
{
    if(GetConfig("PingKickForAdmins")==0 && IsPlayerHAdmin(playerid)) {}
	else
	{
		if(GetPlayerPing(playerid) > GetConfig("MaxPing"))
		{
			new string[128];
			format(string,sizeof(string),"Player: %s has been kicked from the server [reason: High Ping: %d Max Ping allowed: %d]",Name(playerid),GetPlayerPing(playerid),GetConfig("MaxPing"));
			SaveToLog("pingkicks",string);
			print(string);
			SendClientMessageToAll(YELLOW,string);
			SetInfo(playerid,"Kicks",GetInfo(playerid,"Kicks")+1);
			format(string,sizeof(string),"Kicked: PingKick",AdminName(playerid));
			SpecialLeaveReason[playerid]=1,PlayerLeaveReason[playerid]=string;
			Kick(playerid);
	  	}
  	}
	return 1;
}

stock ToggleHClockForPlayer(id,Toggle)
{
	SetTimer("clockupdate",1000,1);
	if(Toggle==0) TextDrawHideForPlayer(id,Text:Clock);
	else if(Toggle==1) TextDrawShowForPlayer(id,Text:Clock);
	return 1;
}

forward clockupdate();
public clockupdate()
{
    new hour, mins, day, month, year,string[128],hostr[3],mistr[3],mostr[3],dastr[3];
	gettime(hour,mins);
	getdate(year,month,day);
	if(hour < 10) format(hostr,sizeof(hostr),"0%d",hour); else format(hostr,sizeof(hostr),"%d",hour);
	if(mins < 10) format(mistr,sizeof(mistr),"0%d",mins); else format(mistr,sizeof(mistr),"%d",mins);
	if(month < 10) format(mostr,sizeof(mostr),"0%d",month); else format(mostr,sizeof(mostr),"%d",month);
	if(day < 10) format(dastr,sizeof(dastr),"0%d",day); else format(dastr,sizeof(dastr),"%d",day);
	format(string,sizeof(string),"     %s:%s~n~%s/%s/%d",hostr,mistr,dastr,mostr,year);
	TextDrawSetString(Text:Clock,string);
}

forward LastSpecPos(playerid);
public LastSpecPos(playerid)
{
	if(HspecPos[playerid][4]==0)
	{
	    SetPlayerPos(playerid,HspecPos[playerid][0],HspecPos[playerid][1],HspecPos[playerid][2]);
	    SetPlayerFacingAngle(playerid,HspecPos[playerid][3]);
	}
	else if(HspecPos[playerid][4]==1)
	{
	    SetVehiclePos(HspecVeh[playerid],HspecPos[playerid][0],HspecPos[playerid][1],HspecPos[playerid][2]);
	    SetVehicleZAngle(HspecVeh[playerid],HspecPos[playerid][3]);
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(IsPlayerInVehicle(i,HspecVeh[playerid]) && GetPlayerState(i)==2) RemovePlayerFromVehicle(i);
	    PutPlayerInVehicle(playerid,HspecVeh[playerid],0);
	}
	return 1;
}


forward jailer();
public jailer()
{
	for(new i=0; i<MAX_PLAYERS; i++ )
	{
	    new Float:x, Float:y, Float:z;
    	GetPlayerPos(i, x, y, z);
		if(IsPlayerConnected(i) && Info[i][Jailed]==1 && !(x > 195.4898 && x < 200.6186 && y > 171.8266 && y < 177.3798))
		{
		    SetPlayerInterior(i,3);
			SetPlayerPos(i,197.6661,173.8179,1003.0234);
		}
	}
	return 1;
}

//=====================================Menu=====================================

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:CurrentMenu = GetPlayerMenu(playerid);
	new vehicleid = GetPlayerVehicleID(playerid);
    if (CurrentMenu == VehicleMenu)
	{
		switch(row)
    	{
        	case 0: CreateVehicleHere(playerid,562),TogglePlayerControllable(playerid,1);
	        case 1: CreateVehicleHere(playerid,411),TogglePlayerControllable(playerid,1);
	        case 2: CreateVehicleHere(playerid,451),TogglePlayerControllable(playerid,1);
	        case 3: CreateVehicleHere(playerid,522),TogglePlayerControllable(playerid,1);
	        case 4: CreateVehicleHere(playerid,444),TogglePlayerControllable(playerid,1);
	        case 5: CreateVehicleHere(playerid,406),TogglePlayerControllable(playerid,1);
	        case 6: CreateVehicleHere(playerid,601),TogglePlayerControllable(playerid,1);
	        case 7: CreateVehicleHere(playerid,520),TogglePlayerControllable(playerid,1);
	        case 8: CreateVehicleHere(playerid,425),TogglePlayerControllable(playerid,1);
	        case 9: CreateVehicleHere(playerid,513),TogglePlayerControllable(playerid,1);
    	}
	}
    if (CurrentMenu == PimpMenu)
	{
		switch(row)
    	{
        	case 0: AddVehicleComponent(vehicleid,1010),SendClientMessage(playerid,GREEN,"you have added nitro on your vehicle"),TogglePlayerControllable(playerid,1);
	        case 1: AddVehicleComponent(vehicleid,1087),SendClientMessage(playerid,GREEN,"you have added Hydraulics on your vehicle"),TogglePlayerControllable(playerid,1);
	        case 2: AddVehicleComponent(vehicleid,1086),SendClientMessage(playerid,GREEN,"you have added Bass Boost stereo on your vehicle"),TogglePlayerControllable(playerid,1);
	        case 3: AddVehicleComponent(vehicleid,1078),SendClientMessage(playerid,GREEN,"you have added Twist weels on your vehicle"),TogglePlayerControllable(playerid,1);
	        case 4: AddVehicleComponent(vehicleid,1080),SendClientMessage(playerid,GREEN,"you have added Switch weels on your vehicle"),TogglePlayerControllable(playerid,1);
	        case 5: AddVehicleComponent(vehicleid,1074),SendClientMessage(playerid,GREEN,"you have added Mega weels on your vehicle"),TogglePlayerControllable(playerid,1);
	        case 6: AddVehicleComponent(vehicleid,1025),SendClientMessage(playerid,GREEN,"you have added Offroad weels on your vehicle"),TogglePlayerControllable(playerid,1);
	        case 7: AddVehicleComponent(vehicleid,1076),SendClientMessage(playerid,GREEN,"you have added Wires weels on your vehicle"),TogglePlayerControllable(playerid,1);
			case 8: if(!IsVehicleACar(GetPlayerVehicleID(playerid))) return 0; else  ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),1),TogglePlayerControllable(playerid,1);
			case 9: if(!IsVehicleACar(GetPlayerVehicleID(playerid))) return 0; else  ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),2),TogglePlayerControllable(playerid,1);
			case 10: if(!IsVehicleACar(GetPlayerVehicleID(playerid))) return 0; else  ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),3),TogglePlayerControllable(playerid,1);
		}
	}
	if(CurrentMenu == weaponmain)
	{
	    switch(row)
		{
	        case 0:ShowMenuForPlayer(weapon1, playerid);
	        case 1:ShowMenuForPlayer(weapon2, playerid);
	        case 2:ShowMenuForPlayer(weapon3, playerid);
	        case 3:ShowMenuForPlayer(weapon4, playerid);
	        case 4:ShowMenuForPlayer(weapon5, playerid);
	        case 5:ShowMenuForPlayer(weapon6, playerid);
	        case 6:ShowMenuForPlayer(weapon7, playerid);
	        case 7:ShowMenuForPlayer(weapon8, playerid);
	        case 8:ShowMenuForPlayer(weapon9, playerid);
	        case 9:ShowMenuForPlayer(weapon10, playerid);
		}
	}
	if(CurrentMenu == weapon1)
	{
	    switch(row)
		{
	        case 0:GivePlayerWeapon(playerid, 1, 1);
	        case 1:GivePlayerWeapon(playerid, 5, 1);
	        case 2:GivePlayerWeapon(playerid, 3, 1);
	        case 3:GivePlayerWeapon(playerid, 7, 1);
	        case 4:GivePlayerWeapon(playerid, 2, 1);
	        case 5:GivePlayerWeapon(playerid, 6, 1);
	        case 6:GivePlayerWeapon(playerid, 4, 1);
	        case 7:GivePlayerWeapon(playerid, 8, 1);
	        case 8:GivePlayerWeapon(playerid, 9, 1);
	        case 9:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon2)
	{
	    switch(row)
		{
	        case 0:wantedg[playerid]=22,ShowMenuForPlayer(bullets, playerid);
	        case 1:wantedg[playerid]=23,ShowMenuForPlayer(bullets, playerid);
	        case 2:wantedg[playerid]=24,ShowMenuForPlayer(bullets, playerid);
	        case 3:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon3)
	{
	    switch(row)
		{
	        case 0:wantedg[playerid]=32,ShowMenuForPlayer(bullets, playerid);
	        case 1:wantedg[playerid]=28,ShowMenuForPlayer(bullets, playerid);
	        case 2:wantedg[playerid]=29,ShowMenuForPlayer(bullets, playerid);
	        case 3:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon4)
	{
	    switch(row)
		{
	        case 0:wantedg[playerid]=25,ShowMenuForPlayer(bullets, playerid);
	        case 1:wantedg[playerid]=26,ShowMenuForPlayer(bullets, playerid);
	        case 2:wantedg[playerid]=27,ShowMenuForPlayer(bullets, playerid);
	        case 3:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon5)
	{
	    switch(row)
		{
	        case 0:wantedg[playerid]=31,ShowMenuForPlayer(bullets, playerid);
	        case 1:wantedg[playerid]=30,ShowMenuForPlayer(bullets, playerid);
	        case 2:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon6)
	{
	    switch(row)
		{
	        case 0:wantedg[playerid]=33,ShowMenuForPlayer(bullets, playerid);
	        case 1:wantedg[playerid]=34,ShowMenuForPlayer(bullets, playerid);
	        case 2:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon7)
	{
	    switch(row)
		{
	        case 0:wantedg[playerid]=18,ShowMenuForPlayer(bullets, playerid);
	        case 1:wantedg[playerid]=16,ShowMenuForPlayer(bullets, playerid);
	        case 2:wantedg[playerid]=39,ShowMenuForPlayer(bullets, playerid);
	        case 3:wantedg[playerid]=17,ShowMenuForPlayer(bullets, playerid);
	        case 4:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon8)
	{
	    switch(row)
		{
	        case 0:wantedg[playerid]=37,ShowMenuForPlayer(bullets, playerid);
	        case 1:wantedg[playerid]=38,ShowMenuForPlayer(bullets, playerid);
	        case 2:wantedg[playerid]=35,ShowMenuForPlayer(bullets, playerid);
	        case 3:wantedg[playerid]=36,ShowMenuForPlayer(bullets, playerid);
	        case 4:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon9)
	{
	    switch(row)
		{
	        case 0:wantedg[playerid]=41,ShowMenuForPlayer(bullets, playerid);
	        case 1:wantedg[playerid]=43,ShowMenuForPlayer(bullets, playerid);
	        case 2:wantedg[playerid]=42,ShowMenuForPlayer(bullets, playerid);
	        case 3:wantedg[playerid]=46,ShowMenuForPlayer(bullets, playerid);
	        case 4:wantedg[playerid]=45,ShowMenuForPlayer(bullets, playerid);
	        case 5:wantedg[playerid]=44,ShowMenuForPlayer(bullets, playerid);
	        case 6:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == weapon10)
	{
	    switch(row)
		{
	        case 0:GivePlayerWeapon(playerid, 15,1);
	        case 1:GivePlayerWeapon(playerid, 14,1);
	        case 2:GivePlayerWeapon(playerid, 10,1);
	        case 3:GivePlayerWeapon(playerid, 13,1);
	        case 4:GivePlayerWeapon(playerid, 10,1);
	        case 5:GivePlayerWeapon(playerid, 11,1);
	        case 6:ShowMenuForPlayer(weaponmain, playerid);
		}
	}
    if(CurrentMenu == bullets)
	{
	    switch(row)
		{
	        case 0:GivePlayerWeapon(playerid, wantedg[playerid],10);
	        case 1:GivePlayerWeapon(playerid, wantedg[playerid],50);
	        case 2:GivePlayerWeapon(playerid, wantedg[playerid],100);
	        case 3:GivePlayerWeapon(playerid, wantedg[playerid],500);
	        case 4:GivePlayerWeapon(playerid, wantedg[playerid],1000);
	        case 5:GivePlayerWeapon(playerid, wantedg[playerid],5000);
	        case 6:ShowMenuForPlayer(weaponmain, playerid);
	    }
    }
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid,1);
    new Menu:Current = GetPlayerMenu(playerid);
    HideMenuForPlayer(Current,playerid);
    return 1;
}
//===============================Player Commands================================
dcmd_register(playerid, params[])
{
	new string[128];
	if(!strlen(params)) return SendClientMessage(playerid, RED, "USAGE: /REGISTER [PASSWORD]   [PASSWORD MUST BE 6+ AND -25].");
	if((strlen(params) < 6 || strlen(params) > 25)) return SendClientMessage(playerid,RED,"Password must be 6+ and -25");
	if(Info[playerid][Registered]) return SendClientMessage(playerid,RED,"there is already a playerfile with yourname");
	dini_Create(GetFile(playerid)); SetInfo(playerid,"Registered",1); SetInfo(playerid,"Password",udb_hash(params)); SetInfo(playerid,"logged",1);
	format(string, 256, "You succesfully registered the nickname %s with password %s", Name(playerid), params); SetSInfo(playerid,"IP",PlayerIp(playerid));
	SendClientMessage(playerid, YELLOW, string); Info[playerid][logged] = 1;
	SendClientMessage(playerid, YELLOW, "You have been automatically logged in!");
	return 1;
}

dcmd_login(playerid, params[])
{
	new password[25],string[128],rank[128];
	if(Info[playerid][logged]) return SendClientMessage(playerid, RED, "You're already logged in!");
	if(!dini_Exists(GetFile(playerid))) return SendClientMessage(playerid, RED, "Error: This account isn't registered. Register with /register [password]");
	if(sscanf(params, "s", password)) return SendClientMessage(playerid, RED, "USAGE: /LOGIN [PASSWORD]");
	if(udb_hash(password) != dini_Int(GetFile(playerid), "Password"))
	{
	    FailLogin[playerid]++;
	    format(string,sizeof(string),"Wrong password (warnings: %d,%d)",FailLogin[playerid],GetConfig("FailLogins"));
	    if(FailLogin[playerid] >= GetConfig("FailLogins"))
	    {
	        format(string,sizeof(string),"Player %s has been kicked from the server [Reason: Max Failed logins ]",Name(playerid));
	        SendClientMessageToAll(YELLOW,string);
	        return Kick(playerid);
	    }
		return SendClientMessage(playerid, RED, string);
	}
	if(strlen(password) < 6 || strlen(password) > 25) return SendClientMessage(playerid,RED,"Password must be 6+ and -25");
	if(GetInfo(playerid,"Banned") == 1)
	{
	    SendClientMessage(playerid,YELLOW,"You have been banned from this server [Reason: Ban Evade.]");
	    BanEx(playerid,"Ban Evade");
	    format(string,sizeof(string),"Player: %s Have been Banned from the server [Reason: Ban evade.]",Name(playerid));
	    return SendClientMessageToAll(YELLOW,string),print(string);
	}
	if(!strcmp(PlayerIp(playerid),"127.0.0.1",true)) rank = "Server Owner";
	else
	switch(GetInfo(playerid,"AdminLevel"))
	{
	    case 1: rank = "Low Moderator";
		case 2: rank = "Normal Moderator";
		case 3: rank = "Big Moderator";
		case 4: rank = "Hero moderator";
		case 5: rank = "Low Administrator";
		case 6: rank = "Normal Administrator";
		case 7: rank = "Big Administrator";
		case 8: rank = "Hero Administrator";
		case 9: rank = "High Administrator";
		case 10: rank = "Highest Administrator";
	}
	Info[playerid][logged] = 1; SetInfo(playerid,"logged",1);
	if(GetInfo(playerid,"AdminLevel")> 1) format(string,sizeof(string),"you have successfully logged in with the Administrator Rank: %s",rank);
	else format(string,sizeof(string),"you have successfully logged in");
	SendClientMessage(playerid,GREEN,string);
	return 1;
}

dcmd_logout(playerid,params[])
{
	#pragma unused params
    if(Info[playerid][Registered] && Info[playerid][logged])
	{
		SendClientMessage(playerid,YELLOW,"You have logged out");
	 	SetInfo(playerid,"logged",0);
		Info[playerid][logged] = 0;
	}
	else SendClientMessage(playerid,RED,"You are not registered/logged in");
	return 1;
}

dcmd_changepass(playerid, params[])
{
    new oldpass[25],newpass[25],string[128];
    if(sscanf(params, "ss", oldpass, newpass)) return SendClientMessage(playerid, YELLOW, "USAGE: /CHANGEPASS [OLDPASS] [NEWPASS]");
    if(udb_hash(oldpass) != dini_Int(GetFile(playerid), "Password")) return SendClientMessage(playerid, RED, "Wrong password.");
    if((strlen(newpass) < 6 || strlen(newpass) > 25)) return SendClientMessage(playerid,RED,"Password must be 6+ and -25");
    SetInfo(playerid,"Password",udb_hash(newpass));
    format(string,sizeof(string),"You have changed your account password from: %s to %s",oldpass,newpass);
    SendClientMessage(playerid,GREEN,string);
	return 1;
}

//==============================Admin Commands==================================
dcmd_kick(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"kick")) return CmdLevelError(playerid,"kick");
	new id, tmp[128];
	if(sscanf(params, "uz", id, tmp)) return SendClientMessage(playerid, RED, "USAGE: /KICK [ID / NAME] [REASON]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	format(tmp, sizeof tmp, "Player: %s has been Kicked by Administrator %s%s%s%s",Name(id), AdminName(playerid), (tmp[0]) ? (" [reason: ") : ("."), tmp[0], (tmp[0]) ? (" ]") : (""));
	SendClientMessageToAll(YELLOW, tmp), print(tmp), SaveToLog("kicks",tmp), SetInfo(id,"Kicks",GetInfo(id,"Kicks")+1);
	SendCommandMsg(playerid,"kick");
	format(tmp,sizeof(tmp),"Kicked By Admin %s",AdminName(playerid));
	SpecialLeaveReason[id]=1,PlayerLeaveReason[id]=tmp;
	return Kick(id);
}

dcmd_ban(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"ban")) return CmdLevelError(playerid,"ban");
	new id, tmp[128],string[128];
	if(sscanf(params, "uz", id, tmp)) return SendClientMessage(playerid, RED, "USAGE: /BAN [ID / NAME] [REASON]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	format(string, sizeof string, "Player: %s has been Banned by Administrator %s%s%s%s",Name(id), AdminName(playerid), (tmp[0]) ? (" [reason: ") : ("."), tmp[0], (tmp[0]) ? (" ]") : (""));
	SendClientMessageToAll(YELLOW, string), print(string),
	SaveToLog("bans",string);
	SetInfo(id,"Banned",1);
	format(string,sizeof(string),"Banned By Admin %s",AdminName(playerid));
	SpecialLeaveReason[id]=1,PlayerLeaveReason[id]=string;
	SendCommandMsg(playerid,"ban");
	return BanEx(id,tmp);
}

dcmd_admins(playerid,params[])
{
    #pragma unused params
	new count=0,string[128],rank[128];
	SendClientMessage(playerid, LIGHTBLUE, "_________________|Admins Online|_________________");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && IsPlayerHAdmin(i))
		{
		    if(!strcmp(PlayerIp(i),"127.0.0.1",true)) rank = "Server Owner";
			else
			switch(GetInfo(i,"AdminLevel"))
			{
			    case 1: rank = "Low Moderator";
				case 2: rank = "Normal Moderator";
				case 3: rank = "Big Moderator";
				case 4: rank = "Hero moderator";
				case 5: rank = "Low Administrator";
				case 6: rank = "Normal Administrator";
				case 7: rank = "Big Administrator";
				case 8: rank = "Hero Administrator";
				case 9: rank = "High Administrator";
				case 10: rank = "Highest Administrator";
			}
			format(string, 128, "Admin: %s  Level: %d  Rank: %s", AdminName(i),GetInfo(i,"AdminLevel"),rank);
			SendClientMessage(playerid, LIGHTBLUE, string);
			count++;
		}
	}
	if (count == 0) SendClientMessage(playerid,LIGHTBLUE,"There Are no Admins Online");
	return SendClientMessage(playerid, LIGHTBLUE, "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯");
}

dcmd_freeze(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"freeze")) return CmdLevelError(playerid,"freze");
	new id, tmp[128];
	if(sscanf(params, "uz", id, tmp)) return SendClientMessage(playerid, RED, "USAGE: /FREEZE [ID / NAME] [REASON]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	format(tmp, sizeof tmp, "Player: %s Is Frozen by Administrator: %s%s%s%s",Name(id), AdminName(playerid), (tmp[0]) ? (" [reason: ") : ("."), tmp[0], (tmp[0]) ? (" ]") : (""));
	SendClientMessageToAll(YELLOW, tmp), print(tmp), SetCameraBehindPlayer(id);
	SendCommandMsg(playerid,"freeze"),Info[id][Frozen]=1;
	return TogglePlayerControllable(id,0);
}

dcmd_unfreeze(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"unfreeze")) return CmdLevelError(playerid,"unfreeze");
	new id, string[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /UNFREEZE [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(id!=playerid) format(string, sizeof(string), "Player: %s Is Unfrozen by Administrator: %s",Name(id), AdminName(playerid));
	if(id!=playerid) SendClientMessageToAll(YELLOW,string),print(string),SetCameraBehindPlayer(id);
	SendCommandMsg(playerid,"unfreeze"),Info[id][Frozen]=0;
	return TogglePlayerControllable(id,1);
}

dcmd_goto(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"goto")) return CmdLevelError(playerid,"goto");
	new id,string[128],Float:X,Float:Y,Float:Z;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /GOTO [ID / NAME]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	SetPlayerInterior(playerid,GetPlayerInterior(id));
	SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id)); GetPlayerPos(id,X,Y,Z);
	if(IsPlayerInAnyVehicle(playerid))
	{
		SetVehiclePos(GetPlayerVehicleID(playerid),X+2,Y,Z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(id));
	}
	else SetPlayerPos(playerid,X+2,Y,Z);
	format(string,sizeof(string),"You teleported to %s his location",Name(id)); SendClientMessage(playerid,YELLOW,string);
	format(string,sizeof(string),"Admin: %s Teleported to your location",AdminName(playerid));
	SendClientMessage(id,YELLOW,string);
	SendCommandMsg(playerid,"goto");
	return 1;
}

dcmd_gethere(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"gethere")) return CmdLevelError(playerid,"gethere");
	new id,string[128],Float:X,Float:Y,Float:Z;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /GETHERE [ID / NAME]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	SetPlayerInterior(id,GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid)); GetPlayerPos(playerid,X,Y,Z);
	if(IsPlayerInAnyVehicle(id))
	{
		SetVehiclePos(GetPlayerVehicleID(id),X+2,Y,Z);
		LinkVehicleToInterior(GetPlayerVehicleID(id),GetPlayerInterior(playerid));
	}
	else SetPlayerPos(id,X+2,Y,Z);
	SendCommandMsg(playerid,"gethere");
	format(string,sizeof(string),"You teleported %s to your location",Name(id)); SendClientMessage(playerid,YELLOW,string);
	format(string,sizeof(string),"Admin: %s Teleported you to his location",AdminName(playerid)); return SendClientMessage(id,YELLOW,string);
}

dcmd_jail(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"jail")) return CmdLevelError(playerid,"jail");
	new id, tmp[256];
	if(sscanf(params, "uz", id, tmp)) return SendClientMessage(playerid, RED, "USAGE: /JAIL [ID / NAME] [REASON]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	format(tmp, sizeof tmp, "Player: %s has been Jailed by Administrator %s%s%s%s",Name(id), AdminName(playerid), (tmp[0]) ? (" [reason: ") : ("."), tmp[0], (tmp[0]) ? (" ]") : (""));
	SendClientMessageToAll(YELLOW, tmp),print(tmp),Info[id][Jailed]=1,SetPlayerInterior(id,3);
	SendCommandMsg(playerid,"jail");
	return SetPlayerPos(id,197.6661,173.8179,1003.0234);
}

dcmd_unjail(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"unjail")) return CmdLevelError(playerid,"unjail");
	new id,string[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /UNJAIL [ID / NAME]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	if(Info[id][Jailed]==0) return SendClientMessage(playerid,RED,"ERROR: This player Isn't Jailed.");
	format(string,sizeof(string),"Player: %s Is UnJailed by Administrator %s.",Name(id),AdminName(playerid)); print(string);
	SendClientMessageToAll(YELLOW,string),Info[id][Jailed]=0,SetPlayerInterior(id,0);
	SendCommandMsg(playerid,"unjail");
	return SpawnPlayer(id);
}

dcmd_announce(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"announce")) return CmdLevelError(playerid,"announce");
	if(!strlen(params)) {
	SendClientMessage(playerid,RED,"USAGE: /ANNOUNCE [TEXT]");
	return SendClientMessage(playerid, RED, "TIP: ~n~ New line,~r~ Red,~g~ Green,~b~ Blue,~w~ White,~y~ Yellow,~p~ Purple,~l~ Black"); }
 	printf("[announce][%s] %s",Name(playerid),params);
    GameTextForAll(params,5000,4);
    SendCommandMsg(playerid,"announce");
	return 1;
}

dcmd_report(playerid,params[])
{
    if(!strlen(params)) return SendClientMessage(playerid,RED,"USAGE: /REPORT [TEXT]");
	new string[128],str[128],year,month,day,hour,minute,second;
	format(string,sizeof(string),"REPORT: [from: %s][ID: %d]:  %s",Name(playerid),playerid,params);
	SendMessageToAdmins(ADMINCOLOR,string),print(string);
	getdate(year, month, day), gettime(hour,minute,second);
	format(str,sizeof(str),"[%d,%d,%d][%d,%d.%d] [from: %s] [IP: %s]:  %s",day,month,year,hour,minute,second,Name(playerid),PlayerIp(playerid),params);
	SaveToLog("reports",str);
	return 1;
}

dcmd_clearchat(playerid,params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"clearchat")) return CmdLevelError(playerid,"clearchat");
	new string[128];
	for(new b = 0; b < 13; b++)
	{
		SendClientMessageToAll(LIGHTBLUE," ");
	}
    format(string, sizeof(string), "Administrator %s Have Cleared the chat.", AdminName(playerid));
    SendCommandMsg(playerid,"clearchat");
	return SendClientMessageToAll(YELLOW, string);
}

dcmd_healall(playerid, params[])
{
    #pragma unused params
	if(!CmdLevelCheck(playerid,"healall")) return CmdLevelError(playerid,"healall");
	for(new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i)) SetPlayerHealth(i, 100.0);
	new string[128];
	format(string, sizeof(string), "Everybody has been healed by Administrator: %s", AdminName(playerid));
	SendClientMessageToAll(YELLOW, string);
    SendCommandMsg(playerid,"healall");
	return 1;
}

dcmd_armourall(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"armourall")) return CmdLevelError(playerid,"armourall");
	for(new i = 0; i < MAX_PLAYERS; i++) { if (IsPlayerConnected(i)) { SetPlayerArmour(i, 100.0); } }
	new string[128];
	format(string, sizeof(string), "Everybody has been armoured by Administrator %s", AdminName(playerid));
	SendClientMessageToAll(YELLOW, string);
	SendCommandMsg(playerid,"armourall");
	return 1;
}

dcmd_ip(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"ip")) return CmdLevelError(playerid,"ip");
	new id,string[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /IP [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	format(string, sizeof string, "Player: %s His IP: %s",Name(id),PlayerIp(id));
	SendCommandMsg(playerid,"ip");
	return SendClientMessage(playerid,YELLOW, string);
}

dcmd_showname(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"showname")) return CmdLevelError(playerid,"showname");
	if(!strlen(params)) return SendClientMessage(playerid,RED,"USAGE: /SHOWNAME [YES/NO]");
	if(!strcmp(params, "yes", true))
	{
		SetInfo(playerid,"ShowName",0);
		SendClientMessage(playerid,LIGHTBLUE,"now other players see your admin name");
	}
	else if(!strcmp(params, "no", true))
	{
		SetInfo(playerid,"ShowName",1);
		SendClientMessage(playerid,LIGHTBLUE,"now other players don't see your admin name");
	}
	else SendClientMessage(playerid,RED,"USAGE: NO / YES");
	SendCommandMsg(playerid,"showname");
	return 1;
}

dcmd_god(playerid, params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"god")) return CmdLevelError(playerid,"god");
	SetPlayerHealth(playerid,99999);
	SetPlayerArmour(playerid,99999);
	SendClientMessage(playerid,0xFF0606FF,"GODMODE is ON!");
	SendCommandMsg(playerid,"god");
	GodMode[playerid]=1;
	return 1;
}

dcmd_setgod(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setgod")) return CmdLevelError(playerid,"setgod");
	new id, tmp[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /SETGOD [ID / NAME]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline Use /god to set your health to godmode");
	format(tmp, sizeof tmp, "Administrator: %s have set your health to godmode ",AdminName(playerid));
	SendClientMessage(id,YELLOW, tmp),GodMode[id]=1;
	SendCommandMsg(playerid,"setgod");
	return SetPlayerHealth(id,99999);
}

dcmd_sethealth(playerid,params[])
{
	if(!CmdLevelCheck(playerid,"sethealth")) return CmdLevelError(playerid,"sethealth");
	new id,string[128],number;
	if(sscanf(params, "ui", id, number)) return SendClientMessage(playerid, RED, "USAGE: /SETHEATH [ID / NAME] [0/100]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 100) return SendClientMessage(playerid,RED,"ERROR: Invaild health amount Only: [0/100]");
	format(string,sizeof(string),"Administrator: %s Have set your health to: %d.",Name(id),number); print(string); SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"sethealth");
	return SetPlayerHealth(id,number);
}

dcmd_setarmour(playerid,params[])
{
	if(!CmdLevelCheck(playerid,"setarmour")) return CmdLevelError(playerid,"setarmour");
	new id,string[128],number;
	if(sscanf(params, "ui", id, number)) return SendClientMessage(playerid, RED, "USAGE: /SETARMOUR [ID / NAME] [0/100]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 100) return SendClientMessage(playerid,RED,"ERROR: Invaild armour amount Only: [0/100]");
	format(string,sizeof(string),"Administrator: %s Have set your armour to: %d.",Name(id),number); SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"setarmour");
	return SetPlayerArmour(id,number);
}

dcmd_setallhealth(playerid,params[])
{
	if(!CmdLevelCheck(playerid,"setallhealth")) return CmdLevelError(playerid,"setallhealth");
	if(!strlen(params)) return SendClientMessage(playerid, RED, "USAGE: /SETALLHEALTH [0/100]");
	new amount[256],Index,string[128]; amount = strtok(params,Index);
	if(strval(amount) < 0 || strval(amount) > 100) return SendClientMessage(playerid,RED,"ERROR: Invaild health amount Only: [0/100]");
	format(string,sizeof(string),"Administartor: %s have set everybody's health to: %d.",AdminName(playerid),amount); print(string);
	SendCommandMsg(playerid,"setallhealth");
	for(new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i)) SetPlayerHealth(i,strval(amount));
	return 1;
}

dcmd_setallarmour(playerid,params[])
{
	if(!CmdLevelCheck(playerid,"setallarmour")) return CmdLevelError(playerid,"setallarmour");
	if(!strlen(params)) return SendClientMessage(playerid, RED, "USAGE: /SETALLARMOUR [0/100]");
	new amount[256],Index,string[128]; amount = strtok(params,Index);
	if(strval(amount) < 0 || strval(amount) > 100) return SendClientMessage(playerid,RED,"ERROR: Invaild armour amount Only: [0/100]");
	format(string,sizeof(string),"Administartor: %s have set everybody's armour to: %d.",AdminName(playerid),amount); print(string);
	for(new i = 0; i < MAX_PLAYERS; i++) { if (IsPlayerConnected(i)) { SetPlayerArmour(i,strval(amount)); } }
	SendCommandMsg(playerid,"setallarmour");
	return SendClientMessageToAll(YELLOW,string);
}

dcmd_say(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"say")) return CmdLevelError(playerid,"say");
    if(!strlen(params)) return SendClientMessage(playerid, RED, "USAGE: /SAY [TEXT]");
    new string[128];
    format(string,sizeof(string),"Admin %s: %s",AdminName(playerid),params),print(string);
    SendCommandMsg(playerid,"say");
    return SendClientMessageToAll(ADMINCOLOR,string);
}

dcmd_lockserver(playerid,params[])
{
	if(!CmdLevelCheck(playerid,"lockserver")) return CmdLevelError(playerid,"lockserver");
    new password[256],string[128];
    if(sscanf(params, "s", password)) return SendClientMessage(playerid, RED, "USAGE: /LOCKSERVER [PASSWORD]");
    if(strcmp(password, dini_Get("/Hadmin/config/configuration.ini","ServerPass")) != 0) return SendClientMessage(playerid, RED, "Error: Incorrect server password");
	ServerLock=1;
    format(string,sizeof(string),"SERVER: Admin %s: Has locked the server nobody els can connect.",AdminName(playerid));
    SendCommandMsg(playerid,"lockserver");
    SendClientMessageToAll(YELLOW,string);
    return 1;
}

dcmd_unlockserver(playerid,params[])
{
	if(!CmdLevelCheck(playerid,"unlockserver")) return CmdLevelError(playerid,"unlockserver");
    new password[256],string[128];
    if(sscanf(params, "s", password)) return SendClientMessage(playerid, RED, "USAGE: /UNLOCKSERVER [PASSWORD]");
    if(strcmp(password, dini_Get("/Hadmin/config/configuration.ini","ServerPass")) != 0) return SendClientMessage(playerid, RED, "Error: Incorrect server password");
	ServerLock=0;
    format(string,sizeof(string),"SERVER: Admin %s: Has unlocked the server everybody can connect.",AdminName(playerid));
    SendCommandMsg(playerid,"unlockserver");
    SendClientMessageToAll(YELLOW,string);
    for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) KillTimer(PingTimer[i]);
    return 1;
}

dcmd_godcar(playerid,params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"godcar")) return CmdLevelError(playerid,"godcar");
	if(GodCarOn[playerid] == 0)
	GodCarOn[playerid] = 1, SendClientMessage(playerid, YELLOW, "You have now godcar for every car!"),
	SendClientMessage(playerid, YELLOW, "Type /godcar again to turn the godcar mode off.");
	else GodCarOn[playerid] = 0, SendClientMessage(playerid, YELLOW, "Godcar mode turned off");
	SendCommandMsg(playerid,"godcar");
	return 1;
}

dcmd_givemoney(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"givemoney")) return CmdLevelError(playerid,"givemoney");
	new id,string[128],number;
	if(sscanf(params, "ui", id, number)) return SendClientMessage(playerid, RED, "USAGE: /GIVEMONEY [ID / NAME] [0/1.000.000]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
	if(id!=playerid) format(string,sizeof(string),"Administrator: %s Have Given you $%d.",AdminName(playerid),number);
	else format(string,sizeof(string),"You have given yourself $%d.",number); SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"givemoney");
	return GivePlayerMoney(id,number);
}

dcmd_setmoney(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"setmoney")) return CmdLevelError(playerid,"setmoney");
	new id,string[128],number;
	if(sscanf(params, "ui", id, number)) return SendClientMessage(playerid, RED, "USAGE: /SETMONEY [ID / NAME] [0/1.000.000]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
	if(id!=playerid) format(string,sizeof(string),"Administrator: %s have Set your money to $%d.",AdminName(playerid),number);
	else format(string,sizeof(string),"You have Set your cash to $%d.",number); SendClientMessage(playerid,YELLOW,string);
	SetPlayerMoney(id,number),SendCommandMsg(playerid,"setmoney");
	return 1;
}

dcmd_getmoney(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"getmoney")) return CmdLevelError(playerid,"getmoney");
	new id,string[128],number;
	if(sscanf(params, "ui", id, number)) return SendClientMessage(playerid, RED, "USAGE: /GETMONEY [ID / NAME] [0/1.000.000]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
	format(string,sizeof(string),"Administrator: %s Have Get $%d from your money away",AdminName(playerid),number); SendClientMessage(playerid,YELLOW,string);
    SendCommandMsg(playerid,"getmoney");SetPlayerMoney(id,GetPlayerMoney(id)-number);
	return 1;
}

dcmd_setscore(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"setscore")) return CmdLevelError(playerid,"setscore");
	new id,string[128],number;
	if(sscanf(params, "ui", id, number)) return SendClientMessage(playerid, RED, "USAGE: /SETSCORE [ID / NAME] [1-100.000]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 100000) return SendClientMessage(playerid,RED,"ERROR: Invaild Score: [0/100.000]");
	if(id!=playerid) format(string,sizeof(string),"Administrator: %s have Set your Score to %d.",AdminName(playerid),number);
	else format(string,sizeof(string),"You have Set your score to %d.",number); SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"setscore");
	return SetPlayerScore(id,number);
}

dcmd_resetmoney(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"resetmoney")) return CmdLevelError(playerid,"resetmoney");
	new id,string[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /RESETMONEY [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(id!=playerid) format(string,sizeof(string),"Administrator: %s Have reseted your money",AdminName(playerid));
	else format(string,sizeof(string),"you have reseted your money"); SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"resetmoney");
	return ResetPlayerMoney(id);
}

dcmd_resetscore(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"resetscore")) return CmdLevelError(playerid,"resetscore");
	new id,string[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /RESETSCORE [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(id!=playerid) format(string,sizeof(string),"Administrator: %s Have reseted your score",AdminName(playerid));
	else format(string,sizeof(string),"you have reseted your score"); SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"resetscore");
	return SetPlayerScore(id,0);
}

dcmd_resetallmoney(playerid,params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"resetallmoney")) return CmdLevelError(playerid,"resetallmoney");
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) ResetPlayerMoney(i);
	format(string,sizeof(string),"Administrator: %s Have reseted All money",AdminName(playerid));
	SendCommandMsg(playerid,"resetallmoney");
	return SendClientMessageToAll(YELLOW,string);
}

dcmd_resetallscores(playerid,params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"resetallscores")) return CmdLevelError(playerid,"resetallscores");
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerScore(i,0);
	format(string,sizeof(string),"Administrator: %s Have reseted All Scores",AdminName(playerid));
	SendCommandMsg(playerid,"resetallscores");
	return SendClientMessageToAll(YELLOW,string);
}

dcmd_setadminlevel(playerid,params[])
{
    if(!IsPlayerAdmin(playerid)) return 0;
	new id,string[128],number;
	if(sscanf(params, "ud", id, number)) return SendClientMessage(playerid, RED, "USAGE: /SETADMINLEVEL [ID / NAME] [0/10]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 10) return SendClientMessage(playerid,RED,"ERROR: Invaild Level: [0/10]");
	if(GetInfo(id,"AdminLevel")==number) return SendClientMessage(playerid, RED, "This player is already administrator with that level");
	format(string,sizeof(string),"Administrator: %s have Set %s his AdministratorLevel to: %d.",AdminName(playerid),AdminName(id),number),SendClientMessageToAll(YELLOW,string);
	Info[id][AdminLevel]=number,SendCommandMsg(playerid,"setadminlevel");
	return SetInfo(id,"AdminLevel",number);
}


dcmd_akill(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"akill")) return CmdLevelError(playerid,"akill");
	new id, tmp[128],string[128];
	if(sscanf(params, "uz", id, tmp)) return SendClientMessage(playerid, RED, "USAGE: /AKILL [ID / NAME] [REASON]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	format(tmp, sizeof tmp, "You are Killed by Administrator %s%s%s%s",AdminName(playerid), (tmp[0]) ? (" [reason: ") : ("."), tmp[0], (tmp[0]) ? (" ]") : (""));
	format(string, sizeof string, "You have Killed %s",Name(id));
	SendClientMessage(id,YELLOW, tmp),SendClientMessage(playerid,YELLOW, string);
	SendCommandMsg(playerid,"akill");
	return SetPlayerHealth(id,0);
}

dcmd_ping(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"ping")) return CmdLevelError(playerid,"ping");
	new id,string[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /PING [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	format(string, sizeof string, "Player: %s His Ping: %d",Name(id),GetPlayerPing(id));
	SendCommandMsg(playerid,"ping");
	return SendClientMessage(playerid,YELLOW, string);
}

dcmd_setcolor(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"setcolor")) return CmdLevelError(playerid,"setcolor");
    new id,string[128],color[128];
	if(sscanf(params, "us", id,color)) return SendClientMessage(playerid, RED, "USAGE: /SETCOLOR [ID / NAME] [COLOR]"),SendClientMessage(playerid, RED, "TIP: look at /hhelp for the colors");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(!strcmp(color, "GREY", true)) SetPlayerColor(id,GREY);
	else if(!strcmp(color, "YELLOW", true)) SetPlayerColor(id,YELLOW);
	else if(!strcmp(color, "PINK", true)) SetPlayerColor(id,PINK);
	else if(!strcmp(color, "BLUE", true)) SetPlayerColor(id,BLUE);
	else if(!strcmp(color, "WHITE", true)) SetPlayerColor(id,WHITE);
	else if(!strcmp(color, "LIGHTBLUE", true)) SetPlayerColor(id,LIGHTBLUE);
	else if(!strcmp(color, "DARKRED", true)) SetPlayerColor(id,DARKRED);
	else if(!strcmp(color, "ORANGE", true)) SetPlayerColor(id,ORANGE);
	else if(!strcmp(color, "BRIGHTRED", true)) SetPlayerColor(id,BRIGHTRED);
	else if(!strcmp(color, "INDIGO", true)) SetPlayerColor(id,INDIGO);
	else if(!strcmp(color, "VIOLET", true)) SetPlayerColor(id,VIOLET);
	else if(!strcmp(color, "LIGHTRED", true)) SetPlayerColor(id,LIGHTRED);
	else if(!strcmp(color, "SEAGREEN", true)) SetPlayerColor(id,SEAGREEN);
	else if(!strcmp(color, "GRAYWHITE", true)) SetPlayerColor(id,GRAYWHITE);
	else if(!strcmp(color, "LIGHTNEUTRALBLUE", true)) SetPlayerColor(id,LIGHTNEUTRALBLUE);
	else if(!strcmp(color, "GREENISHGOLD", true)) SetPlayerColor(id,GREENISHGOLD);
	else if(!strcmp(color, "LIGHTBLUEGREEN", true)) SetPlayerColor(id,LIGHTBLUEGREEN);
	else if(!strcmp(color, "NEUTRALBLUE", true)) SetPlayerColor(id,NEUTRALBLUE);
	else if(!strcmp(color, "LIGHTCYAN", true)) SetPlayerColor(id,LIGHTCYAN);
	else if(!strcmp(color, "LEMON", true)) SetPlayerColor(id,LEMON);
	else if(!strcmp(color, "MEDIUMBLUE", true)) SetPlayerColor(id,MEDIUMBLUE);
	else if(!strcmp(color, "NEUTRAL", true)) SetPlayerColor(id,NEUTRAL);
	else if(!strcmp(color, "BLACK", true)) SetPlayerColor(id,BLACK);
	else if(!strcmp(color, "NEUTRALGREEN", true)) SetPlayerColor(id,NEUTRALGREEN);
	else if(!strcmp(color, "DARKGREEN", true)) SetPlayerColor(id,DARKGREEN);
	else if(!strcmp(color, "LIGHTGREEN", true)) SetPlayerColor(id,LIGHTGREEN);
	else if(!strcmp(color, "DARKBLUE", true)) SetPlayerColor(id,DARKBLUE);
	else if(!strcmp(color, "BLUEGREEN", true)) SetPlayerColor(id,BLUEGREEN);
	else if(!strcmp(color, "PINK", true)) SetPlayerColor(id,PINK);
	else if(!strcmp(color, "LIGHTBLUE", true)) SetPlayerColor(id,LIGHTBLUE);
	else if(!strcmp(color, "DARKRED", true)) SetPlayerColor(id,DARKRED);
	else if(!strcmp(color, "PURPLE", true)) SetPlayerColor(id,PURPLE);
	else if(!strcmp(color, "GREY", true)) SetPlayerColor(id,GREY);
	else if(!strcmp(color, "GREEN", true)) SetPlayerColor(id,GREEN);
	else if(!strcmp(color, "RED", true)) SetPlayerColor(id,RED);
	else if(!strcmp(color, "YELLOW", true)) SetPlayerColor(id,YELLOW);
	else if(!strcmp(color, "WHITE", true)) SetPlayerColor(id,WHITE);
	else if(!strcmp(color, "BROWN", true)) SetPlayerColor(id,BROWN);
	else if(!strcmp(color, "CYAN", true)) SetPlayerColor(id,CYAN);
	else if(!strcmp(color, "TAN", true)) SetPlayerColor(id,TAN);
	else if(!strcmp(color, "PINK", true)) SetPlayerColor(id,PINK);
	else if(!strcmp(color, "KHAKI", true)) SetPlayerColor(id,KHAKI);
	else if(!strcmp(color, "LIME", true)) SetPlayerColor(id,LIME);
	else SendClientMessage(playerid,RED,"enter a valid color or look at /HHelp");
	format(string,sizeof(string),"Administrator %s have set your color to %s",AdminName(playerid),color); SendClientMessage(id,YELLOW,string);
	format(string,sizeof(string),"You have set %s his color to %s",Name(id),color); SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"setcolor");
	return 1;
}

dcmd_setcarhealth(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"setcarhealth")) return CmdLevelError(playerid,"setcarhealth");
    new id,string[128], Float:health;
	if(sscanf(params, "uf", id,health)) return SendClientMessage(playerid, RED, "USAGE: /SETCARHEALTH [ID / NAME] [1/1000]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, RED, "ERROR: This player is not in a vehicle");
	if(health < 0.0 || health > 1000.0) return SendClientMessage(playerid,RED,"ERROR: Enter A valid Health: [1-1000]");
	if(id==playerid) format(string,sizeof(string),"You have set your vehiclehealth to %f",health);
	else format(string,sizeof(string),"Administrator: %s Have Set your vehiclehealth to %f",AdminName(playerid),health);
	SendClientMessage(id,YELLOW,string),SendClientMessage(playerid,YELLOW,"you have set the carhealth");
	SendCommandMsg(playerid,"setcarhealth");
	SetVehicleHealth(GetPlayerVehicleID(id),health);
	return 1;
}



dcmd_giveweapon(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"giveweapon")) return CmdLevelError(playerid,"giveweapon");
	new weapon[256],id,ammo,string[128];
	if(sscanf(params, "usd", id,weapon,ammo)) return SendClientMessage(playerid, RED, "USAGE: /GIVEWEAPON [ID / NAME] [WEAPON] [AMMO]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	new weaponid = GetWeaponID(weapon); if (weaponid == -1) weaponid = strval(weapon);
	if (weaponid < 0 || weaponid > 47) return SendClientMessage(playerid, RED, "[ERROR]: enter a valid WeaponName/WeaponID.");
    GivePlayerWeapon(id, weaponid, ammo); if(id!=playerid) {
	format(string, 256, "Administrator %s have given you a %s with ammo: %d",AdminName(playerid),WeaponNames[weaponid],ammo);
    SendClientMessage(id,YELLOW,string); } else if(id==playerid) {
	format(string, 256, "you have given yourself a %s with %d ammo",WeaponNames[weaponid],ammo);
    SendClientMessage(id, YELLOW, string); }
    SendCommandMsg(playerid,"giveweapon");
	return 1;
}

dcmd_hhelp(playerid,params[])
{
	#pragma unused params
	if(!CmdLevelCheck(playerid,"hhelp")) return CmdLevelError(playerid,"hhelp");
    TextDrawShowForPlayer(playerid,ColorHelp0);
    TextDrawShowForPlayer(playerid,ColorHelp1);
    TextDrawShowForPlayer(playerid,ColorHelp2);
    TextDrawShowForPlayer(playerid,ColorHelp3);
    TextDrawShowForPlayer(playerid,ColorHelp4);
    TextDrawShowForPlayer(playerid,closehelp);
    ColorOpen[playerid]=1;
    SendCommandMsg(playerid,"hhelp");
	return 1;
}

dcmd_mute(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"mute")) return CmdLevelError(playerid,"mute");
	new id, tmp[128];
	if(sscanf(params, "uz", id, tmp)) return SendClientMessage(playerid, RED, "USAGE: /MUTE [ID / NAME] [REASON]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	if(Info[id][Muted]==1) return SendClientMessage(playerid,RED,"Error: This player is already muted");
	format(tmp, sizeof tmp, "%s is Muted by Administrator %s%s%s%s",Name(id),AdminName(playerid), (tmp[0]) ? (" [reason: ") : ("."), tmp[0], (tmp[0]) ? (" ]") : (""));
	SendClientMessageToAll(YELLOW, tmp),Info[id][Muted]=1;
	SendCommandMsg(playerid,"mute");
	return Info[id][Muted]=1;
}

dcmd_unmute(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"unmute")) return CmdLevelError(playerid,"unmute");
	new id, tmp[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /UNMUTE [ID / NAME]");
	if(Info[id][Muted]==0) return SendClientMessage(playerid,RED,"Error: This player is already unmuted");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	format(tmp, sizeof tmp, "Administrator %s Have unmuted %s",AdminName(playerid),Name(id));
	SendClientMessageToAll(YELLOW, tmp),Info[id][Muted]=0;
	SendCommandMsg(playerid,"unmute");
	return Info[id][Muted]=0;
}

dcmd_getallhere(playerid, params[])
{
	#pragma unused params
	if(!CmdLevelCheck(playerid,"getallhere")) return CmdLevelError(playerid,"getallhere");
	new string[128],Float:X,Float:Y,Float:Z;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && i!=playerid)
		{
		    GetPlayerPos(playerid,X,Y,Z);
			SetPlayerInterior(i,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(i,GetPlayerVirtualWorld(playerid));
			if(!IsPlayerInAnyVehicle(i)) SetPlayerPos(i,X+2,Y+2,Z);
			else if(IsPlayerInAnyVehicle(i))
			{
			    LinkVehicleToInterior(GetPlayerVehicleID(i),GetPlayerInterior(playerid));
				SetVehiclePos(GetPlayerVehicleID(i),X+2,Y+2,Z);
			}
		}
	}
	format(string,sizeof(string),"Admin: %s Teleported everybody to his location",AdminName(playerid));
	SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"getallhere");
	return 1;
}

dcmd_carbom(playerid, params[])
{
	#pragma unused params
	if(!CmdLevelCheck(playerid,"carbom")) return CmdLevelError(playerid,"carbom");
   	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,RED,"you must be in a vehicle");
   	SendClientMessage(playerid,GREEN,"You set a carbom on your car 6 seconds to explode");
   	SetTimerEx("bomcar",6000,0,"ii",playerid, GetPlayerVehicleID(playerid));
   	SendCommandMsg(playerid,"carbom");
	return 1;
}

forward bomcar(playerid,vehicleid);
public bomcar(playerid,vehicleid)
{
	new Float:X,Float:Y,Float:Z;
	GetVehiclePos(vehicleid,X,Y,Z);
	CreateExplosion(X,Y,Z,6,4.0);
	SetVehicleHealth(vehicleid, -1);
	SendClientMessage(playerid,GREEN,"vehicle exploded");
	return 1;
}

dcmd_eject(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"eject")) return CmdLevelError(playerid,"eject");
	new id, tmp[128];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /EJECT [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,RED,"This player is not in a vehicle!");
	if(id!=playerid) return format(tmp, sizeof tmp, "Administrator %s Have Ejected %s From his vehicle",AdminName(playerid),Name(id)),SendClientMessageToAll(YELLOW, tmp),RemovePlayerFromVehicle(id);
	else if(id==playerid) return SendClientMessage(playerid,YELLOW,"You have removed yourself from your vehicle"),RemovePlayerFromVehicle(id);
	SendCommandMsg(playerid,"eject");
	return 1;
}

dcmd_setcarcolor(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setcarcolor")) return CmdLevelError(playerid,"setcarcolor");
    new color1,color2;
    if(sscanf(params, "ii", color1,color2)) return SendClientMessage(playerid, RED, "USAGE: /SETCARCOLOR [COLOR1] [COLOR2]");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,RED,"You are not in a vehicle");
    if(color1 < 0 || color1 > 126 || color2 < 0 || color2 > 126) return SendClientMessage(playerid,RED,"ERROR: enter a valid car color!");
	ChangeVehicleColor(GetPlayerVehicleID(playerid), color1,color2);
	SendCommandMsg(playerid,"setcarcolor");
	return SendClientMessage(playerid,GREEN,"you have changed your car color");
}

dcmd_ejectall(playerid, params[])
{
	#pragma unused params
	if(!CmdLevelCheck(playerid,"ejectall")) return CmdLevelError(playerid,"ejectall");
	new tmp[70];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInAnyVehicle(i))
			{
				return RemovePlayerFromVehicle(i);
			}
		}
	}
	format(tmp, sizeof tmp, "Administrator %s Have Ejected everybody from his vehicle.",AdminName(playerid));
	SendClientMessageToAll(YELLOW, tmp);
	SendCommandMsg(playerid,"ejectall");
	return 1;
}

dcmd_pullin(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"pullin")) return CmdLevelError(playerid,"pullin");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,RED,"you are not in a vehicle");
	new id,seat,string[128];
	if (sscanf(params, "ui", id, seat)) return SendClientMessage(playerid, RED, "USAGE: /PULLIN [ID / NICK] [SEAT]");
	if (!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if (seat < 0 || seat > 3) return SendClientMessage(playerid, RED, "ERROR: enter a valid seat: 0-driver, 1-co-driver, 2&3-passengers");
	format(string,sizeof(string),"you are pulled in administrator %s his car",AdminName(playerid));
	SendCommandMsg(playerid,"pullin");
	if(IsPlayerInAnyVehicle(id)) RemovePlayerFromVehicle(id);
	PutPlayerInVehicle(id, GetPlayerVehicleID(playerid), seat);
	return 1;
}

dcmd_explode(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"explode")) return CmdLevelError(playerid,"explode");
    new id,Float:X,Float:Y,Float:Z,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /EXPLODE [ID / NICK]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(IsPlayerInAnyVehicle(id)) GetVehiclePos(GetPlayerVehicleID(id),X,Y,Z),CreateExplosion(X,Y,Z,7,4.0),SetVehicleHealth(GetPlayerVehicleID(id), -1),SetPlayerHealth(id,0);
	else GetPlayerPos(id,X,Y,Z),CreateExplosion(X,Y,Z,7,4.0),SetPlayerHealth(id,0);
	format(string,sizeof(string),"Administrator %s have Exploded Player: %s",AdminName(playerid),Name(id));
	SendCommandMsg(playerid,"explode");
	SendClientMessage(id,YELLOW,string);
	return 1;
}

dcmd_explodeall(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"explodeall")) return CmdLevelError(playerid,"explodeall");
    new Float:X,Float:Y,Float:Z,string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && i != playerid)
		{
			if(IsPlayerInAnyVehicle(i))
			{
				GetVehiclePos(GetPlayerVehicleID(i),X,Y,Z);
				CreateExplosion(X,Y,Z,7,4.0);
				SetVehicleHealth(GetPlayerVehicleID(i),-1);
				SetPlayerHealth(i,0);
			}
			else
			{
				GetPlayerPos(i,X,Y,Z);
				CreateExplosion(X,Y,Z,7,4.0);
				SetPlayerHealth(i,0);
			}
		}
	}
	format(string,sizeof(string),"Administrator %s have Exploded everybody",AdminName(playerid));
	SendCommandMsg(playerid,"explodeall");
	return SendClientMessageToAll(YELLOW,string);
}

dcmd_giveme(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"giveme")) return CmdLevelError(playerid,"giveme");
    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,RED,"ERROR: you cannot do this command in a vehicle");
    ShowMenuForPlayer(VehicleMenu,playerid);
    TogglePlayerControllable(playerid,0);
    SendCommandMsg(playerid,"giveme");
	return 1;
}

dcmd_pimpcar(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"pimpcar")) return CmdLevelError(playerid,"pimpcar");
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,RED,"ERROR: You must in a vehicle to use this command");
	switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case 581,523,462,521,463,522,461,448,468,586,509,481,510,472,473,493,595,484,430,453,452,446,454,590,569,537,538,570,449:
		return SendClientMessage(playerid,RED,"ERROR: You can't add components to this vehicle!");
	}
	TogglePlayerControllable(playerid,0);
    ShowMenuForPlayer(PimpMenu,playerid);
    SendCommandMsg(playerid,"pimpcar");
	return 1;
}

dcmd_delveh(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"delveh")) return CmdLevelError(playerid,"delveh");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,RED,"ERROR: You must in a vehicle to use this command");
    new VID = GetPlayerVehicleID(playerid);
    RemovePlayerFromVehicle(playerid);
	DestroyVehicle(VID);
	SendClientMessage(playerid,YELLOW,"You have deleted your vehicle.");
	SendCommandMsg(playerid,"delveh");
	return 1;
}

dcmd_delallveh(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"delallveh")) return CmdLevelError(playerid,"delallveh");
    #pragma unused params
    new string[128];
	for(new v = 1; v <= MAX_VEHICLES; v++)
	{
 	    DestroyVehicle(v);
	}
	format(string,sizeof(string),"Administrator: %s have deleted ALL vehicles in the server.",AdminName(playerid));
	SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"dellallveh");
	return 1;
}

dcmd_hideme(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"hideme")) return CmdLevelError(playerid,"hideme");
	#pragma unused params
	playercolor[playerid] = GetPlayerColor(playerid);
	SetPlayerColor(playerid,0xFFFFFF00);
	SendCommandMsg(playerid,"hideme");
	SendClientMessage(playerid,YELLOW,"You are hidden nobody can see you now");
	return 1;
}

dcmd_showme(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"showme")) return CmdLevelError(playerid,"showme");
	#pragma unused params
	SetPlayerColor(playerid,playercolor[playerid]);
	SendClientMessage(playerid,YELLOW,"You are NOT hidden EVERYBODY can see you now");
	SendCommandMsg(playerid,"showme");
	return 1;
}

dcmd_kickall(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"kickall")) return CmdLevelError(playerid,"kickall");
    #pragma unused params
    new string[128];
    format(string,sizeof(string),"Administrator %s Have kicked everybody in the server",AdminName(playerid));
    SendClientMessageToAll(YELLOW,string);
    SendCommandMsg(playerid,"kickall");
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(!IsPlayerHAdmin(i)) Kick(i);
	return 1;
}

dcmd_muteall(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"muteall")) return CmdLevelError(playerid,"muteall");
    #pragma unused params
    new string[128];
    format(string,sizeof(string),"Administrator %s have unmuted everybody everybody can talk!",AdminName(playerid));
    SendCommandMsg(playerid,"muteall");
	return MuteAll=1;
}

dcmd_unmuteall(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"unmuteall")) return CmdLevelError(playerid,"unmuteall");
    #pragma unused params
    new string[128];
    format(string,sizeof(string),"Administrator %s have muted everybody nobody can talk!",AdminName(playerid));
    SendCommandMsg(playerid,"unmuteall");
	return MuteAll=0;
}

dcmd_rlh(playerid, params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"rlh")) return CmdLevelError(playerid,"rlh");
    SendClientMessage(playerid,GREEN,"The server restart the Hadmin Filterscript");
    SendCommandMsg(playerid,"rlh");
    SendRconCommand("reloadfs hadmin");
	return 1;
}

dcmd_gmx(playerid, params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"gmx")) return CmdLevelError(playerid,"gmx");
    new string[128];
    format(string,sizeof(string),"Administrator: %s Restart the GameMode",AdminName(playerid));
    SendClientMessageToAll(GREEN,string);
    SendCommandMsg(playerid,"gmx");
	SendRconCommand("gmx");
    return 1;
}

dcmd_lockpm(playerid, params[])
{
    #pragma unused params
	if(!CmdLevelCheck(playerid,"lockpm")) return CmdLevelError(playerid,"lockpm");
	new string[128]; LockPrivm=1;
	format(string,sizeof(string),"Administrator %s has locked the PM",AdminName(playerid));
	SendClientMessageToAll(RED,string);
	SendCommandMsg(playerid,"lockpm");
	return 1;
}

dcmd_unlockpm(playerid, params[])
{
    #pragma unused params
	if(!CmdLevelCheck(playerid,"unlockpm")) return CmdLevelError(playerid,"unlockpm");
	new string[128]; LockPrivm=0;
	format(string,sizeof(string),"Administrator %s has unlocked the PM",AdminName(playerid));
	SendClientMessageToAll(GREEN,string);
	SendCommandMsg(playerid,"unlockpm");
	return 1;
}

dcmd_lockchat(playerid, params[])
{
    #pragma unused params
	if(!CmdLevelCheck(playerid,"lockchat")) return CmdLevelError(playerid,"lockchat");
	new string[128];
	format(string,sizeof(string),"Administrator %s have locked the chat",AdminName(playerid));
	SendClientMessageToAll(RED,string);
	SendCommandMsg(playerid,"lockchat");
	LockChat=1;
	return 1;
}

dcmd_unlockchat(playerid, params[])
{
    #pragma unused params
	if(!CmdLevelCheck(playerid,"unlockchat")) return CmdLevelError(playerid,"unlockchat");
	new string[128];
	format(string,sizeof(string),"Administrator %s have unlocked the chat",AdminName(playerid));
	SendClientMessageToAll(GREEN,string);
	SendCommandMsg(playerid,"unlockchat");
	LockChat=0;
	return 1;
}

dcmd_closeserver(playerid, params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"closeserver")) return CmdLevelError(playerid,"closeserver");
    new string[128];
    format(string,sizeof(string),"Administrator: %s Closed the connection in:",AdminName(playerid));
    SendClientMessageToAll(ORANGE,string);
    SendRconCommand("exit");
	return SendCommandMsg(playerid,"closeserver");
}

dcmd_changehost(playerid, params[])
{
   	if(!CmdLevelCheck(playerid,"changehost")) return CmdLevelError(playerid,"changehost");
   	if(!strlen(params)) return SendClientMessage(playerid,RED,"USAGE: /changehost [hostname]");
   	new string[128];
	format(string, 86, "hostname %s", params);
	SendRconCommand(string);
   	format(string, 86, "Administrator %s have changed the servername to: %s", AdminName(playerid), params);
   	SendCommandMsg(playerid,"changehost");
	return SendClientMessageToAll(GREEN, string);
}

dcmd_adminmsg(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"adminmsg")) return CmdLevelError(playerid,"adminmsg");
    if(!strlen(params)) return SendClientMessage(playerid,RED,"USAGE: /ADMINMSG [TEXT/OFF]");
    new string[128];
    format(string,sizeof(string),"~g~Admin:~w~ %s",params);
    if(!strcmp(params, "OFF", true)) return TextDrawSetString(AdminText,"_");
    else
    TextDrawSetString(AdminText,string);
    SendCommandMsg(playerid,"adminmsg");
	return TextDrawShowForAll(AdminText);
}

dcmd_flip(playerid,params[])
{
	#pragma unused params
	//if(!CmdLevelCheck(playerid,"flip")) return CmdLevelError(playerid,"flip");
	if(!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,RED,"ERROR: You must be in a vehicle.");
	{
		new car, Float:a;
		car = GetPlayerVehicleID(playerid);
		GetVehicleZAngle(car,a);
		SetVehicleZAngle(car,a);
		SendClientMessage(playerid,YELLOW,"You have flipped your vehicle");
	}
	//SendCommandMsg(playerid,"flip");
	return 1;
}

dcmd_fix(playerid, params[])
{
	#pragma unused params
	//if(!CmdLevelCheck(playerid,"fix")) return CmdLevelError(playerid,"fix");
	if(!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,RED,"ERROR: You must be in a vehicle.");
	{
		new car;
		car = GetPlayerVehicleID(playerid);
		SetVehicleHealth(car,1000);
		SendClientMessage(playerid,YELLOW,"You have fixed your vehicle");
	}
	return 1;//SendCommandMsg(playerid,"fix");
}

dcmd_wmenu(playerid, params[])
{
    #pragma unused params
	if(!CmdLevelCheck(playerid,"wmenu")) return CmdLevelError(playerid,"wmenu");
	ShowMenuForPlayer(Menu:weaponmain,playerid);
	SendCommandMsg(playerid,"wmenu");
	return 1;
}

dcmd_gravity(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"gravity")) return CmdLevelError(playerid,"gravity");
    new Float:gravity,string[128];
    if(sscanf(params, "f", gravity)) return SendClientMessage(playerid, RED, "USAGE: /GRAVITY [50/-50]");
    if(floatstr(params)>50.0 || floatstr(params)<-50.0) return SendClientMessage(playerid,RED,"ERROR: enter a valid gravity: [50/-50]");
	format(string,sizeof(string),"Administrator %s have Set The Server Gravity to: %f",AdminName(playerid),gravity);
	SendCommandMsg(playerid,"gravity");
	SetGravity(gravity);
	SendClientMessageToAll(YELLOW,string);
	return 1;
}

dcmd_hlock(playerid,params[])
{
	#pragma unused params
	if(!CmdLevelCheck(playerid,"hlock")) return CmdLevelError(playerid,"hlock");
	new string[128];
	if(!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,RED,"ERROR: You must be in a vehicle.");
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(i != playerid) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,0,1);
	IsVehicleLocked[GetPlayerVehicleID(playerid)] = 1;
	format(string,sizeof(string),"Administrator: %s have locked his vehicle",AdminName(playerid));
	return SendClientMessageToAll(YELLOW,string);
}

dcmd_hunlock(playerid,params[])
{
	#pragma unused params
	if(!CmdLevelCheck(playerid,"hunlock")) return CmdLevelError(playerid,"hunlock");
	new string[128];
	if(!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,RED,"ERROR: You must be in a vehicle.");
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,0,0);
	IsVehicleLocked[GetPlayerVehicleID(playerid)] = 0;
	format(string,sizeof(string),"Administrator: %s have unlocked his vehicle",AdminName(playerid));
	return SendClientMessageToAll(YELLOW,string);
}

dcmd_maxping(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"maxping")) return CmdLevelError(playerid,"maxping");
	new maxping,string[128];
	if(sscanf(params, "s", maxping)) return SendClientMessage(playerid, RED, "USAGE: /MAXPING [+200/OFF]");
	if(!strcmp(params, "OFF", true)) return SetConfig("MaxPing",0);
    if(maxping < 200) return SendClientMessage(playerid,RED,"ERROR: enter a valid max ping: +200");
    format(string,sizeof(string),"Administrator: %s has set the max server ping to %d",AdminName(playerid),maxping);
    SetConfig("MaxPing",maxping); SendCommandMsg(playerid,"maxping");
	return 1;
}

dcmd_hspec(playerid,params[])
{
	new id,string[128];
	if(!CmdLevelCheck(playerid,"hspec")) return CmdLevelError(playerid,"hspec");
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /HSPEC [ID / NAME / OFF]");
	if(!strcmp(params, "OFF", true))
	{
	    if(Specting[playerid]==0) SendClientMessage(playerid,RED,"ERROR: you are not spectating");
	    TogglePlayerSpectating(playerid,0),Specting[playerid]=0;
	    SendClientMessage(playerid,YELLOW,"You stop Spectating now.");
		Specting[playerid]=0,SpecID[playerid]=INVALID_PLAYER_ID;
		SetTimerEx("LastSpecPos",2000,0,"i",playerid);
	}
	else
	{
	if(Specting[playerid]==1) return SendClientMessage(playerid,RED,"Error: you are already spectating use ""/hspec off"" to turn off.");
	if(!IsPlayerConnected(id) || id==playerid) return SendClientMessage(playerid, RED, "This player is offline or is yourself");
	if(!IsPlayerInAnyVehicle(playerid))
	{
		GetPlayerPos(playerid,HspecPos[playerid][0],HspecPos[playerid][1],HspecPos[playerid][2]);
		GetPlayerFacingAngle(playerid,HspecPos[playerid][3]);
		HspecPos[playerid][4]=0;
	}
	else if(GetPlayerState(playerid)==2)
	{
		GetVehiclePos(GetPlayerVehicleID(playerid),HspecPos[playerid][0],HspecPos[playerid][1],HspecPos[playerid][2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid),HspecPos[playerid][3]);
		HspecVeh[playerid]=GetPlayerVehicleID(playerid);
		HspecPos[playerid][4]=1;
	}
	Specting[playerid]=1,SpecID[playerid]=id;
	TogglePlayerSpectating(playerid,1);
	SetPlayerInterior(playerid,GetPlayerInterior(id));
	if(IsPlayerInAnyVehicle(id)) PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));
	else PlayerSpectatePlayer(playerid,id);
	if(IsAdminLevel(id,1)) format(string,sizeof(string),"You are spectating Admin: %s",Name(id));
	else format(string,sizeof(string),"You are spectating player: %s",Name(id));
	SendCommandMsg(playerid,"hspec");
	SendClientMessage(playerid,YELLOW,string);
	}
	return 1;
}

dcmd_veh(playerid,params[])
{
	new vid,string[128];
	if(!CmdLevelCheck(playerid,"veh")) return CmdLevelError(playerid,"veh");
 	if(!strlen(params)) return SendClientMessage(playerid,RED,"USAGE: /VEH [VEHICLE_NAME]");
    vid = GetVehicleID(params);
    if(vid==-1) if(vid<400||vid>611) return SendClientMessage(playerid, RED, "Error: Invalid VEHICLE_NAME");
	SendCommandMsg(playerid,"veh");
	CreateVehicleHere(playerid,vid);
	format(string,sizeof(string),"You have spawned a %s  ,use /delveh to delete the vehicle",aVehicleNames[vid-400]);
	SendClientMessage(playerid,YELLOW,string);
	return 1;
}


dcmd_giveallmoney(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"giveallmoney")) return CmdLevelError(playerid,"giveallmoney");
	new string[128],number;
	if(sscanf(params, "i", number)) return SendClientMessage(playerid, RED, "USAGE: /GIVEALLMONEY [0/1.000.000]");
	if(number < 0 || number > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
 	format(string,sizeof(string),"Administrator: %s Has Given everybody $%d.",AdminName(playerid),number);
 	for(new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i)) GivePlayerMoney(i,number);
 	SendClientMessageToAll(YELLOW,string); SendCommandMsg(playerid,"giveallmoney");
	return 1;
}

dcmd_setallmoney(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"setallmoney")) return CmdLevelError(playerid,"setallmoney");
	new string[128],number;
	if(sscanf(params, "i", number)) return SendClientMessage(playerid, RED, "USAGE: /SETALLMONEY [0/1.000.000]");
	if(number < 0 || number > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
 	format(string,sizeof(string),"Administrator: %s Has set everybody's money to $%d.",AdminName(playerid),number);
	SendCommandMsg(playerid,"setallmoney");SendClientMessageToAll(YELLOW,string);
	for(new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i)) SetPlayerMoney(i,number);
	return 1;
}

dcmd_getallmoney(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"getallmoney")) return CmdLevelError(playerid,"getallmoney");
	new string[128],number;
	if(sscanf(params, "i", number)) return SendClientMessage(playerid, RED, "USAGE: /GETALLMONEY [0/1.000.000]");
	if(number < 0 || number > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
 	format(string,sizeof(string),"Administrator: %s Has Get $%d from everybody away",AdminName(playerid),number);
	SendCommandMsg(playerid,"getallmoney");SendClientMessageToAll(YELLOW,string);
	for(new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i)) SetPlayerMoney(i,GetPlayerMoney(i)-number);
	return 1;
}

dcmd_setallscore(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"setallscore")) return CmdLevelError(playerid,"setallscore");
	new string[128],number;
	if(sscanf(params, "i", number)) return SendClientMessage(playerid, RED, "USAGE: /SETALLSCORE [1-100.000]");
	if(number < 0 || number > 100000) return SendClientMessage(playerid,RED,"ERROR: Invaild Score: [0/100.000]");
	format(string,sizeof(string),"Administrator: %s have Set everybody his Score to %d.",AdminName(playerid),number);
	for(new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i)) SetPlayerScore(i,number);
	SendCommandMsg(playerid,"setallscore");
	return 1;
}

dcmd_nameban(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"nameban")) return CmdLevelError(playerid,"nameban");
	new id, tmp[128],File:file,string[128];
	if(sscanf(params, "uz", id, tmp)) return SendClientMessage(playerid, RED, "USAGE: /NAMEBAN [ID / NAME] [REASON]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	format(string, sizeof(string), "Player: %s has been Name Banned by Administrator %s%s%s%s",Name(id), AdminName(playerid), (tmp[0]) ? (" [reason: ") : ("."), tmp[0], (tmp[0]) ? (" ]") : (""));
	SendClientMessageToAll(YELLOW, string), print(string), SaveToLog("namebans",string);
	format(string,sizeof(string),"%s=kick\r\n",tmp);
	file = fopen("Hadmin/config/ForBiddenNames.ini",io_append);
	fwrite(file,string);
	fclose(file);
	SendCommandMsg(playerid,"nameban");
	SetInfo(id,"Kicks",GetInfo(id,"Kicks")+1);
	format(string,sizeof(string),"Name Banned By Admin %s",AdminName(playerid));
	SpecialLeaveReason[id]=1,PlayerLeaveReason[id]=string;
	return Kick(id);
}

dcmd_setname(playerid,params[])
{
	if(!CmdLevelCheck(playerid,"setname")) return CmdLevelError(playerid,"setname");
	new id, name[24],string[128];
	if(sscanf(params, "us", id, name)) return SendClientMessage(playerid, RED, "USAGE: /SETNAME [ID / NAME] [NEW_NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(id!=playerid) {
	format(string, sizeof(string), "Administrator %s have changed %s his name to %s",AdminName(playerid),Name(id),name);
	SendClientMessageToAll(YELLOW, string); } else {
	format(string, sizeof(string), "You have set your own name to: %s",name);
	SendClientMessage(playerid,YELLOW, string);	}
	OnPlayerConnect(id);
	SendCommandMsg(playerid,"setname");
	return SetPlayerName(id,name);
}

dcmd_warn(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"warn")) return CmdLevelError(playerid,"warn");
    new id,warning[128],string[128];
    if(sscanf(params, "uz", id, warning)) return SendClientMessage(playerid, RED, "USAGE: /WARN [ID / NAME] [WARNING]");
	if(!IsPlayerConnected(id) || id==playerid) return SendClientMessage(playerid, RED, "This player is offline or is yourself");
	if(Info[id][Warnings]>=GetConfig("MaxWarnings"))
	{
		format(string,sizeof(string),"Player: %s is kicked from the server [reason: Max warnings]",Name(id));
		SendClientMessageToAll(YELLOW,string);
		SendClientMessage(id,LIGHTRED,"if you get a warning again you will kicked from the server");
		Info[id][Warnings]=0;
	}
	else if(Info[id][Warnings]==GetConfig("MaxWarnings")-1)
	{
		format(string,sizeof(string),"Administrator %s have given you Your last warning: %s",AdminName(playerid),warning);
		SendClientMessage(id,LIGHTRED,string);
		SendClientMessage(id,LIGHTRED,"if you get a warning again you will kicked from the server");
		format(string,sizeof(string),"You have given %s His last warning (%d,%d): %s",Name(id),Info[id][Warnings],GetConfig("MaxWarnings"),warning);
		SendClientMessage(playerid,YELLOW,string);
	}
	else
	{
		format(string,sizeof(string),"Administrator %s have given you a warning (%d,%d): %s",AdminName(playerid),Info[id][Warnings],GetConfig("MaxWarnings"),warning);
		SendClientMessage(id,LIGHTRED,string);
		Info[id][Warnings]++;
		format(string,sizeof(string),"You have given %s a warning (%d,%d): %s",Name(id),Info[id][Warnings],GetConfig("MaxWarnings"),warning);
		SendClientMessage(playerid,YELLOW,string);
	}
	SendCommandMsg(playerid,"warn");
	return 1;
}

dcmd_givehim(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"givehim")) return CmdLevelError(playerid,"givehim");
    new string[128],id;
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /GIVEHIM [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,RED,"ERROR: This player is already in a vehicle");
	format(string,sizeof(string),"Administrator %s have showed a vehicle menu to you",AdminName(playerid));
	SendClientMessage(id,YELLOW,string);
	format(string,sizeof(string),"You have showed the vehicle menu to: %s",Name(id));
	SendClientMessage(playerid,YELLOW,string);
    ShowMenuForPlayer(VehicleMenu,id);
    TogglePlayerControllable(id,0);
    SendCommandMsg(playerid,"givehim");
	return 1;
}

dcmd_giveallweapon(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"giveallweapon")) return CmdLevelError(playerid,"giveallweapon");
	new weapon[256],ammo,string[128];
	if(sscanf(params, "sd", weapon,ammo)) return SendClientMessage(playerid, RED, "USAGE: /GIVEALLWEAPON [WEAPON] [AMMO]");
	new weaponid = GetWeaponID(weapon); if (weaponid == -1) weaponid = strval(weapon);
	if (weaponid < 0 || weaponid > 47) return SendClientMessage(playerid, RED, "[ERROR]: enter a valid WeaponName/WeaponID.");
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) GivePlayerWeapon(i, weaponid, ammo);
	format(string, 256, "Administrator %s has given everybody a %s with ammo: %d",AdminName(playerid),WeaponNames[weaponid],ammo);
    SendCommandMsg(playerid,"giveallweapon"),SendClientMessageToAll(YELLOW,string);
	return 1;
}

dcmd_force(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"force")) return CmdLevelError(playerid,"force");
    new string[128],id;
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /FORCE [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	format(string,sizeof(string),"Administrator %s have forced you into the class selection",AdminName(playerid));
	SendClientMessage(id,YELLOW,string);
	format(string,sizeof(string),"You have forced %s into the class selection",Name(id));
	SendClientMessage(playerid,YELLOW,string);
    ForceClassSelection(id),SetPlayerHealth(id,0);
    SendCommandMsg(playerid,"force");
	return 1;
}

dcmd_resetallscore(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"resetallscore")) return CmdLevelError(playerid,"resetallscore");
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerScore(i,0);
	format(string,sizeof(string),"Administrator: %s Have reseted All scores",AdminName(playerid));
	SendCommandMsg(playerid,"resetallscore");
	SendClientMessageToAll(YELLOW,string);
	return 1;
}

dcmd_trust(playerid,params[])
{
	new id,trust[128],string[128];
	if(!CmdLevelCheck(playerid,"trust")) return CmdLevelError(playerid,"trust");
	if(sscanf(params, "us", id,trust)) return SendClientMessage(playerid, RED, "USAGE: /TRUST [ID / NICK] [NO / NORMAL / YES]");
	if(!strcmp(trust, "NO", true))
	{
	    format(string,sizeof(string),"Administrator %s don't trust %s",AdminName(playerid),Name(id));
	    SendMessageToAdmins(RED,string);
	    SetInfo(id,"Trust",0);
	}
	else if(!strcmp(trust, "NORMAL", true))
	{
	    format(string,sizeof(string),"Administrator %s normal trust %s",AdminName(playerid),Name(id));
	    SendMessageToAdmins(ORANGE,string);
	    SetInfo(id,"Trust",1);
	}
	else if(!strcmp(trust, "YES", true))
	{
	    format(string,sizeof(string),"Administrator %s trust %s",AdminName(playerid),Name(id));
	    SendMessageToAdmins(GREEN,string);
	    SetInfo(id,"Trust",2);
	}
	else return SendClientMessage(playerid,RED,"Error: enter only  NO / NORMAL / YES");
	SendCommandMsg(playerid,"trust");
	return 1;
}

dcmd_setwanted(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setwanted")) return CmdLevelError(playerid,"setwanted");
	new id,wanted,string[128];
    if(sscanf(params, "ud", id,wanted)) return SendClientMessage(playerid, RED, "USAGE: /SETWANTED [ID / NICK] [1/6]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(wanted < 0 || wanted > 6) return SendClientMessage(playerid,RED,"Error: Enter a valid wanted level: 1/6");
    format(string,sizeof(string),"Administrator: %s has Set %s his Wanted Level to: %d!",AdminName(playerid),Name(id),wanted);
    SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"setwanted");
	SetPlayerWantedLevel(id,wanted);
	return 1;
}

dcmd_setallwanted(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setallwanted")) return CmdLevelError(playerid,"setwallwanted");
	new wanted,string[128];
    if(sscanf(params, "d", wanted)) return SendClientMessage(playerid, RED, "USAGE: /SETALLWANTED [1/6]");
	if(wanted < 0 || wanted > 6) return SendClientMessage(playerid,RED,"Error: Enter a valid wanted level: 1/6");
    format(string,sizeof(string),"Administrator: %s has Set everybody his Wanted Level to: %d!",AdminName(playerid),wanted);
    SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"setwanted");
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerWantedLevel(i,wanted);
	return 1;
}

dcmd_setpass(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setpass")) return CmdLevelError(playerid,"setpass");
    new id,newpass[25],string[128];
    if(sscanf(params, "us", id, newpass)) return SendClientMessage(playerid, YELLOW, "USAGE: /SETPASS [ID / NICK] [NEWPASS]");
    if((strlen(newpass) < 6 || strlen(newpass) > 25)) return SendClientMessage(playerid,RED,"Password must be 6+ and -25");
    SetInfo(id,"Password",udb_hash(newpass));
    format(string,sizeof(string),"You has changed Player %s his account password to: %s",Name(id),newpass);
    SendClientMessage(playerid,GREEN,string);
    format(string,sizeof(string),"Administrator %s has changed your account password to: %s",AdminName(playerid),newpass);
    SendClientMessage(id,GREEN,string);
    printf("Administrator: %s have changed %s his password to %s",Name(playerid),Name(id),newpass);
    SendCommandMsg(playerid,"setpass");
	return 1;
}

dcmd_settime(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"settime")) return CmdLevelError(playerid,"settime");
	new id,hour,mins,string[128];
    if(sscanf(params, "udd", id, hour, mins)) return SendClientMessage(playerid, YELLOW, "USAGE: /SETTIME [ID / NICK] [0/12] [0/59]");
    if(hour < 0 || hour > 24) return SendClientMessage(playerid,RED,"Hour must be [0/12]");
    if(mins < 0 || mins > 59) return SendClientMessage(playerid,RED,"Minute must be [0/59]");
    format(string,sizeof(string),"Administrator %s have set your time to %d:%d",AdminName(playerid),hour,mins);
    SendClientMessage(id,YELLOW,string);
    format(string,sizeof(string),"You have set %s his time to %d:%d",Name(id),hour,mins);
    SendClientMessage(playerid,YELLOW,string);
    SendCommandMsg(playerid,"settime");
	return SetPlayerTime(id,hour,mins);
}

dcmd_setalltime(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setalltime")) return CmdLevelError(playerid,"setalltime");
	new hour,mins,string[128];
    if(sscanf(params, "dd", hour, mins)) return SendClientMessage(playerid, YELLOW, "USAGE: /SETALLTIME [0/12] [0/59]");
    if(hour < 0 || hour > 24) return SendClientMessage(playerid,RED,"Hour must be [0/12]");
    if(mins < 0 || mins > 59) return SendClientMessage(playerid,RED,"Minute must be [0/59]");
    format(string,sizeof(string),"Administrator %s have set everybody his time to %d:%d",AdminName(playerid),hour,mins);
    SendClientMessageToAll(YELLOW,string);
    SendCommandMsg(playerid,"setalltime");
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,hour,mins);
	return 1;
}

dcmd_morning(playerid,params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"morning")) return CmdLevelError(playerid,"morning");
	SetPlayerTime(playerid,7,0);
	SendCommandMsg(playerid,"morning");
	return SendClientMessage(playerid,YELLOW,"The world time has been changed to 7:00.");
}
dcmd_afternoon(playerid,params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"afternoon")) return CmdLevelError(playerid,"afternoon");
	SetPlayerTime(playerid,12,0);
	SendCommandMsg(playerid,"afternoon");
	return SendClientMessage(playerid,YELLOW,"The world time has been changed to 12:00.");
}
dcmd_night(playerid,params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"night")) return CmdLevelError(playerid,"night");
	SetPlayerTime(playerid,18,0);
	SendCommandMsg(playerid,"night");
	return SendClientMessage(playerid,YELLOW,"The world time has been changed to 18:00.");
}
dcmd_midnight(playerid,params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"midnight")) return CmdLevelError(playerid,"midnight");
    SendCommandMsg(playerid,"midnight");
	SetPlayerTime(playerid,0,0);
	return SendClientMessage(playerid,YELLOW,"The world time has been changed to 0:00.");
}

dcmd_jetpack(playerid,params[])
{
	if(!CmdLevelCheck(playerid,"jetpack")) return CmdLevelError(playerid,"jetpack");
	new id,string[128];
	if(!strlen(params))
	{
	    SetPlayerSpecialAction(playerid, 2);
		return SendClientMessage(playerid,YELLOW,"You has given yourself a jetpack");
	}
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /JETPACK [ID / NICK]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
    format(string,sizeof(string),"Administrator %s have given you a jetpack",AdminName(playerid));
	SendClientMessage(id,YELLOW,string);
	format(string,sizeof(string),"You have given player %s a jetpack",Name(id));
	SendClientMessage(playerid,YELLOW,string);
    SetPlayerSpecialAction(id, 2);
	return SendCommandMsg(playerid,"jetpack");
}

dcmd_countdown(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"countdown")) return CmdLevelError(playerid,"countdown");
    new time;
    if(sscanf(params, "d", time)) return SendClientMessage(playerid, RED, "USAGE: /COUNTDOWN [5/60]");
    if(time < 5 || time > 60) return SendClientMessage(playerid,RED,"Error: enter a valid time [5/60]");
    SendCommandMsg(playerid,"countdown");
    CountTimer = SetTimer("CountDown",1000,1);
    Counts=time+1;
	return 1;
}


forward CountDown(time);
public CountDown(time)
{
	new string[128];
	Counts--;
	format(string,sizeof(string),"~r~%d",Counts);
	GameTextForAll(string,1000,3);
	if(Counts <= 0)
	{
	    GameTextForAll("~w~[][][] ~g~GO ~w~[][][]",1000,3);
	    KillTimer(CountTimer);
	}
}

dcmd_hideclock(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"hideclock")) return CmdLevelError(playerid,"hideclock");
	#pragma unused params
    ToggleHClockForPlayer(playerid,0);
    SendClientMessage(playerid,YELLOW,"You have hide your clock");
	return SendCommandMsg(playerid,"hideclock");
}

dcmd_showclock(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"showclock")) return CmdLevelError(playerid,"showclock");
	#pragma unused params
    ToggleHClockForPlayer(playerid,1);
    SendClientMessage(playerid,YELLOW,"You have showed your clock");
	return SendCommandMsg(playerid,"showclock");
}

dcmd_sendplayertext(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"sendplayertext")) return CmdLevelError(playerid,"sendplayertext");
    new id,text[128];
    if(sscanf(params, "us", id, text)) return SendClientMessage(playerid, RED, "USAGE: /SENDPLAYERTEXT [ID / NICK] [TEXT]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
    SendCommandMsg(playerid,"sendplayertext");
    SendPlayerMessageToAll(id,text);
	return 1;
}

dcmd_setskin(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"setskin")) return CmdLevelError(playerid,"setskin");
	new id,skinid,string[128];
	if(sscanf(params, "ud", id, skinid)) return SendClientMessage(playerid, RED, "USAGE: /SETSKIN [ID / NICK] [SKINID]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
    if(IsSkinWrong(skinid)) return SendClientMessage(playerid,RED,"Error: enter a valid skin-ID");
    SendCommandMsg(playerid,"setskin");
    if(playerid != id) format(string,sizeof(string),"Administrator: %s have set your skin to %d",AdminName(playerid),skinid);
    else format(string,sizeof(string),"You have set your own skin to %d",skinid);
    SendClientMessage(id,YELLOW,string);
    format(string,sizeof(string),"You have set %s his skin to %d",Name(id),skinid);
    SendClientMessage(playerid,YELLOW,string);
    return SetPlayerSkin(id,skinid);
}

dcmd_setallskin(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"setallskin")) return CmdLevelError(playerid,"setallskin");
	new skinid,string[128];
	if(sscanf(params, "d", skinid)) return SendClientMessage(playerid, RED, "USAGE: /SETALLSKIN [SKINID]");
    if(IsSkinWrong(skinid)) return SendClientMessage(playerid,RED,"Error: enter a valid skin-ID");
    SendCommandMsg(playerid,"setskin");
    format(string,sizeof(string),"Administrator: %s Have set everybody his skin to %d",AdminName(playerid),skinid);
    SendClientMessageToAll(YELLOW,string);
    for(new i = 0; i < MAX_PLAYERS; i++) SetPlayerSkin(i,skinid);
    return 1;
}

dcmd_stats(playerid, params[])
{
	#pragma unused params
	new string[128];
	format(string,sizeof(string),"[Kills: %d] [deaths: %d] [Joins: %d] [Commands typed: %d] [score: %d] [Money: %d] [Kicks: %d] [Bank: $%d]",GetInfo(playerid,"kills"),
	GetInfo(playerid,"deaths"),GetInfo(playerid,"servertimes"),GetInfo(playerid,"Cmds"),GetPlayerScore(playerid),GetPlayerMoney(playerid),
	GetInfo(playerid,"Kicks"),GetInfo(playerid,"Bank"));
	SendClientMessage(playerid,YELLOW,string);
	return 1;
}

dcmd_getstats(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"getstats")) return CmdLevelError(playerid,"getstats");
	#pragma unused params
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /GETSTATS [ID / NICK]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	new string[128];
	format(string,sizeof(string),"[Kills: %d] [deaths: %d] [Joins: %d] [Commands typed: %d] [score: %d] [Money: %d] [Kicks: %d] [Bank: $%d]",GetInfo(id,"kills"),
	GetInfo(id,"deaths"),GetInfo(id,"servertimes"),GetInfo(id,"Cmds"),GetPlayerScore(id),GetPlayerMoney(id),GetInfo(id,"Kicks"),GetInfo(id,"Bank"));
	SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"getstats");
	return 1;
}

dcmd_respawnallveh(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"respawnallveh")) return CmdLevelError(playerid,"respawnallveh");
    #pragma unused params
    new string[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		for(new v = 0; v < MAX_VEHICLES; v++)
		{
	 	    if(!IsPlayerInVehicle(i,v)) SetVehicleToRespawn(v);
		}
	}
	format(string,sizeof(string),"Administrator: %s have Respawned all Empty vehicles in the server.",AdminName(playerid));
	SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"respawnallveh");
	return 1;
}

dcmd_addword(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"addword")) return CmdLevelError(playerid,"addword");
	new word[128],string[128],File:file;
	if(sscanf(params, "s", word)) return SendClientMessage(playerid, RED, "USAGE: /ADDWORD [WORD]");
	SendCommandMsg(playerid,"addword");
	format(string,sizeof(string),"Administrator %s has add a new Bad word: %s",AdminName(playerid),word);
	SendClientMessageToAll(YELLOW,string),print(string);
	format(string,sizeof(string),"%s\r\n",word);
	file = fopen("Hadmin/config/BadWords.ini",io_append);
	fwrite(file,string);
	fclose(file);
	new	str[100],File:file2;
	if((file2 = fopen("/Hadmin/config/BadWords.ini",io_read)))
	{
		while(fread(file2,str))
		{
		    for(new w = 0, b = strlen(str); w < b; w++) if(str[w] == '\n' || str[w] == '\r') str[w] = '\0';
            BadWords[BadWordSize] = str;
            BadWordSize++;
		}
		fclose(file);
	}
	return 1;
}

dcmd_addname(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"addname")) return CmdLevelError(playerid,"addname");
	new name,string[128],File:file;
	if(sscanf(params, "s", name)) return SendClientMessage(playerid, RED, "USAGE: /ADDNAME [NAME]");
	format(string,sizeof(string),"Administrator %s has add a new Forbidden Name: %s",AdminName(playerid),name);
	SendClientMessageToAll(YELLOW,string);
	format(string,sizeof(string),"%s=kick\r\n",name);
	file = fopen("Hadmin/config/ForBiddenNames.ini",io_append);
	fwrite(file,string);
	fclose(file);
	SendCommandMsg(playerid,"addname");
	return 1;
}

dcmd_resetweapons(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"resetweapons")) return CmdLevelError(playerid,"resetweapons");
    new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /RESETWEAPONS [ID / NICK]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
    if(id==playerid) SendClientMessage(playerid,YELLOW,"You have reset your own weapons"); else {
	format(string,sizeof(string),"Administrator: %s Has reset your weapons!",AdminName(playerid));
	SendClientMessage(id,YELLOW,string); }
	ResetPlayerWeapons(id);
	return SendCommandMsg(playerid,"resetweapons");
}

dcmd_resetallweapons(playerid, params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"resetallweapons")) return CmdLevelError(playerid,"resetallweapons");
    new string[128];
	format(string,sizeof(string),"Administrator: %s Has reset everybody his weapons!",AdminName(playerid));
	SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"resetallweapons");
	for(new i=0; i<MAX_PLAYERS; i++ ) if(IsPlayerConnected(i)) ResetPlayerWeapons(i);
	return 1;
}

dcmd_setweather(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setweather")) return CmdLevelError(playerid,"setweather");
    new id,weather,string[128];
    if(sscanf(params, "ud", id,weather)) return SendClientMessage(playerid, RED, "USAGE: /SETWEATHER [NICK / ID] [WEATHERID]");
    format(string,sizeof(string),"Administrator %s have set your weather to %d",AdminName(playerid),weather);
    SendClientMessage(id,YELLOW,string);
    format(string,sizeof(string),"You have set %s his weather to %d",Name(id),weather);
    SendClientMessage(playerid,YELLOW,string);
    SetPlayerWeather(id,weather);
	return 1;
}

dcmd_setallweather(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"setallweather")) return CmdLevelError(playerid,"setallweather");
    new weather,string[128];
    if(sscanf(params, "d", weather)) return SendClientMessage(playerid, RED, "USAGE: /SETALLWEATHER [WEATHERID]");
    format(string,sizeof(string),"Administrator %s have set everybody his weather to %d",AdminName(playerid),weather);
    SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"setallweather");
	for(new i=0; i<MAX_PLAYERS; i++ ) if(IsPlayerConnected(i)) SetPlayerWeather(i,weather);
	return 1;
}

dcmd_ignore(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"ignore")) return CmdLevelError(playerid,"ignore");
    new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /IGNORE [ID / NICK]");
    if(!IsPlayerConnected(id) || playerid == id) return SendClientMessage(playerid, RED, "This player is offline or is yourself");
    if(Ignore[playerid][id]==1) return SendClientMessage(playerid,RED,"You already ignore this player");
    format(string,sizeof(string),"Administrator %s has ignored you",AdminName(playerid));
    SendClientMessage(id,YELLOW,string);
    format(string,sizeof(string),"You are ignore Player: %s",Name(id));
    SendClientMessage(id,YELLOW,string);
    Ignore[playerid][id]=1;
    SendCommandMsg(playerid,"ignore");
	return 1;
}

dcmd_unignore(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"unignore")) return CmdLevelError(playerid,"unignore");
    new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /UNIGNORE [ID / NICK]");
    if(!IsPlayerConnected(id) || playerid == id) return SendClientMessage(playerid, RED, "This player is offline or is yourself");
    if(Ignore[playerid][id]==0) return SendClientMessage(playerid,RED,"You don't ignore this player");
    format(string,sizeof(string),"Administrator %s has stop ignoring you",AdminName(playerid));
    SendClientMessage(id,YELLOW,string);
    format(string,sizeof(string),"You stop ignoring player: %s",Name(id));
    SendClientMessage(id,YELLOW,string);
    Ignore[playerid][id]=0;
    SendCommandMsg(playerid,"ignore");
	return 1;
}

dcmd_hideall(playerid, params[])
{
	#pragma unused params
	if(!CmdLevelCheck(playerid,"hideall")) return CmdLevelError(playerid,"hideall");
	new string[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        playercolor[i] = GetPlayerColor(i);
		SetPlayerMarkerForPlayer( i, i, 0xFFFFFF00);
    }
    format(string,sizeof(string),"Administrator %s has hide everybody from the radar",AdminName(playerid));
    SendClientMessageToAll(YELLOW,string);
    return SendCommandMsg(playerid,"hideall");
}

dcmd_showall(playerid, params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"showall")) return CmdLevelError(playerid,"showall");
	new string[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
		SetPlayerMarkerForPlayer( i, i, playercolor[i]);
    }
    format(string,sizeof(string),"Administrator %s has showed everybody on the radar",AdminName(playerid));
    SendClientMessageToAll(YELLOW,string);
    return SendCommandMsg(playerid,"showall");
}

dcmd_diepos(playerid, params[])
{
	#pragma unused params
	if(!CmdLevelCheck(playerid,"diepos")) return CmdLevelError(playerid,"diepos");
	if(DiePos[playerid][0]==0 && DiePos[playerid][1]==0 && DiePos[playerid][2]==0 && DiePos[playerid][3]==0) return SendClientMessage(playerid,RED,"You never been died");
	if(!IsPlayerInAnyVehicle(playerid))
	{
		SetPlayerPos(playerid,DiePos[playerid][0],DiePos[playerid][1],DiePos[playerid][2]);
		SetPlayerFacingAngle(playerid,DiePos[playerid][3]);
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		SetVehiclePos(GetPlayerVehicleID(playerid),DiePos[playerid][0],DiePos[playerid][1],DiePos[playerid][2]);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),DiePos[playerid][3]);
	}
	SendClientMessage(playerid,YELLOW,"You stay on your last die pos");
	SendCommandMsg(playerid,"diepos");
	return 1;
}

dcmd_spos(playerid, params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"spos")) return CmdLevelError(playerid,"spos");
    SendClientMessage(playerid,YELLOW,"You have saved your pos here use /loadpos to save");
	GetPlayerPos(playerid,SavedPos[playerid][0],SavedPos[playerid][1],SavedPos[playerid][2]);
	GetPlayerFacingAngle(playerid,SavedPos[playerid][3]);
    SavedPos2[playerid][0] = GetPlayerInterior(playerid);
    SavedPos2[playerid][1] = GetPlayerVirtualWorld(playerid);
    SendCommandMsg(playerid,"spos");
	return 1;
}

dcmd_lpos(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"lpos")) return CmdLevelError(playerid,"lpos");
    if(SavedPos[playerid][0]==0 &&  SavedPos[playerid][1]==0 && SavedPos[playerid][2]==0 && SavedPos[playerid][3]==0)
    return SendClientMessage(playerid,RED,"You don't have saved a pos");
    if(!IsPlayerInAnyVehicle(playerid))
    {
        SetPlayerInterior(playerid,SavedPos2[playerid][0]);
		SetPlayerPos(playerid,SavedPos[playerid][0],SavedPos[playerid][1],SavedPos[playerid][2]);
		SetPlayerFacingAngle(playerid,SavedPos[playerid][3]);
	    SetPlayerVirtualWorld(playerid,SavedPos2[playerid][1]);
    }
    else if(IsPlayerInAnyVehicle(playerid))
    {
        SetPlayerInterior(playerid,SavedPos2[playerid][0]);
        LinkVehicleToInterior(GetPlayerVehicleID(playerid),SavedPos2[playerid][0]);
		SetVehiclePos(GetPlayerVehicleID(playerid),SavedPos[playerid][0],SavedPos[playerid][1],SavedPos[playerid][2]);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),SavedPos[playerid][3]);
	    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),SavedPos2[playerid][1]);
    }
    SendCommandMsg(playerid,"lpos");
    SendClientMessage(playerid,YELLOW,"You have teleport to your last saved pos");
	return 1;
}

dcmd_setworld(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setworld")) return CmdLevelError(playerid,"setworld");
    new id,worldid,string[128];
    if(sscanf(params, "ud", id, worldid)) return SendClientMessage(playerid, RED, "USAGE: /SETWORLD [ID / NICK] [WORLD_ID]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
    SetPlayerVirtualWorld(id,worldid); if(id != playerid) {
	format(string,sizeof(string),"Administrator %s have set your virtual world to %d",AdminName(playerid),worldid);
	SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You have set %s his virtual world to %d",Name(id),worldid);
	SendClientMessage(playerid,YELLOW,string); }
	else if(id == playerid) {
	format(string,sizeof(string),"You have set your own virtual world to %d",worldid);
	SendClientMessage(playerid,YELLOW,string); }
	SendCommandMsg(playerid,"setworld");
	return 1;
}

dcmd_setinterior(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setinterior")) return CmdLevelError(playerid,"setinterior");
    new id,intid,string[128];
    if(sscanf(params, "ud", id, intid)) return SendClientMessage(playerid, RED, "USAGE: /SETINTERIOR [ID / NICK] [INTERIOR_ID]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
    if(intid < 0 || intid > 18) return SendClientMessage(playerid,RED,"Error: enter a valid interior id  [0/18]");
    SetPlayerInterior(id,intid); if(id != playerid) {
	format(string,sizeof(string),"Administrator %s have set your interior ID to %d",AdminName(playerid),intid);
	SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You have set %s his interior ID to %d",Name(id),intid);
	SendClientMessage(playerid,YELLOW,string); }
	else if(id == playerid) {
	format(string,sizeof(string),"You have set your own interior ID to %d",intid);
	SendClientMessage(playerid,YELLOW,string); }
	SendCommandMsg(playerid,"setinterior");
	return 1;
}

dcmd_serverpass(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"serverpass")) return CmdLevelError(playerid,"serverpass");
    new oldpass[256],newpass[256],string[128];
    if(sscanf(params, "ss", oldpass, newpass)) return SendClientMessage(playerid, YELLOW, "USAGE: /SERVERPASS [OLD_PASS] [NEW_PASS]");
    if(strcmp(oldpass, dini_Get("/Hadmin/config/configuration.ini","ServerPass")) != 0)	return SendClientMessage(playerid, RED, "Error: Incorrect server password");
    SetSConfig("ServerPass",newpass);
	format(string,sizeof(string),"You have changed The server password from: %s to %s",oldpass,newpass);
	SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"serverpass");
	return 1;
}

dcmd_setallworld(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setallworld")) return CmdLevelError(playerid,"setallworld");
    new worldid,string[128];
    if(sscanf(params, "d", worldid)) return SendClientMessage(playerid, RED, "USAGE: /SETALLWORLD [WORLD_ID]");
    format(string,sizeof(string),"Administrator %s have set everybody his virtual world to %d",AdminName(playerid),worldid);
	SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"setallworld");
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerVirtualWorld(i,worldid);
	return 1;
}

dcmd_setallinterior(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setallinterior")) return CmdLevelError(playerid,"setallinterior");
    new intid,string[128];
    if(sscanf(params, "d", intid)) return SendClientMessage(playerid, RED, "USAGE: /SETALLWORLD [WORLD_ID]");
    format(string,sizeof(string),"Administrator %s have set everybody his interior ID to %d",AdminName(playerid),intid);
	SendClientMessageToAll(YELLOW,string);
	SendCommandMsg(playerid,"setallinterior");
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerInterior(i,intid);
	return 1;
}

dcmd_resetstats(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"resetstats")) return CmdLevelError(playerid,"resetstats");
    new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /RESETSTATS [NICK / ID]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(id != playerid) {
	format(string,sizeof(string),"Administrator %s have reset your stats",AdminName(playerid));
	SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You have reset %s his stats",Name(id));
	SendClientMessage(playerid,YELLOW,string); }
	else if(id == playerid) SendClientMessage(playerid,YELLOW,"You has reset your own stats");
	SetInfo(id,"kills",0);	SetInfo(id,"deaths",0);	SetInfo(id,"servertimes",0);
	SetInfo(id,"Cmds",0);	SetInfo(id,"score",0);	SetInfo(id,"money",0);
	SetInfo(id,"Kicks",0);
	SendCommandMsg(playerid,"resetstats");
	return 1;
}

dcmd_setstats(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"setstats")) return CmdLevelError(playerid,"setstats");
    new id,stat[128],to[128],string[128],what[128];
    if(sscanf(params, "uss", id,stat,to)) return SendClientMessage(playerid, RED, "USAGE: /SETSTATS [NICK / ID] [STAT] [TO]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
    if(!strcmp(stat, "servertimes", true)) what = "servertimes";
    else if(!strcmp(stat, "kills", true)) what = "kills";
    else if(!strcmp(stat, "Cmds", true)) what = "Cmds";
    else if(!strcmp(stat, "Kicks", true)) what = "Kicks";
    else if(!strcmp(stat, "deaths", true)) what = "deaths";
    else if(!strcmp(stat, "score", true)) what = "score";
    else if(!strcmp(stat, "money", true)) what = "money";
    else return SendClientMessage(playerid,RED,"Error: enter a valid stat");
	format(string,sizeof(string),"You have set %s his %s to %s",Name(id),what,to);
    SendClientMessage(playerid,YELLOW,string);
    SetSInfo(id,what,to);
    SendCommandMsg(playerid,"setstats");
    return 1;
}

dcmd_discaps(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"discaps")) return CmdLevelError(playerid,"discaps");
	new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /DISCAPS [ID / NICK]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(NoCaps[playerid]==1) return SendClientMessage(playerid,RED,"Error: this player has already no caps"); if(id!=playerid) {
	format(string,sizeof(string),"Administrator %s has set your Text on NO CAPS",AdminName(playerid));
	SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You have set %s his text on NO CAPS"); }
	else SendClientMessage(playerid,YELLOW,"You have set your own text mode on NO CAPS");
	NoCaps[id]=1;
	SendCommandMsg(playerid,"discaps");
	return 1;
}

dcmd_encaps(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"encaps")) return CmdLevelError(playerid,"encaps");
	new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /ENCAPS [ID / NICK]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(NoCaps[playerid]==0) return SendClientMessage(playerid,RED,"Error: this player has already normal text"); if(id!=playerid) {
	format(string,sizeof(string),"Administrator %s has set your Text on normal",AdminName(playerid));
	SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You have set %s his text on normal"); }
	else SendClientMessage(playerid,YELLOW,"You have set your own text mode on normal");
	NoCaps[id]=1;
	SendCommandMsg(playerid,"encaps");
	return 1;
}

dcmd_hinfo(playerid, params[])
{
	#pragma unused params
	SendClientMessage(playerid,GREEN,"_________________________________________________");
	SendClientMessage(playerid,LIGHTGREEN,"          Administration System           ");
	SendClientMessage(playerid,LIGHTGREEN,"                version: 2.0           ");
	SendClientMessage(playerid,GREEN,"¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯");
	return 1;
}

dcmd_serverinfo(playerid, params[])
{
	#pragma unused params
	new string[128], str[64],PlayerCount=0,Admins=0,Jails=0,Frozens=0,Mutes=0,Vehicles=0,PlayerVehicles=0,EmtyVehicles=0;
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			PlayerCount++;
			if(IsPlayerInAnyVehicle(i)) PlayerVehicles++;
			if(GetInfo(i,"AdminLevel") >1 && Info[i][logged]==1 || IsPlayerAdmin(i)) Admins++;
			if(Info[i][Jailed]==1) Jails++;
			if(Info[i][Frozen]==1) Frozens++;
			if(Info[i][Muted]==1) Mutes++;
		}
	}
	for(new i=0; i<MAX_VEHICLES; i++)
	{
	    if(GetVehicleModel(i) > 0) Vehicles++;
	}
	GetServerVarAsString("hostname", str, sizeof(str));
	format(string,sizeof(string),"   Server Infomation from the server: %s",str);
	SendClientMessage(playerid,LIGHTGREEN,string);
	format(string,sizeof(string),"   [Max Players: %d]  [Players Connected: %d]",GetMaxPlayers(),PlayerCount);
	SendClientMessage(playerid,LIGHTGREEN,string);
	format(string,sizeof(string),"   [Players Frozen: %d]  [Players Jailed %d]  [Players Muted: %d]  [Admins OnLine %d]",Frozens,Mutes,Jails,Admins);
	SendClientMessage(playerid,LIGHTGREEN,string);
	format(string,sizeof(string),"   [Total Connects: %d]  [Chats %d]  [Commands Typed: %d]",GetConfig("Connects"),GetConfig("Chats"),GetConfig("Cmds"));
	SendClientMessage(playerid,LIGHTGREEN,string);
	format(string,sizeof(string),"   [Total Vehicles: %d] [Players In Vehicle: %d] [Emty Vehicles: %d]",Vehicles,PlayerVehicles,EmtyVehicles);
	return 1;
}

dcmd_password(playerid, params[])
{
	if(ServerLock==0) return 0;
	new pass[128];
	if(sscanf(params, "s", pass)) return SendClientMessage(playerid, YELLOW, "USAGE: /PASSWORD [SERVER_PASSWORD]");
	if(strcmp(pass, dini_Get("/Hadmin/config/configuration.ini","ServerPass")) != 0) return SendClientMessage(playerid, RED, "Error: Incorrect server password");
    GoodLockPass[playerid]=1,KillTimer(LockTimer[playerid]);
	SendClientMessage(playerid,GREEN,"You entered the good server password, you can join now");
	SendClientMessage(playerid,GREEN,"Welcome");
	return 1;
}

dcmd_write(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"write")) return CmdLevelError(playerid,"write");
	new color[128],text[128];
	if(sscanf(params, "sz", color, text)) return SendClientMessage(playerid, RED, "USAGE: /WRITE [COLOR] [TEXT]");
	format(text,sizeof(text),"%s: %s",AdminName(playerid),text);
	if(!strcmp(color, "GREY", true)) SendClientMessageToAll(GREY,text);
	else if(!strcmp(color, "YELLOW", true)) SendClientMessageToAll(YELLOW,text);
	else if(!strcmp(color, "PINK", true)) SendClientMessageToAll(PINK,text);
	else if(!strcmp(color, "BLUE", true)) SendClientMessageToAll(BLUE,text);
	else if(!strcmp(color, "WHITE", true)) SendClientMessageToAll(WHITE,text);
	else if(!strcmp(color, "LIGHTBLUE", true)) SendClientMessageToAll(LIGHTBLUE,text);
	else if(!strcmp(color, "DARKRED", true)) SendClientMessageToAll(DARKRED,text);
	else if(!strcmp(color, "ORANGE", true)) SendClientMessageToAll(ORANGE,text);
	else if(!strcmp(color, "BRIGHTRED", true)) SendClientMessageToAll(BRIGHTRED,text);
	else if(!strcmp(color, "INDIGO", true)) SendClientMessageToAll(INDIGO,text);
	else if(!strcmp(color, "VIOLET", true)) SendClientMessageToAll(VIOLET,text);
	else if(!strcmp(color, "LIGHTRED", true)) SendClientMessageToAll(LIGHTRED,text);
	else if(!strcmp(color, "SEAGREEN", true)) SendClientMessageToAll(SEAGREEN,text);
	else if(!strcmp(color, "GRAYWHITE", true)) SendClientMessageToAll(GRAYWHITE,text);
	else if(!strcmp(color, "LIGHTNEUTRALBLUE", true)) SendClientMessageToAll(LIGHTNEUTRALBLUE,text);
	else if(!strcmp(color, "GREENISHGOLD", true)) SendClientMessageToAll(GREENISHGOLD,text);
	else if(!strcmp(color, "LIGHTBLUEGREEN", true)) SendClientMessageToAll(LIGHTBLUEGREEN,text);
	else if(!strcmp(color, "NEUTRALBLUE", true)) SendClientMessageToAll(NEUTRALBLUE,text);
	else if(!strcmp(color, "LIGHTCYAN", true)) SendClientMessageToAll(LIGHTCYAN,text);
	else if(!strcmp(color, "LEMON", true)) SendClientMessageToAll(LEMON,text);
	else if(!strcmp(color, "MEDIUMBLUE", true)) SendClientMessageToAll(MEDIUMBLUE,text);
	else if(!strcmp(color, "NEUTRAL", true)) SendClientMessageToAll(NEUTRAL,text);
	else if(!strcmp(color, "BLACK", true)) SendClientMessageToAll(BLACK,text);
	else if(!strcmp(color, "NEUTRALGREEN", true)) SendClientMessageToAll(NEUTRALGREEN,text);
	else if(!strcmp(color, "DARKGREEN", true)) SendClientMessageToAll(DARKGREEN,text);
	else if(!strcmp(color, "LIGHTGREEN", true)) SendClientMessageToAll(LIGHTGREEN,text);
	else if(!strcmp(color, "DARKBLUE", true)) SendClientMessageToAll(DARKBLUE,text);
	else if(!strcmp(color, "BLUEGREEN", true)) SendClientMessageToAll(BLUEGREEN,text);
	else if(!strcmp(color, "PINK", true)) SendClientMessageToAll(PINK,text);
	else if(!strcmp(color, "LIGHTBLUE", true)) SendClientMessageToAll(LIGHTBLUE,text);
	else if(!strcmp(color, "DARKRED", true)) SendClientMessageToAll(DARKRED,text);
	else if(!strcmp(color, "PURPLE", true)) SendClientMessageToAll(PURPLE,text);
	else if(!strcmp(color, "GREY", true)) SendClientMessageToAll(GREY,text);
	else if(!strcmp(color, "GREEN", true)) SendClientMessageToAll(GREEN,text);
	else if(!strcmp(color, "RED", true)) SendClientMessageToAll(RED,text);
	else if(!strcmp(color, "YELLOW", true)) SendClientMessageToAll(YELLOW,text);
	else if(!strcmp(color, "WHITE", true)) SendClientMessageToAll(WHITE,text);
	else if(!strcmp(color, "BROWN", true)) SendClientMessageToAll(BROWN,text);
	else if(!strcmp(color, "CYAN", true)) SendClientMessageToAll(CYAN,text);
	else if(!strcmp(color, "TAN", true)) SendClientMessageToAll(TAN,text);
	else if(!strcmp(color, "PINK", true)) SendClientMessageToAll(PINK,text);
	else if(!strcmp(color, "KHAKI", true)) SendClientMessageToAll(KHAKI,text);
	else if(!strcmp(color, "LIME", true)) SendClientMessageToAll(LIME,text);
	else return SendClientMessage(playerid,RED,"enter a valid color or look at /HHelp");
	SendCommandMsg(playerid,"write");
	return 1;
}

dcmd_slap(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"slap")) return CmdLevelError(playerid,"slap");
	new id,string[128],Float:Health;
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /SLAP [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	format(string,sizeof(string),"Administrator %s has bitch-slapped %s",AdminName(playerid),Name(id));
	GetPlayerHealth(id,Health),SendClientMessageToAll(YELLOW,string);
	SetPlayerHealth(id,Health-GetConfig("SlapHealth"));
	SendCommandMsg(playerid,"slap");
	return 1;
}

dcmd_crash(playerid, params[])
{
	if(!CmdLevelCheck(playerid,"crash")) return CmdLevelError(playerid,"crash");
	new Float:X,Float:Y,Float:Z,string[128],id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /CRASH [ID / NAME]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	GetPlayerPos(id, X, Y, Z);
	new crasher = CreatePlayerObject(id,99999999,X,Y,Z,0,0,0);
	format(string,sizeof(string),"You have crashed player %s",Name(id));
	SendClientMessage(playerid,YELLOW,string);
	SendCommandMsg(playerid,"crash");
	DestroyObject(crasher);
	return 1;
}

dcmd_vehint(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"vehint")) return CmdLevelError(playerid,"vehint");
    new id,intid,string[128];
    if(sscanf(params, "ud", id, intid)) return SendClientMessage(playerid, RED, "USAGE: /VEHINT [ID / NICK] [INTERIOR_ID]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
    if(intid < 0 || intid > 18) return SendClientMessage(playerid,RED,"Error: enter a valid interior id  [0/18]");
    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,RED,"Error: This player is NOT in a vehicle");
	if(id != playerid)
	{
		format(string,sizeof(string),"Administrator %s have set your Vehicle interior ID to %d",AdminName(playerid),intid);
		SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You have set %s his Vehicle interior ID to %d",Name(id),intid);
		SendClientMessage(playerid,YELLOW,string);
	}
	else if(id == playerid)
	{
		format(string,sizeof(string),"You have set your own vehicle interior ID to %d",intid);
		SendClientMessage(playerid,YELLOW,string);
	}
	LinkVehicleToInterior(GetPlayerVehicleID(id),intid);
	SendCommandMsg(playerid,"setinterior");
	return 1;
}

dcmd_sayserver(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"sayserver")) return CmdLevelError(playerid,"sayserver");
    if(!strlen(params)) return SendClientMessage(playerid, RED, "USAGE: /SAYSERVER [TEXT]");
    new string[128];
    format(string,sizeof(string),"SERVER: %s.",params);
    printf("[say-server][%s]: %s",Name(playerid),params);
	SendCommandMsg(playerid,"sayserver");
	SendClientMessageToAll(WHITE,string);
    return 1;
}

dcmd_respawn(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"respawn")) return CmdLevelError(playerid,"respawn");
    new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /RESPAWN [ID / NICK]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(id != playerid)
	{
		format(string,sizeof(string),"Administrator %s have Respawned you",AdminName(playerid));
		SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You Respawned Player: %s",Name(id));
		SendClientMessage(playerid,YELLOW,string);
	}
	else if(id == playerid)
	{
		SendClientMessage(playerid,YELLOW,"You have respawned yourself");
	}
	SpawnPlayer(id);
	SendCommandMsg(playerid,"respawn");
	return 1;
}

dcmd_lockcmds(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"lockcmds")) return CmdLevelError(playerid,"lockcmds");
    new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /LOCKCMDS [ID / NICK]");
    if(!IsPlayerConnected(id) || id==playerid) return SendClientMessage(playerid, RED, "This player is offline or is yourself");
    if(CmdsLocked[id]==1) return SendClientMessage(playerid,RED,"This commands are already locked");
    format(string,sizeof(string),"Administrator %s has locked %s his commands",AdminName(playerid),Name(id));
    SendClientMessageToAll(YELLOW,string);
    CmdsLocked[id]=1;
    SendCommandMsg(playerid,"lockcmds");
	return 1;
}

dcmd_unlockcmds(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"unlockcmds")) return CmdLevelError(playerid,"unlockcmds");
    new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /UNLOCKCMDS [ID / NICK]");
    if(!IsPlayerConnected(id) || id==playerid) return SendClientMessage(playerid, RED, "This player is offline or is yourself");
    if(CmdsLocked[id]==0) return SendClientMessage(playerid,RED,"This commands are already unlocked");
    format(string,sizeof(string),"Administrator %s has unlocked %s his commands",AdminName(playerid),Name(id));
    SendClientMessageToAll(YELLOW,string);
    CmdsLocked[id]=0;
    SendCommandMsg(playerid,"unlockcmds");
	return 1;
}

dcmd_votekick(playerid, params[])
{
	new id,string[128];
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, RED, "USAGE: /VOTEKICK [ID / NICK]");
    if(!IsPlayerConnected(id) || id==playerid) return SendClientMessage(playerid, RED, "You can NOT vote-kick a disconnected player or yourself");
    if(Voting==1) return SendClientMessage(playerid,RED,"There is already a vote started!");
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i)) VotePlayerCount++;
	}
	if(VotePlayerCount > 8) VC=8; else if(VotePlayerCount > 7) VC=6; else if(VotePlayerCount > 6) VC=5;
	else if(VotePlayerCount > 5) VC=4; else if(VotePlayerCount > 4) VC=3; else if(VotePlayerCount > 3) VC=2;
	else return SendClientMessage(playerid,RED,"There are not enough players connected MIN: 4!");
	format(string,sizeof(string),"Player: %s has started a vote-kick on Player: %s To Vote Type: /vote",Name(playerid),Name(id));
    SendClientMessageToAll(YELLOW,string); print(string);
    VoteKick[id]=1,Voting=1,VoteStarted[playerid]=1,Votes=0;
    format(string,sizeof(string),"_~w~Vote-kick: ~g~%s~n~_~r~0~w~/~r~%d ~w~Votes",Name(id),VC);
    VoteSeconds = GetConfig("VoteTime")+1;
	voterTimer = SetTimerEx("VoteSecCount",1000,1,"ii",playerid,id);
	VoteUpdate = SetTimerEx("VoteStringUpdate",1000,1,"ii",playerid,id);
    TextDrawSetString(Text:VoteText,string);
    TextDrawShowForAll(Text:VoteText);
    TextDrawShowForAll(Text:VoteTimer);
	return 1;
}

dcmd_vote(playerid, params[])
{
	#pragma unused params
	if(Voting==0) return SendClientMessage(playerid,RED,"Error: there isn't a vote-kick started, use /votekick to start!");
	if(VoteStarted[playerid]==1) return SendClientMessage(playerid,RED,"Error: You Have start this vote-kick you can't vote!");
	if(Voted[playerid]==1) return SendClientMessage(playerid,RED,"Error: You have already voted!");
	if(VoteKick[playerid]==1) return SendClientMessage(playerid,RED,"Error: You can NOT vote on your self");
	SendClientMessage(playerid,YELLOW,"You have voted!");
	Voted[playerid]=1;
	Votes++;
	return 1;
}



forward VoteSecCount(playerid,id);
public VoteSecCount(playerid,id)
{
	new string[128];
	VoteSeconds--;
	format(string,sizeof(string),"~b~%d ~w~Seconds",VoteSeconds);
	TextDrawSetString(Text:VoteTimer,string);
	if(VoteSeconds <= 0)
	{
	    KillTimer(voterTimer),KillTimer(VoteUpdate);
	    TextDrawHideForAll(Text:VoteTimer);
	    TextDrawHideForAll(Text:VoteText);
	    VoteKick[id]=0,Voting=0,VoteStarted[playerid]=0;
	    if(Votes < VC)
	    {
	        format(string,sizeof(string),"Player %s is NOT kicked [Reason: Not enough voters!]",Name(id));
			SendClientMessageToAll(YELLOW,string);
			for(new i=0; i<MAX_PLAYERS; i++) Voted[i]=0;
	    }
	    else if(Votes >= VC)
	    {
	        format(string,sizeof(string),"Player: %s has been kicked from the server [Reason: Vote-kick from %s.]",Name(id),Name(playerid));
	        SendClientMessageToAll(YELLOW,string);
	        Kick(id);
	    }
	}
	return 1;
}

forward VoteStringUpdate(id1,id2);
public VoteStringUpdate(id1,id2)
{
	new string[128];
	VotePlayerCount=0;
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i)) VotePlayerCount++;
	}
	if(VotePlayerCount > 8) VC=8;
	else if(VotePlayerCount > 7) VC=6;
	else if(VotePlayerCount > 6) VC=5;
	else if(VotePlayerCount > 5) VC=4;
	else if(VotePlayerCount > 4) VC=3;
	else if(VotePlayerCount > 3) VC=2;
	if(VotePlayerCount <= 3)
	{
	    SendClientMessageToAll(YELLOW,"The PlayerCount is not enough to end this vote-kick, Vote-kick Cancelled");
		print("The PlayerCount is not enough to end this vote-kick, Vote-kick Cancelled");
		KillTimer(voterTimer),KillTimer(VoteUpdate);
	    TextDrawHideForAll(Text:VoteTimer);
	    TextDrawHideForAll(Text:VoteText);
	    VoteKick[id1]=0;
		Voting=0;
		for(new i=0; i<MAX_PLAYERS; i++) Voted[i]=0,VoteStarted[i]=0;
	}
	format(string,sizeof(string),"_~w~Vote-kick: ~g~%s~n~_~r~%d~w~/~r~%d ~w~Votes",Name(id2),Votes,VC);
	TextDrawSetString(Text:VoteText,string);
	return 1;
}

dcmd_stopvote(playerid,params[])
{
	new reason[128],string[128];
	if(!CmdLevelCheck(playerid,"stopvote")) return CmdLevelError(playerid,"stopvote");
	if(sscanf(params, "z", reason)) return SendClientMessage(playerid, RED, "USAGE: /STOPVOTE [REASON]");
	format(string, sizeof string, "Administrator %s has Stop the Vote-Kick [Reason: %s.]",AdminName(playerid),reason);
	SendClientMessageToAll(YELLOW,string),print(string);
	KillTimer(voterTimer),KillTimer(VoteUpdate);
    TextDrawHideForAll(Text:VoteTimer);
    TextDrawHideForAll(Text:VoteText);
	Voting=0;
	SendCommandMsg(playerid,"stopvote");
	for(new i=0; i<MAX_PLAYERS; i++) Voted[i]=0,VoteStarted[i]=0,VoteKick[i]=0;
	return 1;
}

dcmd_deposit(playerid, params[])
{
	new money,string[128];
    if(sscanf(params, "d", money)) return SendClientMessage(playerid, RED, "USAGE: /DEPOSIT [AMOUNT]");
    if(money < 0 || money > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
    if(GetPlayerMoney(playerid) < money) return SendClientMessage(playerid,RED,"ERROR: You don't have this money");
    format(string,sizeof(string),"You have desposit $%d on your bank account.",money);
    SendClientMessage(playerid,YELLOW,string);
    SetInfo(playerid,"Bank",GetInfo(playerid,"Bank")+money);
    SetPlayerMoney(playerid,GetPlayerMoney(playerid)-money);
	return 1;
}

dcmd_Withdraw(playerid, params[])
{
	new money,string[128];
    if(sscanf(params, "d", money)) return SendClientMessage(playerid, RED, "USAGE: /WITHDRAW [AMOUNT]");
    if(money < 0 || money > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
    if(money > GetInfo(playerid,"Bank")) return SendClientMessage(playerid,RED,"ERROR: You don't have this money on your bank account");
    format(string,sizeof(string),"You have withdraw $%d from your bank account.",money);
    SendClientMessage(playerid,YELLOW,string);
    SetInfo(playerid,"Bank",GetInfo(playerid,"Bank")-money);
    SetPlayerMoney(playerid,GetPlayerMoney(playerid)+money);
	return 1;
}

dcmd_balance(playerid, params[])
{
	#pragma unused params
	new string[128];
	format(string,sizeof(string),"You have $%d on your bank account",GetInfo(playerid,"Bank"));
	SendClientMessage(playerid,YELLOW,string);
	return 1;
}

dcmd_transfer(playerid, params[])
{
	new id,money,string[128];
    if(sscanf(params, "ud", id,money)) return SendClientMessage(playerid, RED, "USAGE: /TRANSFER [ID / NICK] [AMOUNT]");
    if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
    if(money < 0 || money > 1000000) return SendClientMessage(playerid,RED,"ERROR: Invaild money amount: [0/1.000.000]");
    if(GetInfo(playerid,"Bank") < money) return SendClientMessage(playerid,RED,"ERROR: You don't have this money");
    format(string,sizeof(string),"You have transfered $%d To %s his Bank Account.",money,Name(id));
    SendClientMessage(playerid,YELLOW,string);
    SetInfo(id,"Bank",GetInfo(id,"Bank")+money);
    SetInfo(playerid,"Bank",GetInfo(playerid,"Bank")-money);
	return 1;
}


dcmd_rban(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"rban")) return CmdLevelError(playerid,"rban");
	new id, tmp[128],string[128],IP[16];
	if(sscanf(params, "uz", id, tmp)) return SendClientMessage(playerid, RED, "USAGE: /RBAN [ID / NAME] [REASON]");
	if(!IsPlayerConnected(id) || id == playerid) return SendClientMessage(playerid, RED, "This player is offline or it is yourself");
	format(string, sizeof string, "Player: %s has been Range Banned by Administrator %s%s%s%s",Name(id), AdminName(playerid), (tmp[0]) ? (" [reason: ") : ("."), tmp[0], (tmp[0]) ? (" ]") : (""));
	SendClientMessageToAll(YELLOW, string), print(string),
	SaveToLog("rangebans",string);
	SetInfo(id,"Banned",1);
	SendCommandMsg(playerid,"rban");
	format(string,sizeof(string),"Range Banned By Admin %s",AdminName(playerid));
	SpecialLeaveReason[id]=1,PlayerLeaveReason[id]=string;
	GetPlayerIp(playerid,IP,sizeof(IP));
	strdel(IP,strlen(IP)-2,strlen(IP));
	format(string,sizeof(string),"%s**",IP);
	format(string,sizeof(string),"banip %s",IP);
	SendRconCommand(string);
	SendCommandMsg(playerid,"rban");
	return 1;
}

dcmd_olog(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"olog")) return CmdLevelError(playerid,"olog");
	new logname[128];
    if(sscanf(params, "s", logname)) return SendClientMessage(playerid, RED, "USAGE: /OLOG [JOIN_NAME]");
    if(!dini_Isset("Hadmin/config/Online.log",logname)) return SendClientMessage(playerid, RED, "This player has never joined");
	else SendClientMessage(playerid,GREEN,dini_Get("Hadmin/config/Online.log",logname));
	SendCommandMsg(playerid,"olog");
	return 1;
}

dcmd_givehealth(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"givehealth")) return CmdLevelError(playerid,"givehealth");
	new id,string[128],number,Float:health;
	if(sscanf(params, "ud", id, number)) return SendClientMessage(playerid, RED, "USAGE: /GIVEHEATH [ID / NAME] [0/100]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 100) return SendClientMessage(playerid,RED,"ERROR: Invaild health amount Only: [0/100]");
	format(string,sizeof(string),"Administrator: %s Have Given you: %d Health",AdminName(playerid),number);
	SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You given %d Health To %s",number,Name(id));
	SendClientMessage(playerid,YELLOW,string); SendCommandMsg(playerid,"givehealth"); GetPlayerHealth(id,Float:health);
	SetPlayerHealth(id,health+number),GetPlayerHealth(id,Float:health);
	if(GetConfig("AntiGod")==1 && health>=300) SetPlayerHealth(id,100); // els he will be kicked (god mode check)
	return 1;
}

dcmd_givearmour(playerid,params[])
{
    if(!CmdLevelCheck(playerid,"givearmour")) return CmdLevelError(playerid,"givearmour");
	new id,string[128],number,Float:health;
	if(sscanf(params, "ud", id, number)) return SendClientMessage(playerid, RED, "USAGE: /GIVEARMOUR [ID / NAME] [0/100]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED, "This player is offline");
	if(number < 0 || number > 100) return SendClientMessage(playerid,RED,"ERROR: Invaild health amount Only: [0/100]");
	format(string,sizeof(string),"Administrator: %s Have Given you: %d Armour",AdminName(playerid),number);
	SendClientMessage(id,YELLOW,string); format(string,sizeof(string),"You given %d Armour To %s",number,Name(id));
	SendClientMessage(playerid,YELLOW,string); SendCommandMsg(playerid,"givearmour"); GetPlayerArmour(id,Float:health);
	SetPlayerArmour(id,health+number);
	return 1;
}

dcmd_freezeall(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"unfreezeall")) return CmdLevelError(playerid,"unfreezeall");
    #pragma unused params
    new string[128];
    format(string,sizeof(string),"Administrator %s Have Frozen everybody in the server",AdminName(playerid));
    SendClientMessageToAll(YELLOW,string);
    SendCommandMsg(playerid,"freezeall");
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(!IsPlayerHAdmin(i)) TogglePlayerControllable(i,0),Info[i][Frozen]=1;
	return 1;
}

dcmd_unfreezeall(playerid, params[])
{
    if(!CmdLevelCheck(playerid,"unfreezeall")) return CmdLevelError(playerid,"unfreezeall");
    #pragma unused params
    new string[128];
    format(string,sizeof(string),"Administrator %s Have UnFrozen everybody in the server",AdminName(playerid));
    SendClientMessageToAll(YELLOW,string);
    SendCommandMsg(playerid,"unfreezeall");
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(!IsPlayerHAdmin(i)) TogglePlayerControllable(i,1),Info[i][Frozen]=0;
	return 1;
}

dcmd_akillall(playerid,params[])
{
	#pragma unused params
    if(!CmdLevelCheck(playerid,"akillall")) return CmdLevelError(playerid,"akillall");
	new string[128];
	format(string, sizeof(string), "Everybody has been killed by Administrator %s",AdminName(playerid));
	SendClientMessageToAll(YELLOW, string);
	SendCommandMsg(playerid,"akillall");
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(!IsPlayerHAdmin(i)) SetPlayerHealth(i,0);
	return 1;
}

dcmd_lockrcon(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"lockrcon")) return CmdLevelError(playerid,"lockrcon");
    printf("Administrator %s Has locked the Rcon",AdminName(playerid));
    SendClientMessage(playerid,YELLOW,"You have Locked the rcon");
    RconLocked=1;
	return 1;
}

dcmd_unlockrcon(playerid, params[])
{
    #pragma unused params
    if(!CmdLevelCheck(playerid,"unlockrcon")) return CmdLevelError(playerid,"unlockrcon");
	if(RconLocked==0) return SendClientMessage(playerid,RED,"The Rcon is already UnLocked");
	printf("Administrator %s Has unlocked the Rcon",AdminName(playerid));
	SendClientMessage(playerid,YELLOW,"You have UnLocked the rcon");
	RconLocked=1;
	return 1;
}

dcmd_acmds(playerid, params[])
{
    if(!IsPlayerHAdmin(playerid)) return SendClientMessage(playerid,YELLOW,"You cannot use this command!");
	#pragma unused params
	SendClientMessage(playerid,YELLOW, "/kick, /ban, /freeze, /unfreeze, /goto, /gethere, /announce, /jail, /unjail, /clearchat, /ip, /armourall, ");
	SendClientMessage(playerid,YELLOW, "/healall, /showname, /god, /setgod, /sethealth, /setarmour, /setallhealth, /say, /lockserver, ");
	SendClientMessage(playerid,YELLOW, "/unlockserver, /setallarmour, /godcar, /givemoney, /setmoney, /getmoney, /setscore, /resetmoney, ");
	SendClientMessage(playerid,YELLOW, "/resetscore, /resetallmoney, /resetallscores, /setadminlevel, /ping, /akill, /setcolor, /setcarhealth, ");
	SendClientMessage(playerid,YELLOW, "/giveweapon, /hhelp, /mute, /unmute, /getallhere, /carbom, /eject, /ejectall, /pullin, /explode, ");
	SendClientMessage(playerid,YELLOW, "/explodeall, /giveme, /pimpcar, /delveh, /delallveh, /setcarcolor, /hideme, /showme, /kickall, ");
	SendClientMessage(playerid,YELLOW, "/muteall, /unmuteall, /gmx, /lockpm, /unlockpm, /lockchat, /unlockchat, /closeserver, /changehost, ");
	SendClientMessage(playerid,YELLOW, "/adminmsg, /wmenu, /maxping, /hlock, /hunlock, /gravity, /hspec, /veh, /giveallmoney, /setallmoney, ");
	SendClientMessage(playerid,YELLOW, "/getallmoney, /setallscore, /nameban, /setname, /warn, /givehim, /giveallweapon, /force, ");
	SendClientMessage(playerid,YELLOW, "/resetallscore, /trust, /setwanted, /setallwanted, /setpass, /settime, /setalltime, /morning, /afternoon, ");
	SendClientMessage(playerid,YELLOW, "/midnight, /night, /jetpack, /countdown, /hideclock, /showclock, /sendplayertext, /setskin, /setallskin, ");
	SendClientMessage(playerid,YELLOW, "/stats, /getstats, /respawnallveh, /addword, /addname, /resetweapons, /resetallweapons, /setweather, ");
	SendClientMessage(playerid,YELLOW, "/setallweather, /ignore, /unignore, /hideall, /showall, /diepos, /spos, /lpos, /setworld, /setinterior, /serverpass, ");
	SendClientMessage(playerid,YELLOW, "/setallworld, /setallinterior, /resetstats, /setstats, /discaps, /encaps, /hinfo, /serverinfo ");
	SendClientMessage(playerid,YELLOW, "/slap, /crash, /vehint, /sayserver, /respawn, /lockcmds, /unlockcmds, /stopvote, /password, ");
	SendClientMessage(playerid,YELLOW, "/rban, /olog, /givehealth, /givearmour, /freezeall, /unfreezeall, /akillall, /acmds, /write, ");
	return 1;
}


