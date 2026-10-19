#Generamos data cruda (obtenida de AI)

import csv

data = [
    ["  Jhosep Cordova ", "jcordova@enterprise.com", "+51 987654321", "1500.504", "COMPLETED", "2026-10-12 10:15:00"],
    ["Carlos Mendoza", "CMENDOZA@GMAIL.COM  ", "987-111-222", "45.0", "completed", "2026-10-12 11:00:20"],
    ["Lucia Thorne", "lthorne@outlook.com", "+51 999 888 777", "320.128", "FAILED", "2026-10-12 11:45:00"],
    ["  Valeria Ramos ", "vramos@fintech.pe", "955444333", "890.00", "COMPLETED", "2026-10-13 09:10:00"],
    ["Carlos Mendoza", "cmendoza@gmail.com", "987111222", "12.50", "COMPLETED", "2026-10-13 14:20:00"],
]

with open("raw_feed.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["client_name", "email", "phone", "amount", "status", "tx_timestamp"])
    writer.writerows(data)

print("raw_feed.csv generado con exito.")