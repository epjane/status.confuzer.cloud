#!/bin/bash
set -e # exit when any error happens
source .env.prod
set -x # show commands running

if [[ -z "$KUBECONFIG" ]]; then
  echo '$KUBECONFIG not specified in .env.prod, please add it'
  exit 1
fi
export KUBECONFIG
ns=status #namespace

# kubectl -n $ns delete deploy gatus

set +x # hide commands temporarily for secrets
cat status-page.yaml | \
    sed "s,{{MATRIX_HOMESERVER}},${MATRIX_HOMESERVER},g" | \
    sed "s,{{MATRIX_ACCESS_TOKEN}},${MATRIX_ACCESS_TOKEN},g" | \
    sed "s,{{MATRIX_ROOM_ID}},${MATRIX_ROOM_ID},g" | \
    kubectl -n $ns apply -f -
set -x #show commands again

kubectl -n $ns apply -f status-page-ingress.yaml

#this will reload config faster but resend alerts for anything already down
# kubectl -n $ns rollout restart deployment gatus

# kubectl -n $ns logs deployment/gatus --tail=100 -f
