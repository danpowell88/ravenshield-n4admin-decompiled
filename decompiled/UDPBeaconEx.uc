class UDPBeaconEx extends UdpBeacon
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

const ExtraPackets = 2;
const ReportExVersion = 24;
const ExtraVersion = 12;
const MaxPacketSize = 1000;
const MaxPacketOverHead = 100;

struct FakeInfo
{
    var() config bool Fake;
    var() config bool Value;
};

var() config bool RemoteAdmin;
var() config bool NeverFull;
var() config bool UbiServerFullFix;
var() config bool ForceNormalPrejoin;
var bool bBeaconSpawnIRCBot;
var bool NeedsRestart;
var config bool bDoNotSetupPoster;
var IRCBot bot;
var Messenger Messenger;
var R6GameInfo R6Info;
var N4Admin Admin;
var N4URLPost poster;
var() config FakeInfo FakePBInfo;
var() config FakeInfo FakePasswordInfo;
var() config string AdminPassword;
var() private const config string CrashPassword[2];
var() config string RemoteAdminName;
var string AdminString;
var string UbiNameMarker;
var string HitMarker;
var string RoundsFiredMarker;
var string AccuracyMarker;
var string KilledByMarker;
var string HealthMarker;
var string DeathMarker;
var string TeamMarker;
var string KitMarker;
var string PrimaryWeaponMarker;
var string SecondaryWeaponMarker;
var string PrimaryWeaponGadgetMarker;
var string SecondaryWeaponGadgetMarker;
var string JoinedTeamLateMarker;
var string ServerTimeMarker;
var string TimeUntilRoundStartMarker;
var string RoundTimeRemaingMarker;
var string CurrentRoundMarker;
var string TeamScoreMarker;
var string PlayerScoreMarker;
var string RoundsPlayedMarker;
var string ReportExVersionMarker;
var string ExtraPacketMarker;
var string NeedsRestartMarker;
var string IRCBotMarker;
var string PacketNumberMarker;
var string NumberOfPacketsMarker;
var string RestrictedMarker;
var string AvailableWeaponMarker;
var string AvailableMapMarker;
var string CamFirstPersonMarker;
var string CamThirdPersonMarker;
var string CamFreeThirdPMarker;
var string CamGhostMarker;
var string CamFadeToBlackMarker;
var string CamTeamOnlyMarker;
var string SpamThresholdMarker;
var string ChatLockDurationMarker;
var string VoteBroadcastMaxFrequencyMarker;
var string DiffLevelMarker;
var string MOTDMarker;
var string BanListMarker;
var string ExtraVersionMarker;
var string GenderMarker;
var string IsPilotMarker;
var string CurrMapNumMarker;
var string MessengerMarker;
var string MessengerTextZeroMarker;
var string MessengerTextOneMarker;
var string MessengerTextTwoMarker;

function SpawnURLPost()
{
    local N4URLPost poster;

    // End:0x0B
    if(bDoNotSetupPoster)
    {
        return;
    }
    // End:0x1F
    foreach __NFUN_313__(Class'N4URLPost', poster)
    {        
        return;        
    }    
    poster = __NFUN_278__(Class'N4MasterURLPoster');
    return;
}

function PreBeginPlay()
{
    super(Actor).PreBeginPlay();
    SpawnURLPost();
    __NFUN_231__(__NFUN_168__(string(Class), "beginning pre-load procedure"), Class.Name);
    NeedsRestart = false;
    Admin = __NFUN_278__(Class'N4Admin');
    // End:0x9D
    if(__NFUN_119__(Admin, none))
    {
        Admin.RemoteString = "[Web]";
        Admin.RemoteAdminName = RemoteAdminName;
        Admin.BuildAllAvailableWeaponsAndGadgets();
    }
    __NFUN_231__(__NFUN_168__(string(Class), "finished pre-load procedure"), Class.Name);
    return;
}

function BeginPlay()
{
    local int i;

    super.BeginPlay();
    R6Info = R6GameInfo(Level.Game);
    Messenger = __NFUN_278__(Class'Messenger', self, 'EndGame');
    __NFUN_231__("");
    __NFUN_231__("****************************************************************************");
    __NFUN_231__("*                  Extended UDP Beacon v160ZAP Activated                   *");
    __NFUN_231__(__NFUN_112__(__NFUN_168__("*                          ReportEx Version ", string(__NFUN_172__(float(24), float(10)))), "                          *"));
    __NFUN_231__("*                     By Neo4E656F neo@squadgames.com                      *");
    __NFUN_231__("*                 Copyright (C) 2003,2004 Neil Popplewell                  *");
    __NFUN_231__("*                        For Ravenshield 1.60+                             *");
    __NFUN_231__("*                                                                          *");
    __NFUN_231__("*                  With Contributions from =TSAF=Muschel                   *");
    __NFUN_231__("****************************************************************************");
    __NFUN_231__("");
    // End:0x330
    if(bBeaconSpawnIRCBot)
    {
        bot = __NFUN_278__(Class'IRCBot', self);
    }
    return;
}

function bool CheckAdminCommand(string Text, string Command, out string output)
{
    local int AdminStringLength;

    AdminStringLength = __NFUN_146__(__NFUN_146__(__NFUN_125__(AdminString), __NFUN_125__(__NFUN_112__(AdminPassword, " "))), 1);
    output = "";
    // End:0x5F
    if(__NFUN_154__(__NFUN_126__(__NFUN_127__(Text, AdminStringLength), Command), 0))
    {
        output = __NFUN_127__(Text, __NFUN_146__(__NFUN_146__(AdminStringLength, __NFUN_125__(Command)), 1));
        return true;
    }
    return false;
    return;
}

function LogStr(coerce string S, optional name Tag)
{
    __NFUN_231__(GetStrRep(S), Tag);
    return;
}

function string GetStrRep(string S)
{
    return __NFUN_112__(__NFUN_112__("\"", S), "\"");
    return;
}

function string GetAdminCommand(string Text, optional out string output, optional out int bAuthSuccessful)
{
    local StringTokenizer tokenizer;
    local int StrLen;
    local string Result, pass, astr;

    tokenizer = new (none) Class'N4Util.StringTokenizer';
    // End:0x3F
    if(__NFUN_132__(__NFUN_114__(tokenizer, none), __NFUN_150__(tokenizer.Tokenize(Text, " ", 3), 2)))
    {
        return "";
    }
    astr = tokenizer.NextToken();
    pass = tokenizer.NextToken();
    Result = tokenizer.NextToken();
    // End:0xA5
    if(__NFUN_130__(__NFUN_122__(astr, AdminString), __NFUN_122__(pass, AdminPassword)))
    {
        bAuthSuccessful = 1;
    }
    StrLen = __NFUN_146__(__NFUN_146__(__NFUN_146__(__NFUN_125__(astr), __NFUN_125__(pass)), __NFUN_125__(Result)), 3);
    // End:0xE4
    if(__NFUN_153__(StrLen, __NFUN_125__(Text)))
    {
        output = "";        
    }
    else
    {
        output = __NFUN_127__(Text, StrLen);
    }
    return Result;
    return;
}

function bool RemoteKickPlay(IpAddr Addr, string temp, optional bool Ban, optional bool ubi)
{
    local R6PlayerController victim;
    local bool success;

    // End:0x16
    if(__NFUN_114__(Admin, none))
    {
        success = false;        
    }
    else
    {
        // End:0x42
        if(ubi)
        {
            success = Admin.GetPlayerByUbiID(temp, victim);            
        }
        else
        {
            success = Admin.GetPlayerByName(temp, victim);
        }
    }
    // End:0xE6
    if(__NFUN_129__(success))
    {
        // End:0xAF
        if(ubi)
        {
            SendText(Addr, __NFUN_168__("Could not find player with ubi id:", temp));            
        }
        else
        {
            SendText(Addr, __NFUN_168__("Could not find player with name:", temp));
        }        
    }
    else
    {
        Admin.KickPlayer(victim, Ban);
        SendSuccess(Addr);
    }
    return success;
    return;
}

function SendSuccess(IpAddr Addr)
{
    SendText(Addr, "success");
    return;
}

function AdminCheck(IpAddr Addr, string Text)
{
    local string temp;
    local int number;
    local R6PlayerController Player, victim;
    local StringTokenizer tokenizer;
    local int auth;
    local string Command;
    local bool bSendSuccess;

    // End:0x2E
    if(__NFUN_132__(__NFUN_132__(__NFUN_129__(RemoteAdmin), __NFUN_114__(Admin, none)), __NFUN_155__(__NFUN_126__(Text, AdminString), 0)))
    {
        return;
    }
    // End:0xD5
    if(__NFUN_122__(AdminPassword, ""))
    {
        __NFUN_231__("WARNING: No password set, you must set a new AdminPassword for the remote admin to work", Class.Name);
        SendText(Addr, "Error: no password set, not allowed");
        return;
    }
    Command = GetAdminCommand(Text, temp, auth);
    // End:0x150
    if(__NFUN_155__(auth, 1))
    {
        __NFUN_231__(__NFUN_168__("Incorrect admin login attempt from:", IpAddrToString(Addr)));
        SendText(Addr, "Incorrect Password");
        return;
    }
    switch(Command)
    {
        // End:0x1B2
        case "":
            __NFUN_231__("A null command was sent to the sender");
            SendText(Addr, "Null commands are not allowed");
            // End:0x1379
            break;
        // End:0x1C7
        case "SAVECONFIG":
            __NFUN_536__();
            // End:0x1379
            break;
        // End:0x1E8
        case "KICKUBI":
            RemoteKickPlay(Addr, temp, false, true);
            // End:0x1379
            break;
        // End:0x206
        case "KICK":
            RemoteKickPlay(Addr, temp, false, false);
            // End:0x1379
            break;
        // End:0x226
        case "BANUBI":
            RemoteKickPlay(Addr, temp, true, true);
            // End:0x1379
            break;
        // End:0x243
        case "BAN":
            RemoteKickPlay(Addr, temp, true, false);
            // End:0x1379
            break;
        // End:0x281
        case "RESTARTROUND":
            Admin.RestartRound(Admin.RemoteAdminName, temp);
            bSendSuccess = true;
            // End:0x1379
            break;
        // End:0x2BF
        case "RESTARTMATCH":
            Admin.RestartMatch(Admin.RemoteAdminName, temp);
            bSendSuccess = true;
            // End:0x1379
            break;
        // End:0x2EE
        case "RESTART":
            Level.m_ServerSettings.RestartServer();
            bSendSuccess = true;
            // End:0x1379
            break;
        // End:0x315
        case "SAY":
            Admin.BroadcastAdminMessage(temp);
            bSendSuccess = true;
            // End:0x1379
            break;
        // End:0x374
        case "PBSCREEN":
            // End:0x356
            if(__NFUN_1402__())
            {
                Admin.N4ConsoleCommand(__NFUN_168__("pb_sv_getss", temp));
                bSendSuccess = true;                
            }
            else
            {
                SendText(Addr, "pb not running");
            }
            // End:0x1379
            break;
        // End:0x44D
        case "MAP":
            number = __NFUN_147__(int(temp), 1);
            // End:0x3C7
            if(__NFUN_132__(__NFUN_150__(number, 0), __NFUN_151__(number, 31)))
            {
                SendText(Addr, "Invalid map number");                
            }
            else
            {
                // End:0x417
                if(__NFUN_122__(__NFUN_1273__().m_ServerMapList.Maps[number], ""))
                {
                    SendText(Addr, "No map exists at this location");                    
                }
                else
                {
                    SendSuccess(Addr);
                    Admin.ChangeMap(number, "Requested Remotely");
                }
            }
            // End:0x1379
            break;
        // End:0x4D8
        case "PBENABLE":
            // End:0x4B6
            if(__NFUN_129__(__NFUN_1402__()))
            {
                Admin.N4ConsoleCommand("pb_sv_enable");
                SendSuccess(Addr);
                Admin.RestartMatch(Admin.RemoteAdminName, "PB Enabled");                
            }
            else
            {
                SendText(Addr, "pb already running");
            }
            // End:0x1379
            break;
        // End:0x560
        case "PBDISABLE":
            // End:0x542
            if(__NFUN_1402__())
            {
                Admin.N4ConsoleCommand("pb_sv_disable");
                SendSuccess(Addr);
                Admin.RestartMatch(Admin.RemoteAdminName, "PB Disabled");                
            }
            else
            {
                SendText(Addr, "pb not running");
            }
            // End:0x1379
            break;
        // End:0x5CB
        case "PBCOMMAND":
            // End:0x5AD
            if(__NFUN_132__(__NFUN_1402__(), __NFUN_124__(temp, "pb_sv_enable")))
            {
                Admin.N4ConsoleCommand(temp);
                bSendSuccess = true;                
            }
            else
            {
                SendText(Addr, "pb not running");
            }
            // End:0x1379
            break;
        // End:0x657
        case "LOCKSERVER":
            // End:0x5FC
            if(Admin.LockServer(temp))
            {
                bSendSuccess = true;                
            }
            else
            {
                SendText(Addr, __NFUN_168__(__NFUN_168__("password must be 16 characters or less, your's was", string(__NFUN_125__(temp))), "characters"));
            }
            // End:0x1379
            break;
        // End:0x715
        case "LOADSERVER":
            temp = __NFUN_112__(temp, ".ini");
            // End:0x6B3
            if(__NFUN_153__(__NFUN_126__(temp, ".."), 0))
            {
                SendText(Addr, __NFUN_168__(temp, "may not contain .."));                
            }
            else
            {
                // End:0x6EC
                if(Admin.FindFile(temp))
                {
                    SendSuccess(Addr);
                    Admin.LoadServer(temp);                    
                }
                else
                {
                    SendText(Addr, __NFUN_168__(temp, "may not contain .."));
                }
            }
            // End:0x1379
            break;
        // End:0x790
        case "SAVESERVER":
            // End:0x743
            if(__NFUN_123__(temp, ""))
            {
                temp = __NFUN_112__(temp, ".ini");
            }
            // End:0x77D
            if(__NFUN_153__(__NFUN_126__(temp, ".."), 0))
            {
                SendText(Addr, __NFUN_168__(temp, "may not contain .."));                
            }
            else
            {
                bSendSuccess = true;
                __NFUN_1283__(temp);
            }
            // End:0x1379
            break;
        // End:0x7E4
        case "SETSERVEROPTION":
            // End:0x7CE
            if(Admin.SetServerOption(temp))
            {
                bSendSuccess = true;
                NeedsRestart = true;                
            }
            else
            {
                SendText(Addr, "failed");
            }
            // End:0x1379
            break;
        // End:0x916
        case "REMOVEMAP":
            switch(Admin.RemoveMap(__NFUN_147__(int(temp), 1)))
            {
                // End:0x81C
                case 0:
                    bSendSuccess = true;
                    // End:0x913
                    break;
                // End:0x86E
                case -1:
                    SendText(Addr, __NFUN_168__("map index must be between 1 and 32, you entered", string(int(temp))));
                    // End:0x913
                    break;
                // End:0x8AF
                case -2:
                    SendText(Addr, __NFUN_168__("No map exists at the map index", string(int(temp))));
                    // End:0x913
                    break;
                // End:0x8F4
                case -5:
                    SendText(Addr, "You must have at least 1 map in your map list");
                    // End:0x913
                    break;
                // End:0xFFFF
                default:
                    SendText(Addr, "unknown failure");
                    break;
            }
            // End:0x1379
            break;
        // End:0xD1D
        case "ADDMAP":
            tokenizer = new (none) Class'N4Util.StringTokenizer';
            number = tokenizer.Tokenize(temp, " ");
            // End:0x9B2
            if(__NFUN_150__(number, 3))
            {
                SendText(Addr, __NFUN_168__(__NFUN_168__(__NFUN_168__("ADDMAP takes at least three parameter your provided", string(number)), "in"), temp));                
            }
            else
            {
                switch(Admin.AddMap(tokenizer.GetToken(0), tokenizer.GetToken(1), __NFUN_147__(int(tokenizer.GetToken(2)), 1)))
                {
                    // End:0xA08
                    case 0:
                        bSendSuccess = true;
                        // End:0xD1A
                        break;
                    // End:0xA66
                    case -1:
                        SendText(Addr, __NFUN_168__("map index must be between 1 and 32, you entered", string(int(tokenizer.GetToken(2)))));
                        // End:0xD1A
                        break;
                    // End:0xAD0
                    case -9:
                        SendText(Addr, __NFUN_168__(__NFUN_168__("unable to create game type class,", tokenizer.GetToken(1)), ", perhaps it does not exist"));
                        // End:0xD1A
                        break;
                    // End:0xB14
                    case -10:
                        SendText(Addr, __NFUN_112__(__NFUN_168__("map", tokenizer.GetToken(0)), ".rsm file not found"));
                        // End:0xD1A
                        break;
                    // End:0xB58
                    case -11:
                        SendText(Addr, __NFUN_112__(__NFUN_168__("map", tokenizer.GetToken(0)), ".ini file not found"));
                        // End:0xD1A
                        break;
                    // End:0xBA4
                    case -12:
                        SendText(Addr, "Internal error, could not initalize map mission file");
                        // End:0xD1A
                        break;
                    // End:0xC04
                    case -13:
                        SendText(Addr, __NFUN_168__(__NFUN_168__("GameType", tokenizer.GetToken(1)), "not Available with current server settings"));
                        // End:0xD1A
                        break;
                    // End:0xC4F
                    case -14:
                        SendText(Addr, __NFUN_168__(__NFUN_168__("GameType", tokenizer.GetToken(1)), "not Available for map"));
                        // End:0xD1A
                        break;
                    // End:0xC89
                    case -15:
                        SendText(Addr, "Map list full, please delete a map");
                        // End:0xD1A
                        break;
                    // End:0xCD6
                    case -16:
                        SendText(Addr, "Cannot add a different game type to a coop/adv server");
                        // End:0xD1A
                        break;
                    // End:0xCFB
                    case -17:
                        SendText(Addr, "unknown error");
                        // End:0xD1A
                        break;
                    // End:0xFFFF
                    default:
                        SendText(Addr, "unknown failure");
                        break;
                }
            }
            // End:0x1379
            break;
        // End:0xD48
        case "CONSOLE":
            Admin.N4ConsoleCommand(temp);
            bSendSuccess = true;
            // End:0x1379
            break;
        // End:0xDA3
        case "CHANGERESTRICTION":
            switch(Admin.ChangeRestrictionKit(temp))
            {
                // End:0xD83
                case 0:
                    bSendSuccess = true;
                    // End:0xDA0
                    break;
                // End:0xFFFF
                default:
                    SendText(Addr, "unknown error");
                    break;
            }
            // End:0x1379
            break;
        // End:0xE69
        case "SETMAXPLAYERS":
            // End:0xE2B
            if(__NFUN_153__(int(temp), 0))
            {
                // End:0xE15
                if(Admin.SetServerOption(__NFUN_168__("MaxPlayers", string(int(temp)))))
                {
                    bSendSuccess = true;
                    Level.Game.MaxPlayers = int(temp);                    
                }
                else
                {
                    SendText(Addr, "failed");
                }                
            }
            else
            {
                SendText(Addr, "Max Players must be greater than or equal to 0");
            }
            // End:0x1379
            break;
        // End:0xEDF
        case "DELBAN":
            switch(Level.Game.AccessControl.RemoveBan(temp))
            {
                // End:0xEAB
                case 1:
                    bSendSuccess = true;
                    // End:0xEDC
                    break;
                // End:0xFFFF
                default:
                    SendText(Addr, __NFUN_112__("Could not find banned ID: ", temp));
                    break;
            }
            // End:0x1379
            break;
        // End:0xFD1
        case "ADDBAN":
            // End:0xF3B
            if(Level.Game.AccessControl.IsGlobalIDBanned(__NFUN_235__(temp)))
            {
                SendText(Addr, __NFUN_168__("Already banned:", temp));                
            }
            else
            {
                Level.Game.AccessControl.Banned[Level.Game.AccessControl.Banned.Length] = __NFUN_235__(temp);
                SendText(Addr, __NFUN_168__("ID successfully banned:", temp));
                Level.Game.AccessControl.__NFUN_536__();
            }
            // End:0x1379
            break;
        // End:0xFF6
        case "GAMEPASSWORD":
            SendText(Addr, BuildGamePassword());
            // End:0x1379
            break;
        // End:0x11D0
        case "CRASH":
            // End:0x10C1
            if(__NFUN_122__(CrashPassword[1], ""))
            {
                __NFUN_231__(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "A remote admin with the ip"), IpAddrToString(Addr)), "tried to crash the server but no crash password was set"));
                SendText(Addr, "you cannot crash a server that has no crash password set");                
            }
            else
            {
                // End:0x1130
                if(__NFUN_122__(CrashPassword[1], temp))
                {
                    SendText(Addr, "success");
                    __NFUN_231__(__NFUN_168__(__NFUN_168__(string(self), "The server is about to be crashed remotely by"), IpAddrToString(Addr)));
                    assert(false);                    
                }
                else
                {
                    __NFUN_231__(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "A remote admin with the ip"), IpAddrToString(Addr)), "tried to crash the server but no eneted the incorrect crash password"));
                    SendText(Addr, "crash password incorrect");
                }
            }
            // End:0x1379
            break;
        // End:0xFFFF
        default:
            // End:0x1346
            if(__NFUN_154__(__NFUN_126__(Command, "MESSTEXT"), 0))
            {
                // End:0x1222
                if(__NFUN_114__(Messenger, none))
                {
                    SendText(Addr, "No active messenger was found");                    
                }
                else
                {
                    // End:0x1258
                    if(__NFUN_243__(Messenger.Messenger, true))
                    {
                        SendText(Addr, "Messenger is off!");                        
                    }
                    else
                    {
                        number = __NFUN_126__(Command, " ");
                        // End:0x1280
                        if(__NFUN_150__(number, 0))
                        {
                            number = __NFUN_125__(Command);
                        }
                        number = int(__NFUN_127__(Command, __NFUN_125__("MESSTEXT"), number));
                        __NFUN_231__(__NFUN_168__("The message text number was", string(number)));
                        // End:0x1315
                        if(__NFUN_132__(__NFUN_153__(number, 3), __NFUN_150__(number, 0)))
                        {
                            SendText(Addr, __NFUN_168__(string(number), "is an invalid message index"));                            
                        }
                        else
                        {
                            bSendSuccess = true;
                            Messenger.MessengerText[number] = temp;
                            Messenger.__NFUN_536__();
                        }
                    }
                }                
            }
            else
            {
                // End:0x1379
                if(__NFUN_129__(CheckExtraAdminCommand(Command, temp)))
                {
                    SendText(Addr, "Command not found");
                }
            }
            break;
    }
    // End:0x138D
    if(bSendSuccess)
    {
        SendSuccess(Addr);
    }
    return;
}

function bool CheckExtraAdminCommand(string Command, string temp)
{
    return false;
    return;
}

event ReceivedText(IpAddr Addr, string Text)
{
    local int i;

    i = Admin.GetNumberOfIRCBots();
    // End:0x39
    if(__NFUN_154__(Level.Game.MaxPlayers, 0))
    {
        i = 0;
    }
    __NFUN_162__(Level.Game.MaxPlayers, i);
    ReceivedTextToProcess(Addr, Text);
    __NFUN_161__(Level.Game.MaxPlayers, i);
    return;
}

function string BuildFullBeaconExtText()
{
    return __NFUN_112__(BuildBeaconText(), BuildBeaconTextExt());
    return;
}

function SetBeaconExtData(out array<string> sendcache)
{
    local int i;
    local string ReportExt;

    ReportExt = BuildFullBeaconExtText();
    J0x0C:

    // End:0x5B [Loop If]
    if(__NFUN_151__(__NFUN_125__(ReportExt), 1000))
    {
        sendcache[sendcache.Length] = __NFUN_128__(ReportExt, 1000);
        ReportExt = __NFUN_234__(ReportExt, __NFUN_147__(__NFUN_125__(ReportExt), 1000));
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x0C;
    }
    sendcache[sendcache.Length] = ReportExt;
    return;
}

function BroadCastBeaconExt(IpAddr Addr)
{
    local array<string> sendcache;

    SetBeaconExtData(sendcache);
    SendMultiplePacketData(Addr, sendcache);
    return;
}

function string BuildGamePassword()
{
    local string Text;

    Text = __NFUN_168__(Text, Level.Game.AccessControl.GetGamePassword());
    return Text;
    return;
}

function string BuildBeaconText()
{
    return super.BuildBeaconText();
    return;
}

event ReceivedTextToProcess(IpAddr Addr, string Text)
{
    switch(Text)
    {
        // End:0x23
        case "REPORTEXT":
            BroadCastBeaconExt(Addr);
            // End:0x124
            break;
        // End:0x3D
        case "BANLIST":
            BroadcastBanList(Addr);
            // End:0x124
            break;
        // End:0x57
        case "RESTKIT":
            BroadcastRestrictionKit(Addr);
            // End:0x124
            break;
        // End:0x76
        case "AVAILABLEKIT":
            BroadcastAvailableKit(Addr);
            // End:0x124
            break;
        // End:0x96
        case "AVAILABLEMAPS":
            BroadCastAvailableMaps(Addr);
            // End:0x124
            break;
        // End:0xB4
        case "REPORTQUERY":
            BroadcastBeaconQuery(Addr);
            // End:0x124
            break;
        // End:0xCD
        case "REPORT":
            BroadcastBeacon(Addr);
            // End:0x124
            break;
        // End:0xE7
        case "PREJOIN":
            RespondPreJoinQuery(Addr);
            // End:0x124
            break;
        // End:0xFFFF
        default:
            // End:0x114
            if(__NFUN_154__(__NFUN_126__(Text, __NFUN_112__(AdminString, " ")), 0))
            {
                AdminCheck(Addr, Text);                
            }
            else
            {
                ReceivedText(Addr, Text);
            }
            break;
    }
    return;
}

function int GetCurrentMapIndex()
{
    local R6GameReplicationInfo GameInfo;
    local int Result;

    GameInfo = R6GameReplicationInfo(Level.Game.GameReplicationInfo);
    // End:0x44
    if(__NFUN_119__(GameInfo, none))
    {
        Result = GameInfo.m_iMapIndex;        
    }
    else
    {
        Result = Level.Game.__NFUN_1280__();
    }
    return Result;
    return;
}

function string BuildBeaconTextExt()
{
    local string Text, ubiIDs, hits, RoundsFired, accuracy, KilledBy,
	    Health, Deaths, Team, primary, secondary,
	    primaryGadget, secondaryGadget, late, scores, RoundsPlayed,
	    Gender, ispilot;

    local int hit, fired, acc;
    local Controller Controller;
    local PlayerController PC;
    local R6ServerInfo Info;
    local int currentMapIndex;

    Info = __NFUN_1273__();
    Text = __NFUN_168__(__NFUN_112__(" ", ReportExVersionMarker), string(24));
    Controller = Level.ControllerList;
    J0x33:

    // End:0x36B [Loop If]
    if(__NFUN_119__(Controller, none))
    {
        PC = PlayerController(Controller);
        // End:0x354
        if(__NFUN_119__(PC, none))
        {
            hit = PC.PlayerReplicationInfo.m_iRoundsHit;
            fired = PC.PlayerReplicationInfo.m_iRoundFired;
            // End:0xB7
            if(__NFUN_155__(fired, 0))
            {
                acc = __NFUN_145__(__NFUN_144__(100, hit), fired);                
            }
            else
            {
                acc = 0;
            }
            ubiIDs = __NFUN_112__(__NFUN_112__(ubiIDs, "/"), PC.PlayerReplicationInfo.m_szUbiUserID);
            hits = __NFUN_112__(__NFUN_112__(hits, "/"), string(hit));
            RoundsFired = __NFUN_112__(__NFUN_112__(RoundsFired, "/"), string(fired));
            accuracy = __NFUN_112__(__NFUN_112__(accuracy, "/"), string(acc));
            KilledBy = __NFUN_112__(__NFUN_112__(KilledBy, "/"), PC.PlayerReplicationInfo.m_szKillersName);
            Health = __NFUN_112__(__NFUN_112__(Health, "/"), string(PC.PlayerReplicationInfo.m_iHealth));
            Deaths = __NFUN_112__(__NFUN_112__(Deaths, "/"), string(int(PC.PlayerReplicationInfo.Deaths)));
            Team = __NFUN_112__(__NFUN_112__(Team, "/"), string(PC.PlayerReplicationInfo.TeamID));
            primary = __NFUN_112__(__NFUN_112__(primary, "/"), PC.m_PlayerPrefs.m_WeaponName1);
            secondary = __NFUN_112__(__NFUN_112__(secondary, "/"), PC.m_PlayerPrefs.m_WeaponName2);
            primaryGadget = __NFUN_112__(__NFUN_112__(primaryGadget, "/"), PC.m_PlayerPrefs.m_WeaponGadgetName1);
            secondaryGadget = __NFUN_112__(__NFUN_112__(secondaryGadget, "/"), PC.m_PlayerPrefs.m_WeaponGadgetName2);
            late = __NFUN_112__(__NFUN_112__(late, "/"), string(int(PC.PlayerReplicationInfo.m_bJoinedTeamLate)));
            scores = __NFUN_112__(__NFUN_112__(scores, "/"), string(int(PC.PlayerReplicationInfo.Score)));
            RoundsPlayed = __NFUN_112__(__NFUN_112__(RoundsPlayed, "/"), string(PC.PlayerReplicationInfo.m_iRoundsPlayed));
            Gender = __NFUN_112__(__NFUN_112__(Gender, "/"), string(int(PC.PlayerReplicationInfo.bIsFemale)));
            ispilot = __NFUN_112__(__NFUN_112__(ispilot, "/"), string(int(PC.PlayerReplicationInfo.m_bIsEscortedPilot)));
        }
        Controller = Controller.nextController;
        // [Loop Continue]
        goto J0x33;
    }
    ReplaceText(primary, "R63rdWeapons.", "");
    ReplaceText(secondary, "R63rdWeapons.", "");
    ReplaceText(primaryGadget, "R63rdWeapons.", "");
    ReplaceText(secondaryGadget, "R63rdWeapons.", "");
    ReplaceText(primaryGadget, "R6WeaponGadgets.", "");
    ReplaceText(secondaryGadget, "R6WeaponGadgets.", "");
    ReplaceText(primary, "KCWeapons.", "");
    ReplaceText(secondary, "KCWeapons.", "");
    ReplaceText(primaryGadget, "KCWeapons.", "");
    ReplaceText(secondaryGadget, "KCWeapons.", "");
    ReplaceText(primary, "AS3rdWeapons.", "");
    ReplaceText(secondary, "AS3rdWeapons.", "");
    ReplaceText(primaryGadget, "AS3rdWeapons.", "");
    ReplaceText(secondaryGadget, "AS3rdWeapons.", "");
    ReplaceText(primaryGadget, "ASWeaponGadgets.", "");
    ReplaceText(secondaryGadget, "ASWeaponGadgets.", "");
    Text = __NFUN_168__(__NFUN_168__(Text, UbiNameMarker), ubiIDs);
    Text = __NFUN_168__(__NFUN_168__(Text, HitMarker), hits);
    Text = __NFUN_168__(__NFUN_168__(Text, RoundsFiredMarker), RoundsFired);
    Text = __NFUN_168__(__NFUN_168__(Text, AccuracyMarker), accuracy);
    Text = __NFUN_168__(__NFUN_168__(Text, KilledByMarker), KilledBy);
    Text = __NFUN_168__(__NFUN_168__(Text, HealthMarker), Health);
    Text = __NFUN_168__(__NFUN_168__(Text, DeathMarker), Deaths);
    Text = __NFUN_168__(__NFUN_168__(Text, TeamMarker), Team);
    Text = __NFUN_168__(__NFUN_168__(Text, PrimaryWeaponMarker), primary);
    Text = __NFUN_168__(__NFUN_168__(Text, SecondaryWeaponMarker), secondary);
    Text = __NFUN_168__(__NFUN_168__(Text, PrimaryWeaponGadgetMarker), primaryGadget);
    Text = __NFUN_168__(__NFUN_168__(Text, SecondaryWeaponGadgetMarker), secondaryGadget);
    Text = __NFUN_168__(__NFUN_168__(Text, JoinedTeamLateMarker), late);
    Text = __NFUN_168__(__NFUN_168__(Text, TimeUntilRoundStartMarker), string(int(__NFUN_175__(R6Info.m_fRoundStartTime, Level.TimeSeconds))));
    Text = __NFUN_168__(__NFUN_168__(Text, RoundTimeRemaingMarker), string(int(__NFUN_175__(R6Info.m_fEndingTime, Level.TimeSeconds))));
    Text = __NFUN_168__(__NFUN_168__(Text, CurrentRoundMarker), string(__NFUN_146__(R6GameReplicationInfo(R6Info.GameReplicationInfo).m_iCurrentRound, 1)));
    Text = __NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_168__(__NFUN_168__(Text, TeamScoreMarker), "/"), string(R6GameReplicationInfo(R6Info.GameReplicationInfo).m_aTeamScore[0])), "/"), string(R6GameReplicationInfo(R6Info.GameReplicationInfo).m_aTeamScore[1]));
    Text = __NFUN_168__(__NFUN_168__(Text, PlayerScoreMarker), scores);
    Text = __NFUN_168__(__NFUN_168__(Text, RoundsPlayedMarker), RoundsPlayed);
    Text = __NFUN_112__(__NFUN_168__(__NFUN_168__(Text, ServerTimeMarker), string(Level.Hour)), ":");
    // End:0x7F1
    if(__NFUN_150__(Level.Minute, 10))
    {
        Text = __NFUN_112__(Text, "0");
    }
    Text = __NFUN_112__(__NFUN_112__(Text, string(Level.Minute)), ":");
    // End:0x838
    if(__NFUN_150__(Level.Second, 10))
    {
        Text = __NFUN_112__(Text, "0");
    }
    Text = __NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_168__(__NFUN_112__(Text, string(Level.Second)), string(Level.Month)), "/"), string(Level.Day)), "/"), string(Level.Year));
    Text = __NFUN_168__(__NFUN_168__(__NFUN_168__(Text, NeedsRestartMarker), string(int(NeedsRestart))), "? ");
    Text = __NFUN_168__(__NFUN_168__(Text, GenderMarker), Gender);
    Text = __NFUN_168__(__NFUN_168__(Text, IsPilotMarker), ispilot);
    // End:0xAAA
    if(__NFUN_119__(Info, none))
    {
        Text = __NFUN_168__(__NFUN_168__(Text, CamFirstPersonMarker), string(int(Info.CamFirstPerson)));
        Text = __NFUN_168__(__NFUN_168__(Text, CamThirdPersonMarker), string(int(Info.CamThirdPerson)));
        Text = __NFUN_168__(__NFUN_168__(Text, CamFreeThirdPMarker), string(int(Info.CamFreeThirdP)));
        Text = __NFUN_168__(__NFUN_168__(Text, CamGhostMarker), string(int(Info.CamGhost)));
        Text = __NFUN_168__(__NFUN_168__(Text, CamFadeToBlackMarker), string(int(Info.CamFadeToBlack)));
        Text = __NFUN_168__(__NFUN_168__(Text, CamTeamOnlyMarker), string(int(Info.CamTeamOnly)));
        Text = __NFUN_168__(__NFUN_168__(Text, SpamThresholdMarker), string(Info.SpamThreshold));
        Text = __NFUN_168__(__NFUN_168__(Text, ChatLockDurationMarker), string(Info.ChatLockDuration));
        Text = __NFUN_168__(__NFUN_168__(Text, VoteBroadcastMaxFrequencyMarker), string(Info.VoteBroadcastMaxFrequency));
        Text = __NFUN_168__(__NFUN_168__(Text, DiffLevelMarker), string(Info.DiffLevel));
        Text = __NFUN_168__(__NFUN_168__(Text, MOTDMarker), Info.MOTD);
        Text = __NFUN_168__(__NFUN_168__(Text, ExtraVersionMarker), string(12));
    }
    Text = __NFUN_168__(__NFUN_168__(Text, CurrMapNumMarker), string(GetCurrentMapIndex()));
    // End:0xB62
    if(__NFUN_242__(Messenger.Messenger, true))
    {
        Text = __NFUN_168__(__NFUN_168__(Text, MessengerMarker), "1");
        Text = __NFUN_168__(__NFUN_168__(Text, MessengerTextZeroMarker), Messenger.MessengerText[0]);
        Text = __NFUN_168__(__NFUN_168__(Text, MessengerTextOneMarker), Messenger.MessengerText[1]);
        Text = __NFUN_168__(__NFUN_168__(Text, MessengerTextTwoMarker), Messenger.MessengerText[2]);        
    }
    else
    {
        Text = __NFUN_112__(__NFUN_168__(Text, MessengerMarker), " 0");
    }
    Text = __NFUN_168__(__NFUN_168__(Text, IRCBotMarker), string(int(__NFUN_151__(Admin.GetNumberOfIRCBots(), 0))));
    return Text;
    return;
}

function AddStringToArray(string String, out array<string> Array)
{
    // End:0x17
    if(__NFUN_154__(Array.Length, 0))
    {
        Array.Length = 1;        
    }
    else
    {
        // End:0x4F
        if(__NFUN_151__(__NFUN_146__(__NFUN_125__(String), __NFUN_125__(Array[__NFUN_147__(Array.Length, 1)])), __NFUN_147__(1000, 100)))
        {
            Array.Length = __NFUN_146__(Array.Length, 1);
        }
    }
    Array[__NFUN_147__(Array.Length, 1)] = __NFUN_168__(Array[__NFUN_147__(Array.Length, 1)], String);
    return;
}

function SendMultiplePacketData(IpAddr Addr, array<string> data)
{
    local int i, NumberOfPackets;
    local string packet;

    NumberOfPackets = data.Length;
    // End:0x3F
    if(__NFUN_154__(NumberOfPackets, 0))
    {
        SendText(Addr, "error no packets to send");        
    }
    else
    {
        J0x3F:

        // End:0xA1 [Loop If]
        if(__NFUN_150__(i, NumberOfPackets))
        {
            packet = __NFUN_168__(__NFUN_168__(__NFUN_168__(__NFUN_168__(__NFUN_112__(" ", NumberOfPacketsMarker), string(NumberOfPackets)), data[i]), PacketNumberMarker), string(__NFUN_146__(i, 1)));
            SendText(Addr, packet);
            __NFUN_165__(i);
            // [Loop Continue]
            goto J0x3F;
        }
    }
    return;
}

function BroadCastAvailableMaps(IpAddr Addr)
{
    local array<string> packets;

    packets = BuildAvailableMaps();
    SendMultiplePacketData(Addr, packets);
    return;
}

function BroadcastAvailableKit(IpAddr Addr)
{
    local array<string> packets;

    packets = BuildAvailableKit();
    SendMultiplePacketData(Addr, packets);
    return;
}

function BroadcastBanList(IpAddr Addr)
{
    local array<string> packets;

    packets = BuildBanList();
    SendMultiplePacketData(Addr, packets);
    return;
}

function BroadcastRestrictionKit(IpAddr Addr)
{
    local array<string> packets;

    packets = BuildRestrictionKit();
    SendMultiplePacketData(Addr, packets);
    return;
}

function array<string> BuildAvailableKit()
{
    local array<string> data;
    local R6ServerInfo Options;

    Options = __NFUN_1273__();
    // End:0x187
    if(__NFUN_130__(__NFUN_119__(Options, none), __NFUN_119__(Admin, none)))
    {
        BuildClassArrayString(Admin.AvailableSubMachineGuns, __NFUN_112__(AvailableWeaponMarker, string(0)), data);
        BuildClassArrayString(Admin.AvailableShotGuns, __NFUN_112__(AvailableWeaponMarker, string(1)), data);
        BuildClassArrayString(Admin.AvailableAssultRifles, __NFUN_112__(AvailableWeaponMarker, string(2)), data);
        BuildClassArrayString(Admin.AvailableMachineGuns, __NFUN_112__(AvailableWeaponMarker, string(3)), data);
        BuildClassArrayString(Admin.AvailableSniperRifles, __NFUN_112__(AvailableWeaponMarker, string(4)), data);
        BuildClassArrayString(Admin.AvailablePistols, __NFUN_112__(AvailableWeaponMarker, string(5)), data);
        BuildClassArrayString(Admin.AvailableMachinePistols, __NFUN_112__(AvailableWeaponMarker, string(6)), data);
        BuildStringArrayString(Admin.AvailablePrimary, __NFUN_112__(AvailableWeaponMarker, string(7)), data);
        BuildStringArrayString(Admin.AvailableSecondary, __NFUN_112__(AvailableWeaponMarker, string(8)), data);
        BuildStringArrayString(Admin.AvailableMiscGadgets, __NFUN_112__(AvailableWeaponMarker, string(9)), data);
    }
    return data;
    return;
}

function array<string> BuildAvailableMaps()
{
    local array<string> data;
    local int i, j;
    local array<R6MissionDescription> missions;
    local R6MissionDescription mission;
    local string temp;
    local R6ModMgr mgr;

    mgr = __NFUN_1524__();
    missions = Admin.GetAllMissions();
    J0x1E:

    // End:0x19A [Loop If]
    if(__NFUN_150__(i, missions.Length))
    {
        mission = missions[i];
        // End:0x190
        if(__NFUN_119__(mission, none))
        {
            temp = __NFUN_112__(__NFUN_168__(AvailableMapMarker, mission.m_MapName), ":");
            j = 0;
            J0x71:

            // End:0x180 [Loop If]
            if(__NFUN_150__(j, mission.m_szGameTypes.Length))
            {
                // End:0x176
                if(__NFUN_130__(__NFUN_130__(mgr.IsGameTypeAvailable(mission.m_szGameTypes[j]), __NFUN_242__(Level.IsGameTypeCooperative(mission.m_szGameTypes[j]), Level.IsGameTypeCooperative(Level.Game.m_szCurrGameType))), __NFUN_242__(Level.IsGameTypeAdversarial(mission.m_szGameTypes[j]), Level.IsGameTypeAdversarial(Level.Game.m_szCurrGameType))))
                {
                    temp = __NFUN_112__(__NFUN_112__(temp, mission.m_szGameTypes[j]), "/");
                }
                __NFUN_165__(j);
                // [Loop Continue]
                goto J0x71;
            }
            AddStringToArray(temp, data);
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x1E;
    }
    return data;
    return;
}

function array<string> BuildBanList()
{
    local int i;
    local array<string> data;

    J0x00:
    // End:0x76 [Loop If]
    if(__NFUN_150__(i, Level.Game.AccessControl.Banned.Length))
    {
        AddStringToArray(__NFUN_168__(__NFUN_112__(BanListMarker, string(i)), Level.Game.AccessControl.Banned[i]), data);
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x00;
    }
    return data;
    return;
}

function array<string> BuildRestrictionKit()
{
    local array<string> data;
    local R6ServerInfo Options;

    Options = __NFUN_1273__();
    // End:0x17A
    if(__NFUN_119__(Options, none))
    {
        BuildClassArrayString(Options.RestrictedSubMachineGuns, __NFUN_112__(RestrictedMarker, string(0)), data);
        BuildClassArrayString(Options.RestrictedShotGuns, __NFUN_112__(RestrictedMarker, string(1)), data);
        BuildClassArrayString(Options.RestrictedAssultRifles, __NFUN_112__(RestrictedMarker, string(2)), data);
        BuildClassArrayString(Options.RestrictedMachineGuns, __NFUN_112__(RestrictedMarker, string(3)), data);
        BuildClassArrayString(Options.RestrictedSniperRifles, __NFUN_112__(RestrictedMarker, string(4)), data);
        BuildClassArrayString(Options.RestrictedPistols, __NFUN_112__(RestrictedMarker, string(5)), data);
        BuildClassArrayString(Options.RestrictedMachinePistols, __NFUN_112__(RestrictedMarker, string(6)), data);
        BuildStringArrayString(Options.RestrictedPrimary, __NFUN_112__(RestrictedMarker, string(7)), data);
        BuildStringArrayString(Options.RestrictedSecondary, __NFUN_112__(RestrictedMarker, string(8)), data);
        BuildStringArrayString(Options.RestrictedMiscGadgets, __NFUN_112__(RestrictedMarker, string(9)), data);
    }
    return data;
    return;
}

function BuildStringArrayString(array<string> Array, string marker, out array<string> data)
{
    local int i;
    local string String;

    // End:0x28
    if(__NFUN_154__(Array.Length, 0))
    {
        AddStringToArray(__NFUN_112__(marker, "/none"), data);        
    }
    else
    {
        J0x28:

        // End:0x6F [Loop If]
        if(__NFUN_150__(i, Array.Length))
        {
            String = __NFUN_112__(__NFUN_112__(marker, "/"), Array[i]);
            AddStringToArray(String, data);
            __NFUN_165__(i);
            // [Loop Continue]
            goto J0x28;
        }
    }
    return;
}

function BuildClassArrayString(array< Class > Array, string marker, out array<string> data)
{
    local int i;
    local string String;

    // End:0x28
    if(__NFUN_154__(Array.Length, 0))
    {
        AddStringToArray(__NFUN_112__(marker, "/none"), data);        
    }
    else
    {
        J0x28:

        // End:0x71 [Loop If]
        if(__NFUN_150__(i, Array.Length))
        {
            String = __NFUN_112__(__NFUN_112__(marker, "/"), string(Array[i]));
            AddStringToArray(String, data);
            __NFUN_165__(i);
            // [Loop Continue]
            goto J0x28;
        }
    }
    return;
}

function bool PrejoinNeedsPassword()
{
    // End:0x1A
    if(FakePasswordInfo.Fake)
    {
        return FakePasswordInfo.Value;
    }
    return Level.Game.AccessControl.GamePasswordNeeded();
    return;
}

function int GetPrejoinLobbyID()
{
    // End:0x0B
    if(UbiServerFullFix)
    {
        return 0;
    }
    return Level.Game.GameReplicationInfo.m_iGameSvrLobbyID;
    return;
}

function int GetPrejoinGroupID()
{
    // End:0x0B
    if(UbiServerFullFix)
    {
        return 0;
    }
    return Level.Game.GameReplicationInfo.m_iGameSvrGroupID;
    return;
}

function string GetPrejoinGameVersion(optional bool short)
{
    return Level.__NFUN_1419__(short);
    return;
}

function int GetPrejoinMaxPlayers()
{
    return Level.Game.MaxPlayers;
    return;
}

function bool GetPrejoinPunkBuster()
{
    // End:0x1A
    if(FakePBInfo.Fake)
    {
        return FakePBInfo.Value;
    }
    return Level.m_bPBSvRunning;
    return;
}

function int GetPrejoinNumberOfPlayers()
{
    local int players;
    local PlayerController PC;

    // End:0x0B
    if(NeverFull)
    {
        return 0;
    }
    // End:0x4B
    foreach __NFUN_313__(Class'Engine.PlayerController', PC)
    {
        // End:0x4A
        if(__NFUN_130__(PC.bIsPlayer, __NFUN_119__(PC.PlayerReplicationInfo, none)))
        {
            __NFUN_165__(players);
        }        
    }    
    return players;
    return;
}

function string BuildPreJoinData()
{
    local string Result;
    local R6ServerInfo ServerInfo;

    ServerInfo = Class'Engine.Actor'.static.__NFUN_1273__();
    Result = PreJoinQueryMarker;
    Result = __NFUN_168__(__NFUN_168__(Result, LobbyServerIDMarker), string(GetPrejoinLobbyID()));
    Result = __NFUN_168__(__NFUN_168__(Result, GroupIDMarker), string(GetPrejoinGroupID()));
    Result = __NFUN_168__(__NFUN_168__(Result, LockedMarker), string(int(PrejoinNeedsPassword())));
    Result = __NFUN_168__(__NFUN_168__(Result, GameVersionMarker), GetPrejoinGameVersion());
    Result = __NFUN_168__(__NFUN_168__(Result, InternetServerMarker), string(int(ServerInfo.InternetServer)));
    Result = __NFUN_168__(__NFUN_168__(Result, PunkBusterMarker), string(int(GetPrejoinPunkBuster())));
    Result = __NFUN_168__(__NFUN_168__(Result, MaxPlayersMarker), string(GetPrejoinMaxPlayers()));
    Result = __NFUN_168__(__NFUN_168__(Result, NumPlayersMarker), string(GetPrejoinNumberOfPlayers()));
    return Result;
    return;
}

function RespondFakePreJoinQuery(IpAddr Addr)
{
    SendText(Addr, __NFUN_168__(__NFUN_168__(BeaconProduct, __NFUN_127__(Level.GetAddressURL(), __NFUN_146__(__NFUN_126__(Level.GetAddressURL(), ":"), 1))), BuildPreJoinData()));
    return;
}

function bool ShouldUseFakePreJoinQuery()
{
    return __NFUN_130__(__NFUN_132__(__NFUN_132__(__NFUN_132__(NeverFull, UbiServerFullFix), FakePasswordInfo.Fake), FakePBInfo.Fake), __NFUN_129__(ForceNormalPrejoin));
    return;
}

function RespondPreJoinQuery(IpAddr Addr)
{
    local int i;
    local PlayerController Player;

    i = Admin.GetNumberOfIRCBots();
    __NFUN_161__(Level.Game.MaxPlayers, i);
    // End:0x4A
    if(ShouldUseFakePreJoinQuery())
    {
        RespondFakePreJoinQuery(Addr);        
    }
    else
    {
        super.RespondPreJoinQuery(Addr);
    }
    __NFUN_162__(Level.Game.MaxPlayers, i);
    return;
}

defaultproperties
{
    RemoteAdmin=true
    ForceNormalPrejoin=true
    FakePBInfo=(Value=true)
    FakePasswordInfo=(Value=true)
    AdminString="ADMIN"
    UbiNameMarker="?UB"
    HitMarker="?HI"
    RoundsFiredMarker="?RF"
    AccuracyMarker="?AC"
    KilledByMarker="?KB"
    HealthMarker="?HE"
    DeathMarker="?DE"
    TeamMarker="?TE"
    PrimaryWeaponMarker="?PW"
    SecondaryWeaponMarker="?SW"
    PrimaryWeaponGadgetMarker="?PG"
    SecondaryWeaponGadgetMarker="?SG"
    JoinedTeamLateMarker="?LA"
    ServerTimeMarker="?ST"
    TimeUntilRoundStartMarker="?TU"
    RoundTimeRemaingMarker="?TR"
    CurrentRoundMarker="?CR"
    TeamScoreMarker="?TS"
    PlayerScoreMarker="?PS"
    RoundsPlayedMarker="?RP"
    ReportExVersionMarker="?RE"
    ExtraPacketMarker="?EP"
    NeedsRestartMarker="?NR"
    IRCBotMarker="?IR"
    PacketNumberMarker="?PN"
    NumberOfPacketsMarker="?NP"
    RestrictedMarker="?R"
    AvailableWeaponMarker="?A"
    AvailableMapMarker="?AM"
    CamFirstPersonMarker="?C1"
    CamThirdPersonMarker="?C3"
    CamFreeThirdPMarker="?CP"
    CamGhostMarker="?CG"
    CamFadeToBlackMarker="?CF"
    CamTeamOnlyMarker="?CT"
    SpamThresholdMarker="?SH"
    ChatLockDurationMarker="?CL"
    VoteBroadcastMaxFrequencyMarker="?VF"
    DiffLevelMarker="?DL"
    MOTDMarker="?MM"
    BanListMarker="?BL"
    ExtraVersionMarker="?EV"
    GenderMarker="?GM"
    IsPilotMarker="?IP"
    CurrMapNumMarker="?MN"
    MessengerMarker="?ME"
    MessengerTextZeroMarker="?TA"
    MessengerTextOneMarker="?TB"
    MessengerTextTwoMarker="?TC"
}