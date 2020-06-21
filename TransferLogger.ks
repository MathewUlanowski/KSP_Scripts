until false {
    CLEARSCREEN.
    set ShipInfo to LEXICON("mass", round(Ship:mass,2), "Alt", round((ship:altitude)/1000,4)+"km", "Name", ship:name).
    ShipInfo:add("apo", round(ship:apoapsis,2)).
    ShipInfo:add("peo", round(ship:periapsis,2)).
    ShipInfo:add("Tpe", round((time:seconds + ETA:periapsis),2)).
    ShipInfo:add("Tap", round((time:seconds + ETA:apoapsis),2)).
    WRITEJSON(ShipInfo, "shipinfo.json").
    print(readjson(shipinfo.json)).
    wait 0.5.
}
