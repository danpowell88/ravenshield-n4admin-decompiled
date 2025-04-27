class N4URLPostDataManager extends Object
    config
    perobjectconfig;

var config int Port;
var config array<string> data1;
var config array<string> data2;
var config array<string> data3;
var array<string> dummy;
var config string DoNotEdit;
var config string Host;
var config string ident;
var config string URL;

function int Initialize(string H, int P, string U, string i)
{
    local int il;

    LoadDataConfig();
    DoNotEdit = "Do not edit anything in this part of the ini file";
    // End:0x87
    if(__NFUN_132__(__NFUN_132__(__NFUN_132__(__NFUN_123__(H, Host), __NFUN_155__(P, Port)), __NFUN_123__(i, ident)), __NFUN_123__(U, URL)))
    {
        Clear();
    }
    Host = H;
    Port = P;
    ident = i;
    URL = U;
    il = CalcLength();
    __NFUN_536__();
    return il;
    return;
}

function LoadDataConfig()
{
    return;
}

function SaveDataConfig()
{
    __NFUN_536__();
    return;
}

function int CalcLength()
{
    local int i;

    // End:0x63
    if(__NFUN_155__(data3.Length, 0))
    {
        __NFUN_165__(i);
        // End:0x4A
        if(__NFUN_155__(data2.Length, 0))
        {
            __NFUN_165__(i);
            // End:0x3C
            if(__NFUN_155__(data1.Length, 0))
            {
                __NFUN_165__(i);                
            }
            else
            {
                data1 = dummy;
            }            
        }
        else
        {
            data2 = dummy;
            data1 = dummy;
        }        
    }
    else
    {
        Clear();
    }
    return i;
    return;
}

function Clear()
{
    data1 = dummy;
    data2 = dummy;
    data3 = dummy;
    return;
}

function Push(array<string> data)
{
    EncodeArray(data);
    data1 = data2;
    data2 = data3;
    data3 = data;
    SaveDataConfig();
    return;
}

function array<string> Pop()
{
    local array<string> Result;

    Result = data3;
    data3 = data2;
    data2 = data1;
    data1 = dummy;
    SaveDataConfig();
    DecodeArray(Result);
    return Result;
    return;
}

function string GetLineBreak()
{
    return __NFUN_112__(__NFUN_236__(13), __NFUN_236__(10));
    return;
}

function string GetESC()
{
    return __NFUN_236__(27);
    return;
}

static function ReplaceTextInArray(out array<string> data, string Replace, string With)
{
    local int i;
    local string temp;

    i = 0;
    J0x07:

    // End:0x58 [Loop If]
    if(__NFUN_150__(i, data.Length))
    {
        temp = data[i];
        ReplaceText(temp, Replace, With);
        data[i] = temp;
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function DecodeArray(out array<string> data)
{
    ReplaceTextInArray(data, GetESC(), GetLineBreak());
    return;
}

function EncodeArray(out array<string> data)
{
    ReplaceTextInArray(data, GetESC(), "|");
    ReplaceTextInArray(data, GetLineBreak(), GetESC());
    return;
}

static function ReplaceText(out string Text, string Replace, string With)
{
    local int i;
    local string Input;

    Input = Text;
    Text = "";
    i = __NFUN_126__(Input, Replace);
    J0x25:

    // End:0x84 [Loop If]
    if(__NFUN_155__(i, -1))
    {
        Text = __NFUN_112__(__NFUN_112__(Text, __NFUN_128__(Input, i)), With);
        Input = __NFUN_127__(Input, __NFUN_146__(i, __NFUN_125__(Replace)));
        i = __NFUN_126__(Input, Replace);
        // [Loop Continue]
        goto J0x25;
    }
    Text = __NFUN_112__(Text, Input);
    return;
}

defaultproperties
{
    DoNotEdit="Do not edit anything in this part of the ini file"
}