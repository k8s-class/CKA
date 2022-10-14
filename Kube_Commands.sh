cat ~/.kube/config | grep -i "current-context" | awk '{print $2}'
