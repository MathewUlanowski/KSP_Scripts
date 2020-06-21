DECLARE PARAMETER endAp.
DECLARE PARAMETER endPe.

set endAp to endAp*1000.
set endPe to endPe*1000.


function apoChange {
    set apoNode to NODE(time:seconds + eta:periapsis, 0,0,0).
    add apoNode.
    if apoNode:obt:apoapsis < endAp + 100{
        until apoNode:obt:apoapsis > endAp + 100{
            clearscreen.
            print("increasing Ap").
            // print("Node DeltaV: "+round(nextnode:burnvector:mag,4)).
            if apoNode:obt:APOAPSIS < endAp * 0.9{
                set apoNode:prograde to apoNode:prograde + 1.
            }
            else {
                if apoNode:OBT:APOAPSIS < endAp * 0.99{
                    set apoNode:prograde to apoNode:prograde + 0.1.
                }
                else {
                    set apoNode:prograde to apoNode:prograde + 0.01.
                }
            }
        }
        print("Node Constructed").
        RETURN.
    }
    else{
        until apoNode:OBT:APOAPSIS < endAp - 100 {
            clearscreen.
            print("decreasing Ap").
            // print("Node DeltaV: "+round(nextnode:burnvector:mag,4)).
            if apoNode:OBT:APOAPSIS > endAp * 1.1{
                set apoNode:prograde to apoNode:prograde - 1.
            }
            else {
                if apoNode:OBT:APOAPSIS > endAp * 1.11 {
                    set apoNode:prograde to apoNode:prograde - 0.1.
                }
                else {
                    set apoNode:prograde to apoNode:prograde - 0.01.
                }
            }
        }
        print("Node Constructed").
    }
}
function periChange {
    set periNode to node(time:seconds + eta:apoapsis, 0,0,0).
    add periNode.
    if periNode:obt:Periapsis < endPe {
        until periNode:obt:periapsis > endPe - 100 {
            clearscreen.
            print("increasing Pe").
            // print("Node DeltaV: "+round(nextnode:burnvector:mag,4)).
            if periNode:obt:periapsis < endPe * 0.9 {
                set periNode:prograde to periNode:prograde+1.
            }
            else {
                if periNode:obt:periapsis < endPe * 0.99 {
                    set periNode:prograde to periNode:prograde+0.1.
                }
                else {
                    Set periNode:prograde to periNode:prograde+0.01.
                }
            }
        }
        print("Node Constructed").
        RETURN.
    }
    else{
        until periNode:obt:periapsis < endPe + 100 {
            clearscreen.
            print("decreasing Pe").
            // print("Node DeltaV: "+round(nextnode:burnvector:mag,4)).
            if periNode:obt:periapsis > endPe * 1.1 {
                set periNode:prograde to periNode:prograde-1.
            }
            else {
                if periNode:obt:periapsis > endPe * 1.11 {
                    set periNode:prograde to periNode:prograde-0.1.
                }
                else {
                    Set periNode:prograde to periNode:prograde-0.01.
                }
            }
        }
        print("Node Constructed").
    }
}



if ship:apoapsis < endAp {
    apoChange().
    RUN ExecuteNode.ks.
    periChange().
    WAIT 1.
    RUN executenode.ks.
}
else {
    periChange().
    RUN executenode.ks.
    apoChange().
    WAIT 1.
    RUN executenode.ks.
}
