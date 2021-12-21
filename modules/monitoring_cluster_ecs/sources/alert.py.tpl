#!/usr/bin/python3.8
import boto3
import json
import urllib3
import os
import datetime

CLIENT = boto3.client("sns")
http = urllib3.PoolManager()
os.environ["TZ"] = "UTC"

alert_data_object = {
    "alert_name": "",
    "service": "",
    "severity": "",
    "summary": "",
    "status": "",
    "start_time": ""
}


def lambda_handler(json_input, context):
    json_dump = json.dumps(json_input)
    request = json.loads(json_dump)
    print(request)
    for record in request["Records"]:
        alerts_array = parse_alerts_to_array(json.loads(record['Sns']['Message'])['alerts'])
        print(record)

    if alerts_array is not []:
        for alert in alerts_array:
            message, title, icon = create_message(alert)
            send_message_to_slack(message, title, icon)


def parse_alerts_to_array(alerts_data):
    alerts_list = []

    for alert in alerts_data:
        print(len(alert['startsAt']))
        if len(alert['startsAt']) > 21:
            if len(alert['startsAt']) > 24:
              alert['startsAt'] = alert['startsAt'][:-7]
            fmt = "%Y-%m-%dT%H:%M:%S.%f"
        else:
            fmt = "%Y-%m-%dT%H:%M:%SZ"
        print(alert['startsAt'])
        print(fmt)
        current_alert = alert_data_object.copy()
        current_alert["alert_name"] = alert['labels']['alertname']
        current_alert["service"] = alert['labels']['service'] if 'service' in alert['labels'] else 'unknown'
        current_alert["severity"] = alert['labels']['severity'] if 'severity' in alert['labels'] else 'warning'
        current_alert["summary"] = "{} - {}".format(
            alert['annotations']['summary'],
            alert['annotations']['description']
        ) if 'description' in alert['annotations'] else alert['annotations']['summary']
        current_alert["status"] = alert['status']
        current_alert["start_time"] = datetime.datetime.strptime(alert['startsAt'], fmt)

        alerts_list.append(current_alert)
    return alerts_list


def create_message(alert_data):
    message_title = "{} level alert on {}".format(
        alert_data["severity"].capitalize(),
        alert_data["service"]
    )
    icon = ':alerts' if alert_data["severity"] == "critical" else ':warning:'
    message = "A {} level alert has triggered on the ${environment} environment\n\n" \
              "The service {} is impacted as of {}\n\n" \
              "View this alert <https://${alertmanager_fqdn}>\n\n".format(
                alert_data["severity"],
                alert_data["service"],
                "{}".format(alert_data["start_time"].strftime("%Y-%m-%d %H:%M:%S"))
    )
    if alert_data["status"] == "resolved":
        icon = ':white_check_mark:'
        message_title = "Alert {} resolved".format(
            alert_data["alert_name"]
        )
        message = "A {} level alert has been resolved on the ${environment} environment\n\n" \
                  "Resolution as of {}\n\n" \
                  "View this alert <https://${alertmanager_fqdn}>\n\n".format(
                    alert_data["severity"],
                    "{}".format(alert_data["start_time"].strftime("%Y-%m-%d %H:%M:%S"))
        )
    return message, message_title, icon


def send_message_to_slack(message_contents, message_title, icon):
    url = "${webhook_url}"
    msg = {
        "channel": "${channel_name}",
        "username": message_title,
        "text": message_contents,
        "icon_emoji": icon
    }
    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST', url, body=encoded_msg)
    print({
        "message": message_contents,
        "status_code": resp.status,
        "response": resp.data
    })
