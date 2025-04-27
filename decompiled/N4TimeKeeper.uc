class N4TimeKeeper extends Object
    config;

struct TimeInfo
{
    var() config int Year;
    var() config int Month;
    var() config int Day;
    var() config int DayOfWeek;
    var() config int Hour;
    var() config int Minute;
    var() config int Second;
    var() config int Millisecond;
};

var config TimeInfo CurrentTime;

function TimeInfo UpdateCurrentTime(LevelInfo Level)
{
    SetTime(GetTime(Level));
    return CurrentTime;
    return;
}

function SetTime(TimeInfo NewTime)
{
    CurrentTime = NewTime;
    __NFUN_536__();
    return;
}

static function TimeInfo GetTime(LevelInfo Level)
{
    local TimeInfo Result;

    Result.Year = Level.Year;
    Result.Month = Level.Month;
    Result.Day = Level.Day;
    Result.DayOfWeek = Level.DayOfWeek;
    Result.Hour = Level.Hour;
    Result.Minute = Level.Minute;
    Result.Second = Level.Second;
    Result.Millisecond = Level.Millisecond;
    return Result;
    return;
}

function float SecondsElapsedTo(TimeInfo Time)
{
    local TimeInfo dt;
    local float Result;

    dt = Time - CurrentTime;
    Result = float(dt.Second);
    __NFUN_184__(Result, float(__NFUN_145__(dt.Millisecond, 1000)));
    __NFUN_184__(Result, __NFUN_171__(__NFUN_174__(__NFUN_171__(__NFUN_174__(__NFUN_171__(__NFUN_174__(__NFUN_171__(float(dt.Year), 365.2500000), float(dt.Day)), float(24)), float(dt.Hour)), float(60)), float(dt.Minute)), float(60)));
    return Result;
    return;
}

function TimeInfo GetLastTime()
{
    return CurrentTime;
    return;
}

static final operator(20) TimeInfo -(TimeInfo A, TimeInfo B)
{
    local TimeInfo Result;

    Result.Year = __NFUN_147__(A.Year, B.Year);
    Result.Month = __NFUN_147__(A.Month, B.Month);
    Result.Day = __NFUN_147__(A.Day, B.Day);
    Result.DayOfWeek = __NFUN_147__(A.DayOfWeek, B.DayOfWeek);
    Result.Hour = __NFUN_147__(A.Hour, B.Hour);
    Result.Minute = __NFUN_147__(A.Minute, B.Minute);
    Result.Second = __NFUN_147__(A.Second, B.Second);
    Result.Millisecond = __NFUN_147__(A.Millisecond, B.Millisecond);
    return Result;
    return;
}
