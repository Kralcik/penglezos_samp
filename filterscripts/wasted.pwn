#include <a_samp>

//TEXT AND COLOR SETTING:
#define TEXT "~r~WASTED" //Insert your text to be displayed, when player dies and color code before text: ~r~, ~g~, ~b~, ~y~, ~p~(red, green, blue, yellow, purple. ~ are neccesary)

new	Text:FadeText;


forward LetsFade(playerid, proc);

public OnFilterScriptInit()
{
        FadeText=TextDrawCreate(0.0,0.0,"~r~");
	TextDrawTextSize(FadeText,640,480);
	TextDrawLetterSize(FadeText,0.0,50.0);
	TextDrawUseBox(FadeText,1);
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
   SetTimerEx("LetsFade", 100, false, "ii", playerid, 99);
   return 1;
}
public LetsFade(playerid, proc)
{
   if(proc <= 10)
   {
	  GameTextForPlayer(playerid, TEXT, 2000, 0);
   }
   else
   {
      new str[16];
      format(str, 16, "0xFF0000%i", proc);
      TextDrawBoxColor(FadeText, HexToInt(str));
      TextDrawShowForPlayer(playerid, FadeText);
      SetTimerEx("LetsFade", 100, false, "ii", playerid, proc-10);
   }
}
public OnPlayerSpawn(playerid)
{
   TextDrawHideForPlayer(playerid, FadeText);
   return 1;
}

stock HexToInt(string[])
{
   if (string[0]==0) return 0;
   new i;
   new cur=1;
   new res=0;
   for (i=strlen(string);i>0;i--) {
   if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
   cur=cur*16;
   }
   return res;
 }
