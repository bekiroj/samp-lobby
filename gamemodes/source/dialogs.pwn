public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 1)
    {
        if(response)
        {
            if(strlen(inputtext) < 3) return ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Kayýt", "HATA: Þifreniz 3 haneden kýsa olamaz!\n\nKayýt olmak için þifrenizi girin:", "Kaydol", "Çýkýþ");

            new query[128], isim[24];
            GetPlayerName(playerid, isim, 24);
            format(query, sizeof(query), "INSERT INTO `accounts` (`Name`, `Password`) VALUES ('%s', '%s')", isim, inputtext);
            mysql_query(mysqlC, query);
            SendClientMessage(playerid, -1, "Baþarýyla kaydoldunuz!");
            ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD, "Giriþ", "Giriþ yapmak için þifrenizi girin:", "Giriþ", "Çýkýþ");
        }
    }

    if(dialogid == 2)
    {
        if(response)
        {
            new query[128], isim[24];
            GetPlayerName(playerid, isim, 24);
            format(query, sizeof(query), "SELECT * FROM `accounts` WHERE Name = '%s' AND Password = '%s'", isim, inputtext);
            mysql_tquery(mysqlC, query, "OyuncuKontrol", "d", playerid);
        }
    }
    
    if(dialogid == 3)
    {
        if(response)
        {
            if(listitem == 0)
    		{
    		    PlayerData[playerid][pFR] = 0;
    		    PlayerData[playerid][pDM] = 0;
    		    PlayerData[playerid][pLobby] = 1;
    		    
    		    SetPlayerPos(playerid,1387.953, -26.785, 1000.600);
    		    SetPlayerInterior(playerid, 0);
    		    SetPlayerHealth(playerid, 999999);
    		    ResetPlayerWeapons(playerid);
				SendClientMessage(playerid, COLOR_GREY, "Lobi'ye döndün.");
    		}
    		if(listitem == 1)
    		{
    		    if (PlayerData[playerid][pLobby] == 0)
        			return SendClientMessage(playerid, COLOR_RED, "[HATA]: Oyun modu deðiþtirmek için lobiye dönmelisiniz !");
        
        		PlayerData[playerid][pFR] = 0;
    		    PlayerData[playerid][pDM] = 1;
    		    PlayerData[playerid][pLobby] = 0;
    		    
    		    new Random = random(sizeof(DMRandomSpawns));
			    SetPlayerPos(playerid, DMRandomSpawns[Random][0], DMRandomSpawns[Random][1], DMRandomSpawns[Random][2]);
    		    SetPlayerInterior(playerid, 3);
    		    
    		    ResetPlayerWeapons(playerid);
    		    SetPlayerArmour(playerid, 100.0);
   				SetPlayerHealth(playerid, 100.0);
				GivePlayerWeapon(playerid, 25,9999);
				GivePlayerWeapon(playerid, 24, 9999);
				SendClientMessage(playerid, COLOR_GREY, "Deathmatch moduna geçtin.");
    		}
    		if(listitem == 2)
    		{
    		    if (PlayerData[playerid][pLobby] == 0)
        			return SendClientMessage(playerid, COLOR_RED, "[HATA]: Oyun modu deðiþtirmek için lobiye dönmelisiniz !");
        			
                PlayerData[playerid][pFR] = 1;
    		    PlayerData[playerid][pDM] = 0;
    		    PlayerData[playerid][pLobby] = 0;
    		    
			    SetTimerEx("AntiSpawnFinish", 3000, false, "i", playerid);
			    SetPlayerPos(playerid, 1129.025, -1465.072, 15.465);
			    SetPlayerInterior(playerid, 0);
			    
			    SetPlayerHealth(playerid, 999999);
			    SetPlayerArmour(playerid, 0);
    		    ResetPlayerWeapons(playerid);
		    	SendClientMessage(playerid, COLOR_GREY, "Freeroam moduna geçtin.");
    		}
        }
    }
    
    if(dialogid == 4)
	{
	    if(response)
	    {
    		if(listitem == 0)
    		{
        		GivePlayerWeapon(playerid, 22, 200);
				SendClientMessage(playerid, COLOR_GREY, "Colt45 Silahýný aldýn.");
    		}
    		if(listitem == 1)
    		{
    		    GivePlayerWeapon(playerid, 24, 200);
		    	SendClientMessage(playerid, COLOR_GREY, "Desert Eagle Silahýný aldýn.");
    		}
    		if(listitem == 2)
    		{
    		    GivePlayerWeapon(playerid, 25, 200);
		    	SendClientMessage(playerid, COLOR_GREY, "Shotgun Silahýný aldýn.");
    		}
    		if(listitem == 3)
    		{
    		    GivePlayerWeapon(playerid, 26, 200);
		    	SendClientMessage(playerid, COLOR_GREY, "Sawn off shotgun Silahýný aldýn.");
    		}
    		if(listitem == 4)
    		{
    		    GivePlayerWeapon(playerid, 27, 200);
		    	SendClientMessage(playerid, COLOR_GREY, "Combat Shotgun Silahýný aldýn.");
    		}
    		if(listitem == 5)
    		{
    		    GivePlayerWeapon(playerid, 28, 200);
				SendClientMessage(playerid, COLOR_GREY, "UZI Silahýný aldýn.");
    		}
    		if(listitem == 6)
    		{
    	    	GivePlayerWeapon(playerid, 32, 200);
				SendClientMessage(playerid, COLOR_GREY, "Tec-9 Silahýný aldýn.");
			}
    		if(listitem == 7)
    		{
    	    	GivePlayerWeapon(playerid, 29, 200);
				SendClientMessage(playerid, COLOR_GREY, "MP5 Silahýný aldýn.");
			}
    		if(listitem == 8)
    		{
    	    	GivePlayerWeapon(playerid, 30, 200);
				SendClientMessage(playerid, COLOR_GREY, "AK47 Silahýný aldýn.");
			}
    		if(listitem == 9)
    		{
    	    	GivePlayerWeapon(playerid, 31,200);
				SendClientMessage(playerid, COLOR_GREY, "M4 Silahýný aldýn.");
			}
	  		if(listitem == 10)
    		{
    	    	GivePlayerWeapon(playerid, 34, 1000);
				SendClientMessage(playerid, COLOR_GREY, "Sniper Rifte Silahýný aldýn.");
			}
		}
		return 1;
	}
    return 1;
}
