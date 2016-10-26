import slackclient

token = os.getenv("SLACK_TOKEN")

slack = slackclient.SlackClient(token)

if slack.rtm_connect():
    while True:
        event = slack.rtm_read()

        if event:
            event = event.pop()

            if "type" in event and event["type"] == "message":
                message = event

                if message["text"].startswith("<@U2UL1V60N>"):
                    if message["text"].endswith("ping"):
                        slack.rtm_send_message(message["channel"], "pong")
else:
    pass
