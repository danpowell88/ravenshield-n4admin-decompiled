class Messenger extends N4Mutator
    config(N4AdminMessenger)
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

const MAX_MESSAGES = 3;

struct MessageInfo
{
    var() config string LocalizationFile;
    var() config string Message;
    var() config string messageID;
    var() config Sound Sound;
    var() config int Lifetime;
};

var() config bool Messenger;
var() config float WaitTime;
var() config array<MessageInfo> ExtraMessages;
var() config string MessengerText[3];

function BeginPlay()
{
    super(Actor).BeginPlay();
    Tag = 'EndGame';
    return;
}

function Timer()
{
    DisplayMessages();
    return;
}

function DisplayMessages()
{
    local int i;
    local R6AbstractGameInfo GameInfo;

    GameInfo = R6AbstractGameInfo(Level.Game);
    // End:0x33
    if(__NFUN_132__(__NFUN_114__(GameInfo, none), __NFUN_129__(Messenger)))
    {
        return;
    }
    i = 0;
    J0x3A:

    // End:0x80 [Loop If]
    if(__NFUN_150__(i, 3))
    {
        // End:0x76
        if(__NFUN_123__(MessengerText[i], ""))
        {
            GameInfo.BroadcastGameMsg("", MessengerText[i], "");
        }
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x3A;
    }
    i = 0;
    J0x87:

    // End:0x100 [Loop If]
    if(__NFUN_150__(i, ExtraMessages.Length))
    {
        GameInfo.BroadcastGameMsg(ExtraMessages[i].LocalizationFile, ExtraMessages[i].Message, ExtraMessages[i].messageID, ExtraMessages[i].Sound, ExtraMessages[i].Lifetime);
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x87;
    }
    return;
}

event Trigger(Actor Other, Pawn EventInstigator)
{
    super(Actor).Trigger(Other, EventInstigator);
    __NFUN_280__(WaitTime, false);
    return;
}

defaultproperties
{
    Messenger=true
    WaitTime=7.0000000
    MessengerText[0]="This is the default Text"
    MessengerText[1]="Edit your N4AdminMessenger.ini"
    MessengerText[2]="for custom Message"
    RemoteRole=0
    Tag="EndGame"
}