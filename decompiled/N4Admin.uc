class N4Admin extends ReplicationInfo
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

struct Moo
{
    var int i;
};

var config int MaxObjectSearchCount;
var array<R6MissionDescription> missions;
var array< Class > AvailableSubMachineGuns;
var array< Class > AvailableShotGuns;
var array< Class > AvailableAssultRifles;
var array< Class > AvailableMachineGuns;
var array< Class > AvailableSniperRifles;
var array< Class > AvailablePistols;
var array< Class > AvailableMachinePistols;
var array<string> AvailablePrimary;
var array<string> AvailableSecondary;
var array<string> AvailableMiscGadgets;
var() globalconfig string RemoteAdminName;
var string RemoteString;

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    return;
}

function bool BuildAllAvailableWeaponsAndGadgets()
{
    local bool Result;

    AvailableSubMachineGuns.Length = 0;
    AvailableShotGuns.Length = 0;
    AvailableAssultRifles.Length = 0;
    AvailableMachineGuns.Length = 0;
    AvailableSniperRifles.Length = 0;
    AvailablePistols.Length = 0;
    AvailableMachinePistols.Length = 0;
    AvailablePrimary.Length = 0;
    AvailableSecondary.Length = 0;
    AvailableMiscGadgets.Length = 0;
    Result = GetAvailableWeaponsGadgets(AvailablePrimary, AvailableSecondary);
    Result = __NFUN_130__(Result, GetAvailableGadgets(AvailableMiscGadgets));
    Result = __NFUN_130__(Result, GetAvailableGuns(Class'R6Description.R6SubGunDescription', AvailableSubMachineGuns));
    Result = __NFUN_130__(Result, GetAvailableGuns(Class'R6Description.R6ShotgunDescription', AvailableShotGuns));
    Result = __NFUN_130__(Result, GetAvailableGuns(Class'R6Description.R6AssaultDescription', AvailableAssultRifles));
    Result = __NFUN_130__(Result, GetAvailableGuns(Class'R6Description.R6LMGDescription', AvailableMachineGuns));
    Result = __NFUN_130__(Result, GetAvailableGuns(Class'R6Description.R6SniperDescription', AvailableSniperRifles));
    Result = __NFUN_130__(Result, GetAvailableGuns(Class'R6Description.R6PistolsDescription', AvailablePistols));
    Result = __NFUN_130__(Result, GetAvailableGuns(Class'R6Description.R6MachinePistolsDescription', AvailableMachinePistols));
    return Result;
    return;
}

function bool GetAvailableGadgets(out array<string> Misc)
{
    local R6ModMgr mgr;
    local int i;
    local class<R6GadgetDescription> Item;

    mgr = __NFUN_1524__();
    // End:0x2C
    if(__NFUN_132__(__NFUN_114__(mgr, none), __NFUN_114__(mgr.m_pCurrentMod, none)))
    {
        return false;
    }
    i = 0;
    J0x33:

    // End:0xFC [Loop If]
    if(__NFUN_150__(i, mgr.m_pCurrentMod.m_aDescriptionPackage.Length))
    {
        Item = class<R6GadgetDescription>(__NFUN_1005__(__NFUN_112__(mgr.m_pCurrentMod.m_aDescriptionPackage[i], ".u"), Class'R6Description.R6GadgetDescription'));
        J0x8B:

        // End:0xF2 [Loop If]
        if(__NFUN_119__(Item, none))
        {
            // End:0xE1
            if(__NFUN_130__(__NFUN_123__(Item.default.m_NameID, ""), __NFUN_129__(__NFUN_124__(Item.default.m_NameID, "NONE"))))
            {
                AddStringToArray(Item.default.m_NameID, Misc);
            }
            Item = class<R6GadgetDescription>(__NFUN_1006__());
            // [Loop Continue]
            goto J0x8B;
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x33;
    }
    return true;
    return;
}

function bool GetAvailableWeaponsGadgets(out array<string> primary, out array<string> secondary)
{
    local R6ModMgr mgr;
    local int i;
    local class<R6WeaponGadgetDescription> Item;

    mgr = __NFUN_1524__();
    // End:0x2C
    if(__NFUN_132__(__NFUN_114__(mgr, none), __NFUN_114__(mgr.m_pCurrentMod, none)))
    {
        return false;
    }
    i = 0;
    J0x33:

    // End:0x139 [Loop If]
    if(__NFUN_150__(i, mgr.m_pCurrentMod.m_aDescriptionPackage.Length))
    {
        Item = class<R6WeaponGadgetDescription>(__NFUN_1005__(__NFUN_112__(mgr.m_pCurrentMod.m_aDescriptionPackage[i], ".u"), Class'R6Description.R6WeaponGadgetDescription'));
        J0x8B:

        // End:0x12F [Loop If]
        if(__NFUN_119__(Item, none))
        {
            // End:0x11E
            if(__NFUN_130__(__NFUN_123__(Item.default.m_NameID, ""), __NFUN_129__(__NFUN_124__(Item.default.m_NameID, "NONE"))))
            {
                // End:0xF3
                if(Item.default.m_bPriGadgetWAvailable)
                {
                    AddStringToArray(Item.default.m_NameID, primary);
                }
                // End:0x11E
                if(Item.default.m_bSecGadgetWAvailable)
                {
                    AddStringToArray(Item.default.m_NameID, secondary);
                }
            }
            Item = class<R6WeaponGadgetDescription>(__NFUN_1006__());
            // [Loop Continue]
            goto J0x8B;
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x33;
    }
    return true;
    return;
}

function bool GetAvailableGuns(class<R6Description> DescriptionType, out array< Class > Descriptions)
{
    local R6ModMgr mgr;
    local int i;
    local class<R6Description> Item;

    mgr = __NFUN_1524__();
    // End:0x39
    if(__NFUN_132__(__NFUN_132__(__NFUN_114__(mgr, none), __NFUN_114__(mgr.m_pCurrentMod, none)), __NFUN_114__(DescriptionType, none)))
    {
        return false;
    }
    J0x39:

    // End:0xC7 [Loop If]
    if(__NFUN_150__(i, mgr.m_pCurrentMod.m_aDescriptionPackage.Length))
    {
        Item = class<R6Description>(__NFUN_1005__(__NFUN_112__(mgr.m_pCurrentMod.m_aDescriptionPackage[i], ".u"), DescriptionType));
        J0x91:

        // End:0xBD [Loop If]
        if(__NFUN_119__(Item, none))
        {
            AddClassToArray(Item, Descriptions);
            Item = class<R6Description>(__NFUN_1006__());
            // [Loop Continue]
            goto J0x91;
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x39;
    }
    return true;
    return;
}

function int GetMaxPlayers()
{
    return __NFUN_147__(Level.Game.MaxPlayers, GetNumberOfIRCBots());
    return;
}

function bool LockServer(optional string NewPassword)
{
    // End:0x10
    if(__NFUN_151__(__NFUN_125__(NewPassword), 16))
    {
        return false;
    }
    Level.Game.SetGamePassword(NewPassword);
    return true;
    return;
}

function bool FindFile(string FileName)
{
    local R6FileManager FileManager;

    FileManager = new (none) Class'Engine.R6FileManager';
    return FileManager.__NFUN_1528__(FileName);
    return;
}

function bool LoadServer(string FileName)
{
    // End:0x12
    if(__NFUN_129__(FindFile(FileName)))
    {
        return false;
    }
    N4ConsoleCommand(__NFUN_168__("INGAMELOADSERVER", FileName));
    return true;
    return;
}

function string Quotes(coerce string S)
{
    return __NFUN_112__(__NFUN_112__("\"", S), "\"");
    return;
}

function N4SetCommand(string S)
{
    local string ClassName, Value;

    SplitAroundFirstSpace(S, ClassName, Value);
    N4Set(ClassName, Value);
    return;
}

function N4Set(string ClassName, string Cmd)
{
    local Class ObjectClass;
    local string Property, Value;

    ObjectClass = class<Object>(DynamicLoadObject(ClassName, Class'Core.Class'));
    // End:0x50
    if(__NFUN_119__(ObjectClass, none))
    {
        SplitAroundFirstSpace(Cmd, Property, Value);
        N4SetObject(ObjectClass, Property, Value);
    }
    return;
}

function N4SetObject(Class ObjectClass, string Property, coerce string Value)
{
    local class<Actor> ActorClass;
    local string objectNameString;
    local Object tempObject;
    local int i;
    local string MapPrefix, transientPrefix;

    transientPrefix = "Transient.";
    // End:0x2E
    if(__NFUN_132__(__NFUN_114__(ObjectClass, none), __NFUN_152__(__NFUN_125__(Property), 0)))
    {
        return;
    }
    ActorClass = class<Actor>(ObjectClass);
    // End:0x60
    if(__NFUN_119__(ActorClass, none))
    {
        N4SetActor(ActorClass, Property, Value);
        return;
    }
    MapPrefix = __NFUN_112__(GetMapObjectName(), ".");
    objectNameString = string(ObjectClass.Name);
    i = 0;
    J0x8E:

    // End:0xFB [Loop If]
    if(__NFUN_150__(i, MaxObjectSearchCount))
    {
        N4FindAndSet(ObjectClass, __NFUN_112__(__NFUN_112__(MapPrefix, objectNameString), string(i)), Property, Value);
        N4FindAndSet(ObjectClass, __NFUN_112__(__NFUN_112__(transientPrefix, objectNameString), string(i)), Property, Value);
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x8E;
    }
    return;
}

function N4FindAndSet(Class ObjectClass, string ObjectName, string Property, string Value)
{
    local Object tempObject;

    tempObject = FindObject(ObjectName, Class'Core.Object');
    // End:0x36
    if(__NFUN_119__(tempObject, none))
    {
        N4ObjectInstanceSet(tempObject, Property, Value);
    }
    return;
}

function string GetMapObjectName()
{
    local int ITemp;
    local string oname, Str;

    oname = string(self);
    ITemp = __NFUN_126__(oname, ".");
    Str = __NFUN_128__(oname, ITemp);
    return Str;
    return;
}

function N4ObjectInstanceSet(Object o, string Property, coerce string Value)
{
    // End:0x0D
    if(__NFUN_114__(o, none))
    {
        return;
    }
    o.SetPropertyText(Property, Value);
    o.__NFUN_536__();
    return;
}

function N4SetActor(class<Actor> ActorClass, string Property, coerce string Value)
{
    local Actor A;
    local name actorClassName;

    // End:0x1C
    if(__NFUN_132__(__NFUN_114__(ActorClass, none), __NFUN_152__(__NFUN_125__(Property), 0)))
    {
        return;
    }
    actorClassName = ActorClass.Name;
    // End:0x56
    foreach __NFUN_304__(ActorClass, A)
    {
        N4ObjectInstanceSet(A, Property, Value);        
    }    
    return;
}

function SplitAroundFirstSpace(string S, out string A, out string B)
{
    local int ITemp;

    ITemp = __NFUN_126__(S, " ");
    // End:0x45
    if(__NFUN_153__(ITemp, 0))
    {
        A = __NFUN_128__(S, ITemp);
        B = __NFUN_127__(S, __NFUN_146__(ITemp, 1));        
    }
    else
    {
        A = S;
    }
    return;
}

function N4ConsoleCommand(string S)
{
    local string Cmd, data;

    SplitAroundFirstSpace(S, Cmd, data);
    // End:0x32
    if(__NFUN_124__(Cmd, "set"))
    {
        N4SetCommand(data);        
    }
    else
    {
        Level.ConsoleCommand(S);
    }
    return;
}

function bool SetServerOption(string variableAndValue)
{
    local R6ServerInfo Options;

    N4ConsoleCommand(__NFUN_168__(__NFUN_168__("set", "Engine.R6ServerInfo"), variableAndValue));
    Options = __NFUN_1273__();
    // End:0x49
    if(__NFUN_119__(Options, none))
    {
        Options.__NFUN_536__();
    }
    return true;
    return;
}

function bool RestartRound(string AdminName, string explanation)
{
    local R6PlayerController aPC;

    // End:0x21
    if(__NFUN_123__(AdminName, ""))
    {
        AdminName = __NFUN_168__(AdminName, RemoteString);        
    }
    else
    {
        AdminName = RemoteString;
    }
    // End:0x65
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', aPC)
    {
        aPC.ClientDisableFirstPersonViewEffects();
        aPC.ClientRestartRoundMsg(AdminName, explanation);        
    }    
    Level.Game.__NFUN_1210__();
    R6AbstractGameInfo(Level.Game).AdminResetRound();
    R6AbstractGameInfo(Level.Game).ResetRound();
    R6AbstractGameInfo(Level.Game).ResetPenalty();
    return true;
    return;
}

function bool RestartServer()
{
    Level.m_ServerSettings.RestartServer();
    return true;
    return;
}

function bool RestartMatch(string AdminName, string explanation)
{
    local R6PlayerController aPC;

    // End:0x21
    if(__NFUN_123__(AdminName, ""))
    {
        AdminName = __NFUN_168__(AdminName, RemoteString);        
    }
    else
    {
        AdminName = RemoteString;
    }
    // End:0x65
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', aPC)
    {
        aPC.ClientDisableFirstPersonViewEffects();
        aPC.ClientRestartMatchMsg(AdminName, explanation);        
    }    
    // End:0xA7
    if(__NFUN_119__(Level.Game, none))
    {
        Level.Game.__NFUN_1210__();
        Level.Game.RestartGame();
    }
    return true;
    return;
}

function bool GetPlayerByUbiID(string PlayerUbi, out R6PlayerController Player)
{
    local R6PlayerController tempPlayer;

    // End:0x40
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', tempPlayer)
    {
        // End:0x3F
        if(__NFUN_124__(tempPlayer.PlayerReplicationInfo.m_szUbiUserID, PlayerUbi))
        {
            Player = tempPlayer;            
            return true;
        }        
    }    
    return false;
    return;
}

function bool GetPlayerByName(string PlayerName, out R6PlayerController Player)
{
    local R6PlayerController tempPlayer;

    // End:0x40
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', tempPlayer)
    {
        // End:0x3F
        if(__NFUN_124__(tempPlayer.PlayerReplicationInfo.PlayerName, PlayerName))
        {
            Player = tempPlayer;            
            return true;
        }        
    }    
    return false;
    return;
}

function bool KickPlayerUbi(string PlayerName, bool Ban)
{
    local R6PlayerController Player;

    // End:0x3B
    if(GetPlayerByUbiID(PlayerName, Player))
    {
        // End:0x3B
        if(__NFUN_129__(Player.__NFUN_303__('IRCSpectator')))
        {
            return KickPlayer(Player, Ban);
        }
    }
    return false;
    return;
}

function bool KickPlayerName(string PlayerName, bool Ban)
{
    local R6PlayerController Player;

    // End:0x28
    if(GetPlayerByName(PlayerName, Player))
    {
        return KickPlayer(Player, Ban);        
    }
    else
    {
        return false;
    }
    return;
}

function bool KickPlayer(R6PlayerController victim, bool Ban)
{
    local R6PlayerController Player;
    local string Msg;

    // End:0x23
    if(__NFUN_132__(__NFUN_114__(victim, none), __NFUN_114__(Level.Game, none)))
    {
        return false;
    }
    Msg = "a remote admin";
    // End:0x61
    if(__NFUN_123__(RemoteAdminName, ""))
    {
        Msg = __NFUN_112__(__NFUN_112__(__NFUN_112__(Msg, "("), RemoteAdminName), ")");
    }
    // End:0x9D
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', Player)
    {
        Player.ClientAdminKickOff(Msg, victim.PlayerReplicationInfo.PlayerName);        
    }    
    // End:0xF1
    if(Ban)
    {
        Level.Game.AccessControl.KickBan(victim.PlayerReplicationInfo.PlayerName);
        victim.ClientBanned();        
    }
    else
    {
        victim.ClientKickedOut();
    }
    return true;
    return;
}

function BroadcastAdminMessage(string Text, optional string From)
{
    local R6PlayerController Player;

    // End:0x17
    if(__NFUN_122__(From, ""))
    {
        From = RemoteAdminName;
    }
    Text = __NFUN_168__(__NFUN_168__(From, RemoteString), Text);
    // End:0x60
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', Player)
    {
        Player.TeamMessage(none, Text, self.Name);        
    }    
    return;
}

function int IsValidMap(int Map)
{
    // End:0x22
    if(__NFUN_132__(__NFUN_150__(Map, 0), __NFUN_151__(Map, 31)))
    {
        return -1;        
    }
    else
    {
        // End:0x4A
        if(__NFUN_122__(__NFUN_1273__().m_ServerMapList.Maps[Map], ""))
        {
            return -2;
        }
    }
    return 0;
    return;
}

function int ChangeMap(int MapIndex, string Reason, optional string by)
{
    local R6PlayerController Player;
    local string MapName;
    local R6GameReplicationInfo Game;
    local int Valid;

    Valid = IsValidMap(MapIndex);
    // End:0x22
    if(__NFUN_150__(Valid, 0))
    {
        return Valid;
    }
    // End:0x39
    if(__NFUN_122__(by, ""))
    {
        by = RemoteAdminName;
    }
    by = __NFUN_168__(by, RemoteString);
    MapName = __NFUN_1273__().m_ServerMapList.Maps[MapIndex];
    // End:0xA2
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', Player)
    {
        Player.ClientServerMap(__NFUN_168__(by, RemoteString), MapName, Reason);        
    }    
    R6AbstractGameInfo(Level.Game).EndGameAndJumpToMapID(MapIndex);
    return 0;
    return;
}

function bool SaveToServerFile(Object obj)
{
    local R6ModMgr mgr;

    mgr = __NFUN_1524__();
    // End:0x23
    if(__NFUN_132__(__NFUN_114__(mgr, none), __NFUN_114__(obj, none)))
    {
        return false;
    }
    obj.__NFUN_536__(__NFUN_112__(mgr.GetServerIni(), ".ini"));
    return true;
    return;
}

function int RemoveMap(int MapIndex)
{
    local int Valid;
    local R6GameReplicationInfo GameInfo;
    local R6MapList MapList;
    local R6ModMgr mgr;

    mgr = __NFUN_1524__();
    // End:0x1A
    if(__NFUN_114__(mgr, none))
    {
        return -8;
    }
    Valid = IsValidMap(MapIndex);
    // End:0x3C
    if(__NFUN_150__(Valid, 0))
    {
        return Valid;
    }
    GameInfo = R6GameReplicationInfo(Level.Game.GameReplicationInfo);
    // End:0x6F
    if(__NFUN_114__(GameInfo, none))
    {
        return -6;
    }
    MapList = __NFUN_1273__().m_ServerMapList;
    // End:0x92
    if(__NFUN_114__(MapList, none))
    {
        return -7;
    }
    // End:0xBC
    if(__NFUN_130__(__NFUN_154__(MapIndex, 0), __NFUN_122__(MapList.Maps[1], "")))
    {
        return -5;
    }
    J0xBC:

    // End:0x12A [Loop If]
    if(__NFUN_150__(MapIndex, 31))
    {
        MapList.Maps[MapIndex] = MapList.Maps[__NFUN_146__(MapIndex, 1)];
        MapList.GameType[MapIndex] = MapList.GameType[__NFUN_146__(MapIndex, 1)];
        __NFUN_165__(MapIndex);
        // [Loop Continue]
        goto J0xBC;
    }
    MapList.Maps[31] = "";
    MapList.GameType[31] = "";
    MapList.__NFUN_536__(__NFUN_112__(mgr.GetServerIni(), ".ini"));
    return 0;
    return;
}

function int AddMap(string MapName, string GameTypeClass, int MapIndex)
{
    local R6GameReplicationInfo GameInfo;
    local R6MissionDescription mission;
    local string MapDir, GameTypeClassTrans;
    local R6ModMgr mgr;
    local R6MapList MapList;
    local int i;

    MapList = __NFUN_1273__().m_ServerMapList;
    mgr = __NFUN_1524__();
    // End:0x3A
    if(__NFUN_132__(__NFUN_150__(MapIndex, 0), __NFUN_151__(MapIndex, 31)))
    {
        return -1;
    }
    // End:0x4B
    if(__NFUN_114__(MapList, none))
    {
        return -7;
    }
    // End:0x80
    if(FindFile(__NFUN_112__(__NFUN_112__("..\\maps\\", MapName), ".rsm")))
    {
        MapDir = "..\\maps\\";        
    }
    else
    {
        // End:0x134
        if(__NFUN_130__(__NFUN_130__(__NFUN_130__(__NFUN_119__(mgr, none), __NFUN_129__(mgr.IsRavenShield())), __NFUN_119__(mgr.m_pCurrentMod, none)), FindFile(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_112__("..\\Mods\\", mgr.m_pCurrentMod.m_szKeyWord), "\\maps\\"), MapName), ".rsm"))))
        {
            MapDir = __NFUN_112__(__NFUN_112__("..\\Mods\\", mgr.m_pCurrentMod.m_szKeyWord), "\\maps\\");            
        }
        else
        {
            return -10;
        }
    }
    // End:0x15F
    if(__NFUN_129__(FindFile(__NFUN_112__(__NFUN_112__(MapDir, MapName), ".ini"))))
    {
        return -11;
    }
    mission = new (none) Class'Engine.R6MissionDescription';
    // End:0x1A1
    if(__NFUN_129__(mission.Init(Level, __NFUN_112__(__NFUN_112__(MapDir, MapName), ".ini"))))
    {
        return -12;
    }
    // End:0x1C0
    if(__NFUN_129__(mission.IsAvailableInGameType(GameTypeClass)))
    {
        return -14;
    }
    // End:0x1D3
    if(__NFUN_129__(__NFUN_1513__(GameTypeClass)))
    {
        return -13;
    }
    // End:0x397
    if(__NFUN_130__(__NFUN_242__(Level.IsGameTypeCooperative(GameTypeClass), Level.IsGameTypeCooperative(Level.Game.m_szCurrGameType)), __NFUN_242__(Level.IsGameTypeAdversarial(GameTypeClass), Level.IsGameTypeAdversarial(Level.Game.m_szCurrGameType))))
    {
        GameInfo = R6GameReplicationInfo(Level.Game.GameReplicationInfo);
        // End:0x2B4
        if(__NFUN_130__(__NFUN_155__(MapIndex, 0), __NFUN_122__(MapList.Maps[__NFUN_147__(MapIndex, 1)], "")))
        {
            MapIndex = GetNextAvaliableMapSlot(MapList);            
        }
        else
        {
            // End:0x2D0
            if(__NFUN_155__(MapIndex, 31))
            {
                ShiftMapListRight(MapList, MapIndex);
            }
        }
        J0x2D0:

        // End:0x38E [Loop If]
        if(__NFUN_150__(i, Level.m_aGameTypeInfo.Length))
        {
            // End:0x384
            if(__NFUN_122__(Level.m_aGameTypeInfo[i].m_szGameType, GameTypeClass))
            {
                MapList.Maps[MapIndex] = MapName;
                GameTypeClassTrans = Level.m_aGameTypeInfo[i].m_szClassName;
                MapList.GameType[MapIndex] = GameTypeClassTrans;
                MapList.__NFUN_536__(__NFUN_112__(mgr.GetServerIni(), ".ini"));
                return 0;
            }
            __NFUN_165__(i);
            // [Loop Continue]
            goto J0x2D0;
        }
        return -17;        
    }
    else
    {
        return -16;
    }
    return;
}

function CopyStringArray(string in[32], out string Out[32])
{
    local int i;

    J0x00:
    // End:0x2D [Loop If]
    if(__NFUN_150__(i, 32))
    {
        Out[i] = in[i];
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x00;
    }
    return;
}

function ShiftMapListRight(R6MapList List, int From)
{
    local int i;
    local string Maps[32], GameTypes;

    CopyStringArray(List.Maps, Maps);
    CopyStringArray(List.GameType, GameTypes);
    i = From;
    J0x3D:

    // End:0x99 [Loop If]
    if(__NFUN_150__(i, 31))
    {
        List.Maps[__NFUN_146__(i, 1)] = Maps[i];
        List.GameType[__NFUN_146__(i, 1)] = GameTypes[i];
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x3D;
    }
    return;
}

function int GetNextAvaliableMapSlot(R6MapList List)
{
    local int i;

    J0x00:
    // End:0x2F [Loop If]
    if(__NFUN_150__(i, 31))
    {
        // End:0x2C
        if(__NFUN_122__(List.Maps[__NFUN_165__(i)], ""))
        {
            // [Explicit Break]
            goto J0x2F;
        }
        // [Loop Continue]
        goto J0x00;
    }
    J0x2F:

    return i;
    return;
}

function int ChangeRestrictionKit(string data)
{
    local StringTokenizer A, B;
    local int i, j, iCount, jCount, temp;

    local bool add;
    local R6GameInfo R6Game;

    A = new (none) Class'N4Util.StringTokenizer';
    A.Tokenize(data, " ");
    iCount = A.CountTokens();
    J0x3B:

    // End:0x134 [Loop If]
    if(__NFUN_150__(i, iCount))
    {
        j = 0;
        B = new (none) Class'N4Util.StringTokenizer';
        B.Tokenize(A.GetToken(i), "/");
        jCount = B.CountTokens();
        // End:0x12A
        if(__NFUN_153__(jCount, 3))
        {
            add = bool(B.GetToken(2));
            temp = int(B.GetToken(0));
            // End:0x109
            if(__NFUN_150__(temp, 7))
            {
                ChangeRestrictionKitClass(temp, B.GetToken(1), add);
                // [Explicit Continue]
                goto J0x12A;
            }
            ChangeRestrictionKitString(temp, B.GetToken(1), add);
        }
        J0x12A:

        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x3B;
    }
    R6Game = R6GameInfo(Level.Game);
    // End:0x190
    if(__NFUN_119__(R6Game, none))
    {
        R6Game.UpdateRepResArrays();
        R6Game.BroadcastGameMsg("", __NFUN_168__(RemoteAdminName, RemoteString), "RestOption");
    }
    return 0;
    return;
}

function bool ChangeRestrictionKitString(int type, string String, bool add)
{
    local R6ServerInfo server;
    local bool Result;

    server = __NFUN_1273__();
    // End:0x16
    if(__NFUN_114__(server, none))
    {
        return false;
    }
    switch(type)
    {
        // End:0x4B
        case 7:
            Result = AddOrRemoveStringFromArray(String, server.RestrictedPrimary, add);
            // End:0xAC
            break;
        // End:0x79
        case 8:
            Result = AddOrRemoveStringFromArray(String, server.RestrictedSecondary, add);
            // End:0xAC
            break;
        // End:0xA7
        case 9:
            Result = AddOrRemoveStringFromArray(String, server.RestrictedMiscGadgets, add);
            // End:0xAC
            break;
        // End:0xFFFF
        default:
            return false;
            break;
    }
    SaveToServerFile(server);
    return Result;
    return;
}

function bool ChangeRestrictionKitClass(int type, string Class, bool add)
{
    local Class dtype;
    local R6ServerInfo server;
    local bool Result;

    server = __NFUN_1273__();
    // End:0x16
    if(__NFUN_114__(server, none))
    {
        return false;
    }
    dtype = class<Object>(DynamicLoadObject(Class, Class'Core.Class', true));
    // End:0x3F
    if(__NFUN_114__(dtype, none))
    {
        return false;
    }
    switch(type)
    {
        // End:0x73
        case 0:
            Result = AddOrRemoveClassFromArray(dtype, server.RestrictedSubMachineGuns, add);
            // End:0x18B
            break;
        // End:0xA0
        case 1:
            Result = AddOrRemoveClassFromArray(dtype, server.RestrictedShotGuns, add);
            // End:0x18B
            break;
        // End:0xCE
        case 2:
            Result = AddOrRemoveClassFromArray(dtype, server.RestrictedAssultRifles, add);
            // End:0x18B
            break;
        // End:0xFC
        case 3:
            Result = AddOrRemoveClassFromArray(dtype, server.RestrictedMachineGuns, add);
            // End:0x18B
            break;
        // End:0x12A
        case 4:
            Result = AddOrRemoveClassFromArray(dtype, server.RestrictedSniperRifles, add);
            // End:0x18B
            break;
        // End:0x158
        case 5:
            Result = AddOrRemoveClassFromArray(dtype, server.RestrictedPistols, add);
            // End:0x18B
            break;
        // End:0x186
        case 6:
            Result = AddOrRemoveClassFromArray(dtype, server.RestrictedMachinePistols, add);
            // End:0x18B
            break;
        // End:0xFFFF
        default:
            return false;
            break;
    }
    SaveToServerFile(server);
    return Result;
    return;
}

function bool AddOrRemoveStringFromArray(string String, out array<string> Array, bool add)
{
    // End:0x1D
    if(add)
    {
        return AddStringToArray(String, Array);        
    }
    else
    {
        return RemoveStringFromArray(String, Array);
    }
    return;
}

function bool AddOrRemoveClassFromArray(Class Class, out array< Class > Array, bool add)
{
    // End:0x1D
    if(add)
    {
        return AddClassToArray(Class, Array);        
    }
    else
    {
        return RemoveClassFromArray(Class, Array);
    }
    return;
}

function bool RemoveClassFromArray(Class Class, out array< Class > Array)
{
    local int i;

    i = FindClassInArray(Class, Array);
    // End:0x31
    if(__NFUN_132__(__NFUN_150__(i, 0), __NFUN_154__(Array.Length, 0)))
    {
        return false;
    }
    Array.Remove(i, 1);
    return true;
    return;
}

function bool RemoveStringFromArray(string String, out array<string> Array)
{
    local int i;

    i = FindStringInArray(String, Array);
    // End:0x31
    if(__NFUN_132__(__NFUN_150__(i, 0), __NFUN_154__(Array.Length, 0)))
    {
        return false;
    }
    Array.Remove(i, 1);
    return true;
    return;
}

function int GetNumberOfIRCBots()
{
    local int i;
    local IRCBot bot;

    // End:0x18
    foreach __NFUN_304__(Class'IRCBot', bot)
    {
        __NFUN_165__(i);        
    }    
    return i;
    return;
}

function bool AddStringToArray(string String, out array<string> Array)
{
    // End:0x18
    if(__NFUN_153__(FindStringInArray(String, Array), 0))
    {
        return false;
    }
    Array.Length = __NFUN_146__(Array.Length, 1);
    Array[__NFUN_147__(Array.Length, 1)] = String;
    return true;
    return;
}

function int FindStringInArray(string String, array<string> Array)
{
    local int i;

    J0x00:
    // End:0x35 [Loop If]
    if(__NFUN_150__(i, Array.Length))
    {
        // End:0x2B
        if(__NFUN_124__(String, Array[i]))
        {
            return i;
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x00;
    }
    return -1;
    return;
}

function int FindClassInArray(Class Class, array< Class > Array)
{
    local int i;

    J0x00:
    // End:0x39 [Loop If]
    if(__NFUN_150__(i, Array.Length))
    {
        // End:0x2F
        if(__NFUN_124__(string(Class), string(Array[i])))
        {
            return i;
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x00;
    }
    return -1;
    return;
}

function bool AddClassToArray(Class C, out array< Class > A)
{
    // End:0x18
    if(__NFUN_153__(FindClassInArray(C, A), 0))
    {
        return false;
    }
    A[A.Length] = C;
    return true;
    return;
}

function array<R6MissionDescription> GetAllMissions()
{
    // End:0x12
    if(__NFUN_154__(missions.Length, 0))
    {
        LoadAllMissions();
    }
    return missions;
    return;
}

function array<R6MissionDescription> LoadAllMissions()
{
    local R6ModMgr mgr;

    missions.Length = 0;
    AddMissionsFromDirectory("..\\maps\\", missions);
    mgr = __NFUN_1524__();
    // End:0xB7
    if(__NFUN_130__(__NFUN_130__(__NFUN_130__(__NFUN_119__(mgr, none), __NFUN_129__(mgr.IsRavenShield())), __NFUN_119__(mgr.m_pCurrentMod, none)), __NFUN_123__(mgr.m_pCurrentMod.m_szKeyWord, "..")))
    {
        AddMissionsFromDirectory(__NFUN_112__(__NFUN_112__("..\\Mods\\", mgr.m_pCurrentMod.m_szKeyWord), "\\maps\\"), missions);
    }
    return missions;
    return;
}

function AddMissionsFromDirectory(string directory, out array<R6MissionDescription> missions)
{
    local R6MissionDescription mission;
    local R6FileManager FileManager;
    local string Map, ini;
    local int Files, i;

    FileManager = new (none) Class'Engine.R6FileManager';
    Files = FileManager.__NFUN_1525__(directory, "rsm");
    J0x2B:

    // End:0x123 [Loop If]
    if(__NFUN_150__(i, Files))
    {
        FileManager.__NFUN_1526__(i, Map);
        Map = __NFUN_128__(Map, __NFUN_147__(__NFUN_125__(Map), 4));
        ini = __NFUN_112__(__NFUN_112__(directory, Map), ".ini");
        // End:0x119
        if(__NFUN_130__(FindFile(ini), __NFUN_150__(__NFUN_126__(ini, " "), 0)))
        {
            mission = new (none) Class'Engine.R6MissionDescription';
            // End:0x119
            if(__NFUN_130__(__NFUN_130__(__NFUN_119__(mission, none), mission.Init(Level, ini)), __NFUN_124__(Map, mission.m_MapName)))
            {
                missions.Length = __NFUN_146__(missions.Length, 1);
                missions[__NFUN_147__(missions.Length, 1)] = mission;
            }
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x2B;
    }
    return;
}

defaultproperties
{
    MaxObjectSearchCount=20
    RemoteAdminName="Admin"
    RemoteString="[Remote]"
}