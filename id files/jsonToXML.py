import xml.etree.ElementTree as ET
import xml.dom.minidom
import json

Dragon = {}
Illuminati = {}
Templar = {}

filelist = ["IlluminatiMissions.json", "DragonMissions.json", "TemplarMissions.json"]

glob_data = {}
for file in filelist:
    with open(file) as json_file:
        data = json.load(json_file)

        for key in data:
            del data[key]["QuestID"]
            del data[key]["QuestName"]
            del data[key]["Report"]
            glob_data[key] = data[key]["TaskID"]

with open('Factions.json', 'w') as f:
    json.dump(glob_data, f, indent=4)

temp = {}
with open("SharedMissions.json") as json_file:
    data = json.load(json_file)
    for key in data:
        temp[key] = data[key]["TaskID"]

with open('Shared.json', 'w') as f:
    json.dump(temp, f, indent=4)

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