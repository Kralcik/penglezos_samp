#include <a_samp>

new isenable, answer, number[4];

#define COL_RED   "{FF0000}"
#define COL_WHITE "{FFFFFF}"
#define COL_GREEN "{33AA33}"

public OnFilterScriptInit()
{
  SetTimer("mathQuiz",80000, true);
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
      format(string, sizeof(string),"%s answered the right answer of math Quiz which was "COL_RED"%d "COL_WHITE"and wons 3 Scores, 1000$ Cash",CName,answer);
      SendClientMessageToAll(-1, string);
      SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
      GivePlayerMoney(playerid, 1000);
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
                                format(string, sizeof(string),"[Quiz] First one who Solve "COL_GREEN"%d"COL_WHITE" + "COL_GREEN"%d"COL_WHITE" will get 3 Scores, 1000$ Cash",number[0], number[1]);
                        }
                        case 1:
						{
                                do
								{
 								  answer = (number[0]=random(500)) - (number[1]=random(500));
                                }
								while(number[0] < number[1]);
                                format(string, sizeof(string),"[Quiz] First one who Solve "COL_GREEN"%d"COL_WHITE" - "COL_GREEN"%d"COL_WHITE" will get 3 Scores, 1000$ Cash",number[0], number[1]);
                        }
                        case 2:
						{
                                answer = (number[0]=random(100)) * (number[1]=random(80));
                                format(string, sizeof(string),"[Quiz] First one who Solve "COL_GREEN"%d"COL_WHITE" * "COL_GREEN"%d"COL_WHITE" will get 3 Scores, 1000$ Cash",number[0], number[1]);
                        }
                        case 3:
						{
                                do
								{
                                        answer = (number[0]=random(1000)+1) / (number[1]=random(600)+1);
                                }
								while(number[0] % number[1]);
                                format(string, sizeof(string),"[Quiz] First one who Solve "COL_GREEN"%d"COL_WHITE" / "COL_GREEN"%d"COL_WHITE" will get 3 Scores, 1000$ Cash",number[0], number[1]);
                        }
                }
                SendClientMessageToAll(-1, string);
                isenable = true;
        }
        else
		{
                isenable = false;
                format(string, sizeof(string),"No one solved the math Quiz which was "COL_RED"%d"COL_WHITE", so no one wons 1Score, 10$", answer);
                SendClientMessageToAll(-1, string);
        }
        return 1;
}
