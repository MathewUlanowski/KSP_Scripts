PARAMETER DirToImport.

set File to OPEN(DirToImport).

for item in File:list:values {
    print "importing: " + item.
    RUNPATH(DirToImport+"/"+item).
}






