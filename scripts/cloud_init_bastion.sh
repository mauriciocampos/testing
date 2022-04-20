apt update
apt install -yq cloud-init 
apt install -yq wget
apt-get install -y libpam-google-authenticator

systemctl start cloud-init-local
systemctl start cloud-init
systemctl start cloud-config

cloud-init modules --mode=final

echo -e "auth required pam_google_authenticator.so nullok\n auth required pam_permit.so" >> /etc/pam.d/sshd
sed -i.bak 's/^\(@include common-auth\)$/#\1/' /etc/pam.d/sshd
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
echo -e "AuthenticationMethods publickey,keyboard-interactive" >> /etc/ssh/sshd_config