#include <a_samp>
#include <a_mysql>
#include <sscanf2>
#include <zcmd>
#include <foreach>
#include <SKY>
#include <weapon-config>

#define SQL_HOST    "localhost"
#define SQL_USER    "root"
#define SQL_PASS    ""
#define SQL_DB      "database"
new MySQL:mysqlC;

#define RELEASED(%0) \
    (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define C9 "{e1ffc5}"
#define COLOR_RED 0xAA3333AA
#define COLOR_GREY 0xAFAFAFAA
#define ChatBox(%0,%1) \
	SendClientMessageEx(%0, 0x00DD00AA, "[-]{F5F5F5} "%1)

new Float:specPos[MAX_PLAYERS][3];

enum pData
{
	pAdmin,
    pOnline,
	pDM,
	pFR,
	pLobby,
	pSkin,
	pCar
}
new PlayerData[MAX_PLAYERS][pData];

new Float:DMRandomSpawns[][] =
{
    {245.080, 146.087, 1002.538},
    {215.152, 142.488, 1002.538},
    {213.511, 158.288, 1002.538},
    {194.430, 157.773, 1002.538},
    {195.346, 179.078, 1002.539},
    {219.012, 179.270, 1002.546},
    {231.294, 167.896, 1002.538},
    {243.965, 195.730, 1007.686},
    {268.412, 186.456, 1007.686},
    {288.389, 191.349, 1006.686},
    {294.990, 183.243, 1006.686},
    {274.981, 185.144, 1006.686},
    {296.815, 172.785, 1006.686},
    {278.181, 174.364, 1006.686},
    {254.846, 172.761, 1002.538}
};

new VehicleNames[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

new RandomColor[][] =
{
    {0xFF0A0AAA},
    {0x0A12FFAA},
    {0xFFF60AAA},
    {0x00C506AA},
    {0xFFFFFFAA},
    {0x0AFFFFAA}
};

#include "source/commands.pwn"
#include "source/gamemode.pwn"
#include "source/publics.pwn"
#include "source/dialogs.pwn"
#include "source/local.pwn"
main(){}
