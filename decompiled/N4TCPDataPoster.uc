class N4TCPDataPoster extends N4TCPLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var private int postPort;
var private bool bSending;
var private name SendingStateName;
var array<string> data;
var private string postHost;

function bool SetData(string strData)
{
    BuildPostArray(strData, data);
    return true;
    return;
}

function bool SetHostAndPort(string postHost, int postPort)
{
    self.postHost = postHost;
    self.postPort = postPort;
    return true;
    return;
}

function bool SendTheData()
{
    __NFUN_113__(SendingStateName);
    return true;
    return;
}

function bool IsSendingData()
{
    return false;
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
    __NFUN_279__();
    return;
}

event Opened()
{
    super(TcpLink).Opened();
    PostTheData();
    return;
}

protected function PostTheData()
{
    // End:0x41
    if(IsConnected())
    {
        // End:0x33
        if(__NFUN_152__(data.Length, 0))
        {
            N4Log(__NFUN_168__(string(self), "NO data to send"));
            return;
        }
        SendMultipleLinePostData(data);        
    }
    else
    {
        N4Log(__NFUN_168__(string(self), "tried  to post data whilst not connected"));
    }
    return;
}

state Sending
{
    function BeginState()
    {
        ConnectToServer(postHost);
        return;
    }

    function bool SetHostAndPort(string postHost, int postPort)
    {
        return false;
        return;
    }

    function bool IsSendingData()
    {
        return true;
        return;
    }

    function bool SendTheData()
    {
        return false;
        return;
    }

    function bool SetData(string strData)
    {
        return false;
        return;
    }
    stop;
}

defaultproperties
{
    SendingStateName="Sending"
}