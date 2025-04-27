class N4TestMissionManager extends R6MissionObjectiveMgr;

function PawnKilled(Pawn killedPawn)
{
    super.PawnKilled(killedPawn);
    __NFUN_231__(__NFUN_168__("pawn was killed", string(killedPawn)));
    return;
}
