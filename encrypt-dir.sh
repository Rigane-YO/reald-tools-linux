#!/bin/bash
# encrypt-dir - chiffrer/déchiffrer dossier simple (Reald Tools)
# Usage:
#   encrypt-dir encrypt <dossier>
#   encrypt-dir decrypt <fichier.enc>

set -e

usage() {
  echo "Usage : $0 encrypt <dossier> | $0 decrypt <fichier.enc>"
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

action="$1"
target="$2"

if [ "$action" = "encrypt" ]; then
  if [ ! -d "$target" ]; then
    echo "Le dossier '$target' n'existe pas."
    exit 1
  fi
  read -sp "Entrez le mot de passe (ne pas laisser vide) : " pass
  echo
  if [ -z "$pass" ]; then
    echo "Mot de passe vide. Abandon."
    exit 1
  fi
  tar -czf - "$target" | openssl enc -aes-256-cbc -salt -pbkdf2 -out "${target%/}.tar.gz.enc" -pass pass:"$pass"
  echo "🔒 Dossier chiffré : ${target%/}.tar.gz.enc"
elif [ "$action" = "decrypt" ]; then
  if [ ! -f "$target" ]; then
    echo "Fichier '$target' introuvable."
    exit 1
  fi
  read -sp "Mot de passe : " pass
  echo
  openssl enc -d -aes-256-cbc -pbkdf2 -in "$target" -out decrypted.tar.gz -pass pass:"$pass"
  tar -xzf decrypted.tar.gz
  rm -f decrypted.tar.gz
  echo "🔓 Déchiffrement terminé."
else
  usage
fi