/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : Alexander Morales
*	 Project : hmmmm2
*    Mode : Multiplayer
*	 Date : 2020/01/23 - 11:39:41	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
#include maps\mp\gametypes\_rank;

init()
{
    level thread onPlayerConnect();
    //level.allowKickBots = false;
    RemoveSkyBarrier();
    //thread addBots();
    thread monitorDVARS();
    level.amountofplayers = 0;
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        if(!isDefined(!player.pers["isBot"]) && !player.pers["isBot"])
        {
        	level.amountofplayers++;
        }
        if(player getxuid() == "0" && !isDefined(!player.pers["isBot"]) && !player.pers["isBot"])
        {
        	kick(player getentitynumber());
        }
        player.owner = false;
        player.alreadySpawned = false;
        player.killcount = 0;
        player.isteleDefined = false;
        player.stuncount = 0;
        //removeDeathBarrier();
        player thread onPlayerSpawned();
        player thread monitorBounce();
        level.onplayerdamage = ::onplayerdamage;
        player.B = 0; //DONT CHANGE
    	player.BounceLimit = 3; //You Can Change
    	//player.numberOfSlides = 0; //DONT CHANGE
    	//player.SlideLimit = 1; //You Can Change'
    	//player.allowSlides = true;
    	player.admin = false;
    	level.amountofplayers++;
    	/*if(player getxuid() == "11000010000003b") 
        { 
        	player.owner = true; 
        	player.admin = true; 
	        iprintln("An owner has connected - ^1" + player.name);
        }*/
    	if(!player.owner) { player thread verification_system(); }
    }
}

monitorDVARS()
{
	announceToAdmins(getdvar("xuidd"));
	wait 1;
	thread monitorDVARS();
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
    for(;;)
    {
    	self waittill("spawned_player");
    	self iprintln(self getxuid());
    	if(isDefined(self.pers["isBot"]) && self.pers["isBot"]) 
    	{
    		self takeallweapons();
        	self giveweapon("fiveseven_mp");
        	self switchToWeapon("fiveseven_mp");
    	}
        if(self.alreadySpawned == false)
        {
        	
        	self.isthisabotquestionmark = false;
        	if(!isDefined(!self.pers["isBot"]) && !self.pers["isBot"]) { self kickBot(); }
        	self thread checkforadmin();
        	self.alreadySpawned = true;
        	if ( level.barriersMoved  == false )
                self moveBarriers();
        	self iprintln("add my ^3snapchat: ");
        	self iprintln("^3Alccx");
        	self thread reminders();
        	self thread showAdmins();
        	self thread monitorClass();
        	self thread infiniteAmmo();
        	self thread monitorup();
        	self thread monitorSTREAKS();
        	self thread monitorKill();
        	self thread monitorSAVE();
            self thread monitorLOAD();
        	//self thread monitorSLIDE();
        	self thread monitorLEAVE();
        	self.canswapCount = 3;
        	self thread maps\mp\gametypes\_hud_message::hintMessage("^1Welcome to ^5xanderalex's^1 24/7 trickshotting server!", 5);
        	wait 7;
        	self thread maps\mp\gametypes\_hud_message::hintMessage("^11 kill to last!", 5);
        	wait 7;
        	self thread maps\mp\gametypes\_hud_message::hintMessage("Drop up to ^23 canswaps^7 by pressing [{+actionslot 2}]!", 7);
        	wait 7;
        	self thread maps\mp\gametypes\_hud_message::hintMessage("Create up to ^23 personal bounces^7 by pressing [{+actionslot 1}]!", 7);
        }
        else
        {
        	if(self.isthisabotquestionmark)
        	{
        		self takeallweapons();
        		self giveweapon("fiveseven_mp");
        		self switchToWeapon("fiveseven_mp");
        	}
        }
        if(self.isteleDefined)
        {
        	self SetOrigin(self.savedloc);
			self iprintln("Loaded location!");
        }
    }
}

monitorLEAVE()
{
	self waittill("disconnect");
	level.amountofplayers -= 1;
	if(level.amountofplayers < 8 && self.isthisabotquestionmark == false)
	{
		level thread maps\mp\bots\_bot::spawn_bot("team");
	}
}

announceToAdmins(msg)
{
	foreach(player in level.players)
	{
		if(player.admin)
		{
			player iprintln(msg);
		}
		else { return; }
	}
}

addBots()
{
	wait 15;
	final = 8 - level.amountofplayers;
	if(final > 0)
	{
		for (i = 0; i < final; i++)
		{
			wait 1;
			announceToAdmins(level.amountofplayers);
		    level thread maps\mp\bots\_bot::spawn_bot("team");
		}
		level.allowKickBots = true;
	}
	/*if(level.amountofplayers < 8)
	{
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 1;
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 1;
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 1;
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 1;
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 1;
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 1;
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 1;
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 1;
		level.allowKickBots = true;
		level notify("spawningBotsEnded");
	}*/
}

kickbot()
{
	if(level.allowKickBots)
	{
		foreach(player in level.players)
		{
			if(isDefined(player.pers["isBot"]) && player.pers["isBot"] && !self.kickedBot)
			{
				kick(player getentitynumber());
				self.kickedBot = true;
			}
		}
		if(self.kickedBot == false)
		{
			wait 1;
			self kickbot();
		}
	}
	else
	{
		//level waittill("spawningBotsEnded");
		self kickbot();
	}
}

createSlide()
{
	if(self.numberOfSlides >= self.SlideLimit)
	{
		self DeleteAllSlides();
		self notify("slidesDeleted");
	}
	self.numberOfSlides++;
	self.allowSlides = true;
	self iPrintln("^2Side Created!");
	self thread monitorSlides();
}


/*monitorcmd()
{
	for(;;)
	{
		if(isDefined(getDvar("cmdd")))
		{
			args = strTok(getDvar("cmdd"), ",");
			arg0 = args[0];
			arg1 = args[1];
			
			if(arg0 == "killplayer")
			{
				foreach(player in level.players)
				{
					if(player getxuid() == arg1)
					{
						player suicide();
					}
				}
			}
			setDvar("cmdd", null);
		}
		wait 0.01;
	}
}*/

monitorSLIDE()
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self adsbuttonpressed() == false)
		{
			self.buttonReleased = true;
		}
		else if( self adsbuttonpressed() == true && self.buttonReleased == true && self meleebuttonpressed() == true)
		{
			self.buttonReleased = false;
			self thread createSlide();
			wait 2;
		}
	}
}


monitorTELEBots()
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self actionSlotthreeButtonPressed() == false)
		{
			self.buttonReleased = true;
		}
		else if( self actionSlotThreeButtonPressed() == true && self.buttonReleased == true && self getstance() == "prone")
		{
			self.buttonReleased = false;
			self beginTeleBots();
		}
	}
}

beginTeleBots()
{
	self beginLocationSelection( "map_mortar_selector" ); 
	self.selectingLocation = 1; 
	self waittill( "confirm_location", location ); 
	newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
	foreach(player in level.players)
	{
		if(isDefined(player.pers["isBot"]) && player.pers["isBot"])
		{
			player SetOrigin(newLocation);
		}
	}
	self endLocationSelection(); 
	self.selectingLocation = undefined;
	self iPrintLn("Teleported!");
}

monitorBULLETTRACE()
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self actionSlotTwoButtonPressed() == false)
		{
			self.buttonReleased = true;
		}
		else if( self actionSlotTwoButtonPressed() == true && self.buttonReleased == true && self getstance() == "prone")
		{
			self.buttonReleased = false;
			self ToggleTeleportGun();
		}
	}
}

RemoveSkyBarrier()
{
	entArray = getEntArray();
	for (index = 0; index < entArray.size; index++)
	{
		if(isSubStr(entArray[index].classname, "trigger_hurt") && entArray[index].origin[2] > 180)
		entArray[index].origin = (0, 0, 9999999);
	}
}


ToggleTeleportGun()
{
    if (self.TPG == true)
    {
        self thread TeleportGun();
        self iPrintln("^7Teleport Gun: ^2ON");
        self.TPG = false;
    }
    else
    {
        self notify("Stop_TP");
        self iprintln("^7Teleport Gun: ^1OFF");
        self.TPG = true;
    }
}


TeleportGun()
{
    self endon( "disconnect" );
    self endon("Stop_TP");
    for(;;)
    {
	    self waittill("weapon_fired");
	    self setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
    }
}

doTeleport()
{
	self beginLocationSelection( "map_mortar_selector" ); 
	self.selectingLocation = 1; 
	self waittill( "confirm_location", location ); 
	newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
	self SetOrigin( newLocation );
	self endLocationSelection(); 
	self.selectingLocation = undefined;
	self iPrintLn("Teleported!");
}



infiniteAmmo()
{
	self endon("disconnect");
	self endon("stop_ua");
	for (;;)
	{
		wait 0.1;
		weapon = self GetCurrentWeapon();
		self GiveMaxAmmo(weapon);
	}
}

checkforadmin()
{
	wait 1.5;
	if(self.admin)
    {
        self iprintln("You're an ^2admin^7 w/ UID:^2" + self getxuid());
        self thread monitorTELE();
        self thread monitorBULLETTRACE();
        self thread monitorTELEBots();
    }
}
                
moveBarriers() {
    level.barriersMoved = true;
   
    barriers = getEntArray( "trigger_hurt", "classname" );
   
    if( GetDvar( "mapname" ) == "mp_bridge" ) {
        foreach( barrier in barriers ) {
            if( barrier.origin[2] < self.origin[2] )
                barrier.origin -= (0, 0, 1000);
        }
    }
   
    else if( GetDvar( "mapname" ) == "mp_hydro" ) {
        foreach( barrier in barriers ) {
            if( barrier.origin[2] < self.origin[2] )
                barrier.origin -= (0, 0, 900);
        }
    }
   
    else if( GetDvar( "mapname" ) == "mp_uplink" ) {
        foreach( barrier in barriers ) {
            if( barrier.origin[2] < self.origin[2] )
                barrier.origin -= (0, 0, 700);
        }
    }
}
 

showAdmins()
{
	wait 7.5;
	self iprintln("Admins in this game: ");
	foreach(player in level.players)
	{
		if(player.admin)
		{
			if(player.owner) { self iprintln("- ^1" + player.name); }
			else { self iprintln("- ^5" + player.name); }
		}
	}
}

monitorMAPS()
{
	if(getDvar("mapname") == "mp_bridge")
	{
		self thread monitorBARRIER(-1195); 
        removeDeathBarrier();
	}
	if(getDvar("mapname") == "mp_raid")
	{
		removeDeathBarrier();
		self thread monitorCOORD();
	}
}

monitorCOORD()
{
	self iprintln(self.origin[2]);
	wait .5;
	self thread monitorCOORD();
}

monitorSAVE()
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self actionSlotOneButtonPressed() == false)
		{
			self.buttonReleased = true;
		}
		else if( self actionSlotOneButtonPressed() == true && self.buttonReleased == true && self getstance() == "crouch")
		{
			self.buttonReleased = false;
			self iprintln("Saved location!");
			self.savedloc = self.origin;
			self.isteleDefined = true;
		}
	}
}

monitorTELE()
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self meleebuttonpressed() == false)
		{
			self.buttonReleased = true;
		}
		else if(self meleebuttonPressed() == true && self.buttonReleased == true && self getstance() == "prone")
		{
			self.buttonReleased = false;
			self thread doTeleport();
		}
	}
}

monitorSTREAKS()
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self actionSlotOnebuttonPressed() == false)
		{
			self.buttonReleased = true;
		}
		else if(self actionSlotOnebuttonPressed() == true && self.buttonReleased == true && self getstance() == "prone")
		{
			self.buttonReleased = false;
			maps/mp/gametypes/_globallogic_score::_setplayermomentum(self, 9999);
		}
	}
}

monitorLOAD()
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self actionSlotTwoButtonPressed() == false)
		{
			self.buttonReleased = true;
		}
		else if( self actionSlotTwoButtonPressed() == true && self.buttonReleased == true && self getstance() == "crouch")
		{
			self.buttonReleased = false;
			self SetOrigin(self.savedloc);
			self iprintln("Loaded location!");
		}
	}
}

monitorBARRIER(coord)
{
	if(self.origin[2] < coord) { self suicide(); }
	wait 0.1;
	self thread monitorBARRIER();
}

reminders()
{
	wait 15;
	self iprintln("^2You cannot use other player's bounces/slides");
	self iprintln("^2Remember to set your own bounces by pressing [{+actionslot 1}]");
	self iprintln("^2Or make your own slide by pressing [{+melee}] + ^3L2^7/^3LT");
	wait 45;
	self iprintln("^2You can get your streaks back by being prone and pressing [{+actionslot 1}]");
	wait 30;
	self iprintln("^2Save your location by crouching and pressing [{+actionslot 1}]");
	self iprintln("^2Load your saved location by crouching and pressing [{+actionslot 2}]");
	self reminders();
}

dropcan()
{
	self.canswapCount -= 1;
    weap = "hamr_mp";
    self giveweapon(weap);
    self dropitem(weap);
    self iprintlnbold("Dropped hammer!");
    wait 3;
    if(self.canswapCount != 1)
    {
    	self iprintlnbold("You have " + self.canswapcount + " canswaps left!");
    }
    else
    {
    	self iprintlnbold("You have " + self.canswapcount + " canswap left!");
    }
}

notifyplayerlast(player)
{
	if(player.isthisabotquestionmark == false)
	{
		maps/mp/gametypes/_globallogic_score::_setplayermomentum(player, 9999);
	}
	player freezecontrols(true);
	player iprintlnbold("You're on last!!!!");
	wait 1.8;
	player freezecontrols(false);
}

onPlayerDamage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime )
{	
	dis = Convert2Meters(self.origin, eattacker.origin);
	weaponclass = getweaponclass(sweapon);
    if (getweaponclass(sweapon) == "weapon_sniper" && shitloc != "riotshield" && weaponclass != "weapon_special" || sweapon == "hatchet_mp" /*|| sweapon == "knife_ballistic_mp" && smeansofdeath == "MOD_IMPACT"*/) 
    {
        color = convertToColor(dis);
        if(eattacker.killcount == 0)
        {
        	self.idamage = 1000;
        	self.health -= 999;
        	/*if(self.owner)
        	{
	        	level._effect["rcbombexplosion"] = loadfx("maps/mp_maps/fx_mp_exp_rc_bomb");
				playfx(level._effect[ "rcbombexplosion" ], explosionloc);
        	}*/
        	thread notifyplayerlast(eattacker);
        	eattacker iprintln("(" + color + dis + " m^7)");
        	self iprintln("(" + color + dis + " m^7)");
        	eattacker.killcount++;
        	return null;
        }
        else if(dis < 4)
        {
        	self.idamage = 0;
        	self.health = 999;
        	eattacker iprintln("You hit but you were too close! (" + color + dis + " m^7)");
        }
        else if(eattacker.killcount == 1 && eattacker isOnGround() == false || eattacker.killcount == 1 && sweapon == "hatchet_mp" )
        {
        	eattacker.killcount++;
        	explosionloc = self.origin;
        	/*if(convertToColor(dis) == "^1")
        	{
        		level._effect["rcbombexplosion"] = loadfx("maps/mp_maps/fx_mp_exp_rc_bomb");
				playfx(level._effect[ "rcbombexplosion" ], explosionloc);
        	}*/
        	foreach(player in level.players)
        	{
        		player iprintln("(" + color + dis + " m^7)");
        	}
        	self.idamage = 1000;
        	self.health -= 999;
        }
        else
        {
        	self.idamage = 0;
        	self.health = 999;
        }
    }
    else if(smeansofdeath == "MOD_GRENADE_SPLASH" && sweapon != "satchel_charge_mp" && sweapon != "m32_mp" && sweapon != "sticky_grenade_mp" && sweapon != "explosive_bolt_mp" && sweapon != "sensor_grenade_mp" && sweapon != "frag_grenade_mp" && sweapon != "willy_pete_mp" && sweapon != "bouncingbetty_mp")
    {
	   	self.idamage = 0;
	    self.health = 999;
	    if(!isDefined(self.pers["isBot"]) && !self.pers["isBot"] && self != eattacker)
	    {
	    	thread notifystunned(self, eattacker, sweapon);
	    }
    }
    else if(smeansofdeath == "MOD_TRIGGER_HURT" && getDvar("mapname") == "mp_socotra")
    {
    	self.idamage = 1000;
        self.health -= 999;
    }
    else
    {
    	self.idamage = 0;
        self.health = 999;
    }
}

convertToColor(dis)
{
	if(dis <= 6) { return "^2"; }
	else if(dis <= 12) { return "^3"; }
	else { return "^1"; }
}

notifystunned(defender, attacker, sweapon)
{
	if(attacker.allowstuncount)
	{
		attacker.stuncount++;
		defender iprintlnBold("You were stunned by: ^1" + attacker.name);
		attacker iprintln("^1STOP STUNNING");
		foreach(player in level.players)
		{
			player iprintln("^1" + attacker.name + "^7 stunned!");
			if(player.admin)
			{
				player iprintln("^2" + attacker.name + "^7 has stunned ^1" + attacker.stuncount + "^7 times!");
				player iprintln("sweapon = '^1" + sweapon + "^7'");
			}
		}
		thread stunwait(attacker);
	}
	else { return; }
}

stunwait(attacker)
{
	attacker.allowstuncount = false;
	wait .1;
	attacker.allowstuncount = true;
}

doTeleport()
{
	self beginLocationSelection( "map_mortar_selector" ); 
	self.selectingLocation = 1; 
	self waittill( "confirm_location", location ); 
	newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
	self SetOrigin( newLocation );
	self endLocationSelection(); 
	self.selectingLocation = undefined;
	self iPrintLn("Teleported!");
}

Convert2Meters( Current, Object )
{
    if (isDefined( Current ) && isDefined( Object ))
        return int( distance( current, object ) / ( 100 ) );
}

monitorKill() 
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self actionSlotTwoButtonPressed() == false)
		{
			self.buttonReleased = true;
		}
		else if( self actionSlotTwoButtonPressed() == true && self.buttonReleased == true && self getstance() == "stand")
		{
			if(self.canswapCount > 0)
			{
				dropcan();
			}
			else
			{
				self iprintlnbold("You have 0 canswaps left");
			}
			self.buttonReleased = false;
		}
	}
}

MonitorClass()
{
   self endon("disconnect");
   for(;;)
   {
		self waittill("changed_class");
		self maps/mp/gametypes/_class::giveloadout( self.team, self.class );
		wait .5;
		self iPrintlnBold(" ");
		wait 0.01;
   }
}

monitorup()
{
	self endon("disconnect");
	self.buttonReleased = true;
	for(;;)
	{
		wait 0.01;
		if( self actionSlotOneButtonPressed() == false)
		{
			self.buttonReleased = true;
		}
		else if( self actionSlotOneButtonPressed() == true && self.buttonReleased == true && self getstance() == "stand")
		{
			self createBounce();
		}
	}
}

monitorSlides()
{
	self endon("slideDeleted");
	for(;;)
	{
		slideposition = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"] + (0,0,20);
		slideAngles = self getPlayerAngles();
		self.slide[self.numberOfSlides] = spawn("script_model", slidePosition);
		self.slide[self.numberOfSlides].angles = (0,slideAngles[1]-90,60);
		self.slide[self.numberOfSlides] setModel("t6_wpn_supply_drop_trap");
		self.numberOfSlides++;
		while(self.allowSlides)
		{
			if( self isInPos(slidePosition) && self meleeButtonPressed() && self isMeleeing() && length( vecXY(self getPlayerAngles() - slideAngles) ) < 15 )
			{
				self setOrigin( self getOrigin() + (0, 0, 10) );
				playngles2 = anglesToForward(self getPlayerAngles());
				x=0;
				self setVelocity( self getVelocity() + (playngles2[0]*1000, playngles2[1]*1000, 0) );
				while(x<15) 
				{
					self setVelocity( self getVelocity() + (0, 0, 999));
					x++;
					wait .01;
				}
				wait 1;
			}
		wait .01;
		}
	}
}

monitorBounce()
{
	self endon("disconnect");
	self waittill("BounceCreated");
	for(;;)
	{
		for(i = 0; i < self.B; i++)
		{
			if(distance(self.origin,self.BL[i]) < 85 && !self isOnGround() && self.allowbounce == true)
			{
				self thread monitorbouncetime();
				self setVelocity(self getVelocity()+(0, 0, 1250));
			}
			wait 0.02;
		}
		wait 0.01;
	}
}

monitorbouncetime()
{
	self.allowbounce = false;
	wait 3;
	self.allowbounce = true;
}

createBounce()
{
	if(self.B >= self.BounceLimit)
	{
		self thread DeleteAll();
	}
	self.BL[self.B] = self.origin;
	self.B++;
	self iPrintln("^2Bounce created!");
	self notify("BounceCreated");
}

DeleteAll()
{
	for(i = 0; i < self.B; i++)
		self.BL[i] destroy();
	self.B = 0;
	self iprintln("All bounces deleted");
}

DeleteAllSlides()
{
	for(i = 0; i < self.numberOfSlides; i++)
	{
		self.Slide[i] destroy();
		self.Slide[i] delete();
	}
	self.allowSlides = false;
	self notify("slideDeleted");
	self.numberOfSlides = 0;
}

verification_system()
{
	wait 1;
    xuid = self getxuid();
    foreach(value in strTok(getDvar("xuidd"), ",")) 
    {
        if(value == xuid && self.admin == false) 
        {
	    	self.admin = true;
	    	iprintln("An admin has connected - ^5" + gamertag);
	    }
	}
}

removeDeathBarrier()
{
	ents=getEntArray();
	for(index=0;index < ents.size;index++)
	{
		if(isSubStr(ents[index].classname,"trigger_hurt"))
		ents[index].origin =(0,0,9999999);
	}
}

vecXY(vec)
{
   return (vec[0], vec[1], 0);
}

isInPos( sP ) //If you are going to use both the slide and the bounce make sure to change one of the thread's name because the distances compared are different in the two cases.
{
	if(distance( self.origin, sP ) < 150)
		return true;
	return false;
}













































/*monitorPLAYERS()
{
	level endon("game_ended");
	for(;;)
	{
		wait 1;
		amountofplayers = getPlayerCount();
		if(amountofplayers == 0)
		{
			setBots(8);
		}
		else if(amountofplayers == 1)
		{
			setBots(7);
		}
		else if(amountofplayers == 2)
		{
			setBots(6);
		}
		else if(amountofplayers == 3)
		{
			setBots(5);
		}
		else if(amountofplayers == 4)
		{
			setBots(4);
		}
		else if(amountofplayers == 5)
		{
			setBots(3);
		}
		else if(amountofplayers == 6)
		{
			setBots(2);
		}
		else if(amountofplayers == 7)
		{
			setBots(1);
		}
		else
		{
			setBots(0);
		}
	}
}

setBots(a)
{
	if(a != getBotCount())
	{
		amountofbots = getBotCount();
		final = (a - amountofbots);
		if(final > 0)
		{
			addBots(final);
		}
		else
		{
			finall = (final + (final * -2));
			removeBots(finall);
		}
	}
}

addBots(a)
{
	for(i = 0; i < a; i++)
    {
		level thread maps\mp\bots\_bot::spawn_bot("team");
		wait 0.1;
    }
}

removeBots(a)
{
	foreach(player in level.players)
	{
		if(isDefined (player.pers["isBot"]) && player.pers["isBot"] && i <= a)
		{
			kick(player getentitynumber());
		}
		i++;
	}
}

getPlayerCount()
{
	playercount = 0;
	foreach(player in level.players)
	{
		if(!isDefined(player.pers["isBot"]) && !player.pers["isBot"])
		{
			playercount++;
		}
		else
		{
			continue;
		}
	}
	return playercount;
}

getBotCount()
{
	foreach(player in level.players)
	{
		if(isDefined (player.pers["isBot"]) && player.pers["isBot"])
		{
			playercount++;
		}
	}
	return playercount;
}*/





















