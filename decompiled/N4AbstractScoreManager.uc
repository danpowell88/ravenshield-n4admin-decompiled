class N4AbstractScoreManager extends N4MissionHook
    abstract
    config
    editinlinenew
    hidecategories(Object);

var int DevicesDestroyed;
var int BombsDetonated;
var int DoorsDestroyed;
var config bool bUpdateNewPlayerStats;
var bool bUpdatedAll;
var array<PlayerRoundInfo> PlayerRoundInfoSet;
var array<PlayerKillInfo> KillSet;
var KillInfo TerroristKills;
var KillInfo TerroristDeaths;
var string UBIPrefix;

function QuickUpdateAll()
{
    local int i;

    i = 0;
    J0x07:

    // End:0x58 [Loop If]
    if(__NFUN_150__(i, PlayerRoundInfoSet.Length))
    {
        // End:0x4E
        if(__NFUN_119__(PlayerRoundInfoSet[i].PC, none))
        {
            UpdateInfoFor(PlayerRoundInfoSet[i].PC, PlayerRoundInfoSet[i]);
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function AddDoorDestroyedForPawn(Pawn P)
{
    local R6PlayerController Player;

    Player = GetPlayerControllerFromPawn(P);
    // End:0x27
    if(__NFUN_119__(Player, none))
    {
        AddDoorDestroyedFor(Player);
    }
    return;
}

function AddDoorDestroyedFor(R6PlayerController Player)
{
    local int Index;

    Index = FindOrCreateAndUpdateInfoFor(Player);
    // End:0x1E
    if(__NFUN_150__(Index, 0))
    {
        return;
    }
    __NFUN_165__(PlayerRoundInfoSet[Index].DoorsDestroyed);
    return;
}

function ChangeDeviceStatisticsForPawn(Pawn P, optional bool Activated, optional bool bBomb)
{
    local R6PlayerController Player;

    Player = GetPlayerControllerFromPawn(P);
    // End:0x33
    if(__NFUN_119__(Player, none))
    {
        ChangeDeviceStatisticsFor(Player, Activated, bBomb);
    }
    return;
}

function ChangeDeviceStatisticsFor(R6PlayerController Player, optional bool bActivated, optional bool bBomb)
{
    local int Index;

    Index = FindOrCreateAndUpdateInfoFor(Player);
    // End:0x30
    if(__NFUN_132__(__NFUN_150__(Index, 0), __NFUN_153__(Index, PlayerRoundInfoSet.Length)))
    {
        return;
    }
    // End:0x6C
    if(bActivated)
    {
        // End:0x57
        if(bBomb)
        {
            __NFUN_165__(PlayerRoundInfoSet[Index].BombsArmed);            
        }
        else
        {
            __NFUN_165__(PlayerRoundInfoSet[Index].DevicesActivated);
        }        
    }
    else
    {
        // End:0x8A
        if(bBomb)
        {
            __NFUN_165__(PlayerRoundInfoSet[Index].BombsDisarmed);            
        }
        else
        {
            __NFUN_165__(PlayerRoundInfoSet[Index].DevicesDeactivated);
        }
    }
    return;
}

function UpdateOrCreateAllDataUsing(Actor A)
{
    local Controller _Controller;
    local R6PlayerController Player;

    // End:0x42
    if(__NFUN_132__(__NFUN_132__(__NFUN_114__(A, none), __NFUN_114__(A.Level, none)), __NFUN_114__(A.Level.ControllerList, none)))
    {
        return;
    }
    bUpdatedAll = true;
    _Controller = A.Level.ControllerList;
    J0x67:

    // End:0xAF [Loop If]
    if(__NFUN_119__(_Controller, none))
    {
        Player = R6PlayerController(_Controller);
        // End:0x98
        if(__NFUN_119__(Player, none))
        {
            FindOrCreateAndUpdateInfoFor(Player);
        }
        _Controller = _Controller.nextController;
        // [Loop Continue]
        goto J0x67;
    }
    return;
}

function ResetData()
{
    bUpdatedAll = false;
    DevicesDestroyed = 0;
    BombsDetonated = 0;
    DoorsDestroyed = 0;
    ClearPRISet();
    ClearKillSet();
    ResetKillsFor(TerroristKills);
    ResetKillsFor(TerroristDeaths);
    return;
}

function ClearKillSet()
{
    KillSet.Length = 0;
    return;
}

function ClearPRISet()
{
    PlayerRoundInfoSet.Length = 0;
    return;
}

function int FindRoundInfo(string UbiName)
{
    local int i;

    i = 0;
    J0x07:

    // End:0x41 [Loop If]
    if(__NFUN_150__(i, PlayerRoundInfoSet.Length))
    {
        // End:0x37
        if(__NFUN_124__(PlayerRoundInfoSet[i].UbiID, UbiName))
        {
            return i;
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x07;
    }
    return -1;
    return;
}

function PlayerRoundInfo CreateInfoFrom(R6PlayerController Player)
{
    local PlayerRoundInfo Result;

    UpdateInfoFor(Player, Result);
    return Result;
    return;
}

function int FindOrCreateAndUpdateInfoFor(R6PlayerController Player)
{
    local int i;

    i = FindOrCreateRoundInfoFor(Player);
    // End:0x44
    if(__NFUN_130__(__NFUN_153__(i, 0), __NFUN_150__(i, PlayerRoundInfoSet.Length)))
    {
        UpdateInfoFor(Player, PlayerRoundInfoSet[i]);
    }
    return i;
    return;
}

function FindAndUpdateInfoFor(R6PlayerController Player)
{
    local int i;

    i = FindRoundInfoFor(Player);
    // End:0x1E
    if(__NFUN_150__(i, 0))
    {
        return;
    }
    UpdateInfoFor(Player, PlayerRoundInfoSet[i]);
    return;
}

function int FindRoundInfoFor(R6PlayerController Player)
{
    local PlayerReplicationInfo PRI;

    // End:0x11
    if(__NFUN_114__(Player, none))
    {
        return -1;
    }
    PRI = Player.PlayerReplicationInfo;
    // End:0x4D
    if(__NFUN_132__(__NFUN_114__(PRI, none), __NFUN_122__(PRI.m_szUbiUserID, "")))
    {
        return -1;
    }
    return FindRoundInfo(PRI.m_szUbiUserID);
    return;
}

function bool ShouldUpdateKillsAndDeaths(Actor A)
{
    // End:0x42
    if(__NFUN_132__(__NFUN_132__(__NFUN_114__(A, none), __NFUN_114__(A.Level, none)), __NFUN_114__(A.Level.Game, none)))
    {
        return false;
    }
    return __NFUN_124__(A.Level.Game.m_szGameTypeFlag, "RGM_CaptureTheEnemyAdvMode");
    return;
}

function UpdateInfoFor(R6PlayerController Player, out PlayerRoundInfo Info, optional bool bDefinatelyPlayed)
{
    local int RoundsFired, RoundsHit, RoundsPlayed, Kills, Deaths;

    local bool bNewPC;
    local PlayerReplicationInfo PRI;

    // End:0x2C
    if(__NFUN_132__(__NFUN_114__(Player, none), __NFUN_114__(Player.Level.Game, none)))
    {
        return;
    }
    PRI = Player.PlayerReplicationInfo;
    // End:0x4D
    if(__NFUN_114__(PRI, none))
    {
        return;
    }
    // End:0x69
    if(__NFUN_119__(Info.PC, Player))
    {
        bNewPC = true;
    }
    Info.PC = Player;
    Info.GlobalID = Player.m_szGlobalID;
    RoundsFired = PRI.m_iRoundFired;
    RoundsHit = PRI.m_iRoundsHit;
    RoundsPlayed = __NFUN_147__(PRI.m_iRoundsPlayed, PRI.m_iBackUpRoundsPlayed);
    Kills = PRI.m_iRoundKillCount;
    Deaths = int(PRI.Deaths);
    // End:0x186
    if(__NFUN_129__(Player.Level.IsGameTypeCooperative(Player.Level.Game.m_szGameTypeFlag)))
    {
        __NFUN_162__(RoundsFired, PRI.m_iBackUpRoundFired);
        __NFUN_162__(RoundsHit, PRI.m_iBackUpRoundsHit);
        __NFUN_162__(Deaths, int(PRI.m_iBackUpDeaths));
    }
    Info.RoundPlayed = __NFUN_132__(__NFUN_132__(__NFUN_132__(Info.RoundPlayed, bDefinatelyPlayed), __NFUN_151__(RoundsPlayed, 0)), __NFUN_119__(Player.m_pawn, none));
    // End:0x2AC
    if(bNewPC)
    {
        __NFUN_161__(Info.RoundsHit, RoundsHit);
        __NFUN_161__(Info.RoundsFired, RoundsFired);
        // End:0x230
        if(ShouldUpdateKillsAndDeaths(Player))
        {
            __NFUN_161__(Info.Deaths.Enemy, Deaths);
            __NFUN_161__(Info.Kills.Enemy, Kills);
        }
        // End:0x2A9
        if(bUpdateNewPlayerStats)
        {
            PRI.m_iRoundFired = Info.RoundsFired;
            PRI.m_iRoundsHit = Info.RoundsHit;
            PRI.Deaths = float(Info.Deaths.Enemy);
            PRI.m_iRoundKillCount = Info.Kills.Enemy;
        }        
    }
    else
    {
        Info.RoundsHit = __NFUN_250__(RoundsHit, Info.RoundsHit);
        Info.RoundsFired = __NFUN_250__(RoundsFired, Info.RoundsFired);
        // End:0x33E
        if(ShouldUpdateKillsAndDeaths(Player))
        {
            Info.Deaths.Enemy = __NFUN_250__(Deaths, Info.Deaths.Enemy);
            Info.Kills.Enemy = __NFUN_250__(Kills, Info.Kills.Enemy);
        }
    }
    Info.UbiID = PRI.m_szUbiUserID;
    Info.Nickname = PRI.PlayerName;
    Info.PC = Player;
    return;
}

function int CreateRoundInfo(R6PlayerController Player)
{
    local PlayerReplicationInfo PRI;
    local PlayerRoundInfo newInfo;

    // End:0x23
    if(__NFUN_132__(__NFUN_114__(Player, none), __NFUN_119__(IRCSpectator(Player), none)))
    {
        return -1;
    }
    newInfo = CreateInfoFrom(Player);
    // End:0x4B
    if(__NFUN_122__(newInfo.UbiID, ""))
    {
        return -1;
    }
    PlayerRoundInfoSet[PlayerRoundInfoSet.Length] = newInfo;
    return __NFUN_147__(PlayerRoundInfoSet.Length, 1);
    return;
}

function int FindOrCreateRoundInfoFor(R6PlayerController Player)
{
    local int i;

    i = FindRoundInfoFor(Player);
    // End:0x28
    if(__NFUN_150__(i, 0))
    {
        return CreateRoundInfo(Player);
    }
    return i;
    return;
}

function ChangeRainbowKills(R6Rainbow Rainbow, N4MissionHook.EKillType KillType, optional bool Died)
{
    local int Index;
    local R6PlayerController Player, Killer;

    Player = GetPlayerControllerFromPawn(Rainbow);
    Index = FindOrCreateRoundInfoFor(Player);
    // End:0x41
    if(__NFUN_132__(__NFUN_150__(Index, 0), __NFUN_153__(Index, PlayerRoundInfoSet.Length)))
    {
        return;
    }
    UpdateInfoFor(Player, PlayerRoundInfoSet[Index], true);
    // End:0xED
    if(Died)
    {
        AddKillTo(PlayerRoundInfoSet[Index].Deaths, KillType);
        // End:0xEA
        if(__NFUN_119__(Rainbow, none))
        {
            Killer = GetPlayerControllerFromPawn(Rainbow.m_KilledBy);
            // End:0xEA
            if(__NFUN_130__(__NFUN_119__(Killer, none), __NFUN_119__(Killer.PlayerReplicationInfo, none)))
            {
                PlayerRoundInfoSet[Index].KilledBy = Killer.PlayerReplicationInfo.m_szUbiUserID;
            }
        }        
    }
    else
    {
        AddKillTo(PlayerRoundInfoSet[Index].Kills, KillType);
    }
    return;
}

function string GetRainbowName(R6Rainbow Rainbow)
{
    local R6PlayerController Player;
    local string Result;

    // End:0x0E
    if(__NFUN_114__(Rainbow, none))
    {
        return "";
    }
    Player = GetPlayerControllerFromPawn(Rainbow);
    // End:0x69
    if(__NFUN_119__(Player, none))
    {
        // End:0x5E
        if(__NFUN_119__(Player.PlayerReplicationInfo, none))
        {
            Result = Player.PlayerReplicationInfo.m_szUbiUserID;            
        }
        else
        {
            Result = "";
        }        
    }
    else
    {
        Result = __NFUN_112__(UBIPrefix, string(Rainbow.Name));
    }
    return Result;
    return;
}

function string GetStatsNameFor(R6Pawn P)
{
    local R6Rainbow Rainbow;
    local string Result;

    // End:0x0E
    if(__NFUN_114__(P, none))
    {
        return "";
    }
    Rainbow = R6Rainbow(P);
    // End:0x3D
    if(__NFUN_119__(Rainbow, none))
    {
        Result = GetRainbowName(Rainbow);        
    }
    else
    {
        Result = __NFUN_112__(UBIPrefix, string(P.Name));
    }
    return Result;
    return;
}

event R6PawnKilled(R6Pawn Killer, R6Pawn victim)
{
    local bool bFriendly, bNeutral;
    local string KillerName, VictimName;

    super.R6PawnKilled(Killer, victim);
    // End:0x29
    if(__NFUN_114__(Killer, none))
    {
        Killer = victim;        
    }
    else
    {
        // End:0x3F
        if(__NFUN_114__(victim, none))
        {
            victim = Killer;
        }
    }
    // End:0x59
    if(__NFUN_132__(__NFUN_114__(Killer, none), __NFUN_114__(victim, none)))
    {
        return;
    }
    bFriendly = Killer.IsFriend(victim);
    // End:0x9A
    if(__NFUN_129__(bFriendly))
    {
        bNeutral = Killer.IsNeutral(victim);
    }
    KillerName = GetStatsNameFor(Killer);
    VictimName = GetStatsNameFor(victim);
    AddToKillSet(KillerName, VictimName, bFriendly, bNeutral);
    return;
}

function AddToKillSet(string Killer, string Died, optional bool bFriendly, optional bool bNeutral)
{
    local PlayerKillInfo KillInfo;

    KillInfo.Killer = Killer;
    KillInfo.killed = Died;
    KillInfo.bFriendlyFire = bFriendly;
    KillInfo.bNeutralFire = bNeutral;
    KillSet[KillSet.Length] = KillInfo;
    return;
}

defaultproperties
{
    UBIPrefix="&UBI;"
}