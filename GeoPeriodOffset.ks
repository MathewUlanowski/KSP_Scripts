DECLARE PARAMETER Offsettime.

if HASNODE = FALSE
{
    set Offsettime to Offsettime*3600.

    set roughPeriod to 6*3600.
        
    set FirstNode to NODE(time:seconds + eta:apoapsis, 0,0,0).
    ADD FirstNode.



    until FirstNode:obt:period <= Offsettime+0.001 or FirstNode:obt:periapsis <= 70000 
    {
        CLEARSCREEN.
        if FirstNode:OBT:period >= Offsettime+300
        {
            set FirstNode:prograde to FirstNode:prograde - 0.1.
        }
        else 
        {
            set FirstNode:prograde to FirstNode:prograde - ((FirstNode:obt:period-Offsettime)/300)*1.
        }
        print(Round(FirstNode:obt:period,3)).
    }
    
    if FirstNode:obt:periapsis > 70000 
    {
        RUN ExecuteNode.ks.

        set SecondNode to NODE(TIME:seconds + ETA:apoapsis,0,0,0).
        add SecondNode.

        until SecondNode:obt:period >= roughPeriod - 0.001{
            if SecondNode:obt:period <= roughPeriod-300 
            {
                set SecondNode:prograde to SecondNode:prograde + 0.1.
            } 
            else 
            {
                set SecondNode:prograde to SecondNode:prograde + (((roughPeriod-300)-SecondNode:obt:period)/300)*1.
            }
        }
    }
    else 
    {
        REMOVE NEXTNODE.
        set FirstNode to Node(time:seconds + eta:apoapsis,0,0,0).
        ADD FirstNode.
        set PosBurnPer to roughPeriod+Offsettime.
        until FirstNode:obt:period >= PosBurnPer -0.001
        {
            CLEARSCREEN.
            if FirstNode:obt:period <= PosBurnPer-300 
            {
                set FirstNode:prograde to FirstNode:prograde + 0.1.
            }
            else 
            {
                set FirstNode:prograde to FirstNode:prograde + ((PosBurnPer-FirstNode:OBT:period)/300)*1.
            }
            print((FirstNode:obt:period)).
        }
        RUN ExecuteNode.ks.
        set SecondNode to NOde(TIME:seconds + ETA:periapsis,0,0,0).
        ADD SecondNode.

        until SecondNode:obt:period <= roughPeriod+0.001 {
            CLEARSCREEN.
            if SecondNode:obt:period >= roughPeriod+300{
                set SecondNode:prograde to SecondNode:prograde - 0.1.
            }
            else {
                set SecondNode:prograde to SecondNode:prograde - ((SecondNode:obt:period-roughPeriod)/300)*1.
            }
        }
        RUN ExecuteNode.ks.
    }
}
else 
{
    print("aborting period offset due to existing node conflict please delete existing nodes before proceeding.").
}