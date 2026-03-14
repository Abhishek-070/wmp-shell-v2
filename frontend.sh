source common.sh

echo -e "${YC} Install Nginx ${NC}"
dnf module disable nginx -y &>>$OUTPUT
dnf module enable nginx:1.26 -y &>>$OUTPUT
dnf install -y nginx &>>OUTPUT
status_check

echo -e "${YC} Update Nginx config ${NC}"
cp nginx.conf /etc/nginx/nginx.conf &>>$OUTPUT
status_check

echo -e "${YC} Install NodeJS ${NC}"
curl -fsSL https://rpm.nodesource.com/setup_22.x | bash - &>>$OUTPUT
dnf install -y nodejs &>>$OUTPUT

node --version &>>$OUTPUT
npm --version &>>$OUTPUT
status_check

echo -e "${YC} Download and extract application ${NC}"
curl -L -o /tmp/frontend.tar.gz https://raw.githubusercontent.com/raghudevopsb88/wealth-project/main/artifacts/frontend.tar.gz &>>$OUTPUT
mkdir -p /tmp/frontend &>>$OUTPUT
cd /tmp/frontend
tar xzf /tmp/frontend.tar.gz &>>$OUTPUT
status_check

echo -e "${YC} Build frontend codes ${NC}"
cd /tmp/frontend
npm ci &>>$OUTPUT
npm run build &>>$OUTPUT
status_check

echo -e "${YC} Update frontend codes ${NC}"
rm -rf /usr/share/nginx/html/* &>>$OUTPUT
cp -r /tmp/frontend/dist/* /usr/share/nginx/html/ &>>$OUTPUT
status_check

echo -e "${YC} Start Nginx sevices ${NC}"
systemctl enable nginx &>>$OUTPUT
systemctl restart nginx &>>$OUTPUT
status_check