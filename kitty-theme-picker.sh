#!/usr/bin/env bash
set -u

THEMES_DIR="$HOME/.config/kitty/themes"
THEME_LINK="$HOME/.config/kitty/theme.conf"

if [ ! -d "$THEMES_DIR" ]; then
    printf 'kitty-theme-picker: themes directory not found at %s\n' "$THEMES_DIR"
    exit 1
fi

mapfile -t themes < <(find "$THEMES_DIR" -maxdepth 1 -type f -name '*.conf' -printf '%f\n' | sort)

if [ "${#themes[@]}" -eq 0 ]; then
    printf 'kitty-theme-picker: no theme files found in %s\n' "$THEMES_DIR"
    exit 1
fi

pick_theme() {
    local selection=""
    if command -v fzf >/dev/null 2>&1; then
        selection=$(printf '%s\n' "${themes[@]}" | fzf --prompt='kitty theme> ' --height=80% --layout=reverse --border --ansi)
        printf '%s' "$selection"
        return
    fi

    local index=1
    for theme in "${themes[@]}"; do
        printf '%4d  %s\n' "$index" "$theme"
        index=$((index + 1))
    done
    printf '\nSelect theme number (empty to cancel): '
    read -r choice
    if [ -z "${choice:-}" ]; then
        printf ''
        return
    fi
    if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
        printf ''
        return
    fi
    local idx=$((choice - 1))
    if [ "$idx" -lt 0 ] || [ "$idx" -ge "${#themes[@]}" ]; then
        printf ''
        return
    fi
    printf '%s' "${themes[$idx]}"
}

selection=$(pick_theme)

if [ -z "${selection:-}" ]; then
    printf 'kitty-theme-picker: cancelled\n'
    exit 0
fi

theme_path="$THEMES_DIR/$selection"

if ! ln -sf "$theme_path" "$THEME_LINK"; then
    printf 'kitty-theme-picker: failed to update theme symlink\n'
    exit 1
fi

if command -v kitty >/dev/null 2>&1; then
    kitty @ set-colors -a "$theme_path" >/dev/null 2>&1 || true
fi

printf 'Switched to theme: %s\n' "$selection"
