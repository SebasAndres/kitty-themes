#!/usr/bin/env bash
# Instala el comando `kitty-theme`, el prompt de bash y deja elegir el theme inicial.
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

# Prompt de bash con colores y emojis
BASHRC="$HOME/.bashrc"
SOURCE_LINE="[ -f \"$REPO_DIR/bashrc-xeneize.sh\" ] && source \"$REPO_DIR/bashrc-xeneize.sh\""
touch "$BASHRC"
if grep -qF "bashrc-xeneize.sh" "$BASHRC"; then
    echo "~/.bashrc ya carga bashrc-xeneize.sh."
elif grep -qF "Prompt Xeneize" "$BASHRC"; then
    echo "Aviso: ~/.bashrc ya tiene el bloque 'Prompt Xeneize' copiado a mano; no se modifica."
    echo "       Para usar el del repo, borrá ese bloque y volvé a correr ./install.sh."
else
    printf '\n# Prompt Xeneize (kitty-themes)\n%s\n' "$SOURCE_LINE" >> "$BASHRC"
    echo "Agregado a ~/.bashrc: $SOURCE_LINE (abrí una terminal nueva o: source ~/.bashrc)"
fi

# Avisos sobre dependencias
command -v kitty >/dev/null 2>&1 || echo "Aviso: kitty no está instalado (ver README)."
command -v fzf >/dev/null 2>&1 || echo "Tip: instalá fzf para un selector con vista previa."
fc-list 2>/dev/null | grep -qi "emoji" || echo "Aviso: no hay fuente de emojis (instalá fonts-noto-color-emoji, ver README)."

"$REPO_DIR/theme.sh" "$@"
