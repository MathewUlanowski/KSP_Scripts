import json
import os
import time

def SomeFunction():
    if(True):
        somevariable= "this is the scope test"
    return somevariable

while True:
    with open("shipinfo.json", "r") as BringMeIn:
        interpreting = json.load(BringMeIn)

    translated = {}
    
    for i in range(1,len(interpreting["entries"])+1):
        if i%2 != 0:
            newKey = interpreting["entries"][i-1]
        else:
            translated[newKey] = interpreting["entries"][i-1]

    os.system("clear")
    print(SomeFunction())
    # for (key,value) in translated:
    #     print(f"{key}: {value}")
    print("-"*50)
    for Key in translated:
        print(f"|\t{Key}\t|\t {translated[Key]}")
    print("-"*50)
    time.sleep(0.5)
    BringMeIn.close()
