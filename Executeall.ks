function Executeallnodes{
    if HASNODE = TRUE {
        until HASNODE = FALSE {
            IF HASNODE = TRUE {
                RUN EXECUTENODE.
            }
            LOCK THROTTLE TO 0.
            LOCK STEERING TO PROGRADE.
        }
    }
}
Executeallnodes().
UNLOCK THROTTLE.
UNLOCK STEERING.
print("All nodes have been executed.").