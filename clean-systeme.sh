#!/bin/bash
# clean-system - Nettoyage simple (Reald Tools)

echo "🧹 Nettoyage du système en cours..."

# commandes apt si Debian/Ubuntu (vérifier présence d'apt)
if command -v apt >/dev/null 2>&1; then
  sudo apt update -y
  sudo apt -y --purge autoremove
  sudo apt clean
  sudo apt autoclean
fi

# nettoyer les journaux système anciens (7 jours)
if command -v journalctl >/dev/null 2>&1; then
  sudo journalctl --vacuum-time=7d >/dev/null 2>&1 || true
fi

# supprimer les caches temporaires communs (optionnel)
if [ -d /tmp ]; then
  sudo find /tmp -type f -atime +7 -delete 2>/dev/null || true
fi

echo "✅ Nettoyage terminé !"