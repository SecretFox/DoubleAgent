import xml.etree.ElementTree as ET
import json

Dragon = {}
Illuminati = {}
Templar = {}

filelist = ["illuminati.json", "dragon.json", "templar.json"]

FactionData = {}
for file in filelist:
    with open(file) as json_file:
        jsonData = json.load(json_file)
        for key in jsonData:
            FactionData[key] = jsonData[key]

SharedData = {}
with open("all.json") as json_file:
    data = json.load(json_file)
    for key in data:
        SharedData[key] = data[key]

root = ET.Element('root')
for i in FactionData:
	ET.SubElement(root, "Q", tID=FactionData[i], qID=i)
tree = ET.ElementTree(root)
tree.write("Faction.xml")

root = ET.Element('root')
for i in SharedData:
	ET.SubElement(root, "Q", tID=SharedData[i], qID=i)
tree = ET.ElementTree(root)
tree.write("Shared.xml")