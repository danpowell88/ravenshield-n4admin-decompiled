class N4StringArrayManager extends Object;

var int MaxElementLength;
var array<string> data;

function AddText(string Text)
{
    local int currentLength, txtLength, tempLength;

    // End:0x38
    if(__NFUN_155__(data.Length, 0))
    {
        Text = __NFUN_112__(data[__NFUN_147__(data.Length, 1)], Text);
        data.Length = __NFUN_147__(data.Length, 1);
    }
    txtLength = __NFUN_125__(Text);
    J0x45:

    // End:0xC1 [Loop If]
    if(__NFUN_151__(txtLength, 0))
    {
        // End:0x86
        if(__NFUN_152__(txtLength, MaxElementLength))
        {
            data[data.Length] = Text;
            Text = "";
            txtLength = 0;
            // [Explicit Break]
            goto J0xC1;            
        }
        else
        {
            data[data.Length] = __NFUN_128__(Text, MaxElementLength);
            Text = __NFUN_127__(Text, MaxElementLength);
        }
        txtLength = __NFUN_125__(Text);
        // [Loop Continue]
        goto J0x45;
    }
    J0xC1:

    return;
}

function Reset()
{
    data.Length = 0;
    return;
}

defaultproperties
{
    MaxElementLength=800
}