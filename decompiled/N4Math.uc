class N4Math extends Object;

static function int N4IntPower(int Base, int power)
{
    // End:0x1A
    if(__NFUN_132__(__NFUN_154__(power, 0), __NFUN_154__(Base, 1)))
    {
        return 1;
    }
    // End:0x2F
    if(__NFUN_154__(Base, 2))
    {
        return __NFUN_148__(1, power);
    }
    // End:0x4A
    if(__NFUN_132__(__NFUN_151__(power, 31), __NFUN_154__(Base, 0)))
    {
        return 0;
    }
    // End:0x78
    if(__NFUN_150__(power, 0))
    {
        return __NFUN_145__(1, __NFUN_144__(Base, N4IntPower(Base, __NFUN_147__(__NFUN_143__(power), 1))));        
    }
    else
    {
        return __NFUN_144__(Base, N4IntPower(Base, __NFUN_147__(power, 1)));
    }
    return;
}

static function float N4FloatPower(float Base, int power)
{
    // End:0x20
    if(__NFUN_132__(__NFUN_154__(power, 0), __NFUN_180__(Base, float(1))))
    {
        return 1.0000000;
    }
    // End:0x3F
    if(__NFUN_180__(Base, float(2)))
    {
        return float(__NFUN_148__(int(1.0000000), power));
    }
    // End:0x60
    if(__NFUN_132__(__NFUN_151__(power, 31), __NFUN_180__(Base, float(0))))
    {
        return 0.0000000;
    }
    // End:0x92
    if(__NFUN_150__(power, 0))
    {
        return __NFUN_172__(1.0000000, __NFUN_171__(Base, N4FloatPower(Base, __NFUN_147__(__NFUN_143__(power), 1))));        
    }
    else
    {
        return __NFUN_171__(Base, N4FloatPower(Base, __NFUN_147__(power, 1)));
    }
    return;
}

static function int RoundUp(float f)
{
    local int Result;

    Result = int(f);
    // End:0x2A
    if(__NFUN_177__(__NFUN_175__(f, float(Result)), float(0)))
    {
        __NFUN_165__(Result);
    }
    return Result;
    return;
}
