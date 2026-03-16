# 🏠 Dotfiles para Omarchy

> Meus arquivos de configuração pessoais para [Omarchy](https://omarchy.org) (Arch Linux + Hyprland).

## 📦 O que está incluído

| Ferramenta | Descrição |
|------------|-----------|
| **Hyprland** | Configurações do compositor Wayland |
| **Waybar** | Barra de status |
| **Ghostty** | Principal emulador de terminal |
| **Alacritty** | Segundo emulador de terminal |
| **Neovim** | Editor de texto |
| **Bash** | Aliases e configurações do shell |

## ⚙️ Pré-requisitos

- [Omarchy](https://omarchy.org) instalado
- `git` instalado
- Arch Linux com Hyprland

## 🚀 Instalação

```bash
git clone https://github.com/felipeparaizoo/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

> [!NOTE]
> O `install.sh` cria backups automáticos das configurações anteriores em `~/.dotfiles_backup/` antes de criar os symlinks.

## 🗑️ Desinstalação

```bash
cd ~/dotfiles
bash uninstall.sh
```

> [!IMPORTANT]
> Use com cuidado. Este comando remove os symlinks e reseta o Omarchy para as configurações originais de fábrica.

> [!NOTE]
> Durante a desinstalação você pode escolher um backup anterior para restaurar. Caso não tenha backup disponível ou selecione `0`, será realizado o boot padrão do Omarchy.

## 📁 Estrutura

```
dotfiles/
├── alacritty/     # Configurações do Alacritty
├── ghostty/       # Configurações do Ghostty
├── hypr/          # Configurações do Hyprland
├── nvim/          # Configurações do Neovim
├── waybar/        # Configurações do Waybar
├── .gitignore     # Arquivo de configuração do git
├── README.md      # Este arquivo
├── bashrc         # Configurações do Bash
├── install.sh     # Script de instalação
└── uninstall.sh   # Script de desinstalação
```

## 🔄 Como funciona

```
install.sh
├── Faz backup das configs existentes → ~/.dotfiles_backup/YYYYMMDD_HHMMSS/
├── Cria symlinks para cada config
└── Aplica o tema vantablack

uninstall.sh
├── Lista backups disponíveis
├── Remove os symlinks
├── Restaura o backup escolhido (ou roda boot do Omarchy)
└── Volta ao estado do backup escolhido (ou ao estado original)
```

## 🎨 Theme

```
omarchy-theme-install https://github.com/Luquatic/omarchy-catppuccin-glass
```

## 🖼️ Wallpapers 
[Click here](/wallpapers)
