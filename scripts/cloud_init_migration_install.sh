apt update
apt install -yq cloud-init 
apt install -yq wget

systemctl start cloud-init-local
systemctl start cloud-init
systemctl start cloud-config

cloud-init modules --mode=final

ln -s /etc/puppetlabs/puppet /var/lib/puppet
ln -s /etc/puppetlabs/puppet /etc/puppet