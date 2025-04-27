class N4URLPost extends N4TCPLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

const BuildVersion = 310;

struct URLPostHostInfo
{
    var() config string Host;
    var() config string URL;
    var() config int Port;
    var() config string ident;
    var() config string forceddomain;
    var() config bool bSilent;
    var N4URLPost link;
};

struct ReplaceInfo
{
    var() config string Replace;
    var() config string With;
};

var private int pos;
var private int checkstart;
var config int postPort;
var bool bDestroyWithParent;
var config bool bPostToMasterServer;
var bool bSilent;
var float LastRoundTime;
var float RoundTime;
var N4URLPostDataManager DataManager;
var N4AbstractScoreManager ScoreManager;
var N4MissionHookMutator MissionHookMutator;
var N4StringArrayManager arrayManager;
var N4URLEncoder urlEncoder;
var class<N4URLPost> PosterChildClass;
var class<N4URLPostDataManager> DataManagerClass;
var class<N4AbstractScoreManager> ScoreManagerClass;
var class<N4MissionHookMutator> MissionHookMutatorClass;
var array<string> tokens;
var config array<URLPostHostInfo> ExtraURLPostServers;
var config array<ReplaceInfo> GameTypeReplacers;
var URLPostHostInfo LastChildInfo;
var config URLPostHostInfo MasterServer;
var const string UbiNameMarker;
var const string NickMarker;
var const string HitMarker;
var const string RoundsFiredMarker;
var const string DeathMarker;
var const string CurrentMapMarker;
var const string GameTypeMarker;
var const string PlayerKillMarker;
var const string EndMarker;
var const string StartUbiNameMarker;
var const string StartHitMarker;
var const string StartRoundsFiredMarker;
var const string StartDeathMarker;
var const string RoundPlayedMarker;
var const string VersionMarker;
var const string RoundTimeMarker;
var const string TeamKillMarker;
var const string TeamKilledMarker;
var const string NeutralKillMarker;
var const string SuicideMarker;
var const string TerroristDeathMarker;
var const string TerroristSuicideMarker;
var const string TerroristNeutralKillMarker;
var const string TerroristKillMarker;
var const string TerroristTeamKillMarker;
var const string KilledByMarker;
var const string TotalDoorsDestroyedMarker;
var const string TotalDevicesDestroyedMarker;
var const string TotalBombsDetonatedMarker;
var const string PlayerDoorsDestroyedMarker;
var const string PlayerBombsArmedMarker;
var const string PlayerBombsDisarmedMarker;
var const string PlayerDevicesActivatedMarker;
var const string PlayerDevicesDeactivatedMarker;
var const string GlobalIDMarker;
var const string BeaconPortMarker;
var config string postHost;
var config string postURL;
var config string postIdent;
var config string postForcedDomain;
var config string PostOperation;
var config string HTTPVersion;

function ResetOriginalData()
{
    super(Actor).ResetOriginalData();
    LastRoundTime = Level.TimeSeconds;
    // End:0x34
    if(__NFUN_119__(ScoreManager, none))
    {
        ScoreManager.ResetData();
    }
    return;
}

function InitDataManager()
{
    DataManager = N4URLPostDataManager(InitObject(DataManagerClass, Class'N4URLPostDataManager'));
    // End:0x49
    if(__NFUN_119__(DataManager, none))
    {
        DataManager.Initialize(postHost, postPort, postURL, postIdent);
    }
    return;
}

function BeginPlay()
{
    super(Actor).BeginPlay();
    urlEncoder = new (none) Class'N4Util.N4URLEncoder';
    urlEncoder.N4Init();
    arrayManager = new (none) Class'N4StringArrayManager';
    Tag = 'EndGame';
    return;
}

function SpawnPosterChildren()
{
    local int i;

    // End:0x14
    if(bPostToMasterServer)
    {
        SpawnPosterChild(MasterServer);
    }
    i = 0;
    J0x1B:

    // End:0x46 [Loop If]
    if(__NFUN_150__(i, ExtraURLPostServers.Length))
    {
        SpawnPosterChild(ExtraURLPostServers[i]);
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x1B;
    }
    return;
}

event GainedChild(Actor Other)
{
    local N4URLPost Child;

    Child = N4URLPost(Other);
    // End:0x26
    if(__NFUN_119__(Child, none))
    {
        GainedPosterChild(Child);
    }
    return;
}

event LostChild(Actor Other)
{
    local N4URLPost Child;

    Child = N4URLPost(Other);
    // End:0x26
    if(__NFUN_119__(Child, none))
    {
        LostPosterChild(Child);
    }
    return;
}

event LostPosterChild(N4URLPost Child)
{
    return;
}

event GainedPosterChild(N4URLPost Child)
{
    return;
}

function class<N4URLPost> GetChildClass()
{
    // End:0x14
    if(__NFUN_114__(PosterChildClass, none))
    {
        return Class;        
    }
    else
    {
        return PosterChildClass;
    }
    return;
}

function SpawnPosterChild(URLPostHostInfo ChildInfo)
{
    local N4URLPost poster;

    LastChildInfo = ChildInfo;
    poster = __NFUN_278__(GetChildClass(), self);
    // End:0x4A
    if(__NFUN_114__(poster, none))
    {
        N4Log(__NFUN_168__(string(self), "Could not spawn a child"));
    }
    ChildInfo.link = poster;
    return;
}

function DestroyPosterChildren()
{
    local int i;

    i = 0;
    J0x07:

    // End:0x32 [Loop If]
    if(__NFUN_150__(i, ExtraURLPostServers.Length))
    {
        DestroyPosterChild(ExtraURLPostServers[i]);
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function bool isPosterChild()
{
    return __NFUN_119__(getParentPoster(), none);
    return;
}

function bool ShouldDestroyWithParent()
{
    return bDestroyWithParent;
    return;
}

function DestroyPosterChild(URLPostHostInfo ChildInfo)
{
    // End:0x55
    if(__NFUN_130__(__NFUN_130__(__NFUN_119__(ChildInfo.link, none), __NFUN_129__(ChildInfo.link.bDeleteMe)), ChildInfo.link.ShouldDestroyWithParent()))
    {
        ChildInfo.link.__NFUN_279__();
    }
    ChildInfo.link = none;
    return;
}

event Destroyed()
{
    super(Actor).Destroyed();
    // End:0x17
    if(__NFUN_129__(isPosterChild()))
    {
        DestroyPosterChildren();
    }
    return;
}

function N4URLPost getParentPoster()
{
    return N4URLPost(Owner);
    return;
}

function SetUpScoreManager()
{
    local R6AbstractGameInfo _game;
    local N4URLPost tempPoster;

    // End:0x3C
    foreach __NFUN_313__(Class'N4URLPost', tempPoster)
    {
        // End:0x3B
        if(__NFUN_119__(tempPoster.ScoreManager, none))
        {
            ScoreManager = tempPoster.ScoreManager;            
            return;
        }        
    }    
    MissionHookMutator = __NFUN_278__(MissionHookMutatorClass, self);
    // End:0x86
    if(__NFUN_114__(MissionHookMutator, none))
    {
        __NFUN_231__(__NFUN_168__(string(self), "Could not spawn mission hook mutator"));
        return;
    }
    ScoreManager = new (none) ScoreManagerClass;
    // End:0xC8
    if(__NFUN_114__(ScoreManager, none))
    {
        __NFUN_231__(__NFUN_168__(string(self), "Failed creating score manager"));
        return;
    }
    MissionHookMutator.AddNewObjective(ScoreManager);
    MissionHookMutator.CheckForAndUpdateNewMissionManager();
    return;
}

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    // End:0x11
    if(bDeleteMe)
    {
        return;
    }
    // End:0x78
    if(__NFUN_129__(isPosterChild()))
    {
        DisplayInfo();
        SetUpScoreManager();
        // End:0x6F
        if(__NFUN_114__(ScoreManager, none))
        {
            __NFUN_231__(__NFUN_168__(string(self), "Could not create score manager, destroying!!!!"));
            __NFUN_279__();
            return;
        }
        SpawnPosterChildren();        
    }
    else
    {
        GetInfoFromParent();
        // End:0xF1
        if(__NFUN_129__(bDeleteMe))
        {
            // End:0xF1
            if(__NFUN_129__(bSilent))
            {
                N4Log(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_168__(__NFUN_168__("Child", string(self)), "started with URL: http://"), postHost), ":"), string(postPort)), postURL), "?ident="), postIdent));
            }
        }
    }
    InitDataManager();
    CheckReconnect();
    return;
}

function GetInfoFromParent()
{
    local N4URLPost parentPoster;

    parentPoster = getParentPoster();
    // End:0x4B
    if(__NFUN_114__(parentPoster, none))
    {
        N4Log(__NFUN_168__(string(self), "Parent poster was none, destroying"));
        __NFUN_279__();
        return;
    }
    ScoreManager = parentPoster.ScoreManager;
    postPort = parentPoster.LastChildInfo.Port;
    postHost = parentPoster.LastChildInfo.Host;
    postIdent = parentPoster.LastChildInfo.ident;
    postURL = parentPoster.LastChildInfo.URL;
    postForcedDomain = parentPoster.LastChildInfo.forceddomain;
    bSilent = parentPoster.LastChildInfo.bSilent;
    return;
}

function DisplayInfo()
{
    // End:0x206
    if(__NFUN_129__(bSilent))
    {
        __NFUN_231__("");
        __NFUN_231__("****************************************************************************");
        __NFUN_231__(__NFUN_112__(__NFUN_112__("*                       N4URLPost V", string(__NFUN_172__(float(GetBuildNumber()), 100.0000000))), " Activated                          *"));
        __NFUN_231__("*       Copyright (C) 2003,2004 Neil Popplewell.  All rights reserved.     *");
        __NFUN_231__("*          Email: neo@squadgames.com Web: http://www.squadgames.com        *");
        __NFUN_231__("*                     Ravenshield V1.60+ required                          *");
        __NFUN_231__("****************************************************************************");
        __NFUN_231__("");
    }
    return;
}

function PostTheData()
{
    local array<string> data;

    // End:0xAC
    if(IsConnected())
    {
        // End:0x43
        if(__NFUN_114__(DataManager, none))
        {
            N4Log(__NFUN_168__(string(self), "FATAL ERROR, datamanger was none"));
            return;
        }
        data = DataManager.Pop();
        // End:0x9E
        if(__NFUN_152__(data.Length, 0))
        {
            N4Log("No Data to Post!   ***********ERROR************");            
        }
        else
        {
            SendMultiplePostData(data);
        }        
    }
    else
    {
        N4Log("Error, no Connection to Webserver!");
    }
    return;
}

function BuildAndQueueData()
{
    local array<string> tempData;

    // End:0x3C
    if(__NFUN_114__(ScoreManager, none))
    {
        N4Log(__NFUN_168__(string(self), "FATAL ERROR, ScoreManager was none"));
        return;
    }
    ScoreManager.UpdateOrCreateAllDataUsing(self);
    BuildAllData(tempData);
    // End:0x8B
    if(__NFUN_119__(DataManager, none))
    {
        // End:0x88
        if(__NFUN_123__(postHost, ""))
        {
            DataManager.Push(tempData);
            CheckReconnect();
        }        
    }
    else
    {
        N4Log(__NFUN_168__(string(self), "FATAL ERROR, datamanger was none"));
    }
    return;
}

function int GetDataLength(out array<string> A)
{
    local int i, Result;

    i = 0;
    J0x07:

    // End:0x35 [Loop If]
    if(__NFUN_150__(i, A.Length))
    {
        __NFUN_161__(Result, __NFUN_125__(A[i]));
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x07;
    }
    return Result;
    return;
}

function BuildAllData(out array<string> tempData)
{
    // End:0x32
    if(__NFUN_114__(arrayManager, none))
    {
        __NFUN_231__("array manager none!! buildalldata");
        return;
    }
    arrayManager.Reset();
    BuildStats();
    tempData[tempData.Length] = BuildHeader(GetDataLength(arrayManager.data));
    AppendStringArray(arrayManager.data, tempData);
    arrayManager.Reset();
    return;
}

static function AppendStringArray(out array<string> From, out array<string> to)
{
    local int i, j, k;

    j = From.Length;
    k = to.Length;
    to.Length = __NFUN_146__(k, j);
    i = 0;
    J0x32:

    // End:0x69 [Loop If]
    if(__NFUN_150__(i, j))
    {
        to[__NFUN_146__(k, i)] = From[i];
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x32;
    }
    return;
}

function string BuildHeader(int dataLength)
{
    local string header, _domain;

    // End:0x1A
    if(__NFUN_122__(postForcedDomain, ""))
    {
        _domain = postURL;        
    }
    else
    {
        _domain = postURL;
    }
    header = __NFUN_168__(__NFUN_168__(PostOperation, _domain), HTTPVersion);
    AddLine(header, __NFUN_168__("Content-length:", string(dataLength)));
    AddLine(header, __NFUN_112__(__NFUN_112__(__NFUN_168__("Host:", postHost), ":"), string(postPort)));
    AddLine(header, "Content-type: application/x-www-form-urlencoded");
    AddLine(header);
    AddLine(header);
    AddLine(header);
    return header;
    return;
}

function string EncodeNick(string S)
{
    ReplaceText(S, "/", "_");
    return urlEncoder.Encode(S);
    return;
}

function string SD(out string A, coerce string B)
{
    A = __NFUN_112__(__NFUN_112__(A, "/"), EncodeNick(B));
    return A;
    return;
}

function string SA(out string A, coerce string B)
{
    A = __NFUN_112__(A, B);
    return A;
    return;
}

static final operator(41) string @=(out string A, coerce string B)
{
    A = __NFUN_168__(A, B);
    return A;
    return;
}

function BuildStats()
{
    local string Text, ubiIDs, nicks, RoundsHit, RoundsFired, Kills,
	    Deaths, teamkillers, killers, teamkilled, teamkills,
	    neutralkills, suicides, killersUbi, RoundPlayed, Doors,
	    armed, disarmed, Activated, Deactivated, startDeaths,
	    startRoundsHit, startRoundsFired, GlobalID;

    local int i;

    // End:0x3B
    if(__NFUN_114__(ScoreManager, none))
    {
        __NFUN_231__(__NFUN_168__(string(self), "BuildEndText, ScoreManager was none!!"));
        return;
    }
    // End:0x74
    if(__NFUN_114__(arrayManager, none))
    {
        __NFUN_231__(__NFUN_168__(string(self), "BuildStats, arrayManager was none!!"));
        return;
    }
    i = 0;
    J0x7B:

    // End:0x3D4 [Loop If]
    if(__NFUN_150__(i, ScoreManager.PlayerRoundInfoSet.Length))
    {
        // End:0xB6
        if(__NFUN_129__(ScoreManager.PlayerRoundInfoSet[i].RoundPlayed))
        {
            // [Explicit Continue]
            goto J0x3CA;
        }
        SD(ubiIDs, ScoreManager.PlayerRoundInfoSet[i].UbiID);
        SD(nicks, ScoreManager.PlayerRoundInfoSet[i].Nickname);
        SD(RoundsHit, string(ScoreManager.PlayerRoundInfoSet[i].RoundsHit));
        SD(RoundsFired, string(ScoreManager.PlayerRoundInfoSet[i].RoundsFired));
        SD(Kills, string(ScoreManager.PlayerRoundInfoSet[i].Kills.Enemy));
        SD(Deaths, string(ScoreManager.GetTotalKillsFor(ScoreManager.PlayerRoundInfoSet[i].Deaths)));
        SD(RoundPlayed, string(int(ScoreManager.PlayerRoundInfoSet[i].RoundPlayed)));
        SD(neutralkills, string(ScoreManager.PlayerRoundInfoSet[i].Kills.Neutral));
        SD(teamkills, string(ScoreManager.PlayerRoundInfoSet[i].Kills.friendly));
        SD(teamkilled, string(ScoreManager.PlayerRoundInfoSet[i].Deaths.friendly));
        SD(suicides, string(ScoreManager.PlayerRoundInfoSet[i].Deaths.Suicide));
        SD(Doors, string(ScoreManager.PlayerRoundInfoSet[i].DoorsDestroyed));
        SD(armed, string(ScoreManager.PlayerRoundInfoSet[i].BombsArmed));
        SD(disarmed, string(ScoreManager.PlayerRoundInfoSet[i].BombsDisarmed));
        SD(Activated, string(ScoreManager.PlayerRoundInfoSet[i].DevicesActivated));
        SD(Deactivated, string(ScoreManager.PlayerRoundInfoSet[i].DevicesDeactivated));
        SD(killersUbi, EncodeNick(ScoreManager.PlayerRoundInfoSet[i].KilledBy));
        SD(GlobalID, ScoreManager.PlayerRoundInfoSet[i].GlobalID);
        SD(startDeaths, "0");
        SD(startRoundsHit, "0");
        SD(startRoundsFired, "0");
        J0x3CA:

        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x7B;
    }
    Text = __NFUN_112__("&ident=", postIdent);
    SA(Text, __NFUN_112__(UbiNameMarker, ubiIDs));
    SA(Text, __NFUN_112__(NickMarker, nicks));
    SA(Text, __NFUN_112__(HitMarker, RoundsHit));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(RoundsFiredMarker, RoundsFired));
    SA(Text, __NFUN_112__(PlayerKillMarker, Kills));
    SA(Text, __NFUN_112__(DeathMarker, Deaths));
    SA(Text, __NFUN_112__(GameTypeMarker, GetGameType()));
    SA(Text, __NFUN_112__(CurrentMapMarker, GetCurrentMapName()));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(RoundPlayedMarker, RoundPlayed));
    SA(Text, __NFUN_112__(VersionMarker, string(GetBuildNumber())));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(RoundTimeMarker, string(RoundTime)));
    SA(Text, __NFUN_112__(SuicideMarker, suicides));
    SA(Text, __NFUN_112__(NeutralKillMarker, neutralkills));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(TeamKillMarker, teamkills));
    SA(Text, __NFUN_112__(TeamKilledMarker, teamkilled));
    SA(Text, __NFUN_112__(PlayerDoorsDestroyedMarker, Doors));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(PlayerBombsArmedMarker, armed));
    SA(Text, __NFUN_112__(PlayerBombsDisarmedMarker, disarmed));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(PlayerDevicesActivatedMarker, Activated));
    SA(Text, __NFUN_112__(PlayerDevicesDeactivatedMarker, Deactivated));
    SA(Text, __NFUN_112__(KilledByMarker, killersUbi));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(TerroristDeathMarker, string(ScoreManager.GetTotalKillsFor(ScoreManager.TerroristDeaths))));
    SA(Text, __NFUN_112__(TerroristTeamKillMarker, string(ScoreManager.TerroristDeaths.friendly)));
    SA(Text, __NFUN_112__(TerroristSuicideMarker, string(ScoreManager.TerroristDeaths.Suicide)));
    SA(Text, __NFUN_112__(TerroristNeutralKillMarker, string(ScoreManager.TerroristKills.Neutral)));
    SA(Text, __NFUN_112__(TerroristKillMarker, string(ScoreManager.TerroristKills.Enemy)));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(TotalDoorsDestroyedMarker, string(ScoreManager.DoorsDestroyed)));
    SA(Text, __NFUN_112__(TotalDevicesDestroyedMarker, string(ScoreManager.DevicesDestroyed)));
    SA(Text, __NFUN_112__(TotalBombsDetonatedMarker, string(ScoreManager.BombsDetonated)));
    SA(Text, __NFUN_112__(GlobalIDMarker, GlobalID));
    arrayManager.AddText(Text);
    Text = "";
    SA(Text, __NFUN_112__(BeaconPortMarker, string(GetServerBeaconPort())));
    SA(Text, __NFUN_112__(StartUbiNameMarker, ubiIDs));
    SA(Text, __NFUN_112__(StartHitMarker, startRoundsHit));
    SA(Text, __NFUN_112__(StartRoundsFiredMarker, startRoundsFired));
    SA(Text, __NFUN_112__(StartDeathMarker, startDeaths));
    SA(Text, EndMarker);
    AddLine(Text);
    AddLine(Text);
    arrayManager.AddText(Text);
    Text = "";
    return;
}

function int GetServerBeaconPort()
{
    local UDPBeaconEx beaconEX;
    local UdpBeacon beacon;

    // End:0x21
    foreach __NFUN_313__(Class'UDPBeaconEx', beaconEX)
    {        
        return beaconEX.boundport;        
    }    
    // End:0x43
    foreach __NFUN_313__(Class'IpDrv.UdpBeacon', beacon)
    {        
        return beacon.boundport;        
    }    
    return Class'UDPBeaconEx'.default.ServerBeaconPort;
    return;
}

function int GetBuildNumber()
{
    return 310;
    return;
}

function string GetGameType()
{
    local string Result;
    local int i;

    // End:0x17
    if(__NFUN_114__(Level.Game, none))
    {
        return "";
    }
    Result = Level.Game.m_szCurrGameType;
    i = 0;
    J0x3B:

    // End:0x88 [Loop If]
    if(__NFUN_150__(i, GameTypeReplacers.Length))
    {
        // End:0x7E
        if(__NFUN_122__(GameTypeReplacers[i].Replace, Result))
        {
            Result = GameTypeReplacers[i].With;
            // [Explicit Break]
            goto J0x88;
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x3B;
    }
    J0x88:

    return Result;
    return;
}

function string GetCurrentMapName()
{
    // End:0x17
    if(__NFUN_114__(Level.Game, none))
    {
        return "";
    }
    return Level.Game.__NFUN_547__();
    return;
}

function bool StringsMatch(string A, string B, optional bool bCaseInsensitive)
{
    // End:0x19
    if(bCaseInsensitive)
    {
        return __NFUN_124__(A, B);        
    }
    else
    {
        return __NFUN_122__(A, B);
    }
    return;
}

function PlayerController GetPlayerControllerFrom(string PlayerName, optional bool bUbiID, optional bool bCaseInsensitive)
{
    local PlayerController Player;
    local string sTemp;
    local PlayerReplicationInfo Info;

    // End:0x88
    foreach __NFUN_313__(Class'Engine.PlayerController', Player)
    {
        Info = Player.PlayerReplicationInfo;
        // End:0x33
        if(__NFUN_114__(Info, none))
        {
            continue;            
        }
        // End:0x53
        if(bUbiID)
        {
            sTemp = Info.m_szUbiUserID;            
        }
        else
        {
            sTemp = Info.PlayerName;
        }
        // End:0x87
        if(StringsMatch(sTemp, PlayerName, bCaseInsensitive))
        {            
            return Player;
        }        
    }    
    return none;
    return;
}

event ReceivedText(string Text)
{
    super.ReceivedText(Text);
    N4Log(__NFUN_168__("Text", Text),, 3);
    // End:0x30
    if(IsConnected())
    {
        Close();
    }
    return;
}

event ReceivedLine(string Line)
{
    super.ReceivedLine(Line);
    N4Log(__NFUN_168__("Line", Line),, 3);
    // End:0x30
    if(IsConnected())
    {
        Close();
    }
    return;
}

event Resolved(IpAddr Addr)
{
    super.Resolved(Addr);
    Addr.Port = postPort;
    RemoteAddr = Addr;
    Open(Addr);
    return;
}

event Closed()
{
    super.Closed();
    CheckReconnect();
    return;
}

event Opened()
{
    super(TcpLink).Opened();
    PostTheData();
    return;
}

function CheckReconnect()
{
    // End:0x3D
    if(__NFUN_114__(DataManager, none))
    {
        N4Log(__NFUN_168__(string(self), "FATAL ERROR datamanager was none"));
        return;        
    }
    else
    {
        // End:0x78
        if(__NFUN_130__(__NFUN_130__(__NFUN_123__(postHost, ""), __NFUN_151__(DataManager.CalcLength(), 0)), __NFUN_129__(IsConnected())))
        {
            ConnectToServer(postHost);
        }
    }
    return;
}

event Trigger(Actor Other, Pawn EventInstigator)
{
    super(Actor).Trigger(Other, EventInstigator);
    RoundTime = __NFUN_175__(Level.TimeSeconds, LastRoundTime);
    LastRoundTime = Level.TimeSeconds;
    BuildAndQueueData();
    return;
}

defaultproperties
{
    postPort=80
    bDestroyWithParent=true
    bPostToMasterServer=true
    PosterChildClass=Class'N4URLPost'
    DataManagerClass=Class'N4URLPostDataManager'
    ScoreManagerClass=Class'N4ScoreManager'
    MissionHookMutatorClass=Class'N4MissionHookMutator'
    MasterServer=(Host="www.squadgames.com",URL="/rvsslwebphp/post.php",Port=80,ident="Public",bSilent=true)
    UbiNameMarker="&UB="
    NickMarker="&L1="
    HitMarker="&HI="
    RoundsFiredMarker="&RF="
    DeathMarker="&DE="
    CurrentMapMarker="&E1="
    GameTypeMarker="&F1="
    PlayerKillMarker="&O1="
    EndMarker="&xx=end"
    StartUbiNameMarker="&US="
    StartHitMarker="&HS="
    StartRoundsFiredMarker="&RS="
    StartDeathMarker="&DS="
    RoundPlayedMarker="&RP="
    VersionMarker="&VS="
    RoundTimeMarker="&RT="
    TeamKillMarker="&TK="
    TeamKilledMarker="&TD="
    NeutralKillMarker="&NK="
    SuicideMarker="&S1="
    TerroristDeathMarker="&T_D="
    TerroristSuicideMarker="&T_S="
    TerroristNeutralKillMarker="&T_N="
    TerroristKillMarker="&T_K="
    TerroristTeamKillMarker="&T_TK="
    KilledByMarker="&KB="
    TotalDoorsDestroyedMarker="&DD1="
    TotalDevicesDestroyedMarker="&DD2="
    TotalBombsDetonatedMarker="&TBD="
    PlayerDoorsDestroyedMarker="&PDD1="
    PlayerBombsArmedMarker="&PBA="
    PlayerBombsDisarmedMarker="&PBD="
    PlayerDevicesActivatedMarker="&PDA="
    PlayerDevicesDeactivatedMarker="&PDD2="
    GlobalIDMarker="&PGID="
    BeaconPortMarker="&SBPT="
    postHost="localhost"
    postURL="/rvsslwebphp/post.php"
    postIdent="Ident"
    PostOperation="POST"
    HTTPVersion="HTTP/1.0"
    DebugLevel=1
    Tag="EndGame"
}