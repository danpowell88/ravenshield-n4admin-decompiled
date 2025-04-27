class N4ScoreManager extends N4AbstractScoreManager
    config
    editinlinenew
    hidecategories(Object);

var config bool bCTEAlwaysUpdateAll;

event BombExploded(Pawn Pawn, R6IOBomb bomb)
{
    super(N4MissionHook).BombExploded(Pawn, bomb);
    __NFUN_165__(BombsDetonated);
    return;
}

event DoorDestroyed(Pawn Pawn, R6IORotatingDoor Door)
{
    super(N4MissionHook).DoorDestroyed(Pawn, Door);
    AddDoorDestroyedForPawn(Pawn);
    __NFUN_165__(DoorsDestroyed);
    return;
}

event BombArmed(Pawn Pawn, R6IOBomb bomb)
{
    super(N4MissionHook).BombArmed(Pawn, bomb);
    ChangeDeviceStatisticsForPawn(Pawn, true, true);
    return;
}

event BombDisarmed(Pawn Pawn, R6IOBomb bomb)
{
    super(N4MissionHook).BombDisarmed(Pawn, bomb);
    ChangeDeviceStatisticsForPawn(Pawn, false, true);
    return;
}

event DeviceActivated(Pawn Pawn, R6IOObject IOObject)
{
    super(N4MissionHook).DeviceActivated(Pawn, IOObject);
    ChangeDeviceStatisticsForPawn(Pawn, true);
    return;
}

event DeviceDisactived(Pawn Pawn, R6IOObject IOObject)
{
    super(N4MissionHook).DeviceDisactived(Pawn, IOObject);
    ChangeDeviceStatisticsForPawn(Pawn);
    return;
}

event DeviceDestroyed(Pawn Pawn, R6IOObject IOObject)
{
    super(N4MissionHook).DeviceDestroyed(Pawn, IOObject);
    __NFUN_165__(DevicesDestroyed);
    return;
}

event RainbowKill(R6Rainbow Killer, N4MissionHook.EKillType KillType)
{
    super(N4MissionHook).RainbowKill(Killer, KillType);
    ChangeRainbowKills(Killer, KillType);
    return;
}

event RainbowDeath(R6Rainbow corpse, N4MissionHook.EKillType KillType)
{
    super(N4MissionHook).RainbowDeath(corpse, KillType);
    ChangeRainbowKills(corpse, KillType, true);
    return;
}

event TerroristKill(R6Terrorist Killer, N4MissionHook.EKillType KillType)
{
    super(N4MissionHook).TerroristKill(Killer, KillType);
    AddKillTo(TerroristKills, KillType);
    return;
}

event TerroristDeath(R6Terrorist corpse, N4MissionHook.EKillType KillType)
{
    super(N4MissionHook).TerroristDeath(corpse, KillType);
    AddKillTo(TerroristDeaths, KillType);
    return;
}

event RainbowSecured(R6Rainbow Rainbow)
{
    super(N4MissionHook).RainbowSecured(Rainbow);
    // End:0x40
    if(__NFUN_119__(Rainbow, none))
    {
        // End:0x35
        if(__NFUN_130__(bUpdatedAll, __NFUN_129__(bCTEAlwaysUpdateAll)))
        {
            QuickUpdateAll();            
        }
        else
        {
            UpdateOrCreateAllDataUsing(Rainbow);
        }
    }
    return;
}
