class IRCIdentd extends TcpLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var() globalconfig int Port;
var() globalconfig float TimeOut;
var() globalconfig string identd;
var string CRLF;
var string CR;
var string lf;

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    CR = __NFUN_236__(13);
    lf = __NFUN_236__(10);
    CRLF = __NFUN_112__(CR, lf);
    // End:0x43
    if(__NFUN_122__(identd, ""))
    {
        identd = "rvs";
    }
    return;
}

function Timer()
{
    // End:0x0F
    if(IsConnected())
    {
        Close();
    }
    __NFUN_279__();
    return;
}

function Start(optional string ident)
{
    __NFUN_231__("Starting identd server");
    // End:0x31
    if(__NFUN_123__(ident, ""))
    {
        identd = ident;
    }
    __NFUN_280__(0.0000000, false);
    // End:0x89
    if(__NFUN_155__(BindPort(Port, false), Port))
    {
        __NFUN_231__(__NFUN_112__("IRCIdentd, Could not bind Identd port to ", string(Port)));        
    }
    else
    {
        Listen();
        __NFUN_280__(TimeOut, false);
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

event ReceivedText(string Text)
{
    ReplaceText(Text, CRLF, "");
    SendLine(__NFUN_112__(__NFUN_112__(Text, " : USERID : UNIX : "), identd));
    __NFUN_280__(0.0000000, false);
    Close();
    __NFUN_279__();
    return;
}

defaultproperties
{
    Port=113
    TimeOut=60.0000000
    identd="rvs"
    ReceiveMode=1
}