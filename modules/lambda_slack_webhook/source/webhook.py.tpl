#!/usr/bin/python3.8
import urllib3
import json

http = urllib3.PoolManager()

def parse_message(json_message):
    return json.loads(json_message)

def lambda_handler(event, context):
    url = "${webhook_url}"

    message = parse_message(event['Records'][0]['Sns']['Message'])
    msg = {
        "channel": "${notifications_channel_name}",
        "username": "Cloudwatch Alarms",
        "text": message["AlarmDescription"],
        "icon_emoji": ":bell:"
    }

    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST', url, body=encoded_msg)
    print({
        "message": event['Records'][0]['Sns']['Message'],
        "status_code": resp.status,
        "response": resp.data
    })
