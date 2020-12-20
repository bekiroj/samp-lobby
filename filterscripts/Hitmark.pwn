#define FILTERSCRIPT

#include <a_samp>

#if defined FILTERSCRIPT

new Text:HitMark;

public OnFilterScriptInit()
{
  HitMark = TextDrawCreate(339.000000, 172.000000, "X");
  TextDrawAlignment(HitMark, 2);
  TextDrawBackgroundColor(HitMark, 255);
  TextDrawFont(HitMark, 2);
  TextDrawLetterSize(HitMark, 0.259999, 1.299998);
  TextDrawColor(HitMark, -1);
  TextDrawSetOutline(HitMark, 0);
  TextDrawSetProportional(HitMark, 0);
  TextDrawSetShadow(HitMark, 1);
  TextDrawSetSelectable(HitMark, 0);
  
  return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    TextDrawShowForPlayer(playerid, HitMark);
    SetTimerEx("HitRemove", 300, false, "i", playerid);
    PlayerPlaySound(playerid,17802,0.0,0.0,0.0);
    return 1;
}

forward HitRemove(playerid);
public HitRemove(playerid)
{
  TextDrawHideForPlayer(playerid, HitMark);
  return 1;
}

#endif
