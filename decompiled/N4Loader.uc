class N4Loader extends N4Mutator
    config
    hidecategories(Movement,Collision,Lighting,LightColor,Karma,Force);

struct AdvanceServerActorInfo
{
    var() config string actorClassName;
    var() config name SpawnTag;
    var() config Vector SpawnLocation;
    var() config Rotator SpawnRotation;
    var() config bool bUseLoaderAsOwner;
    var Actor SpawnedActor;
};

var() config array<string> ServerActors;
var() config array<AdvanceServerActorInfo> AdvancedServerActors;
var array<AdvanceServerActorInfo> InternalActorInfoSet;

function InitInternalActorInfoSet()
{
    local int i, j;

    InternalActorInfoSet.Length = __NFUN_146__(ServerActors.Length, AdvancedServerActors.Length);
    i = 0;
    J0x1C:

    // End:0x54 [Loop If]
    if(__NFUN_150__(i, ServerActors.Length))
    {
        InternalActorInfoSet[__NFUN_165__(j)].actorClassName = ServerActors[i];
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x1C;
    }
    i = 0;
    J0x5B:

    // End:0x8E [Loop If]
    if(__NFUN_150__(i, AdvancedServerActors.Length))
    {
        InternalActorInfoSet[__NFUN_165__(j)] = AdvancedServerActors[i];
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x5B;
    }
    return;
}

function SpawnActors()
{
    local int i;

    i = 0;
    J0x07:

    // End:0x32 [Loop If]
    if(__NFUN_150__(i, InternalActorInfoSet.Length))
    {
        N4SpawnActor(InternalActorInfoSet[i]);
        __NFUN_165__(i);
        // [Loop Continue]
        goto J0x07;
    }
    return;
}

function Actor N4SpawnActor(AdvanceServerActorInfo ActorInfo)
{
    local class<Actor> ActorClass;
    local Actor A, tOwner;

    // End:0x14
    if(__NFUN_152__(__NFUN_125__(ActorInfo.actorClassName), 0))
    {
        return none;
    }
    ActorClass = class<Actor>(DynamicLoadObject(ActorInfo.actorClassName, Class'Core.Class'));
    // End:0x7F
    if(__NFUN_114__(ActorClass, none))
    {
        __NFUN_231__(__NFUN_168__(__NFUN_168__(string(self), "Could not find the class for the actor"), ActorInfo.actorClassName));
        return none;        
    }
    else
    {
        // End:0xEF
        if(__NFUN_114__(ActorClass, self.Class))
        {
            __NFUN_231__(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "refusing to spawn an actor of the same class as the loader"), string(ActorClass)), string(self.Class)));
            return none;
        }
    }
    // End:0x104
    if(ActorInfo.bUseLoaderAsOwner)
    {
        tOwner = self;
    }
    A = __NFUN_278__(ActorClass, tOwner, ActorInfo.SpawnTag, ActorInfo.SpawnLocation, ActorInfo.SpawnRotation);
    ActorInfo.SpawnedActor = A;
    // End:0x1A1
    if(__NFUN_114__(A, none))
    {
        __NFUN_231__(__NFUN_168__(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "Failed to spawn actor of class"), string(ActorClass)), "with name entry"), ActorInfo.actorClassName));
        return none;
    }
    __NFUN_231__(__NFUN_168__(__NFUN_168__(__NFUN_168__(__NFUN_168__(string(self), "spawned actor"), string(A)), "with name"), ActorInfo.actorClassName));
    return A;
    return;
}

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    InitInternalActorInfoSet();
    SpawnActors();
    return;
}
