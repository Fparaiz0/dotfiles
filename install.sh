#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error()   { echo -e "${RED}❌ $1${NC}"; }

if [ ! -d "$HOME/.config" ]; then
    mkdir -p "$HOME/.config"
    log_success "Diretório ~/.config criado"
fi

create_link() {
    local source="$1"
    local target="$2"

    if [ ! -e "$source" ]; then
        log_warning "Fonte não encontrada: $source (pulando...)"
        return 1
    fi

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
        log_warning "Backup criado: $target → $BACKUP_DIR/"
    fi

    if ln -sfn "$source" "$target"; then
        log_success "Link criado: $target → $source"
    else
        log_error "Falha ao criar link: $target"
        return 1
    fi
}

echo ""
echo "🔧 Instalando dotfiles de: $DOTFILES_DIR"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

ERRORS=0

create_link "$DOTFILES_DIR/hypr"      "$HOME/.config/hypr"      || ((ERRORS++))
create_link "$DOTFILES_DIR/waybar"    "$HOME/.config/waybar"    || ((ERRORS++))
create_link "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty" || ((ERRORS++))
create_link "$DOTFILES_DIR/nvim"      "$HOME/.config/nvim"      || ((ERRORS++))
create_link "$DOTFILES_DIR/ghostty"   "$HOME/.config/ghostty"   || ((ERRORS++))

create_link "$DOTFILES_DIR/bashrc"    "$HOME/.bashrc"           || ((ERRORS++))

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ "$ERRORS" -eq 0 ]; then
    log_success "Todos os dotfiles instalados com sucesso!"
else
    log_warning "$ERRORS item(ns) pulado(s) ou com falha. Verifique as mensagens acima."
fi

if [ -d "$BACKUP_DIR" ]; then
    echo ""
    log_warning "Backups salvos em: $BACKUP_DIR"
fi

echo ""