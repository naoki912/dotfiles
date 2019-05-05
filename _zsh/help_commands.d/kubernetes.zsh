alias h-k8s-xpanes='cat --bg=dark << EOF
xpanes -c "kubectl exec -ti {} sh" \$(kubectl get pods -l app=sample-app -o jsonpath="{.items[*].metadata.name}")
EOF
'

alias h-k8s-kubectl-get-pod-all='cat --bg=dark << EOF
kubectl get pods --all-namespaces --include-uninitialized
EOF
'

alias h-k8s-busybox='cat --bg=dark << EOF
# - h-k8s-run
# - h-k8s-manifest-pod

# one liner
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600

# manifest
spec:
  containers:
    - name: busybox
      image: busybox:1.28
      command: ["sleep", "3600"]
EOF
'

alias h-k8s-kubectl-exec='cat --bg=dark << EOF
kubectl exec -ti \$POD_NAME -c \$CONTAINER_NAME -- ls
EOF
'

alias h-k8s-run='cat --bg=dark << EOF
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600
kubectl get pods -l run=busybox
POD_NAME=\$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")
kubectl exec -ti \$POD_NAME -- nslookup kubernetes
EOF
'

alias h-k8s-manifest-pod='cat --bg=dark << EOF
apiVersion: v1
kind: Pod
metadata:
  name: busybox
spec:
  securityContext:
    runAsNonRoot: true
  containers:
  - name: a
    image: busybox:1.28
    command: ["sleep", "3600"]
  - name: b
    image: busybox:1.28
    command: ["sleep", "3600"]
EOF
'

alias h-k8s-manifest-deployment='cat --bg=dark << EOF
# https://github.com/MasayaAoyama/kubernetes-perfect-guide/blob/master/samples/chapter06/sample-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
    spec:
      containers:
        - name: nginx-container
          image: nginx:1.12
          ports:
            - containerPort: 80
EOF
'

alias h-k8s-manifest-clusterip='cat --bg=dark << EOF
# https://github.com/MasayaAoyama/kubernetes-perfect-guide/blob/master/samples/chapter06/sample-clusterip-multi.yaml
apiVersion: v1
kind: Service
metadata:
  name: sample-clusterip
spec:
  type: ClusterIP
  # clusterIPをstaticに設定する
  #clusterIP: 10.32.0.10
  # 特定のk8s nodeの IP_ADDR:PORT で受信したtrafficをPodに転送
  #externalIPs:
  #  - 10.240.0.20 #workerのhost IP
  #  - 10.240.0.21 #workerのhost IP
  ports:
    - name: "http-port"
      protocol: "TCP"
      port: 8080
      targetPort: 80
    - name: "https-port"
      protocol: "TCP"
      port: 8443
      targetPort: 443
  selector:
    app: sample-app
EOF
'

alias h-k8s-manifest-nodeport='cat --bg=dark << EOF
# https://github.com/MasayaAoyama/kubernetes-perfect-guide/blob/master/samples/chapter06/sample-nodeport.yaml
apiVersion: v1
kind: Service
metadata:
  name: sample-nodeport
spec:
  type: NodePort
  # kube-proxyにNodeをまたいで別NodeのPodにLBさせないようにする
  #externalTrafficPolicy: Local
  ports:
    - name: "http-port"
      protocol: "TCP"
      port: 8080
      targetPort: 80
      nodePort: 30080
  selector:
    app: sample-app
EOF
'

alias h-k8s-manifest-lb='cat --bg=dark << EOF
# https://github.com/MasayaAoyama/kubernetes-perfect-guide/blob/master/samples/chapter06/sample-lb.yaml
apiVersion: v1
kind: Service
metadata:
  name: sample-lb
spec:
  type: LoadBalancer
  # kube-proxyにNodeをまたいで別NodeのPodにLBさせないようにする
  #externalTrafficPolicy: Local
  # IPを固定する場合
  #loadBalancerIP: xxx.xxx.xxx.xxx
  ports:
    - name: "http-port"
      protocol: "TCP"
      port: 8080
      targetPort: 80
      nodePort: 30082
  selector:
    app: sample-app
EOF
'

alias h-k8s-manifest-daemonset='cat --bg=dark << EOF
# https://github.com/MasayaAoyama/kubernetes-perfect-guide/blob/master/samples/chapter05/sample-ds.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: sample-ds
spec:
  # // RollingUpdateの場合
  # // 即時アップデートが開始される
  #updateStrategy:
  #  type: RollingUpdate
  #  rollingUpdate:
  #    maxUnavailable: 2
  #---
  # // OnDeleteの場合
  # // 意図的にPodを削除しない限りアップデートされない
  #updateStrategy:
  #  type: OnDelete
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
    spec:
      containers:
        - name: nginx-container
          image: nginx:1.12
          ports:
            - containerPort: 80
EOF
'

alias h-k8s-manifest-pod-security-policy='cat --bg=dark << EOF
# https://kubernetes.io/docs/concepts/policy/pod-security-policy/

apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: example
spec:
  privileged: false  # Dont allow privileged pods!
  # The rest fills in some required fields.
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  runAsUser:
    rule: RunAsAny
  fsGroup:
    rule: RunAsAny
  volumes:
  - "*"
EOF
'

alias h-k8s-config-value='cat --bg=dark << EOF
# go-templateの外側の"はシングルクオートに変更すること
kubectl config view -o go-template="{{ range .users }}{{ if eq .name "k8s-traning-admin" }}{{ index .user "client-certificate-data" }}{{ end }}{{ end }}" --raw=true
base64 -d ...

kubectl config view -o jsonpath="{.users[?(@.name=="admin")].user.client-certificate-data}"
EOF
'

alias h-k8s-manifest-help='cat --bg=dark << EOF
kubectl explain deployment.spec
EOF
'

alias h-k8s-patch-serial='cat --bg=dark << EOF
# -pの"はシングルクオートに変更すること
kubectl patch deployments nginx-deployment --type="json" -p="[{"op": "replace", "path": "/spec/template/metadata/annotations/serial", "value": "201812121620"}]"
EOF
'

alias h-k8s-node-label='cat --bg=dark << EOF
kubectl label nodes worker-0 key=value
kubectl get nodes --show-labels

# ROLESにWorkerという文字列を入れたい場合
kubectl label node worker-0 node-role.kubernetes.io/worker=worker
EOF
'

alias h-k8s-node-taint='cat --bg=dark << EOF
kubectl patch node worker-x --type="json" -p="[{"op": "add", "path": "/spec/taints", "value": [{"effect": "NoSchedule", "key": "node-role.kubernetes.io/worker"}] }]"
or
kubectl taint nodes worker-x key=value:NoSchedule
kubectl taint nodes controller-0 node-role.kubernetes.io/master=:NoSchedule

kubectl taint nodes worker-x hoge=value:NoSchedule
kubectl taint nodes worker-x hoge=value:PreferNoSchedule
kubectl taint nodes worker-x hoge=value:NoExecute
kubectl taint nodes worker-x hoge=:NoExecute

kubectl taint nodes worker-x hoge-

--
spec/containers/tolerations

tolerations:
- key: "key"
  operator: "Exists"

tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"

tolerations:
- key: node-role.kubernetes.io/worker
  operator: "Exists"
  effect: "NoSchedule"
EOF
'

alias h-k8s-node-drain='cat --bg=dark << EOF
# drainはScheduleされないようにするだけで、trait NoExecuteなどでPodを別に移す必要がある。

kubectl drain master-0
> error: DaemonSet-managed pods (use --ignore-daemonsets to ignore): ...

kubectl get nodes
> NAME              STATUS                     ROLES    AGE     VERSION
> master-0          Ready,SchedulingDisabled   master   2d23h   v1.13.0
> worker-0          Ready                      worker   2d23h   v1.13.0
# SchedulingDisabled が追加される

# drain解除
kubectl uncordon master-0
EOF
'

alias h-k8s-helm-install='cat --bg=dark << EOF
helm init

kubectl create serviceaccount -n kube-system tiller

kubectl create clusterrolebinding \
  tiller-cluster-rule \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:tiller

kubectl patch deployment \
  tiller-deploy -p \
  "{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}" \
  -n kube-system
EOF
'

alias h-k8s-helm-ingress='cat --bg=dark << EOF
helm install stable/nginx-ingress --name my-ingress --set rbac.create=true --namespace kube-system --set controller.kind=DaemonSet,controller.hostNetwork=true
EOF
'

alias h-k8s-preset-try-clusterip='cat --bg=dark << EOF
---
apiVersion: v1
kind: Pod
metadata:
  name: kero-busybox
  labels:
    app: kero-busybox
spec:
  containers:
  - name: busybox
    image: busybox:1.28
    command: ["sleep", "3600"]

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kero-deployment-nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: kero-deployment-nginx
  template:
    metadata:
      labels:
        app: kero-deployment-nginx
    spec:
      containers:
        - name: nginx-container
          image: nginx:1.12
          ports:
            - containerPort: 80

---
apiVersion: v1
kind: Service
metadata:
  name: kero-clusterip
spec:
  type: ClusterIP
  ports:
    - name: "http-port"
      protocol: "TCP"
      port: 8080
      targetPort: 80
  selector:
    app: kero-deployment-nginx
EOF
'

alias h-k8s-preset-useradd-user='cat --bg=dark << EOF
# 新しくnamespaceを作成し、そのnamespaceのみを操作できるユーザーを作成する手順
# develop namespaceだけ操作できるユーザーの作成例
# Userを作成する方法

# namespaceを作成する
kubectl create namespace develop

# 証明書を作成する
openssl genrsa -out kero.key 2048
openssl req -new -key kero.key -out kero.csr -subj "/CN=kero/O=sakura"
sudo openssl x509 -req -in kero.csr \
  -CA /etc/kubernetes/pki/ca.crt \
  -CAkey /etc/kubernetes/pki/ca.key \
  -CAcreateserial \
  -out kero.crt -days 100

# kubeconfig を作成する
kubectl config set-credentials kero \
  --client-certificate kero.crt \
  --client-key kero.key \
  --embed-certs
kubectl config set-context kero-context \
  --cluster kubernetes \
  --namespace develop \
  --user=kero

cat role-kero.yaml
<<OUTPUT
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  namespace: develop
  name: kero-role
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["deployments", "replicasets", "pods"]
  verbs: ["list", "get", "watch", "create", "update", "patch", "delete"]
# You can use ["*"] for all verbs
OUTPUT

cat rolebind.yaml
<<OUTPUT
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: kero-role-binding
  namespace: develop
subjects:
- kind: User
  name: kero
  apiGroup: ""
roleRef:
  kind: Role
  name: kero-role
  apiGroup: ""
OUTPUT

kubectl apply -f role-kero.yaml -f rolebind.yaml
EOF
'

alias h-k8s-preset-useradd-sa='cat --bg=dark << EOF
# default namespaceだけ操作できるユーザーの作成例
# ServiceAccountを作成する方法

# ServiceAccount を作成する
kubectl create serviceaccount kero -n default

SECRET_NAME=\$(kubectl get serviceaccount kero -n default -o jsonpath="{.secrets[0].name}")
# Secretからca.crtを取得する場合はこのコマンドを叩く(おそらく既にClusterは登録されているのでやらなくていい)
# ca.crtファイルには base64 -d したものを入れること(set-clusterした時にbase64されるのでオニオン状態になる)
CA_CRT=\$(kubectl -n default get secret "\${SECRET_NAME}" -o go-template="{{index .data \"ca.crt\"}}" | base64 -d)
echo $CA_CRT > ca.crt
# SecretからTokenを取得する
USER_TOKEN=\$(kubectl get secret "\${SECRET_NAME}" -n default -o jsonpath="{.data.token}" | base64 -d)

# kubeconfig を作成する
kubectl config set-credentials kero --token \${USER_TOKEN}
kubectl config set-context kero-context \\
  --cluster kubernetes \\
  --namespace default \\
  --user=kero

# Clusterの登録がまだの場合は以下を実行
echo \${CA_CRT} > ca.crt
kubectl config set-cluster kubernetes \\
    --server=x.x.x.x \\
    --certificate-authority=ca.crt \\
    --embed-certs=true

kubectl config use-context n-kanazawa@mycluster

cat role-and-rolebind.yaml
<<OUTPUT
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: Role
metadata:
  namespace: default
  name: kero-role
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["deployments", "replicasets", "pods"]
  verbs: ["list", "get", "watch", "create", "update", "patch", "delete"]
# You can use ["*"] for all verbs
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: RoleBinding
metadata:
  name: kero-role-binding
  namespace: default
roleRef:
  apiGroup: ""
  kind: Role
  name: kero-role
subjects:
- kind: ServiceAccount
  name: kero
  namespace: default
OUTPUT

kubectl apply -f role-and-rolebind.yaml -n default
EOF
'

