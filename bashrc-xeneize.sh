# --- Prompt Xeneize (añadido para Kitty) ---
# install.sh agrega a ~/.bashrc la línea que carga este archivo.
# Usa colores truecolor (24 bits) y emojis: requiere una terminal
# con truecolor (kitty lo es) y una fuente de emojis como Noto Color Emoji.

if [ -t 1 ]; then
    __git_branch() { git branch --show-current 2>/dev/null | sed 's/.*/  &/'; }
    # Carpetas de ls en celeste, distinto del azul del usuario en el prompt
    eval "$(dircolors -b 2>/dev/null)"
    export LS_COLORS="${LS_COLORS}:di=01;38;2;127;200;255"
    PS1='\[\e[1;38;2;61;126;255m\]\u\[\e[0;38;2;253;185;19m\]@\h \[\e[1;38;2;253;185;19m\]\w\[\e[0;38;2;111;160;255m\]$(__git_branch)\n\[\e[1;38;2;253;185;19m\]❯\[\e[0m\] '
    # Saludo al abrir la terminal
    printf '\e[1;38;2;253;185;19m🛰️🚀🖖🤖🦍⚽💙💛! \e[0m\n'
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lh --color=auto --group-directories-first'
