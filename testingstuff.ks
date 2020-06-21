PARAMETER specificpart is "ELOrbitalDock".
for part in ship:parts {
if part:name = specificpart {
print part:name.
print part:resources.
print part:allfields.
}
}

