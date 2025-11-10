#!/bin/bash
# install.sh - installe les outils Reald Tools dans /usr/local/bin

set -e
REPO_RAW_BASE="https://raw.githubusercontent.com/Rigane-YO/reald-tools/main"

TOOLS=("clean-system" "sys-health" "encrypt-dir")

echo "🚀 Installation de Reald Tools..."

for tool in "${TOOLS[@]}"; do
  echo "-> Installation de $tool..."
  sudo curl -sSL "${REPO_RAW_BASE}/${tool}.sh" -o /usr/local/bin/${tool}
  sudo chmod +x /usr/local/bin/${tool}
done

echo "✅ Installation terminée !"
echo "Commandes disponibles : ${TOOLS[*]}"