class N4XMLLogger extends N4ScoreManagerUser
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var float XMLLoggerVersion;
var N4XMLNode rootNode;
var N4XMLNode TempPlayerNode;
var array<Actor> TriggerActorSet;

static function N4XMLLogger GetXMLLoggerFrom(Actor A)
{
    local N4XMLLogger Result;

    // End:0x0D
    if(__NFUN_114__(A, none))
    {
        return none;
    }
    // End:0x2E
    foreach A.__NFUN_313__(Class'N4XMLLogger', Result)
    {        
        return Result;        
    }    
    Result = A.__NFUN_278__(Class'N4XMLLogger');
    return Result;
    return;
}

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    Tag = 'EndGame';
    rootNode = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    rootNode.SetName("RoundStatistics");
    return;
}

function string GetBoolString(bool B)
{
    // End:0x10
    if(B)
    {
        return "true";
    }
    return "false";
    return;
}

function N4XMLNode GetXMLServerInfo()
{
    local R6ServerInfo ServerOptions;
    local N4XMLNode Result;

    Result = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    ServerOptions = Class'Engine.Actor'.static.__NFUN_1273__();
    Result.AddAttribute("Mod", Class'Engine.Actor'.static.__NFUN_1524__().m_pCurrentMod.m_szKeyWord);
    Result.AddAttribute("Version", Level.__NFUN_1419__(false, __NFUN_129__(Class'Engine.Actor'.static.__NFUN_1524__().IsRavenShield())));
    // End:0x1B6
    if(__NFUN_119__(Level.Game, none))
    {
        Result.AddAttribute("GameType", Level.Game.m_szCurrGameType);
        Result.AddAttribute("Map", Level.Game.__NFUN_547__());
        Result.AddAttribute("PunkBuster", GetBoolString(Level.m_bPBSvRunning));
        Result.AddAttribute("MaxPlayers", string(Level.Game.MaxPlayers));
        Result.AddAttribute("NeedsPassword", GetBoolString(Level.Game.AccessControl.GamePasswordNeeded()));
    }
    // End:0x243
    if(__NFUN_119__(ServerOptions, none))
    {
        Result.AddAttribute("RoundTime", string(ServerOptions.RoundTime));
        Result.AddAttribute("BombTime", string(ServerOptions.BombTime));
        Result.AddAttribute("TerroristCount", string(ServerOptions.NbTerro));
    }
    return Result;
    return;
}

function N4XMLNode FromPlayerRoundInfo(PlayerRoundInfo Info)
{
    local N4XMLNode Result, temp;

    Result = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    Result.SetName("PlayerRoundStats");
    temp = FromKillInfo(Info.Kills);
    temp.SetName("Kills");
    Result.AddChild(temp);
    temp = FromKillInfo(Info.Deaths);
    temp.SetName("Deaths");
    Result.AddChild(temp);
    Result.AddAttribute("UbiID", Info.UbiID);
    Result.AddAttribute("NickName", Info.Nickname);
    Result.AddAttribute("GlobalID", Info.GlobalID);
    Result.AddAttribute("Hits", string(Info.RoundsHit));
    Result.AddAttribute("Fired", string(Info.RoundsFired));
    Result.AddAttribute("Played", GetBoolString(Info.RoundPlayed));
    Result.AddAttribute("DoorsDestroyed", string(Info.DoorsDestroyed));
    Result.AddAttribute("BombsArmed", string(Info.BombsArmed));
    Result.AddAttribute("BombsDisarmed", string(Info.BombsDisarmed));
    Result.AddAttribute("DevicesActivated", string(Info.DevicesActivated));
    Result.AddAttribute("DevicesDeactivated", string(Info.DevicesDeactivated));
    Result.AddAttribute("LastKillerUbiID", Info.KilledBy);
    return Result;
    return;
}

function N4XMLNode GetDeviceStats()
{
    local N4XMLNode Result;

    Result = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    Result.AddAttribute("DoorsDestroyed", string(ScoreManager.DoorsDestroyed));
    Result.AddAttribute("DevicesDestroyed", string(ScoreManager.DevicesDestroyed));
    Result.AddAttribute("BombsDetonated", string(ScoreManager.BombsDetonated));
    return Result;
    return;
}

function N4XMLNode FromKillInfo(KillInfo Info)
{
    local N4XMLNode Result;

    Result = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    Result.AddAttribute("Friendly", string(Info.friendly));
    Result.AddAttribute("Neutral", string(Info.Neutral));
    Result.AddAttribute("Enemy", string(Info.Enemy));
    Result.AddAttribute("Suicide", string(Info.Suicide));
    return Result;
    return;
}

function N4XMLNode FromPlayerKillInfo(PlayerKillInfo Info)
{
    local N4XMLNode Result;

    Result = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    Result.AddAttribute("Killer", Info.Killer);
    Result.AddAttribute("Killed", Info.killed);
    Result.AddAttribute("FriendlyFire", GetBoolString(Info.bFriendlyFire));
    Result.AddAttribute("NeutralFire", GetBoolString(Info.bNeutralFire));
    return Result;
    return;
}

function N4XMLNode GetTerroristStats()
{
    local N4XMLNode Result, TempNode;

    Result = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    TempNode = FromKillInfo(ScoreManager.TerroristDeaths);
    TempNode.SetName("Deaths");
    Result.AddChild(TempNode);
    TempNode = FromKillInfo(ScoreManager.TerroristKills);
    TempNode.SetName("Kills");
    Result.AddChild(TempNode);
    return Result;
    return;
}

function N4XMLNode GetPlayerRoundInfoSet()
{
    local N4XMLNode Result, TempNode;
    local int i;

    Result = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    i = 0;
    J0x26:

    // End:0x98 [Loop If]
    if(__NFUN_150__(i, ScoreManager.PlayerRoundInfoSet.Length))
    {
        TempNode = FromPlayerRoundInfo(ScoreManager.PlayerRoundInfoSet[i]);
        TempNode.SetName("PlayerInfo");
        Result.AddChild(TempNode);
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x26;
    }
    return Result;
    return;
}

function N4XMLNode GetKillInfoSet()
{
    local N4XMLNode Result, TempNode;
    local int i;

    Result = N4XMLNode(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4Util.N4XMLNode'));
    i = 0;
    J0x26:

    // End:0x96 [Loop If]
    if(__NFUN_150__(i, ScoreManager.KillSet.Length))
    {
        TempNode = FromPlayerKillInfo(ScoreManager.KillSet[i]);
        TempNode.SetName("KillInfo");
        Result.AddChild(TempNode);
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x26;
    }
    return Result;
    return;
}

function RebuildStats()
{
    local N4XMLNode TempNode;
    local int i;

    // End:0x0D
    if(__NFUN_114__(rootNode, none))
    {
        return;
    }
    rootNode.ClearAndDisposeChildren();
    rootNode.ClearAttributes();
    // End:0x38
    if(__NFUN_114__(ScoreManager, none))
    {
        return;
    }
    rootNode.AddAttribute("XMLLoggerVersion", string(XMLLoggerVersion));
    TempNode = GetXMLServerInfo();
    TempNode.SetName("ServerInfo");
    rootNode.AddChild(TempNode);
    TempNode = GetPlayerRoundInfoSet();
    TempNode.SetName("PlayerInfoSet");
    rootNode.AddChild(TempNode);
    TempNode = GetKillInfoSet();
    TempNode.SetName("KillInfoSet");
    rootNode.AddChild(TempNode);
    TempNode = GetTerroristStats();
    TempNode.SetName("TerroristStatistics");
    rootNode.AddChild(TempNode);
    TempNode = GetDeviceStats();
    TempNode.SetName("DeviceStatistics");
    rootNode.AddChild(TempNode);
    return;
}

function AddRebuildHook(Actor A)
{
    TriggerActorSet[TriggerActorSet.Length] = A;
    return;
}

event Trigger(Actor Other, Pawn EventInstigator)
{
    local int i;

    super(Actor).Trigger(Other, EventInstigator);
    RebuildStats();
    i = 0;
    J0x1D:

    // End:0x7C [Loop If]
    if(__NFUN_150__(i, TriggerActorSet.Length))
    {
        // End:0x5B
        if(__NFUN_132__(__NFUN_114__(TriggerActorSet[i], none), TriggerActorSet[i].bDeleteMe))
        {
            // [Explicit Continue]
            goto J0x72;
        }
        TriggerActorSet[i].Trigger(self, none);
        J0x72:

        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x1D;
    }
    return;
}

function WriteTo(N4StringOutputStream output)
{
    local StatLogFile file;

    // End:0x1A
    if(__NFUN_132__(__NFUN_114__(rootNode, none), __NFUN_114__(output, none)))
    {
        return;
    }
    rootNode.WriteTo(output);
    return;
}

defaultproperties
{
    XMLLoggerVersion=1.0000000
    Tag="EndGame"
}