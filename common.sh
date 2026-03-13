app_prereq(){
useradd -r -s /bin/false appuser
mkdir -p /app
curl -L -o /tmp/${service_name}.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/${service_name}.tar.gz
cd /app
tar xzf /tmp/${service_name}.tar.gz
}