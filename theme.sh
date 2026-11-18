#!/usr/bin/env bash
# Selector de themes de kitty: enlaza ~/.config/kitty/kitty.conf a themes/<nombre>.conf
#
# Uso:
#   kitty-theme             menú interactivo (usa fzf si está instalado)
#   kitty-theme <nombre>    activa ese theme
#   kitty-theme list        lista los themes disponibles
#   kitty-theme current     muestra el theme activo
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
THEMES_DIR="$REPO_DIR/themes"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"
TARGET="$CONFIG_DIR/kitty.conf"

theme_names() {
    find "$THEMES_DIR" -maxdepth 1 -name '*.conf' -printf '%f\n' | sed 's/\.conf$//' | sort
}

theme_description() {
    sed -n 's/^## description: //p' "$THEMES_DIR/$1.conf" | head -1
}

current_theme() {
    local link
    link="$(readlink -f "$TARGET" 2>/dev/null || true)"
    case "$link" in
        "$THEMES_DIR"/*.conf) basename "$link" .conf ;;
        *) echo "(ninguno: $TARGET no apunta a un theme de este repo)" ;;
    esac
}

list_themes() {
    local name active
    active="$(current_theme)"
    while read -r name; do
        if [ "$name" = "$active" ]; then printf '* '; else printf '  '; fi
        printf '%-16s %s\n' "$name" "$(theme_description "$name")"
    done < <(theme_names)
}

backup_existing_config() {
    [ -e "$TARGET" ] || return 0
    case "$(readlink -f "$TARGET")" in "$THEMES_DIR"/*) return 0 ;; esac
    local backup="$TARGET.bak.$(date +%Y%m%d-%H%M%S)"
    mv "$TARGET" "$backup"
    echo "Configuración anterior respaldada en: $backup"
}

reload_kitty() {
    # kitty recarga su configuración al recibir SIGUSR1
    if pkill -USR1 -x kitty 2>/dev/null; then
        echo "kitty recargado."
    else
        echo "Abrí kitty para ver el theme (o recargá con ctrl+shift+F5)."
    fi
}

apply_theme() {
    local name="$1"
    if [ ! -f "$THEMES_DIR/$name.conf" ]; then
        echo "Theme '$name' no existe. Disponibles:" >&2
        theme_names >&2
        exit 1
    fi
    mkdir -p "$CONFIG_DIR"
    backup_existing_config
    ln -sfn "$THEMES_DIR/$name.conf" "$TARGET"
    echo "Theme activo: $name"
    reload_kitty
}

pick_theme() {
    if command -v fzf >/dev/null 2>&1; then
        local name
        while read -r name; do
            printf '%s\t%s\n' "$name" "$(theme_description "$name")"
        done < <(theme_names) \
            | fzf --prompt="theme (activo: $(current_theme))> " --height=50% --reverse \
                --delimiter='\t' --preview="cat '$THEMES_DIR'/{1}.conf" \
            | cut -f1
        return
    fi
    local names
    mapfile -t names < <(theme_names)
    echo "Theme activo: $(current_theme)" >&2
    PS3="Elegí un theme (número): "
    select name in "${names[@]}"; do
        [ -n "${name:-}" ] && { echo "$name"; return; }
    done
}

main() {
    case "${1:-}" in
        list|ls) list_themes ;;
        current) current_theme ;;
        -h|--help) sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//' ;;
        "")
            local choice
            choice="$(pick_theme)"
            [ -n "$choice" ] && apply_theme "$choice"
            ;;
        *) apply_theme "$1" ;;
    esac
}

main "$@"
