# status.confuzer.cloud

Create `.env.prod` with the following contents (replacing the x's with the actual data):

```bash
KUBECONFIG=/path/to/kubeconfig.yaml
MATRIX_HOMESERVER=https://matrix.org
MATRIX_ACCESS_TOKEN=mat_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
MATRIX_ROOM_ID=!xxxxxxxxxxxxxxxxxx:matrix.org
```

See [gatus README](https://github.com/TwiN/gatus#configuring-matrix-alerts) for how to get [access token](https://webapps.stackexchange.com/q/131056) and internal-room-id (room id also available with the room's share button).

Then run `./deploy.sh` to read the env vars, deploy gatus, and set up ngnix-ingress. Note: must have nginx-ingress configured in your k8s cluster.

Optional - tail the logs:
```bash
kubectl -n status logs deployment/gatus --tail=100 -f
```
