#!/bin/bash

# Atualiza os pacotes e instala o Flatpak
sudo apt update
sudo apt install -y flatpak

# Adiciona o repositório Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instala o Barrier via Flatpak
flatpak install -y flathub com.github.debauchee.barrier

# Cria um arquivo de serviço systemd para iniciar o Barrier na inicialização do sistema
sudo tee /etc/systemd/system/barrier.service > /dev/null <<EOF
[Unit]
Description=Barrier Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/flatpak run com.github.debauchee.barrier

[Install]
WantedBy=default.target
EOF

# Habilita e inicia o serviço do Barrier
sudo systemctl enable barrier.service
sudo systemctl start barrier.service

echo "Barrier instalado e configurado para iniciar com o sistema."
