class N4MissionHookMutator extends N4Mutator
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var bool bMissionManagerSpawned;
var R6MissionObjectiveMgr LastMissionManager;
var array<R6MissionObjectiveBase> ExtraObjectiveSet;

function AddNewObjective(R6MissionObjectiveBase Objective, optional bool bDoNotUpdateCurrentMissionManager)
{
    // End:0x0D
    if(__NFUN_114__(Objective, none))
    {
        return;
    }
    ExtraObjectiveSet[ExtraObjectiveSet.Length] = Objective;
    // End:0x5B
    if(__NFUN_130__(__NFUN_119__(LastMissionManager, none), __NFUN_129__(bDoNotUpdateCurrentMissionManager)))
    {
        LastMissionManager.m_aMissionObjectives[LastMissionManager.m_aMissionObjectives.Length] = Objective;
    }
    return;
}

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    __NFUN_117__('Tick');
    return;
}

function CheckForAndUpdateNewMissionManager()
{
    local R6MissionObjectiveMgr newMgr;
    local R6AbstractGameInfo R6Game;
    local int i;

    R6Game = R6AbstractGameInfo(Level.Game);
    // End:0xF5
    if(__NFUN_119__(R6Game, none))
    {
        newMgr = R6Game.m_missionMgr;
        // End:0xEA
        if(__NFUN_130__(__NFUN_119__(newMgr, none), __NFUN_119__(newMgr, LastMissionManager)))
        {
            i = 0;
            J0x5B:

            // End:0xEA [Loop If]
            if(__NFUN_150__(i, ExtraObjectiveSet.Length))
            {
                // End:0xE0
                if(__NFUN_119__(ExtraObjectiveSet[i], none))
                {
                    ExtraObjectiveSet[i].Reset();
                    // End:0xC6
                    if(__NFUN_119__(newMgr, none))
                    {
                        newMgr.m_aMissionObjectives[newMgr.m_aMissionObjectives.Length] = ExtraObjectiveSet[i];
                    }
                    ExtraObjectiveSet[i].SetMObjMgr(newMgr);
                }
                __NFUN_165__(i);
                // [Loop Continue]
                goto J0x5B;
            }
        }
        LastMissionManager = newMgr;
    }
    return;
}

function Tick(float t)
{
    super(Actor).Tick(t);
    CheckForAndUpdateNewMissionManager();
    return;
}

defaultproperties
{
    RemoteRole=0
    bAlwaysTick=true
    bAlwaysRelevant=true
}