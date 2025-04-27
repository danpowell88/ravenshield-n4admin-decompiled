class IRCSpectator extends R6PlayerController
    config(User);

var() config bool LogMessages;
var IRCUpLink link;
var string BotName;

function PreBeginPlay()
{
    local Player tPlayer;

    link = __NFUN_278__(Class'IRCUpLink');
    BotName = link.BotName;
    // End:0x3D
    if(__NFUN_122__(BotName, ""))
    {
        BotName = "IRC Bot";
    }
    bIsPlayer = false;
    return;
}

function ProcessMessage(string Message, optional int type)
{
    // End:0x1E
    if(LogMessages)
    {
        __NFUN_231__(Message, Class.Name);
    }
    link.ProcessMessage(Message, type);
    return;
}

event TeamMessage(PlayerReplicationInfo PRI, coerce string Msg, name MsgType)
{
    // End:0x43
    if(__NFUN_132__(__NFUN_254__(MsgType, 'Say'), __NFUN_254__(MsgType, 'TeamSay')))
    {
        Msg = __NFUN_112__(__NFUN_112__(GetPrefixToMsg(PRI, MsgType), ": "), Msg);
    }
    ProcessMessage(Msg, 1);
    return;
}

function ClientMPMiscMessage(string szMsgID, string Name, optional string szEndOfMsg)
{
    local string Message;

    // End:0x48
    if(__NFUN_123__(Name, ""))
    {
        Message = __NFUN_112__(__NFUN_112__(Name, " "), Localize("MPMiscMessages", szMsgID, "R6GameInfo"));        
    }
    else
    {
        Message = Localize("MPMiscMessages", szMsgID, "R6GameInfo");
    }
    Message = __NFUN_168__(Message, szEndOfMsg);
    ProcessMessage(Message, 3);
    return;
}

function ClientRestartRoundMsg(string _AdminName, string explanation)
{
    return;
}

function InitInteractions()
{
    return;
}

event InitMultiPlayerOptions()
{
    return;
}

function Tick(float fDeltaTime)
{
    return;
}

event PlayerTick(float DeltaTime)
{
    return;
}

function ClientKickedOut()
{
    SendNoKickMsg();
    return;
}

function SendNoKickMsg()
{
    local R6PlayerController Player;

    // End:0x80
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', Player)
    {
        Player.TeamMessage(none, __NFUN_112__(PlayerReplicationInfo.PlayerName, ": You cannot kick me, I am an IRC Bot set up by the admin of this server"), 'kickmsg');        
    }    
    return;
}

function ClientBanned()
{
    SendNoKickMsg();
    return;
}

function ServerIndicatesInvalidCDKey(string _szErrorMsgKey)
{
    return;
}

event Destroyed()
{
    return;
}

function ClientVoiceMessage(PlayerReplicationInfo Sender, PlayerReplicationInfo Recipient, name messagetype, byte messageID)
{
    return;
}

function HandleServerMsg(string _szServerMsg, optional int iLifeTime)
{
    ProcessMessage(_szServerMsg, 5);
    return;
}

function InitPlayerReplicationInfo()
{
    super(Controller).InitPlayerReplicationInfo();
    PlayerReplicationInfo.PlayerName = BotName;
    PlayerReplicationInfo.bIsSpectator = true;
    PlayerReplicationInfo.bOutOfLives = true;
    PlayerReplicationInfo.bWaitingPlayer = false;
    return;
}

function ServerMove(float TimeStamp, Vector InAccel, Vector ClientLoc, bool NewbRun, bool NewbDuck, bool NewbCrawl, int View, int iNewRotOffset, optional byte OldTimeDelta, optional int OldAccel)
{
    return;
}

function ReplicateMove(float DeltaTime, Vector NewAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    return;
}

function bool CheckAuthority(int _LevelNeeded)
{
    return true;
    return;
}

function ClientChangeMap()
{
    // End:0x1A
    if(__NFUN_119__(link, none))
    {
        link.MapChange();
    }
    super.ClientChangeMap();
    return;
}

function int GetTeam(string Name)
{
    local R6PlayerController Player;

    // End:0x4B
    foreach __NFUN_313__(Class'R6Engine.R6PlayerController', Player)
    {
        // End:0x4A
        if(__NFUN_124__(Player.PlayerReplicationInfo.PlayerName, Name))
        {            
            return Player.PlayerReplicationInfo.TeamID;
        }        
    }    
    return 0;
    return;
}

function ClientDeathMessage(string Killer, string killed, byte bSuicideType)
{
    local string Msg;
    local int Team;

    // End:0x16
    if(__NFUN_114__(Level.Game, none))
    {
        return;
    }
    Msg = Class'R6Engine.R6Pawn'.static.BuildDeathMessage(Killer, killed, bSuicideType);
    // End:0xBC
    if(Level.IsGameTypeTeamAdversarial(Level.Game.m_szCurrGameType))
    {
        Team = GetTeam(killed);
        // End:0x90
        if(__NFUN_154__(Team, 2))
        {
            ProcessMessage(Msg, 6);            
        }
        else
        {
            // End:0xAC
            if(__NFUN_154__(Team, 3))
            {
                ProcessMessage(Msg, 7);                
            }
            else
            {
                ProcessMessage(Msg, 7);
            }
        }        
    }
    else
    {
        ProcessMessage(Msg, 2);
    }
    return;
}

function ClientNewLobbyConnection(int iLobbyID, int iGroupID)
{
    return;
}

event ReceiveLocalizedMessage(class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    ProcessMessage(Message.static.GetString(Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject), 4);
    return;
}

auto state NotPlaying
{    stop;
}

state Dead
{
    function PlayFiring()
    {
        return;
    }

    function AltFiring()
    {
        return;
    }

    function PlayerMove(float DeltaTime)
    {
        return;
    }

    function ServerReStartPlayer()
    {
        return;
    }

    exec function Fire(optional float f)
    {
        return;
    }

    simulated function ResetCurrentState()
    {
        return;
    }

    simulated function BeginState()
    {
        return;
    }

    function EnterSpectatorMode()
    {
        return;
    }

    function EndState()
    {
        return;
    }

    function Tick(float t)
    {
        return;
    }

    function Timer()
    {
        return;
    }
    stop;
}

defaultproperties
{
    BotName="IRC Bot"
    bShowLog=true
}