SET BASIC to LEXICON().

// creates a lexicon for TWR that will tell you max twr or current twr 
SET BASIC["TWR"] to LEXICON().

BASIC:TWR:add("MAX", {RETURN SHIP:AVAILABLETHRUST/SHIP:MASS.}).
BASIC:TWR:add("CURRENT", {RETURN THROTTLE*SHIP:AVAILABLETHRUST/SHIP:MASS.}).
BASIC:add("SRFCMAG", {RETURN SQRT((ship:groundspeed^2)+(ship:VERTICALSPEED^2)).}).
BASIC:add("GroundGravV", {RETURN SQRT(ship:body:mu / (ship:body:radius^2)).}).