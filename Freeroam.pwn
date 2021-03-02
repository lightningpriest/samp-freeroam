/*

______          _           _    ______                                       
| ___ \        (_)         | |   |  ___|                                      
| |_/ / __ ___  _  ___  ___| |_  | |_ _ __ ___  ___ _ __ ___   __ _ _ __ ___  
|  __/ '__/ _ \| |/ _ \/ __| __| |  _| '__/ _ \/ _ \ '__/ _ \ / _` | '_ ` _ \ 
| |  | | | (_) | |  __/ (__| |_  | | | | |  __/  __/ | | (_) | (_| | | | | | |
\_|  |_|  \___/| |\___|\___|\__| \_| |_|  \___|\___|_|  \___/ \__,_|_| |_| |_|
              _/ |                                                            
             |__/                                                Version: 1.0                                                     
    Credits:
    Developer - sold1er (github.com/prrssr)

	100% Created from Scratch.
	Contact me if you wanna ask something or read the documentation first.

	Discord: prrssr#5555
	Email: contact@prrssr.tk
*/

#include <a_samp>
#include <a_mysql>
#include <bcrypt>
#include <zcmd>
#include <easyDialog>
#include <sscanf2>

#define	BCRYPT_COST	12

#define MYSQL_HOSTNAME		"localhost"
#define MYSQL_USERNAME		"root"
#define MYSQL_PASSWORD		""
#define MYSQL_DATABASE		"project2"

#define SERVER_NAME 	 "[0.3-DL] Project Freeroam"
#define SERVER_URL 		 "www.projectfreeroam.tk"
#define SERVER_REVISION  "PFR - v1.0"

#define DIALOG_VEHICLES (5) 

#define COLOR_RED           (0xFF0000FF)
#define COLOR_PINK          (0xFFC0CBFF)
#define COLOR_PURPLE        (0xA020F0FF)
#define COLOR_BLUE          (0x0000FFFF)
#define COLOR_GREEN         (0x00FF00FF)
#define COLOR_YELLOW        (0xFFFF00FF)
#define COLOR_BLACK         (0x000000FF)
#define COLOR_ORANGE        (0xFFA500FF)
#define COLOR_ICE           (0x03F2FFFF)
#define COLOR_LIME          (0x00FF40FF)
#define COLOR_GREY          (0x383838FF)
#define COLOR_WHITE         (0xFFFFFFFF)


new
	MySQL: Database,
	bool:LoggedIn[MAX_PLAYERS]
;

new Text:SPEEDOS[MAX_PLAYERS];

new playerColors[MAX_PLAYERS] = {
0x000000FF,
0xFFFFFFFF,
0x008000FF,
0xFF0000FF,
0x800080FF,
0xFFFF00FF,
0x0000FFFF,
0x800000FF,
0x000080FF,
0x21421EFF,
0x3D2B1FFF,
0x00008BFF,
0x8B0000FF,
0x082567FF,
0x92000AFF,
0x800020FF,
0x191970FF,
0x120A8FFF,
0x960018FF,
0x483C32FF,
0x7B3F00FF,
0x6D351AFF,
0x704214FF,
0x3B444BFF,
0x2F4F4FFF,
0x4B0082FF,
0x0000CDFF,
0x228B22FF,
0x464646FF,
0x80461BFF,
0x8B4513FF,
0xB31B1BFF,
0x534B4FFF,
0x556B2FFF,
0x0047ABFF,
0x614051FF,
0xB22222FF,
0x79443BFF,
0xA52A2AFF,
0x702963FF,
0x4D5D53FF,
0xCF1020FF,
0x00FF00FF,
0xC04000FF,
0x808000FF,
0x008080FF,
0xB7410EFF,
0x893F45FF,
0x483D8BFF,
0x2E8B57FF,
0x00A86BFF,
0x008B8BFF,
0x8B008BFF,
0xC41E3AFF,
0x6B8E23FF,
0xA0522DFF,
0x007BA7FF,
0xFF2400FF,
0xDC143CFF,
0x40826DFF,
0x32CD32FF,
0x1560BDFF,
0x0BDA51FF,
0x696969FF,
0x3FFF00FF,
0xE32636FF,
0xFF4500FF,
0xEC5800FF,
0xB8860BFF,
0xE30B5CFF,
0xE0115FFF,
0xE34234FF,
0xD2691EFF,
0xE34234FF,
0xB87333FF,
0xE52B50FF,
0x3CB371FF,
0xC71585FF,
0xC71585FF,
0xCC7722FF,
0x9400D3FF,
0x738678FF,
0xDE3163FF,
0xE3256BFF,
0x7BA05BFF,
0xF28500FF,
0x7CFC00FF,
0x20B2AAFF,
0x4682B4FF,
0xCD7F32FF,
0x7FFF00FF,
0xFF007FFF,
0x00FF7FFF,
0x808080FF,
0x708090FF,
0xCD5C5CFF,
0xCD5C5CFF,
0xFF8C00FF,
0x4169E1FF,
0xFF7518FF,
0xE49B0FFF,
0x50C878FF,
0xCD853FFF,
0x6A5ACDFF,
0x00FA9AFF,
0x8A2BE2FF,
0x9932CCFF,
0x778899FF,
0x9ACD32FF,
0xB5A642FF,
0x5F9EA0FF,
0x00CED1FF,
0xDAA520FF,
0xFFA500FF,
0xFF1493FF,
0xFF6347FF,
0x1E90FFFF,
0x00DDDDFF,
0xFFBF00FF,
0x00BFFFFF,
0xC19A6BFF,
0x9AB973FF,
0x9966CCFF,
0x30D5C8FF,
0xFF7F50FF,
0x7B68EEFF,
0xFFD700FF,
0x8FBC8FFF,
0xBC8F8FFF,
0xADFF2FFF,
0x9370D8FF,
0xD87093FF,
0x66CDAAFF,
0xBDB76BFF,
0xBA55D3FF,
0xD1E231FF,
0x48D1CCFF,
0x6495EDFF,
0xF4C430FF,
0xFA8072FF,
0xCC8899FF,
0xF08080FF,
0xC2B280FF,
0xFDE910FF,
0xF4A460FF,
0xE9967AFF,
0xA9A9A9FF,
0x00FFFFFF,
0x00FFFFFF,
0xFF00FFFF,
0xFF00FFFF,
0xFF9966FF,
0x90EE90FF,
0xD2B48CFF,
0xFFA07AFF,
0xFF69B4FF,
0xDEB887FF,
0xDA70D6FF,
0x98FB98FF,
0xC8A2C8FF,
0xFFDB58FF,
0xACE1AFFF,
0xC0C0C0FF,
0x87CEEBFF,
0xFBEC5DFF,
0xFBEC5DFF,
0xC9A0DCFF,
0xEEDC82FF,
0xF0DC82FF,
0x87CEFAFF,
0xDF73FFFF,
0x7FFFD4FF,
0xB0C4DEFF,
0xDDA0DDFF,
0xEE82EEFF,
0xF0E68CFF,
0xFFCC99FF,
0xADD8E6FF,
0xD8BFD8FF,
0xFFB6C1FF,
0xB0E0E6FF,
0xD3D3D3FF,
0xFBCEB1FF,
0xEEE8AAFF,
0xFADFADFF,
0xF5DEB3FF,
0xFFDEADFF,
0xFFC0CBFF,
0xAFEEEEFF,
0xE0B0FFFF,
0xFFDAB9FF,
0xDCDCDCFF,
0xCCCCFFFF,
0xFFE4B5FF,
0xFFE5B4FF,
0xFFE4C4FF,
0xE5E4E2FF,
0xF7E7CEFF,
0xFFEBCDFF,
0xFAEBD7FF,
0xFFEFD5FF,
0xFFE4E1FF,
0xF5F5DCFF,
0xE6E6FAFF,
0xFFFACDFF,
0xFAFAD2FF,
0xFFFDD0FF,
0xFAF0E6FF,
0xFFF8DCFF,
0xFDF5E6FF,
0xE0FFFFFF,
0xFFFFE0FF,
0xF0FFF0FF,
0xF5F5F5FF,
0xFFF5EEFF,
0xFFF0F5FF,
0xF0F8FFFF,
0xFFFAF0FF,
0xF8F4FFFF,
0xF0FFFFFF,
0xFFFFF0FF,
0xF5FFFAFF,
0xF8F8FFFF,
0xFFFAFAFF,
0x006400FF
};

enum PlayerData
{
	user_id,
	user_cash,
	user_kills,
	user_deaths
};

static const VehicleName[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch",
	"Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi",
	"Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee","Predator",
	"Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo","RC Bandit", "Romero",
	"Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder","Reefer","Tropic","Flatbed",
	"Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler",
	"ZR-350","Walton","Regina","Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper",
	"Rancher","FBI Rancher","Virgo","Greenwood","Jetmax","Hotring Racer","Sandking","Blista Compact","Police Maverick",
	"Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT",
	"Elegant","Journey","Bike","Mountain Bike","Beagle","Cropduster","Stuntplane","Tanker","Road Train","Nebula","Majestic",
	"Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV-1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent",
	"Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility",
	"Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger",
	"Flash","Tahoma","Savanna","Bandito","Freight","Trailer","Kart","Mower","Duneride","Sweeper","Broadway",
	"Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer","Emperor","Wayfarer",
	"Euros","Hotdog","Club","Trailer","Trailer","Andromada","Dodo","RCCam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A",
	"Luggage Trailer B","Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};


#define GetVehicleName(%0) VehicleName[GetVehicleModel(%0)-400]
#define GetVehicleModelName(%0) VehicleName[%0-400]

stock randomEx(minnum = cellmin, maxnum = cellmax)
{
	return random(maxnum - minnum + 1) + minnum;
}

stock SpawnVehicleInFrontOfPlayer(playerid, vehiclemodel, color1, color2)
{
	new Float:x,Float:y,Float:z;
	new Float:facing;
	new Float:distance;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, facing);

    new Float:size_x,Float:size_y,Float:size_z;
	GetVehicleModelInfo(vehiclemodel, VEHICLE_MODEL_INFO_SIZE, size_x, size_y, size_z);

	distance = size_x + 0.5;

  	x += (distance * floatsin(-facing, degrees));
    y += (distance * floatcos(-facing, degrees));

    facing += 90.0;
	if(facing > 360.0) facing -= 360.0;

	return CreateVehicle(vehiclemodel, x, y, z + (size_z * 0.25), facing, color1, color2, -1);
}

new PlayerInfo[MAX_PLAYERS][PlayerData];

main() { }

public OnGameModeInit()
{
	Database = mysql_connect(MYSQL_HOSTNAME, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE);
	if(Database == MYSQL_INVALID_HANDLE || mysql_errno(Database) != 0)
	{
		print("SERVER: [MySQL Connection] Failed");
		SendRconCommand("exit");
		return 1;
	}
	new rcon[80];
	format(rcon, sizeof(rcon), "hostname %s", SERVER_NAME);
	SendRconCommand(rcon);
	format(rcon, sizeof(rcon), "weburl %s", SERVER_URL);
	SendRconCommand(rcon);
	SetGameModeText(SERVER_REVISION);
	print("SERVER: [MySQL Connection] Connected.");
	return 1;
}

public OnPlayerConnect(playerid)
{
	new query[200];
	mysql_format(Database, query, sizeof(query), "SELECT * FROM `players` WHERE `Username` = '%e'", GetName(playerid));
	mysql_tquery(Database, query, "CheckAccount", "d", playerid);

	SetPlayerColor(playerid, playerColors[playerid % sizeof playerColors]);

	SetPlayerCameraPos(playerid, 2089.5100,1967.3738,99.8420);
	SetPlayerCameraLookAt(playerid, 2089.5100,1967.3738,99.8420);

	SPEEDOS[playerid] = TextDrawCreate(10.0,200.0," ");
    TextDrawShowForPlayer(playerid,SPEEDOS[playerid]);
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new vehicleid,Float:speed_x,Float:speed_y,Float:speed_z,Float:final_speed,speed_string[256],final_speed_int;
	vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid != 0)
	{
		GetVehicleVelocity(vehicleid,speed_x,speed_y,speed_z);
		final_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*136.666667;
		final_speed_int = floatround(final_speed,floatround_round);
		format(speed_string,256,"Speed: %i",final_speed_int);
		TextDrawSetString(SPEEDOS[playerid], speed_string);
	}
	else
	{
		TextDrawSetString(SPEEDOS[playerid], " ");
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
    SetPlayerSkin(playerid, 299);
	SetPlayerArmour(playerid, 100.0);
	GivePlayerMoney(playerid, 99999999);
    return 1;
}

public OnPlayerDisconnect(playerid)
{
	new query[200];
	mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `Cash` = '%i', `Kills` = '%i', `Deaths` = '%i' WHERE `ID` = '%i'", PlayerInfo[playerid][user_cash], PlayerInfo[playerid][user_kills], PlayerInfo[playerid][user_deaths], PlayerInfo[playerid][user_id]);
	mysql_query(Database, query);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    SendDeathMessageToPlayer(playerid, killerid, playerid, reason);
    return 1;
}

forward CheckAccount(playerid);
public CheckAccount(playerid)
{
	new string[300];
	if(cache_num_rows())
	{
		format(string, sizeof(string), "{FFFFFF}Welcome back, {00EEFF}%s.{FFFFFF}\nPlease input your password below to login.", GetName(playerid));
		Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login - Project Freeroam", string, "Login", "Quit");
	}
	else
	{
		format(string, sizeof(string), "{FFFFFF}Welcome to our server, {00EEFF}%s.{FFFFFF}\nPlease type a strong password below to continue.", GetName(playerid));
		Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register - Project Freeroam", string, "Register", "Quit");
	}
	return 1;
}

Dialog:DIALOG_REGISTER(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordHashed", "d", playerid);
	}
	else
		Kick(playerid);
	return 1;
}

Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[300], Password[BCRYPT_HASH_LENGTH];
		mysql_format(Database, query, sizeof(query), "SELECT `Password` FROM `players` WHERE `Username` = '%e'", GetName(playerid));
		mysql_query(Database, query);
		cache_get_value_name(0, "Password", Password, BCRYPT_HASH_LENGTH);
		bcrypt_check(inputtext, Password, "OnPasswordChecked", "d", playerid);
	}
	else
		Kick(playerid);
	return 1;
}

forward OnPasswordHashed(playerid);
public OnPasswordHashed(playerid)
{
	new hash[BCRYPT_HASH_LENGTH], query[300];
	bcrypt_get_hash(hash);
	mysql_format(Database, query, sizeof(query), "INSERT INTO `players` (`Username`, `Password`, `IPAddress`, `Cash`, `Kills`, `Deaths`) VALUES ('%e', '%e', '%e', 0, 0, 0)", GetName(playerid), hash, ReturnIP(playerid));
	mysql_tquery(Database, query, "OnPlayerRegister", "d", playerid);
	return 1;
}

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
	SpawnPlayer(playerid);
	SendClientMessage(playerid, -1, "{ADDBE6}SERVER: {FFFFFF}You have been successfully registered in our server.");
	return 1;	
}

forward OnPasswordChecked(playerid);
public OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();
	if(match)
	{
		new query[300];
		mysql_format(Database, query, sizeof(query), "SELECT * FROM `players` WHERE `Username` = '%e'", GetName(playerid));
		mysql_tquery(Database, query, "OnPlayerLoad", "d", playerid);
	}
	else
	{
		new string[100];
		format(string, sizeof(string), "Wrong Password!\nPlease type your correct password below.");
		Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login to our server", string, "Register", "Dip");
	}
	return 1;
}

forward OnPlayerLoad(playerid);
public OnPlayerLoad(playerid)
{
	cache_get_value_name_int(0, "ID", PlayerInfo[playerid][user_id]);
	cache_get_value_name_int(0, "Cash", PlayerInfo[playerid][user_cash]);
	cache_get_value_name_int(0, "Kills", PlayerInfo[playerid][user_kills]);
	cache_get_value_name_int(0, "Deaths", PlayerInfo[playerid][user_deaths]);

	LoggedIn[playerid] = true;
	SendClientMessage(playerid, -1, "{ADDBE6}SERVER: {FFFFFF}Welcome to {FF0000}Project Freeroam.");
    SendClientMessage(playerid, -1, "{ADDBE6}SERVER: {FFFFFF}Use {FFFF00}/help {FFFFFF}to view server commands.");
    SpawnPlayer(playerid);
	return 1;
}

CMD:changepassword(playerid, params[])
{
	new string[128];
	format(string, sizeof(string), "{FFFFFF}Password Change\nInput the new password you want to have for your account.");
	Dialog_Show(playerid, DIALOG_PASSWORDCHANGE, DIALOG_STYLE_PASSWORD, "Change your password", string, "Change", "Close");
	return 1;
}

Dialog:DIALOG_PASSWORDCHANGE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordChanged", "i", playerid);
	}
	return 1;
}


CMD:help(playerid, params[])
{
	SendClientMessage(playerid, -1, "{ADDBE6}**HELP**: {FFFFFF}/veh, /skin, /jetpack, /godmode, /suicide, /repair, /nitro, /pm");
	SendClientMessage(playerid, -1, "{ADDBE6}**HELP**: {FFFFFF}/vehgodmode");
    return 1;
}

CMD:suicide(playerid, params[])
{
   SetPlayerHealth(playerid, 0.0);
   return 1;
}

CMD:nitro(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	AddVehicleComponent(vehicleid, 1010);
	SendClientMessage(playerid, -1, "{ADDBE6}NITRO: {FFFFFF}Nitro {00FF00}installed.");
	return 1;
}

CMD:vehgodmode(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	SetVehicleHealth(vehicleid, 99999);
	SendClientMessage(playerid, COLOR_WHITE, "{ADDBE6}VEHICLE GODMODE: {FFFFFF}Vehicle Godmode {00FF00}enabled.");
	return 1;
}

CMD:repair(playerid, params[])
{
	RepairVehicle(GetPlayerVehicleID(playerid));
	return 1;
}

CMD:pm(playerid, params[])
{
	new
	    iTarget,
	    szMsg[ 100 ];

	if (sscanf(params, "rs[100]", iTarget, szMsg))
	{
		return SendClientMessage(playerid, COLOR_GREY, "USAGE: /pm [id/nickname] [message]");
	}
	
	if (iTarget == INVALID_PLAYER_ID)
	{
	    return SendClientMessage(playerid, COLOR_GREY, "ERROR: That player is not connected!");
	}
	
	new
	    string[ 128 ];
	new
		pName[ MAX_PLAYER_NAME ],
		tName[ MAX_PLAYER_NAME ];
		
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	GetPlayerName(iTarget, tName, MAX_PLAYER_NAME);
	format(string, sizeof(string), "PM from %s: %s", pName, szMsg);
	SendClientMessage(iTarget, COLOR_YELLOW, string);
	format(string, sizeof (string), "PM to %s: %s", tName, szMsg);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	return true;
}

CMD:skin(playerid,params[])
{
	new skinnumber, skinid, string[128];
	if(sscanf(params, "d", skinid)) SendClientMessage(playerid, -1, "{383838}USAGE: /skin [skinid]");
	else if(skinid < 0 || skinid > 299) SendClientMessage(playerid, 0xFF000000, "{383838}ERROR: Choose a skin between 0 to 299!");
	else
	{
	    SetPlayerSkin(playerid, skinid);
	   	skinnumber = GetPlayerSkin(playerid);
	    format(string, sizeof(string), "{ADDBE6}SKIN: {FFFFFF}You have changed your skin to {FFFF00}%d", skinnumber);
	    SendClientMessage(playerid, -1, string);
	}
	return 1;
}

CMD:jetpack(playerid, params[])
{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
	return 1;
}

CMD:veh(playerid,params[])
{
		new dstring[2048];
		new string[64];
		format(dstring,sizeof(dstring),"{FFFFFF}");
		for(new i=400; i < 612; i++)
		{
		    format(string,sizeof(string),"%s\n",GetVehicleModelName(i));
		    strcat(dstring, string);
		}
		ShowPlayerDialog(playerid, DIALOG_VEHICLES, DIALOG_STYLE_LIST, "{FFFFFF}Spawn Vehicles",dstring,"Spawn","Cancel");
	    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	case DIALOG_VEHICLES:
	{
		if(response)
		{
			 SpawnVehicleInFrontOfPlayer(playerid, listitem+400, randomEx(0,255), randomEx(0,255));
		}
	}
    }
    return 1;
}

forward OnPasswordChanged(playerid);
public OnPasswordChanged(playerid)
{
	new hash[BCRYPT_HASH_LENGTH], query[300];
	bcrypt_get_hash(hash);
	mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `Password` = '%e' WHERE `Username` = '%e'", hash, GetName(playerid));
	mysql_query(Database, query);
	SendClientMessage(playerid, -1, "{ADDBE6}SERVER: {FFFFFF}You have successfully changed your password.");
	return 1;
}

GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

ReturnIP(playerid)
{
	new PlayerIP[17];
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	return PlayerIP;
}