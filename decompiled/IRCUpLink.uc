class IRCUpLink extends N4TCPLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var() config int Port;
var int nicks;
var int ProcessUser;
var() config bool ShowScores;
var() config bool ShowDeathMessages;
var() config bool ShowSayMessages;
var() config bool ShowMiscMessages;
var() config bool ShowLocalMessages;
var() config bool ShowServerMessages;
var() config bool ShowOtherMessages;
var() config bool Debug;
var() config bool ShowScoresAtRoundEnd;
var bool bShutDownCorrectly;
var bool ScoresShown;
var bool ShownAlready;
var bool bLogOn;
var() config bool bDelayAtStartup;
var bool bGotoReconnecting;
var bool bResetReconnectTime;
var() config float ServerMessageDelay;
var() config float ReconnectTime;
var IRCIdentd identd;
var N4Admin Admin;
var FloodProtection FloodProtection;
var N4TimeKeeper TimeKeeper;
var N4ShutdownManager ShutdownManager;
var class<N4TimeKeeper> TimeKeeperClass;
var class<N4ShutdownManager> ShutdownManagerClass;
var() config array<string> OnConnectCommand;
var() config string BotName;
var() config string Nickname;
var() config string AlternateNickName;
var() config string server;
var() config string OnJoinMessage;
var() config string Channel;
var() config string ChannelKey;
var() config string JoinNotice;
var() config string DefaultPrefix;
var() config string MessagePrefix;
var() config string DeathPrefix;
var() config string MiscPrefix;
var() config string LocalPrefix;
var() config string ServerPrefix;
var() config string GreenTeamPrefix;
var() config string RedTeamPrefix;
var() config string OtherTeamPrefix;
var() config string MapChangeQuitMessage;
var() config string SpamMessage;
var() config string UserID;
var() config string AdminPassword;
var() config string Password;
var() config string PlayerTeamScoreFormatString;
var() config string PlayerScoreFormatString;
var() config string RejoinMessage;
var() config string TeamGameFormatString;
var() config string GameFormatString;
var() config string PlayerInfoFormatString;
var() config string GreenTeamDeathPrefix;
var() config string RedTeamDeathPrefix;
var string nick;
var string CTCP;
var private string Version;

function PreBeginPlay()
{
    super.PreBeginPlay();
    InitTimeKeeper();
    InitShutDownManager();
    return;
}

function InitShutDownManager()
{
    ShutdownManager = N4ShutdownManager(InitObject(ShutdownManagerClass, Class'N4IRCShutdownManager'));
    // End:0x3F
    if(__NFUN_119__(ShutdownManager, none))
    {
        bShutDownCorrectly = ShutdownManager.PowerOn();        
    }
    else
    {
        __NFUN_231__(__NFUN_168__(string(self), "Could not load the shutdown maanger"));
    }
    return;
}

function Shutdown()
{
    // End:0x1D
    if(__NFUN_119__(ShutdownManager, none))
    {
        ShutdownManager.Shutdown();        
    }
    else
    {
        __NFUN_231__(__NFUN_168__(string(self), "Shutdown manager not found"));
    }
    return;
}

function InitTimeKeeper()
{
    TimeKeeper = N4TimeKeeper(InitObject(TimeKeeperClass, Class'IRCTimeKeeper'));
    return;
}

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    __NFUN_231__("IRC Bot started");
    FloodProtection = __NFUN_278__(Class'FloodProtection');
    FloodProtection.SetLink(self);
    // End:0x50
    if(__NFUN_122__(UserID, ""))
    {
        UserID = "blank";
    }
    ReplaceText(server, " ", "");
    // End:0x79
    if(__NFUN_176__(ServerMessageDelay, float(5)))
    {
        ServerMessageDelay = 5.0000000;
    }
    Admin = __NFUN_278__(Class'N4Admin');
    Admin.RemoteString = "[IRC]";
    nicks = 0;
    CTCP = __NFUN_236__(1);
    ScoresShown = false;
    // End:0xCE
    if(__NFUN_129__(bDelayAtStartup))
    {
        ConnectToServer(server);        
    }
    else
    {
        // End:0x1A9
        if(__NFUN_119__(TimeKeeper, none))
        {
            // End:0x132
            if(bShutDownCorrectly)
            {
                __NFUN_185__(ReconnectTime, TimeKeeper.SecondsElapsedTo(TimeKeeper.GetTime(Level)));
                __NFUN_231__(__NFUN_168__("Temp reconnect time is", string(ReconnectTime)));                
            }
            else
            {
                __NFUN_231__(__NFUN_168__(string(self), "Did not shutdown correctly last time, waiting the full reconnect time before connecting"));
            }
            ReconnectTime = __NFUN_246__(ReconnectTime, 0.0000000, default.ReconnectTime);
        }
        bGotoReconnecting = true;
        bResetReconnectTime = true;
    }
    return;
}

function UpdateTimeKeeper()
{
    __NFUN_231__("Updating time keeper");
    // End:0x3A
    if(__NFUN_119__(TimeKeeper, none))
    {
        TimeKeeper.UpdateCurrentTime(Level);        
    }
    else
    {
        __NFUN_231__("Could not update the time keeper");
    }
    return;
}

function ConnectToServer(string server)
{
    super.ConnectToServer(server);
    UpdateTimeKeeper();
    return;
}

function QueueLine(string Text)
{
    // End:0x24
    if(IsConnected())
    {
        FloodProtection.AddNext(__NFUN_112__(Text, CRLF));
    }
    return;
}

function SendLine(string Text)
{
    // End:0x1B
    if(IsConnected())
    {
        SendText(__NFUN_112__(Text, CRLF));
    }
    return;
}

function Tick(float t)
{
    super(Actor).Tick(t);
    // End:0x28
    if(bGotoReconnecting)
    {
        __NFUN_113__('Reconnecting', 'Open');
        bGotoReconnecting = false;
    }
    // End:0x81
    if(__NFUN_176__(__NFUN_175__(R6GameInfo(Level.Game).m_fEndingTime, Level.TimeSeconds), float(0)))
    {
        // End:0x7E
        if(__NFUN_129__(ScoresShown))
        {
            ScoresShown = true;
            // End:0x7E
            if(ShowScoresAtRoundEnd)
            {
                BroadcastScores();
            }
        }        
    }
    else
    {
        ScoresShown = false;
    }
    return;
}

function Timer()
{
    // End:0x17
    if(__NFUN_123__(SpamMessage, ""))
    {
        BroadcastText(SpamMessage);
    }
    // End:0x26
    if(ShowScores)
    {
        BroadcastScores();
    }
    return;
}

function string GetCurrentNickName()
{
    return nick;
    return;
}

event Resolved(IpAddr Addr)
{
    Addr.Port = Port;
    // End:0x27
    if(__NFUN_119__(identd, none))
    {
        identd.__NFUN_279__();
    }
    identd = __NFUN_278__(Class'IRCIdentd');
    identd.Start(UserID);
    RemoteAddr = Addr;
    Open(Addr);
    return;
}

event Closed()
{
    UpdateTimeKeeper();
    __NFUN_231__("Disconnect");
    __NFUN_113__('Reconnecting', 'Open');
    return;
}

function string BreakUpText(string Text, string delimeter, optional out string after)
{
    local int i;

    i = __NFUN_126__(Text, delimeter);
    // End:0x4E
    if(__NFUN_153__(i, 0))
    {
        after = __NFUN_234__(Text, __NFUN_147__(__NFUN_125__(Text), __NFUN_146__(i, __NFUN_125__(delimeter))));
        return __NFUN_128__(Text, i);
    }
    return Text;
    return;
}

function ReplyToMessage(string received, string Message)
{
    SendMessage(GetSender(received), Message);
    return;
}

function SendNotice(string to, string Message)
{
    // End:0x2D
    if(__NFUN_123__(Message, ""))
    {
        QueueLine(__NFUN_112__(__NFUN_168__(__NFUN_168__("NOTICE", to), ":"), Message));
    }
    return;
}

function SendMessage(string to, string Message)
{
    // End:0x2E
    if(__NFUN_123__(Message, ""))
    {
        QueueLine(__NFUN_112__(__NFUN_168__(__NFUN_168__("PRIVMSG", to), ":"), Message));
    }
    return;
}

function string GetSender(string Msg, optional out string ident, optional out string Host)
{
    Msg = BreakUpText(Msg, " ");
    Msg = BreakUpText(Msg, "@", Host);
    Msg = BreakUpText(Msg, "!", ident);
    BreakUpText(Msg, ":", Msg);
    return Msg;
    return;
}

function ChangeNick(string newNickName)
{
    SendLine(__NFUN_168__("NICK", newNickName));
    nick = Nickname;
    return;
}

function LogOn()
{
    // End:0x1F
    if(__NFUN_123__(Password, ""))
    {
        SendLine(__NFUN_168__("PASS", Password));
    }
    ChangeNick(Nickname);
    SendLine(__NFUN_168__(__NFUN_168__("USER", UserID), "0 0 :rvs irc bot"));
    return;
}

event N4ReceiveLine(string Line)
{
    super.N4ReceiveLine(Line);
    ProcessLine(Line);
    return;
}

function ProcessLine(string Text)
{
    // End:0x10
    if(Debug)
    {
        __NFUN_231__(Text);
    }
    // End:0x27
    if(bLogOn)
    {
        LogOn();
        bLogOn = false;
    }
    // End:0x94
    if(__NFUN_132__(__NFUN_154__(__NFUN_126__(__NFUN_235__(Text), __NFUN_235__("NOTICE AUTH :***")), 0), __NFUN_154__(__NFUN_126__(__NFUN_235__(GetAfterParticularToken(Text, 1)), __NFUN_235__("NOTICE AUTH :***")), 0)))
    {
        __NFUN_165__(ProcessUser);
        // End:0x91
        if(__NFUN_154__(ProcessUser, 2))
        {
            bLogOn = true;
        }        
    }
    else
    {
        // End:0xCC
        if(__NFUN_154__(__NFUN_126__(Text, "PING"), 0))
        {
            ReplaceText(Text, "PING", "PONG");
            SendLine(Text);            
        }
        else
        {
            // End:0x145
            if(__NFUN_154__(__NFUN_126__(Text, "ERROR :Closing Link:"), 0))
            {
                __NFUN_231__(__NFUN_168__(__NFUN_168__(string(self), "Server quit, Excess flood? Try turning some message off. Raw error:"), Text));                
            }
            else
            {
                isKnownCommand(Text);
            }
        }
    }
    return;
}

function string GetParticularToken(string Text, int tokens, optional string token)
{
    local StringTokenizer tokenizer;

    // End:0x15
    if(__NFUN_122__(token, ""))
    {
        token = " ";
    }
    tokenizer = new (none) Class'N4Util.StringTokenizer';
    tokenizer.Tokenize(Text, token);
    return tokenizer.GetToken(tokens);
    return;
}

function string GetCommand(string Text)
{
    return GetParticularToken(Text, 1);
    return;
}

function bool isKnownCommand(string Text)
{
    local StringTokenizer tokens;

    tokens = new (none) Class'N4Util.StringTokenizer';
    tokens.Tokenize(Text, " ");
    switch(GetCommand(Text))
    {
        // End:0x49
        case "001":
            OnConnect(Text);
            // End:0x135
            break;
        // End:0xB5
        case "433":
            // End:0x7B
            if(Debug)
            {
                __NFUN_231__("attempting to change nickname");
            }
            // End:0x96
            if(__NFUN_154__(__NFUN_165__(nicks), 0))
            {
                ChangeNick(AlternateNickName);                
            }
            else
            {
                ChangeNick(__NFUN_112__(__NFUN_112__("b", string(__NFUN_147__(nicks, 1))), Nickname));
            }
            // End:0x135
            break;
        // End:0xCC
        case "KICK":
            OnKicked(Text);
            // End:0x135
            break;
        // End:0xE5
        case "NOTICE":
            OnNotice(Text);
            // End:0x135
            break;
        // End:0xFF
        case "PRIVMSG":
            OnMessage(Text);
            // End:0x135
            break;
        // End:0x116
        case "JOIN":
            OnJoin(Text);
            // End:0x135
            break;
        // End:0x12D
        case "NICK":
            OnNick(Text);
            // End:0x135
            break;
        // End:0xFFFF
        default:
            return false;
            break;
    }    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x135
    return true;
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x135
    return;
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x135
    // Failed to format remaining nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x135
}

function OnNick(string Text)
{
    local string Sender;

    Sender = GetSender(Text);
    // End:0x37
    if(__NFUN_124__(Sender, GetCurrentNickName()))
    {
        nick = __NFUN_127__(GetParticularToken(Text, 2), 1);
    }
    return;
}

function OnJoin(string Text)
{
    local string Sender;

    Sender = GetSender(Text);
    // End:0x3F
    if(__NFUN_130__(__NFUN_123__(Sender, GetCurrentNickName()), __NFUN_123__(JoinNotice, "")))
    {
        SendNotice(Sender, JoinNotice);
    }
    return;
}

function string GetReceiver(string Text)
{
    return GetParticularToken(Text, 2);
    return;
}

function string GetAfterParticularToken(string Text, int tokens, optional string token)
{
    // End:0x15
    if(__NFUN_122__(token, ""))
    {
        token = " ";
    }
    J0x15:

    // End:0x69 [Loop If]
    if(__NFUN_130__(__NFUN_151__(tokens, 0), __NFUN_153__(__NFUN_126__(Text, token), 0)))
    {
        Text = __NFUN_234__(Text, __NFUN_147__(__NFUN_125__(Text), __NFUN_146__(__NFUN_126__(Text, token), __NFUN_125__(token))));
        __NFUN_166__(tokens);
        // [Loop Continue]
        goto J0x15;
    }
    // End:0x7C
    if(__NFUN_151__(tokens, 0))
    {
        Text = "";
    }
    return Text;
    return;
}

function string GetAfterParticularTokenWithoutLast(string Text, int tokens, optional string token)
{
    Text = GetAfterParticularToken(Text, tokens, token);
    Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
    // End:0x51
    if(Debug)
    {
        __NFUN_231__(__NFUN_168__("Token text:", Text));
    }
    return Text;
    return;
}

function Quit(optional string Reason)
{
    SendLine(__NFUN_112__("QUIT :", Reason));
    return;
}

function MapChange()
{
    UpdateTimeKeeper();
    Shutdown();
    Quit(MapChangeQuitMessage);
    return;
}

event Destroyed()
{
    super(Actor).Destroyed();
    Shutdown();
    __NFUN_231__("IRC bot DESTROYED!!!");
    UpdateTimeKeeper();
    return;
}

function string GetMessage(string Text)
{
    Text = GetAfterParticularToken(Text, 3);
    Text = __NFUN_234__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
    return Text;
    return;
}

function OnNotice(string Text)
{
    local string Sender, Receiver, Message;

    Sender = GetSender(Text);
    Message = GetMessage(Text);
    Receiver = GetReceiver(Text);
    return;
}

function SendCTCPReply(string to, string type, string reply)
{
    SendNotice(to, __NFUN_112__(__NFUN_168__(__NFUN_112__(CTCP, type), reply), CTCP));
    return;
}

function SendCTCP(string to, string Text)
{
    SendMessage(to, __NFUN_112__(__NFUN_112__(CTCP, Text), CTCP));
    return;
}

function OnMessage(string Text)
{
    local string Sender, Receiver, Message;
    local R6PlayerController Player;
    local int i;

    Sender = GetSender(Text);
    Message = GetMessage(Text);
    Receiver = GetReceiver(Text);
    // End:0x70
    if(__NFUN_122__(Message, __NFUN_112__(__NFUN_112__(CTCP, "VERSION"), CTCP)))
    {
        SendCTCPReply(Sender, "VERSION", Version);        
    }
    else
    {
        // End:0x18B
        if(__NFUN_122__(Message, __NFUN_112__(__NFUN_112__(CTCP, "TIME"), CTCP)))
        {
            Text = __NFUN_112__(string(Level.Hour), ":");
            // End:0xCE
            if(__NFUN_150__(Level.Minute, 10))
            {
                Text = __NFUN_112__(Text, "0");
            }
            Text = __NFUN_112__(__NFUN_112__(Text, string(Level.Minute)), ":");
            // End:0x115
            if(__NFUN_150__(Level.Second, 10))
            {
                Text = __NFUN_112__(Text, "0");
            }
            Text = __NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_168__(__NFUN_112__(Text, string(Level.Second)), string(Level.Month)), "/"), string(Level.Day)), "/"), string(Level.Year));
            SendCTCPReply(Sender, "TIME", Text);            
        }
        else
        {
            // End:0x1CD
            if(__NFUN_122__(Message, __NFUN_112__(__NFUN_112__(CTCP, "FINGER"), CTCP)))
            {
                SendCTCPReply(Sender, "FINGER", "Don't stop");                
            }
            else
            {
                // End:0xC72
                if(__NFUN_122__(__NFUN_234__(Message, 1), CTCP))
                {
                    // End:0x20C
                    if(__NFUN_154__(__NFUN_126__(Message, __NFUN_112__(CTCP, "PING")), 0))
                    {
                        SendNotice(Sender, Message);                        
                    }
                    else
                    {
                        // End:0x21B
                        if(__NFUN_122__(AdminPassword, ""))
                        {                            
                        }
                        else
                        {
                            // End:0x288
                            if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "NICK"), AdminPassword)), 0))
                            {
                                Text = GetAfterParticularToken(Message, 2);
                                Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                // End:0x285
                                if(__NFUN_123__(Text, ""))
                                {
                                    SendLine(__NFUN_168__("NICK", Text));
                                }                                
                            }
                            else
                            {
                                // End:0x2F1
                                if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "RESTARTROUND"), AdminPassword)), 0))
                                {
                                    Admin.RestartRound(Sender, GetAfterParticularTokenWithoutLast(Message, 2));
                                    SendNotice(Sender, "Round Restarted");                                    
                                }
                                else
                                {
                                    // End:0x33A
                                    if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "PLAYERINFO"), AdminPassword)), 0))
                                    {
                                        SendNotice(Sender, GetPlayerInfo(GetAfterParticularTokenWithoutLast(Message, 2), false));                                        
                                    }
                                    else
                                    {
                                        // End:0x386
                                        if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "PLAYERINFOUBI"), AdminPassword)), 0))
                                        {
                                            SendNotice(Sender, GetPlayerInfo(GetAfterParticularTokenWithoutLast(Message, 2), true));                                            
                                        }
                                        else
                                        {
                                            // End:0x3EF
                                            if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "RESTARTMATCH"), AdminPassword)), 0))
                                            {
                                                Admin.RestartMatch(Sender, GetAfterParticularTokenWithoutLast(Message, 2));
                                                SendNotice(Sender, "Match Restarted");                                                
                                            }
                                            else
                                            {
                                                // End:0x448
                                                if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "RESTARTSERVER"), AdminPassword)), 0))
                                                {
                                                    Admin.RestartServer();
                                                    SendNotice(Sender, "Server Restarted");                                                    
                                                }
                                                else
                                                {
                                                    // End:0x4AC
                                                    if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "RAW"), AdminPassword)), 0))
                                                    {
                                                        Text = GetAfterParticularToken(Message, 2);
                                                        Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                        // End:0x4A9
                                                        if(__NFUN_123__(Text, ""))
                                                        {
                                                            SendLine(Text);
                                                        }                                                        
                                                    }
                                                    else
                                                    {
                                                        // End:0x4DC
                                                        if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "SHOWSCORES"), AdminPassword)), 0))
                                                        {
                                                            BroadcastScores();                                                            
                                                        }
                                                        else
                                                        {
                                                            // End:0x5B7
                                                            if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "KICKUBI"), AdminPassword)), 0))
                                                            {
                                                                Text = GetAfterParticularToken(Message, 2);
                                                                Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                                // End:0x578
                                                                if(Admin.KickPlayerUbi(Text, false))
                                                                {
                                                                    SendNotice(Sender, __NFUN_168__(Text, "has been kicked from the server"));                                                                    
                                                                }
                                                                else
                                                                {
                                                                    SendNotice(Sender, __NFUN_112__("Could not find a player with the ubi id ", Text));
                                                                }                                                                
                                                            }
                                                            else
                                                            {
                                                                // End:0x68C
                                                                if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "KICK"), AdminPassword)), 0))
                                                                {
                                                                    Text = GetAfterParticularToken(Message, 2);
                                                                    Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                                    // End:0x650
                                                                    if(Admin.KickPlayerName(Text, false))
                                                                    {
                                                                        SendNotice(Sender, __NFUN_168__(Text, "has been kicked from the server"));                                                                        
                                                                    }
                                                                    else
                                                                    {
                                                                        SendNotice(Sender, __NFUN_168__("Could not find a player with the name", Text));
                                                                    }                                                                    
                                                                }
                                                                else
                                                                {
                                                                    // End:0x765
                                                                    if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "BANUBI"), AdminPassword)), 0))
                                                                    {
                                                                        Text = GetAfterParticularToken(Message, 2);
                                                                        Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                                        // End:0x727
                                                                        if(Admin.KickPlayerUbi(Text, true))
                                                                        {
                                                                            SendNotice(Sender, __NFUN_168__(Text, "has been banned from the server"));                                                                            
                                                                        }
                                                                        else
                                                                        {
                                                                            SendNotice(Sender, __NFUN_168__("Could not find a player with the ubi id", Text));
                                                                        }                                                                        
                                                                    }
                                                                    else
                                                                    {
                                                                        // End:0x83B
                                                                        if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "BAN"), AdminPassword)), 0))
                                                                        {
                                                                            Text = GetAfterParticularToken(Message, 2);
                                                                            Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                                            // End:0x7FE
                                                                            if(Admin.KickPlayerName(Text, true))
                                                                            {
                                                                                SendNotice(Sender, __NFUN_112__(Text, " has been banned from the server"));                                                                                
                                                                            }
                                                                            else
                                                                            {
                                                                                SendNotice(Sender, __NFUN_112__("Could not find a player with the name ", Text));
                                                                            }                                                                            
                                                                        }
                                                                        else
                                                                        {
                                                                            // End:0x8A1
                                                                            if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "SAY"), AdminPassword)), 0))
                                                                            {
                                                                                Text = GetAfterParticularToken(Message, 2);
                                                                                Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                                                Admin.BroadcastAdminMessage(Text, Sender);                                                                                
                                                                            }
                                                                            else
                                                                            {
                                                                                // End:0x907
                                                                                if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "CONSOLE"), AdminPassword)), 0))
                                                                                {
                                                                                    Text = GetAfterParticularToken(Message, 2);
                                                                                    Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                                                    Level.ConsoleCommand(Text);                                                                                    
                                                                                }
                                                                                else
                                                                                {
                                                                                    // End:0x9C0
                                                                                    if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "LOADSERVER"), AdminPassword)), 0))
                                                                                    {
                                                                                        Text = GetAfterParticularToken(Message, 2);
                                                                                        Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                                                        // End:0x996
                                                                                        if(Admin.LoadServer(Text))
                                                                                        {
                                                                                            SendNotice(Sender, __NFUN_112__(Text, " has been loaded"));                                                                                            
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            SendNotice(Sender, __NFUN_112__(Text, " could not be found"));
                                                                                        }                                                                                        
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        // End:0xA29
                                                                                        if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "ISPBENABLED"), AdminPassword)), 0))
                                                                                        {
                                                                                            // End:0xA0B
                                                                                            if(__NFUN_1402__())
                                                                                            {
                                                                                                SendNotice(Sender, "pb is enabled");                                                                                                
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                SendNotice(Sender, "pb is disabled");
                                                                                            }                                                                                            
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            // End:0xB7D
                                                                                            if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "SETMAXPLAYERS"), AdminPassword)), 0))
                                                                                            {
                                                                                                Text = GetAfterParticularToken(Message, 2);
                                                                                                Text = __NFUN_128__(Text, __NFUN_147__(__NFUN_125__(Text), 1));
                                                                                                // End:0xB35
                                                                                                if(__NFUN_151__(int(Text), 0))
                                                                                                {
                                                                                                    // End:0xB16
                                                                                                    if(Admin.SetServerOption(__NFUN_168__("MaxPlayers", string(int(Text)))))
                                                                                                    {
                                                                                                        Level.Game.MaxPlayers = __NFUN_146__(int(Text), Admin.GetNumberOfIRCBots());
                                                                                                        SendNotice(Sender, __NFUN_168__("Max Players now:", string(Admin.GetMaxPlayers())));                                                                                                        
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        SendNotice(Sender, "unknown failure");
                                                                                                    }                                                                                                    
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    SendNotice(Sender, __NFUN_168__("Max Players must be greater than 0, you requested", Text));
                                                                                                }                                                                                                
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                // End:0xC72
                                                                                                if(__NFUN_154__(__NFUN_126__(Message, __NFUN_168__(__NFUN_112__(CTCP, "MAP"), AdminPassword)), 0))
                                                                                                {
                                                                                                    Text = GetParticularToken(Message, 2);
                                                                                                    switch(Admin.ChangeMap(__NFUN_147__(int(Text), 1), GetAfterParticularTokenWithoutLast(Message, 3), Sender))
                                                                                                    {
                                                                                                        // End:0xC17
                                                                                                        case -1:
                                                                                                            SendNotice(Sender, "Map index must be between 1 and 32");
                                                                                                            // End:0xC72
                                                                                                            break;
                                                                                                        // End:0xC4A
                                                                                                        case -2:
                                                                                                            SendNotice(Sender, "No map exists at this index");
                                                                                                            // End:0xC72
                                                                                                            break;
                                                                                                        // End:0xFFFF
                                                                                                        default:
                                                                                                            SendNotice(Sender, "Map change successful");
                                                                                                            // End:0xC72
                                                                                                            break;
                                                                                                            break;
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return;
}

function OnConnect(string Text)
{
    local int i;
    local string chan;

    chan = Channel;
    // End:0x29
    if(__NFUN_123__(ChannelKey, ""))
    {
        chan = __NFUN_168__(chan, ChannelKey);
    }
    __NFUN_231__("Connected", Class.Name);
    __NFUN_280__(ServerMessageDelay, true);
    nick = GetReceiver(Text);
    JoinChannel(chan);
    i = 0;
    J0x70:

    // End:0x96 [Loop If]
    if(__NFUN_150__(i, OnConnectCommand.Length))
    {
        SendLine(OnConnectCommand[__NFUN_165__(i)]);
        // [Loop Continue]
        goto J0x70;
    }
    return;
}

function JoinChannel(string Channel)
{
    // End:0x23
    if(__NFUN_122__(__NFUN_128__(Channel, 1), "#"))
    {
        SendLine(__NFUN_168__("JOIN", Channel));
    }
    __NFUN_231__(__NFUN_168__("Joined channel", Channel), Class.Name);
    BroadcastText(__NFUN_168__("Raven Shield IRC Bot now broadcasting in", Channel));
    BroadcastText(OnJoinMessage);
    return;
}

function OnKicked(string Text)
{
    // End:0x41
    if(__NFUN_124__(GetParticularToken(Text, 4), __NFUN_112__(":", GetCurrentNickName())))
    {
        ReplyToMessage(Text, RejoinMessage);
        JoinChannel(GetReceiver(Text));        
    }
    else
    {
        SendLine(__NFUN_168__("JOIN", GetReceiver(Text)));
    }
    return;
}

function ProcessMessage(string Text, optional int type)
{
    local string Prefix;

    // End:0x2D
    if(Debug)
    {
        Text = __NFUN_168__(__NFUN_168__("message type", string(type)), Text);
    }
    switch(type)
    {
        // End:0x53
        case 1:
            Prefix = MessagePrefix;
            // End:0x50
            if(__NFUN_129__(ShowSayMessages))
            {
                return;
            }
            // End:0x126
            break;
        // End:0x73
        case 2:
            Prefix = DeathPrefix;
            // End:0x70
            if(__NFUN_129__(ShowDeathMessages))
            {
                return;
            }
            // End:0x126
            break;
        // End:0x93
        case 3:
            Prefix = MiscPrefix;
            // End:0x90
            if(__NFUN_129__(ShowMiscMessages))
            {
                return;
            }
            // End:0x126
            break;
        // End:0xB3
        case 4:
            Prefix = LocalPrefix;
            // End:0xB0
            if(__NFUN_129__(ShowLocalMessages))
            {
                return;
            }
            // End:0x126
            break;
        // End:0xD3
        case 5:
            Prefix = ServerPrefix;
            // End:0xD0
            if(__NFUN_129__(ShowServerMessages))
            {
                return;
            }
            // End:0x126
            break;
        // End:0xF3
        case 6:
            Prefix = GreenTeamDeathPrefix;
            // End:0xF0
            if(__NFUN_129__(ShowDeathMessages))
            {
                return;
            }
            // End:0x126
            break;
        // End:0x113
        case 7:
            Prefix = RedTeamDeathPrefix;
            // End:0x110
            if(__NFUN_129__(ShowDeathMessages))
            {
                return;
            }
            // End:0x126
            break;
        // End:0xFFFF
        default:
            // End:0x123
            if(__NFUN_129__(ShowOtherMessages))
            {
                return;
            }
            // End:0x126
            break;
            break;
    }
    BroadcastText(Text, Prefix);
    return;
}

function string GetPlayerInfo(string Name, bool ubi)
{
    local R6PlayerController Player;

    // End:0x97
    foreach __NFUN_304__(Class'R6Engine.R6PlayerController', Player)
    {
        // End:0x28
        if(Player.__NFUN_303__('IRCSpectator'))
        {
            continue;            
        }
        // End:0x96
        if(__NFUN_132__(__NFUN_130__(__NFUN_122__(Player.PlayerReplicationInfo.PlayerName, Name), __NFUN_129__(ubi)), __NFUN_130__(__NFUN_122__(Player.PlayerReplicationInfo.m_szUbiUserID, Name), ubi)))
        {            
            return BuildPlayerInfo(Player, PlayerInfoFormatString);
        }        
    }    
    return __NFUN_168__(__NFUN_168__("Player", Name), "Not Found");
    return;
}

function BroadcastText(string Text, optional string Prefix)
{
    // End:0x0E
    if(__NFUN_122__(Text, ""))
    {
        return;
    }
    // End:0x25
    if(__NFUN_122__(Prefix, ""))
    {
        Prefix = DefaultPrefix;
    }
    SendMessage(Channel, __NFUN_112__(Prefix, Text));
    return;
}

function BroadcastScores()
{
    local R6PlayerController Player;
    local PlayerReplicationInfo Info;
    local R6GameInfo GameInfo;
    local R6GameReplicationInfo GameReplicationInfo;
    local string temp;

    GameInfo = R6GameInfo(Level.Game);
    GameReplicationInfo = R6GameReplicationInfo(GameInfo.GameReplicationInfo);
    // End:0x1E4
    if(Level.IsGameTypeTeamAdversarial(Level.Game.m_szCurrGameType))
    {
        BroadcastText(BuildGameInfo(TeamGameFormatString));
        // End:0xD9
        foreach __NFUN_304__(Class'R6Engine.R6PlayerController', Player)
        {
            // End:0x94
            if(Player.__NFUN_303__('IRCSpectator'))
            {
                continue;                
            }
            Info = Player.PlayerReplicationInfo;
            // End:0xD8
            if(__NFUN_154__(Info.TeamID, 2))
            {
                BroadcastText(BuildPlayerInfo(Player, PlayerTeamScoreFormatString), GreenTeamPrefix);
            }            
        }        
        // End:0x147
        foreach __NFUN_304__(Class'R6Engine.R6PlayerController', Player)
        {
            // End:0x102
            if(Player.__NFUN_303__('IRCSpectator'))
            {
                continue;                
            }
            Info = Player.PlayerReplicationInfo;
            // End:0x146
            if(__NFUN_154__(Info.TeamID, 3))
            {
                BroadcastText(BuildPlayerInfo(Player, PlayerTeamScoreFormatString), RedTeamPrefix);
            }            
        }        
        // End:0x1E0
        foreach __NFUN_304__(Class'R6Engine.R6PlayerController', Player)
        {
            // End:0x170
            if(Player.__NFUN_303__('IRCSpectator'))
            {
                continue;                
            }
            Info = Player.PlayerReplicationInfo;
            // End:0x1DF
            if(__NFUN_130__(__NFUN_130__(__NFUN_155__(Info.TeamID, 2), __NFUN_155__(Info.TeamID, 3)), Player.bIsPlayer))
            {
                BroadcastText(BuildPlayerInfo(Player, PlayerTeamScoreFormatString), OtherTeamPrefix);
            }            
        }                
    }
    else
    {
        BroadcastText(BuildGameInfo(GameFormatString));
        // End:0x24D
        foreach __NFUN_304__(Class'R6Engine.R6PlayerController', Player)
        {
            // End:0x21D
            if(Player.__NFUN_303__('IRCSpectator'))
            {
                continue;                
            }
            Info = Player.PlayerReplicationInfo;
            BroadcastText(BuildPlayerInfo(Player, PlayerScoreFormatString), OtherTeamPrefix);            
        }        
    }
    return;
}

function int CountPlayers(optional bool bot)
{
    local R6PlayerController Player;
    local int Result;

    Result = 0;
    // End:0x3A
    foreach __NFUN_304__(Class'R6Engine.R6PlayerController', Player)
    {
        // End:0x32
        if(Player.__NFUN_303__('IRCSpectator'))
        {
            continue;            
            // End:0x39
            continue;
        }
        __NFUN_165__(Result);        
    }    
    return Result;
    return;
}

function string BuildGameInfo(string Format)
{
    local R6GameInfo Game;
    local R6GameReplicationInfo Info;
    local R6ServerInfo server;
    local string redteamscore, greenteamscore, round, roundspermap, timeperround, timeremaining,
	    timebetweenrounds, timeuntilstart, BombTime, Map, MaxPlayers,
	    players, GameType, numberofterros, neutralizedterros;

    Game = R6GameInfo(Level.Game);
    Info = R6GameReplicationInfo(Game.GameReplicationInfo);
    server = Level.m_ServerSettings;
    redteamscore = __NFUN_112__("", string(Info.m_aTeamScore[1]));
    greenteamscore = __NFUN_112__("", string(Info.m_aTeamScore[0]));
    round = __NFUN_112__("", string(__NFUN_146__(Info.m_iCurrentRound, 1)));
    roundspermap = __NFUN_112__("", string(server.RoundsPerMatch));
    timeperround = __NFUN_112__("", DisplayTime(server.RoundTime));
    timebetweenrounds = __NFUN_112__("", DisplayTime(server.BetweenRoundTime));
    timeuntilstart = DisplayTime(int(__NFUN_175__(Game.m_fRoundStartTime, Level.TimeSeconds)));
    // End:0x151
    if(__NFUN_176__(__NFUN_175__(Game.m_fEndingTime, Level.TimeSeconds), float(0)))
    {
        timeremaining = timeperround;        
    }
    else
    {
        timeremaining = __NFUN_112__("", DisplayTime(int(__NFUN_175__(Game.m_fEndingTime, Level.TimeSeconds))));
    }
    // End:0x1BA
    if(__NFUN_151__(server.BombTime, -1))
    {
        BombTime = __NFUN_112__("", DisplayTime(server.BombTime));        
    }
    else
    {
        BombTime = __NFUN_112__("", string(server.BombTime));
    }
    Map = __NFUN_112__("", Level.Game.__NFUN_547__());
    MaxPlayers = string(Admin.GetMaxPlayers());
    players = __NFUN_112__("", string(CountPlayers(false)));
    GameType = Level.GetGameNameLocalization(Game.m_szCurrGameType);
    numberofterros = __NFUN_112__("", string(server.NbTerro));
    neutralizedterros = __NFUN_112__("", string(Game.GetNbTerroNeutralized()));
    ReplaceText(Format, "#redteamscore#", redteamscore);
    ReplaceText(Format, "#greenteamscore#", greenteamscore);
    ReplaceText(Format, "#round#", round);
    ReplaceText(Format, "#roundspermap#", roundspermap);
    ReplaceText(Format, "#timeperround#", timeperround);
    ReplaceText(Format, "#timeremaining#", timeremaining);
    ReplaceText(Format, "#timebetweenrounds#", timebetweenrounds);
    ReplaceText(Format, "#timeuntilstart#", timeuntilstart);
    ReplaceText(Format, "#bombtime#", BombTime);
    ReplaceText(Format, "#map#", Map);
    ReplaceText(Format, "#maxplayers#", MaxPlayers);
    ReplaceText(Format, "#players#", players);
    ReplaceText(Format, "#gametype#", GameType);
    ReplaceText(Format, "#numberofterros#", numberofterros);
    ReplaceText(Format, "#neutralizedterros#", neutralizedterros);
    return Format;
    return;
}

function string BuildPlayerInfo(R6PlayerController Player, string Format)
{
    local PlayerReplicationInfo Info;
    local string Name, ubi, Kills, Deaths, Ping, Health,
	    roundkills, rounddeaths, Score, Killer, RoundsFired,
	    RoundsHit, RoundsPlayed, roundswon, accuracy, lives,
	    BanId;

    Info = Player.PlayerReplicationInfo;
    Name = Info.PlayerName;
    ubi = Info.m_szUbiUserID;
    Kills = __NFUN_112__("", string(Info.m_iKillCount));
    Deaths = __NFUN_112__("", string(int(Info.Deaths)));
    Ping = __NFUN_112__("", string(Info.Ping));
    Health = __NFUN_112__("", string(Info.m_iHealth));
    roundkills = __NFUN_112__("", string(Info.m_iKillCountForEvent));
    rounddeaths = __NFUN_112__("", string(Info.m_iDeathCountForEvent));
    Score = __NFUN_112__("", string(int(Info.Score)));
    Killer = __NFUN_112__("", Info.m_szKillersName);
    RoundsFired = __NFUN_112__("", string(Info.m_iRoundFired));
    RoundsHit = __NFUN_112__("", string(Info.m_iRoundsHit));
    RoundsPlayed = __NFUN_112__("", string(Info.m_iRoundsPlayed));
    roundswon = __NFUN_112__("", string(Info.m_iRoundsWon));
    accuracy = __NFUN_112__("", string(__NFUN_145__(__NFUN_144__(Info.m_iRoundsHit, 100), Info.m_iRoundFired)));
    lives = __NFUN_112__("", string(Info.NumLives));
    BanId = Player.m_szGlobalID;
    ReplaceText(Format, "#name#", Name);
    ReplaceText(Format, "#ubi#", ubi);
    ReplaceText(Format, "#kills#", Kills);
    ReplaceText(Format, "#deaths#", Deaths);
    ReplaceText(Format, "#ping#", Ping);
    ReplaceText(Format, "#health#", Health);
    ReplaceText(Format, "#roundkills#", roundkills);
    ReplaceText(Format, "#rounddeaths#", rounddeaths);
    ReplaceText(Format, "#score#", Score);
    ReplaceText(Format, "#killer#", Killer);
    ReplaceText(Format, "#roundsfired#", RoundsFired);
    ReplaceText(Format, "#roundshit#", RoundsHit);
    ReplaceText(Format, "#roundsplayed#", RoundsPlayed);
    ReplaceText(Format, "#roundswon#", roundswon);
    ReplaceText(Format, "#accuracy#", accuracy);
    ReplaceText(Format, "#lives#", lives);
    ReplaceText(Format, "#banid#", BanId);
    return Format;
    return;
}

state Reconnecting
{Open:

    ProcessUser = 0;
    bLogOn = false;
    __NFUN_231__(__NFUN_168__(__NFUN_168__("Reconnecting in", string(ReconnectTime)), "seconds"));
    __NFUN_256__(ReconnectTime);
    // End:0x52
    if(bResetReconnectTime)
    {
        ReconnectTime = default.ReconnectTime;
    }
    ConnectToServer(server);
    stop;        
}

defaultproperties
{
    Port=6667
    ShowDeathMessages=true
    ShowSayMessages=true
    ShowMiscMessages=true
    ShowLocalMessages=true
    ShowServerMessages=true
    ShowOtherMessages=true
    ShowScoresAtRoundEnd=true
    bDelayAtStartup=true
    ServerMessageDelay=120.0000000
    ReconnectTime=60.0000000
    TimeKeeperClass=Class'IRCTimeKeeper'
    BotName="IRC Bot"
    Nickname="rvsbot"
    AlternateNickName="ravenbot"
    server="irc.progameplayer.com"
    OnJoinMessage="2RvS Match bot by Neo4E656F"
    Channel="#rvsbots"
    JoinNotice="I am a Raven Shield IRC match bot if you find me annoying please use /ignore, thankyou"
    MessagePrefix="2"
    DeathPrefix="4"
    MiscPrefix="3"
    LocalPrefix="3"
    ServerPrefix="3"
    GreenTeamPrefix="0,3"
    RedTeamPrefix="0,4"
    OtherTeamPrefix="0,2"
    MapChangeQuitMessage="Map change, brb"
    SpamMessage="Visit http://www.koalaclaw.com"
    UserID="matchbot"
    PlayerTeamScoreFormatString="Name: #name# Ubi: #ubi# Kills: #kills# Deaths: #deaths# Ping: #ping#"
    PlayerScoreFormatString="Name: #name# Ubi: #ubi# Kills: #kills# Deaths: #deaths# Ping: #ping#"
    RejoinMessage="I am a raven shield match bot, I will continue to auto-rejoin until you ban me"
    TeamGameFormatString="0,3Green Team Score: #greenteamscore# 0,4Red Team Score: #redteamscore# 0,14Map: #map# Round: #round#/#roundspermap# Round Time: #timeremaining#/#timeperround# Game Type: #gametype# Players: #players#/#maxplayers#"
    GameFormatString="0,12Map: #map# Round: #round#/#roundspermap# Round Time: #timeremaining#/#timeperround# Game Type: #gametype# Players: #players#/#maxplayers#"
    PlayerInfoFormatString="Name: #name# Ubi: #ubi# Banid: #banid# Kills: #kills# Deaths: #deaths# Ping: #ping#"
    GreenTeamDeathPrefix="4"
    RedTeamDeathPrefix="3"
    Version="Raven Shield IRC Match Bot v2.3 by Neo4E656F neo@squadgames.com"
    bUseN4LineMode=true
}