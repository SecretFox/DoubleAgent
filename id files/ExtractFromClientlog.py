import json
import re

data = {}
data2 = {}
install_path = "G:\Secret World Legends\ClientLog.txt"

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
		quest_id = re.search(QuestPattern, line).group(1)
		
		rewards = re.search(rewardPattern, line).group(1)
		optional = re.search(optionalpattern, line).group(1)
		cash = re.search(CashPattern, line)
		if not cash:
			cash = 0
		else:
			cash = cash.group(1)
		
		xp = re.search(XPPattern, line)
		if not xp:
			xp =0
		else:
			xp = xp.group(1)
		
		quest_name = re.search(QuestNamePattern, line).group(1)
		task_id = re.search(TaskPattern, line).group(1)
		report = re.search(ReportPattern, line).group(1)
		if faction not in data2:
			data2[faction]={}
		data2[faction][str(quest_id)] = task_id
		if str(quest_id) not in data:
			data[str(quest_id)] = {
					'name': quest_name,
					'TaskID': task_id,
					'rewards': rewards,
					'optional': optional,
					'Cash': cash,
					'XP': xp,
					faction+'-report': report.replace("&&", "\n")}
		else:
			data[str(quest_id)][faction+'-report'] = report.replace("&&", "\n")
	except Exception as e:
		print(line, e)


with open(install_path, encoding='utf-8') as f:
	content = f.readlines()
	index = 0
	for line in content:
		if "WARNING: Scaleform.DoubleAgent" in line:
			extract_data(line)

with open('Missions.json', 'w',encoding="utf8") as outfile:
	json.dump(data, outfile, indent=4, sort_keys=True, ensure_ascii=False)

for faction in data2:
	with open(faction+'.json', 'w',encoding="utf8") as outfile:
		json.dump(data2[faction], outfile, indent=4, sort_keys=True, ensure_ascii=False)
