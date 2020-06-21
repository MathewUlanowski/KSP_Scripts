set AllVehicles to LEXICON().

AllVehicles:add("Vehicle1",LEXICON("name", "Vehicle1","mass",Ship:mass)).

print(AllVehicles:Vehicle1:Name).
print(AllVehicles:Vehicle1:mass).
log "print("+char(34)+"Hello"+CHAR(34)+")." to myfirstlog.ks.
run myfirstlog.ks.
deletepath(myfirstlog.ks).
