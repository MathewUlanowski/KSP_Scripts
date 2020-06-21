set MyLex to LEX().

set MyLex["someKey"] to "a value for the key".
set MyLex["anotherKey"] to "another value of anotherKey".
set MyLex["more crap"] to "even more crappy values".

print MyLex:dump.