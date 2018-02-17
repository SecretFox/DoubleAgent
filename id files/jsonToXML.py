import xml.etree.ElementTree as ET
import json

Dragon = {}
Illuminati = {}
Templar = {}

filelist = ["IlluminatiMissions.json", "DragonMissions.json", "TemplarMissions.json"]

FactionData = {}
for file in filelist:
    with open(file) as json_file:
        jsonData = json.load(json_file)
        for key in jsonData:
            FactionData[key] = jsonData[key]["TaskID"]
with open('Factions.json', 'w') as f:
    json.dump(FactionData, f, indent=4)

SharedData = {}
with open("SharedMissions.json") as json_file:
    data = json.load(json_file)
    for key in data:
        SharedData[key] = data[key]["TaskID"]
with open('Shared.json', 'w') as f:
    json.dump(SharedData, f, indent=4)

with open("Factions.json", "r") as f:
    FactionJson = json.load(f)
    root = ET.Element('root')
    for i in FactionJson:
        ET.SubElement(root, "Q", tID=FactionJson[i], qID=i)
    tree = ET.ElementTree(root)
    tree.write("Faction.xml")

with open("Shared.json", "r") as f:
    FactionJson = json.load(f)
    root = ET.Element('root')
    for i in FactionJson:
        ET.SubElement(root, "Q", tID=FactionJson[i], qID=i)
    tree = ET.ElementTree(root)
    tree.write("Shared.xml")