import json
import re

data = {}
data2 = {}

FactionPattern = "Faction=([a-zA-Z]+)"
QuestPattern = "QuestID=([0-9]+)"
TaskPattern = "TaskID=([0-9]+)"
CashPattern = "Cash=([0-9]+)"
XPPattern = "XP=([0-9]+)"
rewardPattern = "rewards=(.*?) optional"
optionalpattern = "optional=(.*?) Cash"
QuestNamePattern = "QuestName=(.*?) TaskID"
ReportPattern = "Report=(.*?)\|\|"
	
def extract_data(line):
	global data
	try:
		faction = re.search(FactionPattern, line).group(1)
		quest_ID = re.search(QuestPattern, line).group(1)
		
		rewards = re.search(rewardPattern, line).group(1)
		optional = re.search(optionalpattern, line).group(1)
		Cash = re.search(CashPattern, line)
		if not Cash:
			Cash =0
		else:
			Cash = Cash.group(1)
		
		XP = re.search(XPPattern, line)
		if not XP:
			XP =0
		else:
			XP = XP.group(1)
		
		quest_Name = re.search(QuestNamePattern, line).group(1)
		task_ID = re.search(TaskPattern, line).group(1)
		report = re.search(ReportPattern, line).group(1)
		if faction not in data2:
			data2[faction]={}
		data2[faction][str(quest_ID)]=task_ID
		if str(quest_ID) not in data:		
			data[str(quest_ID)] = {
					'name': quest_Name,
					'TaskID': task_ID,
					'rewards': rewards,
					'optional': optional,
					'Cash': Cash,
					'XP': XP,
					faction+'-report': report.replace("&&", "\n")}
		else:
			data[str(quest_ID)][faction+'-report'] = report.replace("&&", "\n")
	except Exception as e:
		print(line,e)

with open("G:\Secret World Legends\ClientLog.txt", encoding='utf-8') as f:
    content = f.readlines()
    index = 0
    for line in content:
        if "WARNING: Scaleform.DoubleAgent" in line:
            extract_data(line)

with open('Missions.json', 'w',encoding="utf8") as outfile:
	json.dump(data,outfile,indent=4,sort_keys=True,ensure_ascii=False);

for faction in data2:
	with open(faction+'.json', 'w',encoding="utf8") as outfile:
		json.dump(data2[faction],outfile,indent=4,sort_keys=True,ensure_ascii=False);