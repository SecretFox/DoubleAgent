import json
import re

dragon = {}
lumie = {}
templar = {}
shared = {}


def extract_data(start):
    global dragon, lumie, templar, shared
    FactionPattern = "Faction=([a-zA-Z]+)"
    QuestPattern = "QuestID=([0-9]+)"
    TaskPattern = "TaskID=([0-9]+)"
    QuestNamePattern = "QuestName=(.*?) TaskID"
    ReportPattern = "Report=(.*?)\|\|"
    faction = re.search(FactionPattern, line).group(1)
    quest_ID = re.search(QuestPattern, line).group(1)
    quest_Name = re.search(QuestNamePattern, line).group(1)
    task_ID = re.search(TaskPattern, line).group(1)
    report = re.search(ReportPattern, line).group(1)
    if faction == "Lumie":
        lumie[str(quest_ID)] = {
            'QuestName': quest_Name,
            'TaskID': task_ID,
            'Report': report.replace("&&", "\n")
        }
    elif faction == "Shared":
        shared[str(quest_ID)] = {
            'QuestName': quest_Name,
            'TaskID': task_ID,
            'Report': report.replace("&&", "\n")
        }
    elif faction == "Dragon":
        dragon[str(quest_ID)] = {
            'QuestID': quest_ID,
            'QuestName': quest_Name,
            'TaskID': task_ID,
            'Report': report.replace("&&", "\n")
        }
    elif faction == "Templar":
        templar[str(quest_ID)] = {
            'QuestName': quest_Name,
            'TaskID': task_ID,
            'Report': report.replace("&&", "\n")
        }


with open("G:\Secret World Legends\ClientLog.txt", encoding='utf-8') as data_file:
    content = data_file.readlines()
    index = 0
    for line in content:
        if "WARNING: Scaleform.DoubleAgent" in line:
            extract_data(line)

with open('IlluminatiMissions.json', 'w') as outfile:
    json.dump(lumie, outfile, sort_keys=True, indent=4)
with open('TemplarMissions.json', 'w') as outfile:
    json.dump(templar, outfile, sort_keys=True, indent=4)
with open('DragonMissions.json', 'w') as outfile:
    json.dump(dragon, outfile, sort_keys=True, indent=4)
with open('SharedMissions.json', 'w') as outfile:
    json.dump(shared, outfile, sort_keys=True, indent=4)
