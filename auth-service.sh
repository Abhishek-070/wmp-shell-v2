source common.sh
service_name= auth-service

dnf install -y golang
cp ${service_name}.service /etc/systemd/system/${service_name}.service

app_prereq

cd /app
CGO_ENABLED=0 go build -o ${service_name} ./cmd/server

chown -R appuser:appuser /app
chmod o-rwx /app -R

systemctl daemon-reload
systemctl enable ${service_name}
systemctl start ${service_name}