#!/bin/bash
#Maintainer shubhamyesare98@gmail.com
#This script will monitoring the CPU, RAM and Storage usage of the system
#!/bin/bash
# Simple CPU, RAM, Disk monitoring with email alert (curl)

# -------- CONFIG --------
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=80

EMAIL_ID="shubhamyesare98@gmail.com"
APP_PASSWORD="your_app_password"
# ------------------------

DATE=$(date)

# -------- EMAIL FUNCTION (AS YOU ASKED) --------
send_email() {
    SUBJECT="$1"
    BODY="$2"
    curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
      --mail-from "$EMAIL_ID" \
      --mail-rcpt "$EMAIL_ID" \
      --user "$EMAIL_ID:$APP_PASSWORD" \
      -T <(echo -e "From: $EMAIL_ID\nTo: $EMAIL_ID\nSubject: $SUBJECT\n\n$BODY")
}

# -------- CPU CHECK --------
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2+$4)}')
if [ "$CPU" -gt "$CPU_THRESHOLD" ]; then
    send_email "CPU ALERT" "CPU usage is ${CPU}% at ${DATE}"
fi

# -------- RAM CHECK --------
RAM=$(free | awk '/Mem/ {print int($3/$2*100)}')
if [ "$RAM" -gt "$RAM_THRESHOLD" ]; then
    send_email "RAM ALERT" "RAM usage is ${RAM}% at ${DATE}"
fi

# -------- DISK CHECK --------
DISK=$(df / | awk 'NR==2 {print int($5)}')
if [ "$DISK" -gt "$DISK_THRESHOLD" ]; then
    send_email "DISK ALERT" "Disk usage is ${DISK}% at ${DATE}"
fi

echo "System monitoring completed at $DATE"
