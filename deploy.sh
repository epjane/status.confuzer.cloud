#!/bin/bash
set -e # exit when any error happens
set -a # automatically export all variables
source .env.prod
set +a
set -x # show commands running

if [[ -z "$KUBECONFIG" ]]; then
  echo '$KUBECONFIG not specified in .env.prod, please add it'
  exit 1
fi
ns=status #namespace

# kubectl -n $ns delete deploy gatus

set +x # hide commands temporarily for secrets
cat status-page.yaml | \
    envsubst '$MATRIX_HOMESERVER,$MATRIX_ROOM_ID,$MATRIX_ACCESS_TOKEN' | \
    kubectl -n $ns apply -f -
set -x #show commands again

kubectl -n $ns apply -f status-page-ingress.yaml

#this will reload config faster but resend alerts for anything already down
# kubectl -n $ns rollout restart deployment gatus

# kubectl -n $ns logs deployment/gatus --tail=100 -f
