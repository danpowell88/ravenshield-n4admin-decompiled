class N4HTTPPost extends N4TCPLink
    transient
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var() config string PostOperation;
var() config string HTTPVersion;

function string BuildHTTPHeader(int _dataLength, string _host, int _port, string _domain)
{
    local string header;

    header = __NFUN_168__(__NFUN_168__(PostOperation, _domain), HTTPVersion);
    AddLine(header, __NFUN_168__("Content-length:", string(_dataLength)));
    AddLine(header, __NFUN_112__(__NFUN_112__(__NFUN_168__("Host:", _host), ":"), string(_port)));
    AddLine(header, "Content-type: application/x-www-form-urlencoded");
    AddLine(header);
    AddLine(header);
    AddLine(header);
    return header;
    return;
}

defaultproperties
{
    PostOperation="POST"
    HTTPVersion="HTTP/1.0"
}