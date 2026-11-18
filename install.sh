#!/usr/bin/env bash
# Instala esta configuración de kitty creando un enlace simbólico en ~/.config/kitty
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"
TARGET="$CONFIG_DIR/kitty.conf"

mkdir -p "$CONFIG_DIR"

# Respaldo de la configuración existente (si no es ya nuestro enlace)
if [ -e "$TARGET" ] && [ "$(readlink -f "$TARGET")" != "$REPO_DIR/kitty.conf" ]; then
    BACKUP="$TARGET.bak.$(date +%Y%m%d-%H%M%S)"
    mv "$TARGET" "$BACKUP"
    echo "Configuración anterior respaldada en: $BACKUP"
fi

ln -sf "$REPO_DIR/kitty.conf" "$TARGET"
echo "Enlace creado: $TARGET -> $REPO_DIR/kitty.conf"

# Avisos sobre dependencias
command -v kitty >/dev/null 2>&1 || echo "Aviso: kitty no está instalado (ver README)."
fc-list 2>/dev/null | grep -qi "DejaVu Sans Mono" || echo "Aviso: falta la fuente 'DejaVu Sans Mono' (ver README)."

echo "Listo. Recarga kitty con ctrl+shift+F5 o ábrelo de nuevo."
