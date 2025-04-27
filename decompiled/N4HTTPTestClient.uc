class N4HTTPTestClient extends N4BufferedTCPLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var bool bRec;

event ReceivedText(string Text)
{
    local N4HTTPReponse response;
    local N4HTTPPage ThePage;
    local N4HTTPServerTest server;

    server = N4HTTPServerTest(Owner);
    // End:0xE1
    if(__NFUN_130__(__NFUN_129__(bRec), __NFUN_119__(server, none)))
    {
        bRec = true;
        ThePage = server.Page;
        ThePage = server.LOGO;
        response = N4HTTPReponse(Class'N4BaseUtil.N4Object'.static.N4CreateObject(Class'N4XHTML.N4HTTPReponse'));
        response.SetFileName("squadgameslogo.jpg");
        ThePage.RespondTo(none, response);
        response.WriteToLink(self);
        Flush();
        ThePage.WritePageTo(self);
        Flush();
        Close();
    }
    return;
}
