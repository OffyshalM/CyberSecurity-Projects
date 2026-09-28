import random
import re
from datetime import datetime, timedelta
import json
import pandas as pd
import requests

re_detection_rules = {
    "api_hook": r"(SetWindowsHookEx|CallNextHookEx|UnhookWindowsHookEx)",
    "dll_injection": r"(LoadLibrary|GetProcAddress|VirtualAllocEx|WriteProcessMemory|CreateRemoteThread)",
    "startup_persistence": r"(%APPDATA%|%PROGRAMDATA%|% USERPROFILE%|%WINDIR%)\\.*\\(Startup|Run|RunOnce|Services)",
    "rare_extensions": r"\.(exe|dll|scr|bat|cmd|vbs|js)$",
}


data_pools = {
    "process_names": ["chrome.exe", "explorer.exe", "notepad.exe", "cmd.exe", "powershell.exe", "python.exe"],
    "actions": ["HTTPS outbound Request", "File Write", "Registry Modification", "Process   Creation", "DLL Injection", "API Hooking"],
    "file_paths": [
        "C:\\Windows\\System32\\",
        "C:\\Program Files\\",
        "C:\\Users\\Public\\"
    ]
}
anomaly_pool = {
    "anomalies": ["Unexpected Process Creation", "Suspicious File Write", "Unauthorized Registry Modification", "Unusual Network Activity"]
}


log_mock = []

setBaseTime = datetime.now() - timedelta(minutes=15)


for i in range(100):
    anomaly_chance = random.random()
    if anomaly_chance < 0.3:
        anomaly = random.choice(anomaly_pool["anomalies"])
        log_entry = {
            "timestamp": (setBaseTime + timedelta(minutes=i)).strftime("%Y-%m-%d %H:%M:%S"),
            "device_id": f"device_{random.randint(1, 100)}",
            "process_name": random.choice(data_pools["process_names"]),
            "action": anomaly,
            "file_path": random.choice(data_pools["file_paths"]) + f"malicious_{random.randint(1, 100)}.exe"
        }
    else:
        log_entry = {
            "timestamp": (setBaseTime + timedelta(minutes=i)).strftime("%Y-%m-%d %H:%M:%S"),
            "device_id": f"device_{random.randint(1, 100)}",
            "process_name": random.choice(data_pools["process_names"]),
            "action": random.choice(data_pools["actions"]),
            "file_path": random.choice(data_pools["file_paths"]) + f"normal_{random.randint(1, 100)}.txt"
        }
    log_mock.append(log_entry)


def check_detection(action_text, file_path):
    for pattern_name, pattern in re_detection_rules.items():
        if re.search(pattern, action_text, re.IGNORECASE) or re.search(pattern, file_path, re.IGNORECASE):
            return True, pattern_name
    return False, "Normal"


processedLogs = []
for log_entry in log_mock:
    time_stamp = log_entry["timestamp"]
    is_anomaly, detection_type = check_detection(log_entry["action"], log_entry["file_path"])


    row = log_entry.copy()
    row["anomaly"] = is_anomaly
    row["detection_type"] = detection_type

    processedLogs.append(row)



df = pd.DataFrame(processedLogs)
df = df.sort_values(by='timestamp')

payload_list = []
for index, row in df.iterrows():
    alert_dict = {
        "deviceId": row.get("device_id"),
        "timestamp": row.get("timestamp"),
        "processName": row.get("process_name"),
        "eventType": row.get("detection_type"), 
        "anomalyScore": 0.95 if row.get("anomaly") else 0.1,  
        "severity": "HIGH" if row.get("anomaly") else "LOW",  
        "rawDetail": f"Action: {row.get('action')} | Path: {row.get('file_path')}" 
    }
    payload_list.append(alert_dict)

json_payload = payload_list
print(json.dumps(json_payload, indent=2))

url = "http://localhost:8080/alerts/save"

print("Sending Security Logs to Java backend ...")


try:
    response = requests.post(url, json=json_payload)
    if response.status_code == 200:
        print("Logs sent successfully!")
    else:
        print(f"Failed to send logs. Status code: {response.status_code}, Response: {response.text}")

except Exception as e:
    print(f"An error occured while sending Logs, check your backend server:{e}")        