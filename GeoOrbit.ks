DECLARE PARAMETER HourOffset.

RUN AutoOrbit(2863.33406).

RUN GeoPeriodOffset(HourOffset).

if HourOffset = 1 {
    print("you have achieved a Keostationary orbit with an offset of "+HourOffset+" hour").
}
else {
    print("you have achieved a Keostationary orbit with and offset of "+HourOffset+" hours").
}