class FloodProtection extends ReplicationInfo
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var() config int MaxQueueSize;
var() config float MessageDelay;
var TcpLink link;
var MessageNode Head;

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    __NFUN_280__(MessageDelay, true);
    SetLink(TcpLink(Owner));
    return;
}

function ClearQueue()
{
    Head = none;
    return;
}

function SetLink(TcpLink L)
{
    link = L;
    return;
}

function AddNext(string Text)
{
    local MessageNode Node, Tail;
    local int i;

    Node = new (none) Class'MessageNode';
    // End:0x1C
    if(__NFUN_114__(Node, none))
    {
        return;
    }
    Node.Text = Text;
    // End:0xB6
    if(__NFUN_119__(Head, none))
    {
        Tail = Head;
        i = 0;
        J0x4D:

        // End:0x90 [Loop If]
        if(__NFUN_130__(__NFUN_119__(Tail.Next, none), __NFUN_150__(i, MaxQueueSize)))
        {
            Tail = Tail.Next;
            __NFUN_165__(i);
            // [Loop Continue]
            goto J0x4D;
        }
        // End:0xB3
        if(__NFUN_150__(i, MaxQueueSize))
        {
            Tail.Next = Node;
        }        
    }
    else
    {
        Head = Node;
    }
    return;
}

function Timer()
{
    local MessageNode old;

    // End:0x5D
    if(__NFUN_114__(link, none))
    {
        // End:0x5A
        if(__NFUN_119__(Head, none))
        {
            old = Head;
            J0x21:

            // End:0x53 [Loop If]
            if(__NFUN_119__(old, none))
            {
                old.Next = none;
                old = old.Next;
                // [Loop Continue]
                goto J0x21;
            }
            Head = none;
        }        
    }
    else
    {
        // End:0xA4
        if(__NFUN_119__(Head, none))
        {
            old = Head;
            Head = Head.Next;
            link.SendText(old.Text);
        }
    }
    return;
}

defaultproperties
{
    MaxQueueSize=40
    MessageDelay=2.0000000
}