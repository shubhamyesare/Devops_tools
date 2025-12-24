System Resource Monitoring Script (Bash)
Overview

This Bash script monitors CPU, RAM, and Disk usage of a Linux system and sends email alerts when usage exceeds defined thresholds.
Email notifications are sent using Gmail SMTP via curl.

Features

Monitors CPU usage

Monitors RAM usage

Monitors Disk usage (/ partition)

Sends email alerts when thresholds are crossed

Simple and lightweight Bash implementation

Prerequisites

Linux system

bash shell

curl installed

Gmail account with App Password enabled

Configuration

Update the following variables in the script:

CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=80

EMAIL_ID="your_email@gmail.com"
APP_PASSWORD="your_gmail_app_password"


⚠️ Note:
Do not use your normal Gmail password. Generate an App Password from Google Account → Security → App passwords.

How It Works

CPU Usage

Uses top to calculate CPU usage

RAM Usage

Uses free to calculate memory usage percentage

Disk Usage

Uses df to check root (/) partition usage

If usage exceeds the threshold, an email alert is triggered.

Email Function

The script sends email using this function:

send_email() {
    SUBJECT="$1"
    BODY="$2"
    curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
      --mail-from "$EMAIL_ID" \
      --mail-rcpt "$EMAIL_ID" \
      --user "$EMAIL_ID:$APP_PASSWORD" \
      -T <(echo -e "From: $EMAIL_ID\nTo: $EMAIL_ID\nSubject: $SUBJECT\n\n$BODY")
}

Usage

Make the script executable:

chmod +x system_monitor.sh


Run the script:

./system_monitor.sh

Sample Alert Email
Subject: CPU ALERT

CPU usage is 85% at Mon Dec 23 17:30:10 IST 2025

Automation (Optional)

You can schedule this script using cron:

crontab -e


Run every 5 minutes:

*/5 * * * * /path/to/system_monitor.sh

Security Best Practices

Do not hardcode credentials in production

Use environment variables for email and app password

Restrict file permissions:

chmod 700 system_monitor.sh

Author

Shubham Yesare
📧 shubhamyesare98@gmail.com