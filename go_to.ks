run import("0:/Libs/GUImaker").

sas off.
parameter lat is -0.0972148874905006.

parameter lng is -74.576683112989. 

set Dest to latlng(lat, lng).

set Dist to {return round(Dest:distance,1).}.

set finish to false.
when abort then {
    set finish to true.
}

set DestinationInterface to CreateGui("Destination Interface", 175,150).
set latitudeInput to CreateTextField(
    DestinationInterface, {
        local parameter input is 0.
        set lat to input:tonumber().
        set Dest@ to LATLNG(lat,lng).
        return true.
    },
    "-0.0982148874905006"
).
set longitudeInput to CreateTextField(
    DestinationInterface, {
        local parameter input is 0.
        set lng to input:tonumber().
        set Dest@ to LATLNG(lat,lng).
        RETURN true.
    },
    "-74.576683112989"
).
DestinationInterface:show().


set ProVec to vecDraw(v(0,0,0), {return ship:srfprograde:vector*ship:airspeed.},cyan,"prograde",2,true).
// set ProVec:vecupdater to { return ship:prograde:vector * ship:airspeed. }.
set DestVec to vecDraw(v(0,0,0), {return Dest:ALTITUDEPOSITION(Dest:TERRAINHEIGHT+100).}, red, "destination",1,true,0.1,false).
until finish {
    clearscreen.
    print round(Dist()/1000,1) + " km".
    print round(ship:airspeed,1) + " m/s".
    print ship:prograde:roll.
    if Dist() > 1000 { 
        lock steering to heading(Dest:heading, 60).
    } else {
        lock steering to heading(Dest:heading, 90-(30*(Dist()/1000))).
    }
}