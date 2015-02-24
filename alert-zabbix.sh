#!/bin/bash

# Slack APIのURL
url='https://hooks.slack.com/services/hogehoge'
# Slackに表示するbotの名前
username='Zabbix'
# 送信先チャネル
to="$1"
status="$2"
subject="$3"
severity="{\"title\": \"severity\", \"value\": \"$4\", \"short\": true}"
value="$5"
event="{\"title\": \"event ID\", \"value\": \"$6\", \"short\": true}"

# ステータスに応じてアイコンを変えられる
if [ "$status" == 'OK' ]; then
        emoji=':fire:'
        color='good'
elif [ "$status" == 'PROBLEM' ]; then
        emoji=':fire:'
        color='danger'
else
        # emoji=':ghost:'
        emoji=':fire:'
        color='danger'
fi

# JSON生成
payload="payload={\"channel\": \"${to}\", \"username\": \"${username}\", \"pretext\": \"$value\", \"text\": \"${subject}\", \"fields\": [${severity}, ${event}], \"color\": \"${color}\", \"icon_emoji\": \"${emoji}\"}"
# Slack投稿
curl -X POST --data-urlencode "${payload}" $url
