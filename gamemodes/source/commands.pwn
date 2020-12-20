public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success) SendClientMessage(playerid, 0xFF0000FF, "[Hata] {FFFFFF}Ge�ersiz bir komut girdiniz.");
    return 1;
}
CMD:skin(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
	new skin;
	if(sscanf(params, "i", skin)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan] {FFFFFF}/skin id ");
	if(strval(params) < 0 || strval(params) > 311) return 1;
	SetPlayerSkin(playerid, skin);
	PlayerData[playerid][pSkin] = skin;
	return 1;
}
CMD:time(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    new time;
   	if(sscanf(params,"i", time)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan] {FFFFFF}/time [time] ");
    if((time < 0) || (time > 24)) return 1;
    SetPlayerTime(playerid, time,0);
    return 1;
}
CMD:weather(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    new weather;
   	if(sscanf(params,"i", weather)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan�m] {FFFFFF}/weather id ");
    if((weather < 0) || (weather > 100)) return 1;
    SetPlayerWeather(playerid, weather);
    return 1;
}
CMD:gotopos(playerid,params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
	new intid,Float:pos[3];
	if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");
	if (sscanf(params, "ifff",intid,pos[0],pos[1],pos[2])) return SendClientMessage(playerid, 0xCCCC99FF, "/gotopos [INT ID] [X] [Y] [Z]");
	SetPlayerInterior(playerid,intid);
	SetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	return 1;
}
CMD:sethp(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid,
        Float:amount;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");

    if (sscanf(params, "uf", userid, amount))
        return SendClientMessage(playerid, 0xCCCC99FF, "/sethp [id/isim] [de�er]");
        
    ChatBox(playerid, "%s isimli oyuncunun can de�erini (%d) olarak de�i�tirdiniz.",getName(userid),amount);
    SetPlayerHealth(userid, amount);
    return 1;
}
CMD:setscore(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid,
        amount;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");

    if (sscanf(params, "uf", userid, amount))
        return SendClientMessage(playerid, 0xCCCC99FF, "/setscore [id/isim] [de�er]");

    SetPlayerScore(userid, amount);
    ChatBox(playerid, "%s isimli oyuncunun skorunu (%d) olarak de�i�tirdiniz.",getName(userid),amount);
    return 1;
}
CMD:givemoney(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid,
        amount;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");

    if (sscanf(params, "uf", userid, amount))
        return SendClientMessage(playerid, 0xCCCC99FF, "/givemoney [id/isim] [de�er]");

    GivePlayerMoney(userid, amount);
    ChatBox(playerid, "%s isimli oyuncunun paras�n� (%d) olarak de�i�tirdiniz.",getName(userid),amount);
    return 1;
}
CMD:isinlan(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid;

    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
        
    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
        
    if (PlayerData[playerid][pFR] == 1)
	{
    	if (sscanf(params, "u", userid))
        	return SendClientMessage(playerid, 0xCCCC99FF, "/goto [id/isim]");

		SendPlayerToPlayer(playerid, userid);
		ChatBox(playerid, "%s isimli oyuncuya ���nland�n�z.",getName(userid));
    }
    return 1;
}
CMD:adminver(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");
    new isim[24];
    GetPlayerName(userid, isim, 24);
    new isim2[24];
    GetPlayerName(playerid, isim2, 24);
    PlayerData[userid][pAdmin] = 1;
    ChatBox(playerid, "%s isimli oyuncuyu yetkili yapt�n�z.",getName(userid));
    ChatBox(userid, "%s isimli yetkili sizi yetkili yapt�.",getName(playerid));
    AdminMessage(COLOR_RED, "ADM: %s (%d) adl� yetkili %s (%d) adl� ki�iye yetki verdi.",isim,playerid,isim2,userid);
    return 1;
}
CMD:adminal(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");
    new isim[24];
    GetPlayerName(userid, isim, 24);
    new isim2[24];
    GetPlayerName(playerid, isim2, 24);
    PlayerData[userid][pAdmin] = 0;
    ChatBox(playerid, "%s isimli oyuncunun yetkisini ald�n�z.",getName(userid));
    ChatBox(userid, "%s isimli yetkili yetkinizi ald�.",getName(playerid));
    AdminMessage(COLOR_RED, "ADM: %s (%d) adl� yetkili %s (%d) adl� ki�inin yetkisini ald�.",isim,playerid,isim2,userid);
    return 1;
}
CMD:chattemizle(playerid) {
	if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
    for(new a; a < 35; a++) SendClientMessage(playerid, -1, "");
    return 1;
}
CMD:health(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");

    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    SetPlayerHealth(playerid, 100);
    ChatBox(playerid, "Can�n�z� yeniden doldurdunuz.");
    return 1;
}
CMD:armor(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");

    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    SetPlayerArmour(playerid, 100.0);
    ChatBox(playerid, "Z�rh�n�z� yeniden doldurdunuz.");
    return 1;
}
CMD:komutlar(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");

    SendClientMessage(playerid, -1, ""C9"/lobby, /chattemizle, /time, /skin, /weather, /flip, /weptemizle");
    SendClientMessage(playerid, -1, ""C9"/wep, /veh, /jetpack, ,/cred, /cwhite, /cblue, /isinlan, /setvw");
    SendClientMessage(playerid, -1, ""C9"/health, /armor, /report, /pm, /adminkomutlar");
    return 1;
}
CMD:weptemizle(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    ChatBox(playerid, "Silahlar�n�z� s�f�rlad�n�z.");
    ResetPlayerWeapons(playerid);
    return 1;
}
CMD:adminkomutlar(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
	if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");
    SendClientMessage(playerid, -1, ""C9"/sethp, /givemoney, /time, /setscore, /slap, /adminver, /adminal");
    SendClientMessage(playerid, -1, ""C9"/gotopos, /dl, /spec, /kick, /ban, /unban");
    return 1;
}
CMD:lobby(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    new vehicleid = GetPlayerVehicleID(playerid);
	if (IsEngineVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu ara�ta kullanamazs�n !");
    ShowPlayerDialog(playerid, 3, DIALOG_STYLE_LIST, "Lobby", "Lobby\nDeathmatch\nFreeroam", "Select!", "Close");
    return 1;
}
CMD:wep(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "Weapons", "Colt 45 \nDesert Eagle \nShotgun \nSawnoff Shotgun \nCombat Shotgun \nUZI\nTec9 \nMP5 \nAK-47 \nM4 \nSniper Rifle ", "Select!", "Close");
	return 1;
}
CMD:jetpack(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
 	new vehicleid = GetPlayerVehicleID(playerid);
	if (IsEngineVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu ara�ta kullanamazs�n !");
 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    return 1;
}
CMD:flip(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
 	new vehicleid = GetPlayerVehicleID(playerid);
	if (!IsEngineVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu ara�ta kullanabilirsiniz !");
	FlipVehicle(vehicleid);
    return 1;
}
CMD:cred(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");

	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    SetPlayerColor(playerid,0xC50000AA);
    return 1;
}
CMD:cblue(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");

	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    SetPlayerColor(playerid,0x0006C5AA);
    return 1;
}
CMD:cwhite(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");
    SetPlayerColor(playerid,0xF0F0F0AA);
    return 1;
}
CMD:slap(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");

    if (sscanf(params, "u", userid))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan�m] {FFFFFF}/slap id ");

    static
        Float:px,
        Float:py,
        Float:pz;

    GetPlayerPos(userid, px, py, pz);
    SetPlayerPos(userid, px, py, pz + 5);
    PlayerPlaySound(userid, 1130, 0.0, 0.0, 0.0);
    return 1;
}
CMD:spec(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
	if (PlayerData[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Yeterli yetkiniz yok !");
    new id;
    if (sscanf(params, "u", id)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan�m] {FFFFFF}/sped id ");
    if (id == playerid) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Kendini izleyemezsin !");
    if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
    {
        GetPlayerPos(playerid, specPos[playerid][0], specPos[playerid][1], specPos[playerid][2]);
        SetPVarInt(playerid, "specVw", GetPlayerVirtualWorld(playerid));
        SetPVarInt(playerid, "specInterior", GetPlayerInterior(playerid));
    }
    SetPlayerInterior(playerid, GetPlayerInterior(id));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
    TogglePlayerSpectating(playerid, true);
    if (IsPlayerInAnyVehicle(id))
    {
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));
    }
    else
    {
        PlayerSpectatePlayer(playerid, id);
    }
    SendClientMessage(playerid, 0xCCCC99FF, "[Kullan�m] {FFFFFF}��kmak i�in /specoff ");
	return 1;
}
CMD:specoff(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Yeterli yetkiniz yok !");

    IzlemeBitir(playerid);
    return 1;
}
CMD:kick(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");

    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");

    if (sscanf(params, "u]", userid))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan�m] {FFFFFF}/kick (id) ");
        
    ChatBox(playerid, "%s isimli yetkili taraf�ndan sunucudan at�ld�n�z.",getName(userid));
    Kick(userid);
    AdminMessage(COLOR_RED, "ADM: %s (%d) adl� yetkilii %s (%d) adl� oyuncuyu sunucudan att�.",getName(userid),playerid,getName(playerid),userid);
    return 1;
}
CMD:report(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid,
        reason[128];

    if (sscanf(params, "us[128]", userid, reason))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan�m] {FFFFFF}/report (id) (sebep) ");

    ChatBox(playerid, "%s isimli oyuncuyu yetkililere bildirdiniz.",getName(userid));
    AdminMessage(COLOR_RED, "ADM: %s (%d) adl� ki�i %s (%d) adl� ki�iyi rapor etti.",getName(playerid) ,playerid,getName(userid),userid);
    AdminMessage(COLOR_RED, "ADM: Gerek�e: %s.",reason);
    return 1;
}
CMD:ban(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        userid;
    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");

    if (sscanf(params, "u]", userid))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan�m] {FFFFFF}/ban (id) ");
        
    new query[128], ip[24], isim[24];
    GetPlayerIp(userid, ip, 24);
    GetPlayerName(playerid, isim, 24);
    format(query, sizeof(query), "INSERT INTO `bans` (`Ip`, `Name`) VALUES ('%s', '%s')", ip, isim);
    mysql_query(mysqlC, query);
    ChatBox(userid, "Sunucudan yasakland�n�z.");
    Kick(userid);
    AdminMessage(COLOR_RED, "ADM: %s (%d) adl� ki�i %s (%d) adl� ki�iyi sunucudan yasaklad�.",getName(playerid),playerid,getName(userid),userid);
    return 1;
}
CMD:unban(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in giri� yapmal�s�n�z !");
        
    static
        name;
    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak i�in yetkiniz yok !");

    if (sscanf(params, "u]", name))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan�m] {FFFFFF}/unban (isim) ");
        
    new query[128];
    format(query, sizeof(query), "DELETE FROM `bans` WHERE `Name` = '%s'", name);
    mysql_query(mysqlC, query);
    
    AdminMessage(COLOR_RED, "ADM: %s (%d) adl� yetkili %s adl� oyuncunun yasaklamas�n� kald�rd�.", getName(playerid) , playerid, name);
    return 1;
}
CMD:veh(playerid, params[])
{
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");

    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmal�s�n�z !");

	new car[15], carid;
	if(sscanf(params,"s[15]",car)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan] {FFFFFF}/veh [model ID/name]");
	if(IsNumeric(car))
	{
		if(strval(car) < 400 || strval(car) > 611) return SendClientMessage(playerid, COLOR_RED, "Ge�ersiz model.");
		carid = strval(car);
	}
	else
	{
        carid = GetVehicleModelIDFromName(car);
	}
	new Float:x, Float:y, Float:z, Float:angle, vw;
	new vehid;
	GetPlayerPos(playerid, x, y, z );
	GetPlayerFacingAngle(playerid, angle );
	vehid = CreateVehicle(carid, x, y + 3, z, angle, 0, 0, 200 );
	vw=GetPlayerVirtualWorld(playerid);
	SetVehicleVirtualWorld(vehid, vw);
	PutPlayerInVehicle(playerid,vehid,0);
	return 1;
}
