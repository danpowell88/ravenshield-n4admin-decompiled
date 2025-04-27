class N4StatLogger extends N4Mutator
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var int BuildNumber;
var N4XMLLogger XMLLogger;

function int GetBuildNumber()
{
    return BuildNumber;
    return;
}

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    __NFUN_231__("");
    __NFUN_231__("****************************************************************************");
    __NFUN_231__(__NFUN_112__(__NFUN_112__("*                    N4StatLogger V", string(__NFUN_172__(float(GetBuildNumber()), 100.0000000))), " Activated                          *"));
    __NFUN_231__("*       Copyright (C) 2003,2004 Neil Popplewell.  All rights reserved.     *");
    __NFUN_231__("*          Email: neo@squadgames.com Web: http://www.squadgames.com        *");
    __NFUN_231__("*                     Ravenshield V1.60+ required                          *");
    __NFUN_231__("****************************************************************************");
    __NFUN_231__("");
    XMLLogger = Class'N4XMLLogger'.static.GetXMLLoggerFrom(self);
    XMLLogger.AddRebuildHook(self);
    return;
}

event Trigger(Actor Other, Pawn EventInstigator)
{
    local StatLogFile file;
    local N4LogFileStringOutputStream Logger;

    super(Actor).Trigger(Other, EventInstigator);
    Logger = N4LogFileStringOutputStream(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4LogFileStringOutputStream'));
    file = __NFUN_278__(Class'N4Util.N4TimeStatLogFile');
    Logger.LogFile = file;
    file.StartLog();
    file.FileLog(__NFUN_112__(__NFUN_236__(65279), "<?xml version=\"1.0\" encoding=\"utf-16\"?>"));
    file.FileFlush();
    XMLLogger.WriteTo(Logger);
    file.StopLog();
    return;
}

defaultproperties
{
    BuildNumber=100
}