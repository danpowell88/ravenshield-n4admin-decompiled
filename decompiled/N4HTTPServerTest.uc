class N4HTTPServerTest extends N4TCPLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var N4XHTMLPage Page;
var N4SquadGamesLogo LOGO;

function BeginPlay()
{
    super(Actor).BeginPlay();
    __NFUN_231__(__NFUN_168__(string(self), "spawned"));
    LOGO = N4SquadGamesLogo(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4XHTML.N4SquadGamesLogo'));
    Page = N4XHTMLPage(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4XHTML.N4XHTMLPage'));
    Page.XHTMLDocument.AddTextToBody("Hello");
    Page.XHTMLDocument.Title.SetContent("WOoo");
    return;
}

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    BeginListening();
    return;
}

protected function BeginListening()
{
    BindPort(1455, true);
    Listen();
    return;
}

defaultproperties
{
    AcceptClass=Class'N4HTTPTestClient'
}