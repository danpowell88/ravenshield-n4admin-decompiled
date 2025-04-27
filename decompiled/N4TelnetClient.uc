class N4TelnetClient extends N4TelnetLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var array<string> MOTD;
var string username;
var string Password;

event Tick(float t)
{
    super(Actor).Tick(t);
    return;
}

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    __NFUN_231__("Post begin play");
    return;
}

event N4ReceiveLine(string Line)
{
    __NFUN_231__(__NFUN_112__(__NFUN_112__("Received a line\"", Line), "\""));
    return;
}

event Opened()
{
    super(TcpLink).Opened();
    __NFUN_231__(__NFUN_168__(string(self), "Opened()"));
    return;
}

event Closed()
{
    super(N4TCPLink).Closed();
    __NFUN_231__(__NFUN_168__(string(self), "Closed()"));
    __NFUN_279__();
    return;
}

event Accepted()
{
    super(TcpLink).Accepted();
    __NFUN_231__(__NFUN_168__(string(self), "Accepted()"));
    SendMultipleLinePostData(MOTD);
    BeginAuthorization();
    return;
}

function BeginAuthorization()
{
    __NFUN_113__('AwaitingUsername');
    return;
}

auto state Idle
{    stop;
}

state AwaitingUsername
{
    function BeginState()
    {
        super(Object).BeginState();
        __NFUN_231__(__NFUN_168__(string(self), "Awaiting username"));
        N4SendText("Username: ");
        return;
    }

    event N4ReceiveLine(string Line)
    {
        username = Line;
        __NFUN_113__('AwaitingPassword');
        return;
    }
    stop;
}

state AwaitingPassword
{
    function BeginState()
    {
        super(Object).BeginState();
        __NFUN_231__(__NFUN_168__(string(self), "Awaiting password"));
        N4SendText("Password: ");
        return;
    }

    event N4ReceiveLine(string Line)
    {
        Password = Line;
        N4SendLongText(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_112__("You entered the username:\"", username), "\" and password\""), Password), "\""));
        N4Log(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_112__(__NFUN_168__(string(self), "Client entered the username:\""), username), "\" and password\""), Password), "\""));
        __NFUN_113__('Authorized');
        return;
    }
    stop;
}

state AuthorizationFailed
{
    function BeginState()
    {
        super(Object).BeginState();
        __NFUN_231__("Auth failed");
        N4SendLine("Auth failed");
        return;
    }

    event N4ReceiveLine(string Line)
    {
        return;
    }
    stop;
}

state Authorized
{Begin:

    __NFUN_231__("Client is connected and authorized");
    stop;    
}
