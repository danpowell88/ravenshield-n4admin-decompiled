class N4ShutdownManager extends Object
    config;

var config bool bShutDownCorrectly;
var bool bDidShutdownProperly;

function bool PowerOn()
{
    bDidShutdownProperly = bShutDownCorrectly;
    bShutDownCorrectly = false;
    SaveShutdownConfig();
    return DidShutdownProperly();
    return;
}

function bool DidShutdownProperly()
{
    return bDidShutdownProperly;
    return;
}

function Shutdown()
{
    bShutDownCorrectly = true;
    SaveShutdownConfig();
    return;
}

function SaveShutdownConfig()
{
    __NFUN_536__();
    return;
}

defaultproperties
{
    bShutDownCorrectly=true
}