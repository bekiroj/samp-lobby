public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success) SendClientMessage(playerid, 0xFF0000FF, "[Hata] {FFFFFF}Geçersiz bir komut girdiniz.");
    return 1;
}
CMD:skin(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
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
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    new time;
   	if(sscanf(params,"i", time)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan] {FFFFFF}/time [time] ");
    if((time < 0) || (time > 24)) return 1;
    SetPlayerTime(playerid, time,0);
    return 1;
}
CMD:weather(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    new weather;
   	if(sscanf(params,"i", weather)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullaným] {FFFFFF}/weather id ");
    if((weather < 0) || (weather > 100)) return 1;
    SetPlayerWeather(playerid, weather);
    return 1;
}
CMD:gotopos(playerid,params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
	new intid,Float:pos[3];
	if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");
	if (sscanf(params, "ifff",intid,pos[0],pos[1],pos[2])) return SendClientMessage(playerid, 0xCCCC99FF, "/gotopos [INT ID] [X] [Y] [Z]");
	SetPlayerInterior(playerid,intid);
	SetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	return 1;
}
CMD:sethp(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid,
        Float:amount;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");

    if (sscanf(params, "uf", userid, amount))
        return SendClientMessage(playerid, 0xCCCC99FF, "/sethp [id/isim] [deðer]");
        
    ChatBox(playerid, "%s isimli oyuncunun can deðerini (%d) olarak deðiþtirdiniz.",getName(userid),amount);
    SetPlayerHealth(userid, amount);
    return 1;
}
CMD:setscore(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid,
        amount;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");

    if (sscanf(params, "uf", userid, amount))
        return SendClientMessage(playerid, 0xCCCC99FF, "/setscore [id/isim] [deðer]");

    SetPlayerScore(userid, amount);
    ChatBox(playerid, "%s isimli oyuncunun skorunu (%d) olarak deðiþtirdiniz.",getName(userid),amount);
    return 1;
}
CMD:givemoney(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid,
        amount;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");

    if (sscanf(params, "uf", userid, amount))
        return SendClientMessage(playerid, 0xCCCC99FF, "/givemoney [id/isim] [deðer]");

    GivePlayerMoney(userid, amount);
    ChatBox(playerid, "%s isimli oyuncunun parasýný (%d) olarak deðiþtirdiniz.",getName(userid),amount);
    return 1;
}
CMD:isinlan(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid;

    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
        
    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
        
    if (PlayerData[playerid][pFR] == 1)
	{
    	if (sscanf(params, "u", userid))
        	return SendClientMessage(playerid, 0xCCCC99FF, "/goto [id/isim]");

		SendPlayerToPlayer(playerid, userid);
		ChatBox(playerid, "%s isimli oyuncuya ýþýnlandýnýz.",getName(userid));
    }
    return 1;
}
CMD:adminver(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");
    new isim[24];
    GetPlayerName(userid, isim, 24);
    new isim2[24];
    GetPlayerName(playerid, isim2, 24);
    PlayerData[userid][pAdmin] = 1;
    ChatBox(playerid, "%s isimli oyuncuyu yetkili yaptýnýz.",getName(userid));
    ChatBox(userid, "%s isimli yetkili sizi yetkili yaptý.",getName(playerid));
    AdminMessage(COLOR_RED, "ADM: %s (%d) adlý yetkili %s (%d) adlý kiþiye yetki verdi.",isim,playerid,isim2,userid);
    return 1;
}
CMD:adminal(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");
    new isim[24];
    GetPlayerName(userid, isim, 24);
    new isim2[24];
    GetPlayerName(playerid, isim2, 24);
    PlayerData[userid][pAdmin] = 0;
    ChatBox(playerid, "%s isimli oyuncunun yetkisini aldýnýz.",getName(userid));
    ChatBox(userid, "%s isimli yetkili yetkinizi aldý.",getName(playerid));
    AdminMessage(COLOR_RED, "ADM: %s (%d) adlý yetkili %s (%d) adlý kiþinin yetkisini aldý.",isim,playerid,isim2,userid);
    return 1;
}
CMD:chattemizle(playerid) {
	if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
    for(new a; a < 35; a++) SendClientMessage(playerid, -1, "");
    return 1;
}
CMD:health(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");

    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    SetPlayerHealth(playerid, 100);
    ChatBox(playerid, "Canýnýzý yeniden doldurdunuz.");
    return 1;
}
CMD:armor(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");

    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    SetPlayerArmour(playerid, 100.0);
    ChatBox(playerid, "Zýrhýnýzý yeniden doldurdunuz.");
    return 1;
}
CMD:komutlar(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");

    SendClientMessage(playerid, -1, ""C9"/lobby, /chattemizle, /time, /skin, /weather, /flip, /weptemizle");
    SendClientMessage(playerid, -1, ""C9"/wep, /veh, /jetpack, ,/cred, /cwhite, /cblue, /isinlan, /setvw");
    SendClientMessage(playerid, -1, ""C9"/health, /armor, /report, /pm, /adminkomutlar");
    return 1;
}
CMD:weptemizle(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    ChatBox(playerid, "Silahlarýnýzý sýfýrladýnýz.");
    ResetPlayerWeapons(playerid);
    return 1;
}
CMD:adminkomutlar(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
	if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");
    SendClientMessage(playerid, -1, ""C9"/sethp, /givemoney, /time, /setscore, /slap, /adminver, /adminal");
    SendClientMessage(playerid, -1, ""C9"/gotopos, /dl, /spec, /kick, /ban, /unban");
    return 1;
}
CMD:lobby(playerid) {
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    new vehicleid = GetPlayerVehicleID(playerid);
	if (IsEngineVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu araçta kullanamazsýn !");
    ShowPlayerDialog(playerid, 3, DIALOG_STYLE_LIST, "Lobby", "Lobby\nDeathmatch\nFreeroam", "Select!", "Close");
    return 1;
}
CMD:wep(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "Weapons", "Colt 45 \nDesert Eagle \nShotgun \nSawnoff Shotgun \nCombat Shotgun \nUZI\nTec9 \nMP5 \nAK-47 \nM4 \nSniper Rifle ", "Select!", "Close");
	return 1;
}
CMD:jetpack(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
 	new vehicleid = GetPlayerVehicleID(playerid);
	if (IsEngineVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu araçta kullanamazsýn !");
 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    return 1;
}
CMD:flip(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
 	new vehicleid = GetPlayerVehicleID(playerid);
	if (!IsEngineVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu araçta kullanabilirsiniz !");
	FlipVehicle(vehicleid);
    return 1;
}
CMD:cred(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");

	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    SetPlayerColor(playerid,0xC50000AA);
    return 1;
}
CMD:cblue(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");

	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    SetPlayerColor(playerid,0x0006C5AA);
    return 1;
}
CMD:cwhite(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
	if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
 	if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");
    SetPlayerColor(playerid,0xF0F0F0AA);
    return 1;
}
CMD:slap(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");

    if (sscanf(params, "u", userid))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullaným] {FFFFFF}/slap id ");

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
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
	if (PlayerData[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "[HATA]: Yeterli yetkiniz yok !");
    new id;
    if (sscanf(params, "u", id)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullaným] {FFFFFF}/sped id ");
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
    SendClientMessage(playerid, 0xCCCC99FF, "[Kullaným] {FFFFFF}Çýkmak için /specoff ");
	return 1;
}
CMD:specoff(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Yeterli yetkiniz yok !");

    IzlemeBitir(playerid);
    return 1;
}
CMD:kick(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");

    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");

    if (sscanf(params, "u]", userid))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullaným] {FFFFFF}/kick (id) ");
        
    ChatBox(playerid, "%s isimli yetkili tarafýndan sunucudan atýldýnýz.",getName(userid));
    Kick(userid);
    AdminMessage(COLOR_RED, "ADM: %s (%d) adlý yetkilii %s (%d) adlý oyuncuyu sunucudan attý.",getName(userid),playerid,getName(playerid),userid);
    return 1;
}
CMD:report(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid,
        reason[128];

    if (sscanf(params, "us[128]", userid, reason))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullaným] {FFFFFF}/report (id) (sebep) ");

    ChatBox(playerid, "%s isimli oyuncuyu yetkililere bildirdiniz.",getName(userid));
    AdminMessage(COLOR_RED, "ADM: %s (%d) adlý kiþi %s (%d) adlý kiþiyi rapor etti.",getName(playerid) ,playerid,getName(userid),userid);
    AdminMessage(COLOR_RED, "ADM: Gerekçe: %s.",reason);
    return 1;
}
CMD:ban(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        userid;
    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");

    if (sscanf(params, "u]", userid))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullaným] {FFFFFF}/ban (id) ");
        
    new query[128], ip[24], isim[24];
    GetPlayerIp(userid, ip, 24);
    GetPlayerName(playerid, isim, 24);
    format(query, sizeof(query), "INSERT INTO `bans` (`Ip`, `Name`) VALUES ('%s', '%s')", ip, isim);
    mysql_query(mysqlC, query);
    ChatBox(userid, "Sunucudan yasaklandýnýz.");
    Kick(userid);
    AdminMessage(COLOR_RED, "ADM: %s (%d) adlý kiþi %s (%d) adlý kiþiyi sunucudan yasakladý.",getName(playerid),playerid,getName(userid),userid);
    return 1;
}
CMD:unban(playerid, params[])
{
    if (PlayerData[playerid][pOnline] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için giriþ yapmalýsýnýz !");
        
    static
        name;
    if (PlayerData[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak için yetkiniz yok !");

    if (sscanf(params, "u]", name))
        return SendClientMessage(playerid, 0xCCCC99FF, "[Kullaným] {FFFFFF}/unban (isim) ");
        
    new query[128];
    format(query, sizeof(query), "DELETE FROM `bans` WHERE `Name` = '%s'", name);
    mysql_query(mysqlC, query);
    
    AdminMessage(COLOR_RED, "ADM: %s (%d) adlý yetkili %s adlý oyuncunun yasaklamasýný kaldýrdý.", getName(playerid) , playerid, name);
    return 1;
}
CMD:veh(playerid, params[])
{
    if (PlayerData[playerid][pDM] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");

    if (PlayerData[playerid][pLobby] == 1)
        return SendClientMessage(playerid, COLOR_RED, "[HATA]: Bu komutu kullanmak Freeroam modunda olmalýsýnýz !");

	new car[15], carid;
	if(sscanf(params,"s[15]",car)) return SendClientMessage(playerid, 0xCCCC99FF, "[Kullan] {FFFFFF}/veh [model ID/name]");
	if(IsNumeric(car))
	{
		if(strval(car) < 400 || strval(car) > 611) return SendClientMessage(playerid, COLOR_RED, "Geçersiz model.");
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
