# status.confuzer.cloud

This is configured to use matrix for notifications, but that can be changed to other services as per the gatus docs.

Assuming you already have a matrix user account that you will recieve the notifications on, create a bot account, then create a room with your user account, and invite the bot account to it.

Create `.env.prod` with the following contents (replacing the x's with the actual data):

```bash
KUBECONFIG=/path/to/kubeconfig.yaml
MATRIX_HOMESERVER=https://matrix.org
MATRIX_ROOM_ID=!xxxxxxxxxxxxxxxxxx:matrix.org
MATRIX_ACCESS_TOKEN=mat_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Find the MATRIX_ROOM_ID pressing the room's share button.

Find the MATRIX_ACCESS_TOKEN by running the following:

```bash
curl -XPOST https://matrix.org/_matrix/client/v3/login \
  -H 'Content-Type: application/json' \
  -d '{
    "type":"m.login.password",
    "identifier":{
      "type":"m.id.user",
      "user":"BOT_USERNAME"
    },
    "password":"BOT_PASSWORD"
  }'
```

Make sure to properly escape any " and \ chars in your password.

Note: the [gatus README](https://github.com/TwiN/gatus#configuring-matrix-alerts) is a bit incorrect on how to [get the access token](https://webapps.stackexchange.com/q/131056) because it gets one that is temporary. It also has an alternative method to get the room id, but the share button is easier.

Then run `./deploy.sh` to read the env vars, deploy gatus, and set up ngnix-ingress. Note: must have nginx-ingress configured in your k8s cluster, which is covered in the [multik8s repo](https://codeberg.org/epjane/multik8s).

Optional - tail the logs:
```bash
kubectl -n status logs deployment/gatus --tail=100 -f
```
