echo "Making Backup of /etc/apt/sources.list..."
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak

echo "Adding Ubuntu Repositories..."
sudo cp ./tuna_ubuntu.list /etc/apt/sources.list