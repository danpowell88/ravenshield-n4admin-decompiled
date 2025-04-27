class N4ExtraPlayers extends N4Mutator
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

var() config int ExtraPlayers;

function BeginPlay()
{
    super(Actor).BeginPlay();
    // End:0x38
    if(__NFUN_119__(Level.Game, none))
    {
        __NFUN_161__(Level.Game.MaxPlayers, ExtraPlayers);
    }
    return;
}
