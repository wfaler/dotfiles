# Add Neovim PPA
sudo add-apt-repository -y ppa:neovim-ppa/unstable 
# Add dependencies of terraform & gcloud
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl apt-transport-https ca-certificates
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# add gcloud repos
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# install terraform, neovim, ripgrep, gcloud, cloc and tmux
sudo apt-get update && sudo apt-get install -y terraform neovim ripgrep google-cloud-sdk cloc tmux


# TODO
# pkgs.kubeval
# pkgs.kubectx
# pkgs.kubernetes-helm
# pkgs.kustomize 
# pkgs.direnv
# pkgs.packer
# pkgs.git-secret
# pkgs.awscli
# pkgs.protoc-gen-go
# tmux settings
# nvim settings
