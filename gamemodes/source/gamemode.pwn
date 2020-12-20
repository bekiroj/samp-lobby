public OnGameModeInit()
{
    SetGameModeText("Deatmatch/Freeroam");
    DisableInteriorEnterExits();
    CreatePickup(1239, 23, 1379.341, -26.426, 1000.600);
    Create3DTextLabel("/lobby", 0xF0F0F0AA, 1379.341, -26.426, 1000.600, 10.0, 0, 0);
    SetVehiclePassengerDamage(true);
    SetDisableSyncBugs(true);
    mysqlC = mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DB);
    if(mysql_errno(mysqlC) == 0)
    {
        print("MySQL baðlantýsý kuruldu!");
    }
    else
    {
        print("MySQL baðlanýtýsý baþarýsýz!!");
    }
    return 1;
}
