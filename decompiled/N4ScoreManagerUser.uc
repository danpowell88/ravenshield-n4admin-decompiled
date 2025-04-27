class N4ScoreManagerUser extends N4Mutator
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var float LastRoundTime;
var N4AbstractScoreManager ScoreManager;
var N4MissionHookMutator MissionHookMutator;
var R6AbstractGameInfo TheGameInfo;
var class<N4AbstractScoreManager> ScoreManagerClass;
var class<N4MissionHookMutator> MissionHookMutatorClass;

function PreBeginPlay()
{
    super(Actor).PreBeginPlay();
    // End:0x11
    if(bDeleteMe)
    {
        return;
    }
    SetUpScoreManager();
    TheGameInfo = R6AbstractGameInfo(Level.Game);
    return;
}

function int GetDifficulty()
{
    // End:0x1A
    if(__NFUN_119__(TheGameInfo, none))
    {
        return TheGameInfo.m_iDiffLevel;
    }
    return 0;
    return;
}

function ResetOriginalData()
{
    super(Actor).ResetOriginalData();
    LastRoundTime = Level.TimeSeconds;
    // End:0x34
    if(__NFUN_119__(ScoreManager, none))
    {
        ScoreManager.ResetData();
    }
    return;
}

function SetUpScoreManager()
{
    local R6AbstractGameInfo _game;
    local N4URLPost tempPoster;

    // End:0x3C
    foreach __NFUN_313__(Class'N4URLPost', tempPoster)
    {
        // End:0x3B
        if(__NFUN_119__(tempPoster.ScoreManager, none))
        {
            ScoreManager = tempPoster.ScoreManager;            
            return;
        }        
    }    
    MissionHookMutator = __NFUN_278__(MissionHookMutatorClass, self);
    // End:0x86
    if(__NFUN_114__(MissionHookMutator, none))
    {
        __NFUN_231__(__NFUN_168__(string(self), "Could not spawn mission hook mutator"));
        return;
    }
    ScoreManager = new (none) ScoreManagerClass;
    // End:0xC8
    if(__NFUN_114__(ScoreManager, none))
    {
        __NFUN_231__(__NFUN_168__(string(self), "Failed creating score manager"));
        return;
    }
    MissionHookMutator.AddNewObjective(ScoreManager);
    MissionHookMutator.CheckForAndUpdateNewMissionManager();
    return;
}

defaultproperties
{
    ScoreManagerClass=Class'N4ScoreManager'
    MissionHookMutatorClass=Class'N4MissionHookMutator'
}