#!/usr/bin/env bash
# Instala el comando `kitty-theme` y deja elegir el theme inicial.
#   ./install.sh            abre el selector
#   ./install.sh <theme>    instala directamente ese theme
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$BIN_DIR"
ln -sf "$REPO_DIR/theme.sh" "$BIN_DIR/kitty-theme"
echo "Comando instalado: $BIN_DIR/kitty-theme -> $REPO_DIR/theme.sh"
case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *) echo "Aviso: $BIN_DIR no está en tu PATH; agregalo para usar 'kitty-theme'." ;;
esac

# Avisos sobre dependencias
command -v kitty >/dev/null 2>&1 || echo "Aviso: kitty no está instalado (ver README)."
command -v fzf >/dev/null 2>&1 || echo "Tip: instalá fzf para un selector con vista previa."

"$REPO_DIR/theme.sh" "$@"
