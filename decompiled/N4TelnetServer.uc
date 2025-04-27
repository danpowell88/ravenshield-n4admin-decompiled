class N4TelnetServer extends N4TelnetLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var() config int ListenPort;
var int boundport;
var bool bListenResult;
var N4TelnetClient lastClient;
var config array<string> MOTD;

function BeginPlay()
{
    super(Actor).BeginPlay();
    boundport = BindPort(ListenPort, true);
    bListenResult = Listen();
    // End:0x70
    if(bListenResult)
    {
        N4Log(__NFUN_168__(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "Listening on"), string(boundport)), "Desired port was"), string(ListenPort)));        
    }
    else
    {
        N4Log(__NFUN_168__(__NFUN_168__(string(self), "Listen failed on port"), string(boundport)));
    }
    return;
}

event GainedClient(N4TelnetClient Client)
{
    __NFUN_231__(__NFUN_168__("Gained a client", string(Client)));
    Client.MOTD = MOTD;
    return;
}

event LostClient(N4TelnetClient Client)
{
    __NFUN_231__(__NFUN_168__("Lost a client", string(Client)));
    return;
}

event GainedChild(Actor Other)
{
    local N4TelnetClient Client;

    super(Actor).GainedChild(Other);
    Client = N4TelnetClient(Other);
    // End:0x31
    if(__NFUN_119__(Client, none))
    {
        GainedClient(Client);
    }
    return;
}

event LostChild(Actor Other)
{
    local N4TelnetClient Client;

    super(Actor).LostChild(Other);
    Client = N4TelnetClient(Other);
    // End:0x31
    if(__NFUN_119__(Client, none))
    {
        LostClient(Client);
    }
    return;
}

event Accepted()
{
    super(TcpLink).Accepted();
    N4Log(__NFUN_168__("An error occured, the server tried to become a client.  The accept class is", string(AcceptClass)));
    return;
}

defaultproperties
{
    ListenPort=8827
    MOTD[0]="Welcome to Neo's server"
    MOTD[1]="Enjoy your stay"
    MOTD[2]=""
    MOTD[3]=""
    AcceptClass=Class'N4TelnetClient'
}