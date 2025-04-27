class N4HTTPBeaconPoster extends N4HTTPPost
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

struct HTTPPostHostInfo
{
    var() config string Host;
    var() config string URL;
    var() config int Port;
    var() config string forceddomain;
};

var() config float UpdatePeriodTime;
var() class<N4TCPDataPoster> DataPosterClass;
var() config array<HTTPPostHostInfo> HTTPServerSet;

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    __NFUN_280__(UpdatePeriodTime, true);
    return;
}

function UDPBeaconEx FindBeacon()
{
    local UDPBeaconEx beacon;

    // End:0x18
    foreach __NFUN_313__(Class'UDPBeaconEx', beacon)
    {        
        return beacon;        
    }    
    return none;
    return;
}

function SendBeaconDataToServerSet()
{
    local UDPBeaconEx beacon;
    local string BeaconText;
    local int i;
    local N4TCPDataPoster poster;
    local int ContentLength;
    local string header, _domain;

    beacon = FindBeacon();
    // End:0xA6
    if(__NFUN_114__(beacon, none))
    {
        N4Log(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "COULD NOT FIND A UDPBeaconEx, this needs to"), "be installed for N4HTTPBeaconPoster to work."), "Please consolut the documentation"));
        return;
    }
    BeaconText = beacon.BuildFullBeaconExtText();
    ContentLength = __NFUN_125__(BeaconText);
    // End:0xF4
    if(__NFUN_152__(ContentLength, 0))
    {
        N4Log(__NFUN_168__(string(self), "No content to send"));
        return;
    }
    i = 0;
    J0xFB:

    // End:0x24F [Loop If]
    if(__NFUN_150__(i, HTTPServerSet.Length))
    {
        poster = __NFUN_278__(DataPosterClass, self);
        // End:0x170
        if(__NFUN_114__(poster, none))
        {
            __NFUN_231__(__NFUN_168__(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "Could not spawn a poster of class"), string(DataPosterClass)), "position"), string(i)));
            // [Explicit Continue]
            goto J0x245;
        }
        // End:0x1A0
        if(__NFUN_123__(HTTPServerSet[i].forceddomain, ""))
        {
            _domain = HTTPServerSet[i].forceddomain;            
        }
        else
        {
            _domain = HTTPServerSet[i].Host;
        }
        header = BuildHTTPHeader(ContentLength, HTTPServerSet[i].Host, HTTPServerSet[i].Port, _domain);
        poster.SetData(__NFUN_112__(header, BeaconText));
        poster.SetHostAndPort(HTTPServerSet[i].Host, HTTPServerSet[i].Port);
        poster.SendTheData();
        J0x245:

        __NFUN_165__(i);
        // [Loop Continue]
        goto J0xFB;
    }
    return;
}

function Timer()
{
    super(Actor).Timer();
    SendBeaconDataToServerSet();
    return;
}

defaultproperties
{
    UpdatePeriodTime=30.0000000
    DataPosterClass=Class'N4TCPDataPoster'
}