# kitty-themes 🎨

Colección de configuraciones ("themes") para el emulador de terminal [kitty](https://sw.kovidgoyal.net/kitty/), con un comando para cambiar entre ellas en un segundo.

Cada theme es un `kitty.conf` completo (fuente, ventana, pestañas, atajos y colores) en `themes/<nombre>.conf`. Elegir uno enlaza `~/.config/kitty/kitty.conf` a ese archivo y recarga kitty al instante.

## Themes incluidos

| Theme | Descripción |
|---|---|
| `xeneize` 💙💛 | Fondo azul marino `#061A3A`, acentos oro `#FDB913`, DejaVu Sans Mono 12, opacidad 0.90, pestañas arriba sin fondo separadas por `│`, `cursor_trail`, atajos de splits con flechas |
| `alien-blood` 👽 | La config que tenías en `~/.config/kitty`: JetBrains Mono 13, opacidad 0.95, pestañas *powerline* inclinadas, colores Alien Blood sobre Catppuccin Mocha |

## Elegir un theme

```bash
kitty-theme              # menú interactivo (con vista previa si tenés fzf)
kitty-theme xeneize      # activar uno directamente
kitty-theme list         # listar (el activo aparece con *)
kitty-theme current      # mostrar el activo
```

La primera vez que se activa un theme, si `~/.config/kitty/kitty.conf` es un archivo propio se respalda como `kitty.conf.bak.FECHA`.

### Agregar un theme nuevo

1. Creá `themes/mi-theme.conf` con una config completa de kitty (podés partir de copiar otro).
2. Opcional: poné en la primera línea `## description: ...` para que se vea en el listado.
3. `kitty-theme mi-theme`.

Tip: `kitty +kitten themes` muestra cientos de paletas; copiá los colores de la que te guste al final de tu `.conf`.

## Atajos de teclado (theme `xeneize`)

| Atajo | Acción |
|---|---|
| `Ctrl+Shift+T` | Nueva pestaña en el directorio actual |
| `Ctrl+Shift+Enter` / `Ctrl+Shift+→` | Dividir verticalmente (panel a la derecha) |
| `Ctrl+Shift+-` / `Ctrl+Shift+↓` | Dividir horizontalmente (panel abajo) |
| `Ctrl+Shift+Z` | Maximizar / restaurar el panel actual |
| `Alt+←/→/↑/↓` | Moverse entre paneles |
| `Ctrl+Alt+←/→/↑/↓` | Cambiar el tamaño del panel |
| `Ctrl+=` / `Ctrl+-` / `Ctrl+0` | Agrandar / achicar / restablecer la fuente |
| `Ctrl+Shift+F5` | Recargar la configuración (atajo de kitty) |

---

## Instalación en Linux

### 1. Instalar kitty

> La opción `cursor_trail` necesita **kitty 0.37 o superior**. Las versiones de los repositorios de algunas distros son más viejas; en ese caso usa el instalador oficial.

**Instalador oficial (recomendado, siempre la última versión):**

```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Esto instala kitty en `~/.local/kitty.app`. Para tenerlo en el PATH y en el menú de aplicaciones:

```bash
mkdir -p ~/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty*.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
```

**Desde el gestor de paquetes:**

```bash
sudo apt install kitty        # Debian / Ubuntu
sudo dnf install kitty        # Fedora
sudo pacman -S kitty          # Arch
```

### 2. Instalar las fuentes

`xeneize` usa DejaVu Sans Mono y `alien-blood` usa JetBrains Mono:

```bash
sudo apt install fonts-dejavu fonts-jetbrains-mono          # Debian / Ubuntu
sudo dnf install dejavu-sans-mono-fonts jetbrains-mono-fonts # Fedora
sudo pacman -S ttf-dejavu ttf-jetbrains-mono                 # Arch
```

### 3. Instalar la configuración

```bash
git clone https://github.com/SebasAndres/kitty-themes.git ~/kitty-themes
cd ~/kitty-themes
./install.sh
```

El script:
- instala el comando `kitty-theme` en `~/.local/bin` (enlace a `theme.sh`),
- abre el selector para elegir el theme inicial (o pasalo directo: `./install.sh xeneize`),
- respalda tu `~/.config/kitty/kitty.conf` actual y lo reemplaza por un **enlace simbólico** al theme, así un `git pull` actualiza la configuración,
- avisa si falta kitty.

**Instalación manual** (sin script):

```bash
mkdir -p ~/.config/kitty
cp themes/xeneize.conf ~/.config/kitty/kitty.conf
```

Luego abre kitty o, si ya está abierto, pulsa `Ctrl+Shift+F5`.

---

## Windows

kitty **no tiene versión nativa para Windows** (el autor no planea hacerla). La forma de usarlo es a través de **WSL2**, que en Windows 10 (21H2+) y Windows 11 puede mostrar aplicaciones gráficas de Linux gracias a WSLg.

### 1. Instalar WSL2 con Ubuntu

En PowerShell **como administrador**:

```powershell
wsl --install -d Ubuntu
```

Reinicia cuando lo pida y crea tu usuario de Linux. Si ya tenías WSL, actualízalo con `wsl --update`.

### 2. Dentro de Ubuntu (WSL)

Sigue los mismos pasos de Linux:

```bash
sudo apt update
sudo apt install -y fonts-dejavu fonts-jetbrains-mono git curl
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir -p ~/.local/bin && ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/

git clone https://github.com/SebasAndres/kitty-themes.git ~/kitty-themes
~/kitty-themes/install.sh
```

### 3. Abrir kitty

```bash
kitty &
```

kitty se abre como una ventana normal de Windows. Si instalaste los archivos `.desktop` (ver paso de Linux), también aparece en el menú Inicio, dentro de la carpeta *Ubuntu*.

**Limitaciones en WSL:** si aparece un error de OpenGL, prueba `LIBGL_ALWAYS_SOFTWARE=1 kitty`. La transparencia y algunos atajos con `Alt` pueden comportarse distinto según el driver gráfico.

**Alternativa nativa:** si prefieres no usar WSL, [WezTerm](https://wezfurlong.org/wezterm/) o Windows Terminal funcionan de forma nativa. Puedes llevar la paleta de colores de cualquier theme (sección *Tema*) a cualquiera de ellos.

---

## Personalización

- **Opacidad en caliente:** con `dynamic_background_opacity yes` puedes usar `Ctrl+Shift+A` y luego `M` (más) / `L` (menos).
- **Otra fuente:** cambia `font_family`. Para ver las disponibles: `kitty +list-fonts`.
- **Otra paleta:** `kitty +kitten themes` abre un selector con cientos de paletas. Ojo: escribe en `~/.config/kitty/kitty.conf`, que es un enlace a tu theme, así que modifica el archivo del repo.
