import json
import re

results = {}


def extract_data(i, dat):
    global results
    start = dat[i]
    QuestPattern = "QuestID=([0-9]+)"
    TaskPattern = "TaskID=([0-9]+)"
    QuestNamePattern = "QuestName=(.*?) TaskID"
    quest_ID = re.search(QuestPattern, start).group(1)
    quest_Name = re.search(QuestNamePattern, start).group(1)
    task_ID = re.search(TaskPattern, start).group(1)
    ReportPattern = str(task_ID)+" " + "Report=(.*?)\|\|"
    report = re.search(ReportPattern, "".join(dat), re.DOTALL).group(1)
    results[str(quest_ID)] = {
        'QuestID': quest_ID,
        'QuestName': quest_Name,
        'TaskID': task_ID,
        'Report': report
    }


with open("G:\Secret World Legends\ClientLog.txt", encoding='utf-8') as data_file:
    content = data_file.readlines()
    index = 0
    for line in content:
        if "WARNING: Scaleform.DoubleAgent" in line:
            extract_data(index, content)
        index += 1
        print(index)

with open('data.json', 'w') as outfile:
    json.dump(results, outfile, sort_keys=True,indent=4)
