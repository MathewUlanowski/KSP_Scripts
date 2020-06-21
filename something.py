with open("shipinfo.json", "r") as rawFile:
    rawJSON = json.load(RawFile)

translatedVar = {}

for i in range(1,len(rawJSON["entries"])+1):
    if i%2 !=0:
        Key = rawJSON["entries"][i-1]
    else:
        translatedVar[Key] = rawJSON["entries"][i-1]
with open('Interpreter.json', 'w') as outfile:
    json.dump(translatedVar, outfile)