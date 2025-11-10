#!/bin/bash
# sys-health - résumé rapide de l'état du système

echo "📊 État du système - Reald Tools"
echo "-------------------------------"

echo "🕓 Uptime : $(uptime -p)"
echo "💻 Kernel : $(uname -r)"
echo ""

# RAM
if command -v free >/dev/null 2>&1; then
  echo "💾 RAM : $(free -h | awk '/Mem:/ {print $3 \" / \" $2}')"
fi

# CPU load
if [ -f /proc/loadavg ]; then
  echo "⚙️  Load average : $(cut -d ' ' -f1-3 /proc/loadavg)"
fi

# Disk
echo ""
echo "💽 Disques :"
df -h --total | sed -n '$p'

# Températures (si lm-sensors installé)
if command -v sensors >/dev/null 2>&1; then
  echo ""
  echo "🌡️  Températures :"
  sensors | sed -n '1,6p'
fi

# Processus top (5)
echo ""
echo "🔝 Top 5 processus par mémoire :"
ps aux --sort=-%mem | awk 'NR<=6{print NR-1") "$0}' 

echo ""
echo "✅ Fin du rapport."