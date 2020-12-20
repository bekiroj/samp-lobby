forward OyuncuYukle(playerid);
public OyuncuYukle(playerid)
{
    new rows;
    cache_get_row_count(rows);

    if(!rows)
    {
        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Kayýt", "Sunucumuzda hesabýnýz bulunamadý.\nKayýt olmak için þifrenizi girin:", "Kaydol", "Çýkýþ");
    }
    else
    {
        ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD, "Giriþ", "Sunucumuzda hesabýnýz bulundu.\nGiriþ yapmak için þifrenizi girin:", "Giriþ", "Çýkýþ");
    }
    return 1;
}

forward YasaklilarYukle(playerid);
public YasaklilarYukle(playerid)
{
    new rows;
    cache_get_row_count(rows);

    if(!rows)
    {
        //ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Kayýt", "Sunucumuzda hesabýnýz bulunamadý.\nKayýt olmak için þifrenizi girin:", "Kaydol", "Çýkýþ");
    }
    else
    {
    	ChatBox(playerid, "Sunucudan yasaklandýnýz.");
    	Kick(playerid);
    }
    return 1;
}

forward OyuncuKontrol(playerid);
public OyuncuKontrol(playerid)
{
    new rows;
    cache_get_row_count(rows);

    if(!rows) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD, "Giriþ", "Yanlýþ þifre girdiniz.\n\nGiriþ yapmak için þifrenizi girin:", "Giriþ", "Çýkýþ");
    else
    {
        new admin, skin, skor;
        cache_get_value_name_int(0, "Admin", admin);
        cache_get_value_name_int(0, "Skin", skin);
        cache_get_value_name_int(0, "Skor", skor);
        
		PlayerData[playerid][pLobby] = 1;
		PlayerData[playerid][pDM] = 0;
		PlayerData[playerid][pFR] = 0;
		PlayerData[playerid][pOnline] = 1;
		PlayerData[playerid][pAdmin] = admin;
		PlayerData[playerid][pSkin] = skin;
		
        SpawnPlayer(playerid);
        SetPlayerScore(playerid, skor);
        GivePlayerMoney(playerid, 250000);
        
        new Random = random(sizeof(RandomColor));
        SetPlayerColor(playerid,RandomColor[Random][0]);
		
        ChatBox(playerid, "Baþarýyla giriþ yaptýnýz!");
        ChatBox(playerid, "'Spawn' butonuna basarak devam edebilirsiniz!");
    }
    return 1;
}

stock IsEngineVehicle(vehicleid)
{
	static const g_aEngineStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}

stock FlipVehicle(vehicleid)
{
    new
        Float:fAngle;

    GetVehicleZAngle(vehicleid, fAngle);

    SetVehicleZAngle(vehicleid, fAngle);
    SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
    return 1;
}

SendPlayerToPlayer(playerid, targetid)
{
    new
        Float:px,
        Float:py,
        Float:pz;

    GetPlayerPos(targetid, px, py, pz);

    if (IsPlayerInAnyVehicle(playerid))
    {
        SetVehiclePos(GetPlayerVehicleID(playerid), px, py + 2, pz);
        LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
    }
    else
        SetPlayerPos(playerid, px + 1, py, pz);

    SetPlayerInterior(playerid, GetPlayerInterior(targetid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
    return 1;
}

stock IzlemeBitir(playerid)
{
	TogglePlayerSpectating(playerid, false);
    SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "specVw"));
    SetPlayerInterior(playerid, GetPVarInt(playerid, "specInterior"));
    SetPlayerPos(playerid, specPos[playerid][0], specPos[playerid][1], specPos[playerid][2]);
    return 1;
}

stock AdminMessage(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (PlayerData[i][pAdmin] >= 1) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
 	foreach (new i : Player)
	{
		if (PlayerData[i][pAdmin] >= 1) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock getName(playerid)
{
	new str[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, str, sizeof(str));
	return str;
}

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(VehicleNames[i], vname, true) != -1 )
			return i + 400;
	}
	return -1;
}

stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
	static
	    args,
	    str[144];

	if ((args = numargs()) == 3)
	{
	    SendClientMessage(playerid, color, text);
	}
	else
	{
		while (--args >= 3)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2
			#emit ADD.C 12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S text
		#emit PUSH.C 144
		#emit PUSH.C str
		#emit PUSH.S 8
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		SendClientMessage(playerid, color, str);

		#emit RETN
	}
	return 1;
}

forward AntiSpawnFinish(playerid);
public AntiSpawnFinish(playerid)
{
   SetPlayerHealth(playerid, 100);
   return 1;
}

forward DelVeh(vehicleid);
public DelVeh(vehicleid)
{
   DestroyVehicle(vehicleid);
   return 1;
}

stock IsACBUGWeapon(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        new wID = GetPlayerWeapon ( playerid ) ;
        if (wID == 24 || wID == 25 || wID == 27 || wID == 34 ) return 1 ;
    }
    return 0 ;
}
