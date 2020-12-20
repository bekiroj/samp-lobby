public OnPlayerConnect(playerid)
{
    new query2[128], ip[24];
    GetPlayerIp(playerid, ip, 24);
    format(query2, sizeof(query2), "SELECT * FROM `bans` WHERE Ip = '%s'", ip);
    mysql_tquery(mysqlC, query2, "YasaklilarYukle", "d", playerid);
    
    new query[128], isim[24];
    GetPlayerName(playerid, isim, 24);
    format(query, sizeof(query), "SELECT * FROM `accounts` WHERE Name = '%s'", isim);
    mysql_tquery(mysqlC, query, "OyuncuYukle", "d", playerid);
    
    SetPlayerColor(playerid,0xA5A5A5AA);
    PlayerData[playerid][pOnline] = 0;
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new query[128], isim[24];
    GetPlayerName(playerid, isim, 24);
    new admin = PlayerData[playerid][pAdmin];
    new skin = PlayerData[playerid][pSkin];
    format(query, sizeof(query),"UPDATE `accounts` SET `Admin`='%d',`Skin`='%d',`Skor`='%d' WHERE `Name`='%s'",admin,skin,GetPlayerScore(playerid),isim);
    mysql_query(mysqlC, query);
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    SendDeathMessage(killerid, playerid, reason);
    if (killerid != INVALID_PLAYER_ID)
    {
        if (PlayerData[killerid][pDM] == 1)
		{
        	SetPlayerScore(killerid, GetPlayerScore(killerid) + 1);
        }
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
    if (PlayerData[playerid][pDM] == 1)
	{
	    new skin = PlayerData[playerid][pSkin];
    	new Random = random(sizeof(DMRandomSpawns));
	    SetPlayerPos(playerid, DMRandomSpawns[Random][0], DMRandomSpawns[Random][1], DMRandomSpawns[Random][2]);
	    SetPlayerInterior(playerid, 3);
	    
	    SetPlayerHealth(playerid, 100.0);
		SetPlayerArmour(playerid, 100.0);
	    SetPlayerSkin(playerid, skin);
	    ResetPlayerWeapons(playerid);
	    
    	GivePlayerWeapon(playerid, 24, 9999);
		GivePlayerWeapon(playerid, 25,9999);
    }
    if (PlayerData[playerid][pFR] == 1)
	{
	    SetTimerEx("AntiSpawnFinish", 3000, false, "i", playerid);
	    
	    new skin = PlayerData[playerid][pSkin];
		SetPlayerPos(playerid, 1129.025, -1465.072, 15.465);
	    SetPlayerInterior(playerid, 0);

 	    SetPlayerSkin(playerid, skin);
 	    SetPlayerArmour(playerid, 0);
        SetPlayerHealth(playerid, 999999);
        
        ResetPlayerWeapons(playerid);
    }
    if (PlayerData[playerid][pLobby] == 1)
	{
	    new skin = PlayerData[playerid][pSkin];
        SetPlayerPos(playerid,1387.936, -26.477, 1002);
        SetPlayerFacingAngle(playerid, 90.0);
        
        SetPlayerHealth(playerid, 999999);
        SetPlayerSkin(playerid, skin);
        ResetPlayerWeapons(playerid);
    }
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & 512 && IsPlayerInAnyVehicle(playerid))
	    {
	        SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
	        RepairVehicle(GetPlayerVehicleID(playerid));
	        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
 		}
    if((IsACBUGWeapon(playerid) && RELEASED(KEY_FIRE)) && newkeys != KEY_FIRE && newkeys & KEY_CROUCH)
    	{
        	ApplyAnimation ( playerid , "PED" , "getup" , 4.1 , 0 , 0 , 0 , 0 , 0 ) ;
        	ChatBox(playerid, "C-Bug yapmak yasak!");
    	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    SetTimerEx("DelVeh", 2500, false, "i", vehicleid);
	return 1;
}
