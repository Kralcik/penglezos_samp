// Anti-Cheat Guard
// Coded by: panagiotisegl
// Cheats protected: jetpack,armor,ping,swear,advertisment
// Version: 2.0

#include <a_samp>
#include <zcmd>

#define MAXPINGS 1000
#define enable 0
#define disable 1
#define MAX_WORD_LEN 18
#define MAX_WORDS 122
#define MAX_SWEARCOUNT 5

new swear[][MAX_WORD_LEN] =
{
	{"anus"},
	{"arsehole"},
	{"ass"},
	{"bitch"},
	{"biatch"},
	{"blowjob"},
	{"boner"},
	{"bullshit"},
	{"clit"},
	{"cock"},
	{"cum"},
	{"cunt"},
	{"dick"},
	{"dildo"},
	{"douche"},
	{"fag"},
	{"fellatio"},
	{"fuck"},
	{"fudgepacker"},
	{"gay"},
	{"damn"},
	{"gooch"},
	{"handjob"},
	{"hard-on"},
  	{"homo"},
    {"hoe"},
 	{"homodumbshit"},
	{"humping"},
	{"jerkoff"},
	{"jigaboo"},
	{"jizz"},
	{"jungle-bunny"},
	{"junglebunny"},
	{"kooch"},
	{"kootch"},
	{"kunt"},
	{"kyke"},
	{"lesbian"},
	{"lesbo"},
	{"lezzie"},
	{"mcfagget"},
	{"minge"},
	{"mothafucka"},
	{"motherfucker"},
	{"motherfucking"},
	{"muff"},
	{"muffdiver"},
	{"munging"},
	{"negro"},
	{"nigga"},
	{"niglet"},
	{"nutsack"},
	{"paki"},
	{"panooch"},
	{"pecker"},
	{"peckerhead"},
	{"penis"},
	{"piss"},
	{"polesmoker"},
	{"pollock"},
	{"poonani"},
	{"porchmonkey"},
	{"prick"},
	{"punanny"},
	{"punta"},
	{"pussies"},
	{"pussy"},
	{"pussylicking"},
	{"puto"},
	{"queef"},
	{"renob"},
	{"rimjob"},
	{"ruski"},
	{"sandnigger"},
	{"schlong"},
	{"scrote"},
	{"shit"},
	{"shiz"},
	{"shiznit"},
	{"skank"},
	{"skullfuck"},
	{"slut"},
	{"slutbag"},
	{"smeg"},
	{"snatch"},
	{"tard"},
	{"testicle"},
	{"thundercunt"},
	{"tit"},
	{"twat"},
	{"twatwaffle"},
	{"unclefucker"},
	{"vag"},
	{"vagina"},
	{"vjayjay"},
	{"wank"},
	{"whore"},
	{"whorebag"},
	{"whoreface"},
	{"wop"},
	{"@gmail"},
	{"@live"},
	{"@msn"},
	{"@hotmail"},
	{".de"},
	{".cc"},
	{"www."},
	{".com"},
	{".co"},
	{".uk"},
	{".org"},
	{".net"},
	{".info"},
	{".tk"}
};

new ping[MAX_PLAYERS];
new JetPack[MAX_PLAYERS];
new LastArmour[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n------------------------------------------------------");
	print(" Anti-Cheat Guard by panagiotisegl                      ");
	print("------------------------------------------------------\n");
}

public OnPlayerConnect(playerid)
{
    JetPack[playerid] = 0;
	return 1;
}

new swearCount[MAX_PLAYERS];
public OnPlayerDisconnect(playerid, reason){
	swearCount[playerid] = 0;
}
public OnPlayerText(playerid, text[])
{
// Advertisment protection
if(strfind(text, ":", true) != -1)
    {
        new i_numcount, i_period, i_pos;
        while(text[i_pos])
        {
            if('0' <= text[i_pos] <= '9') i_numcount ++;
            else if(text[i_pos] == '.') i_period ++;
            i_pos++;
        }
        if(i_numcount >= 8 && i_period >= 3)
		{
            return 0;
        }
}
// Swear Protection
	if((strlen(text) < 3) || (text[0] == '/') || (text[0] == '#') || (text[0] == '!')) return 1;

	new offset;
	new len;
 	for(new i=0; i<MAX_WORDS; i++)
	{
		offset = strfind(text, swear[i], true);
		if(offset > -1)
		{
			len = strlen(swear[i]);
			if(len < 3) break;
			for(new y=0; y<len; y++)
			{
				text[offset+y] = '*';
			}
			swearCount[playerid]++;
			new string[64];
			format(string, sizeof(string), "Swearing is not allowed here, warning %d/%d", swearCount[playerid], MAX_SWEARCOUNT);
			SendClientMessage(playerid, 0xFF6347FF, string);
   			if(swearCount[playerid] >= MAX_SWEARCOUNT)
			{
			    new name[24];
			    GetPlayerName(playerid, name, sizeof(name));
			    format(string, sizeof(string), "*** %s has been kicked for offensive language", name);
			    SendClientMessageToAll(0xFF6347FF, string);
			    Kick(playerid);
			    break;
			}
			break;
		}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
// Armour protection
new Float:armour;
GetPlayerArmour(playerid,armour);
new result = armour-LastArmour[playerid];
if(result > 99.0) // leave that 99.0
{
  SetPlayerArmour(playerid, 0);
}
else
{
  LastArmour[playerid] = armour;
}
// High Ping protection
if(ping[playerid] != disable)
	{
		if(GetPlayerPing(playerid) > MAXPINGS)
		{
            SetTimerEx("pKick", 10, true, "i", playerid);
			new string[128], targetid;
            format(string, sizeof(string), "[Anti-Cheat]: %s has been kicked for high ping. ",GetName(targetid));
            SendClientMessageToAll(-1, string);
            print(string);
			GameTextForPlayer(playerid,"~r~High~w~ Ping",3000,0);
		}
}
// Jetpack protection
    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
    {
        if(JetPack[playerid] == 0)
        {
        new string[128], targetid;
    	format(string, sizeof(string), "[Anti-Cheat]: %s has been banned for using jetpack hacks ",GetName(targetid));
    	SendClientMessageToAll(-1, string);
     	print(string);
		SetTimerEx("KickTimer", 10, false, "i", playerid);
		BanEx(playerid,string);
        }
        else
            return 1;
    }
    else JetPack[playerid] = 0;
    return 1;
}

forward KickTimer(playerid);
public KickTimer(playerid)
{
    Kick(playerid);
    return 1;
}

forward pKick(playerid);
public pKick(playerid)
{
    Kick(playerid);
}

stock GetName(playerid)
{
    new
    pName[MAX_PLAYER_NAME];

    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
    return pName;
}
