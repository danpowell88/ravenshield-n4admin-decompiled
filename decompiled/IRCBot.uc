class IRCBot extends N4Mutator
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var config bool bDisableIRCBot;
var IRCSpectator bot;

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    __NFUN_231__("");
    __NFUN_231__("****************************************************************************");
    __NFUN_231__("*                      Raven Shield Match Bot v2.3                         *");
    __NFUN_231__("*                    By Neo4E656F neo@squadgames.com                       *");
    __NFUN_231__("*                 Copyright (C) 2003,2004 Neil Popplewell                  *");
    __NFUN_231__("*                           for Ravenshield 1.60+                          *");
    __NFUN_231__("****************************************************************************");
    __NFUN_231__("");
    // End:0x255
    if(bDisableIRCBot)
    {
        __NFUN_231__(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "The IRC bot has been disabled in the ini file under"), GetClassAndPackage()), "then bDisableIRCBot"));        
    }
    else
    {
        StartIRCBot();
    }
    return;
}

function StartIRCBot()
{
    __NFUN_165__(Level.Game.MaxPlayers);
    bot = __NFUN_278__(Class'IRCSpectator');
    // End:0x4B
    if(__NFUN_114__(bot, none))
    {
        __NFUN_166__(Level.Game.MaxPlayers);
    }
    return;
}

function string GetClassAndPackage()
{
    return "N4Admin.IRCBot";
    return;
}
