# kitty-config · tema Xeneize 💙💛

Mi configuración para el emulador de terminal [kitty](https://sw.kovidgoyal.net/kitty/), con un tema azul y oro, transparencia, pestañas estilo *powerline* y atajos para dividir la pantalla.

## Qué incluye

| Sección | Detalles |
|---|---|
| **Fuente** | DejaVu Sans Mono, 12 pt, ligaduras activadas |
| **Ventana** | Padding de 12 px, opacidad 0.90 (ajustable en caliente), 110×32 celdas al abrir |
| **Cursor** | Forma de barra, parpadeo, efecto `cursor_trail` |
| **Pestañas** | Arriba, estilo powerline inclinado, título `índice: título` |
| **Varios** | 10 000 líneas de historial, sin campana, copiar al seleccionar |
| **Tema** | Fondo azul marino `#061A3A`, acentos oro `#FDB913` |

## Atajos de teclado

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

### 2. Instalar la fuente

```bash
sudo apt install fonts-dejavu     # Debian / Ubuntu
sudo dnf install dejavu-sans-mono-fonts   # Fedora
sudo pacman -S ttf-dejavu         # Arch
```

### 3. Instalar la configuración

```bash
git clone https://github.com/<tu-usuario>/kitty-config.git ~/kitty-config
cd ~/kitty-config
./install.sh
```

El script:
- respalda tu `~/.config/kitty/kitty.conf` actual (como `kitty.conf.bak.FECHA`),
- crea un **enlace simbólico** al `kitty.conf` del repo, así un `git pull` actualiza la configuración,
- avisa si falta kitty o la fuente.

**Instalación manual** (sin script):

```bash
mkdir -p ~/.config/kitty
cp kitty.conf ~/.config/kitty/kitty.conf
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
sudo apt install -y fonts-dejavu git curl
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir -p ~/.local/bin && ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/

git clone https://github.com/<tu-usuario>/kitty-config.git ~/kitty-config
~/kitty-config/install.sh
```

### 3. Abrir kitty

```bash
kitty &
```

kitty se abre como una ventana normal de Windows. Si instalaste los archivos `.desktop` (ver paso de Linux), también aparece en el menú Inicio, dentro de la carpeta *Ubuntu*.

**Limitaciones en WSL:** si aparece un error de OpenGL, prueba `LIBGL_ALWAYS_SOFTWARE=1 kitty`. La transparencia y algunos atajos con `Alt` pueden comportarse distinto según el driver gráfico.

**Alternativa nativa:** si prefieres no usar WSL, [WezTerm](https://wezfurlong.org/wezterm/) o Windows Terminal funcionan de forma nativa. Puedes llevar la paleta de colores de `kitty.conf` (sección *Tema*) a cualquiera de ellos.

---

## Personalización

- **Opacidad en caliente:** con `dynamic_background_opacity yes` puedes usar `Ctrl+Shift+A` y luego `M` (más) / `L` (menos).
- **Otra fuente:** cambia `font_family`. Para ver las disponibles: `kitty +list-fonts`.
- **Otro tema:** `kitty +kitten themes` abre un selector con cientos de temas.
