sudo add-apt-repository -y ppa:neovim-ppa/unstable 
# Add dependencies of terraform & gcloud
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl apt-transport-https ca-certificates
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# add gcloud repos
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# install terraform, neovim, ripgrep, gcloud, cloc and tmux
sudo apt-get update && sudo apt-get install -y terraform neovim ripgrep google-cloud-sdk cloc tmux packer awscli direnv
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -P /usr/local/bin/
sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -P /usr/local/bin/
sudo wget https://github.com/ahmetb/kubectx/blob/master/kubens -P /usr/local/bin/
sudo wget https://github.com/ahmetb/kubectx/blob/master/kubectx -P /usr/local/bin/
sudo chmod 755 /usr/local/bin/kubens && sudo chmod 755 /usr/local/bin/kubectx

# todo
# pkgs.git-secret
# tmux settings
# nvim settings

cat direnv-setup >> ~/.zshrc
