#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error()   { echo -e "${RED}❌ $1${NC}"; }
log_info()    { echo -e "${BLUE}ℹ️  $1${NC}"; }

remove_link() {
    local target="$1"

    if [ -L "$target" ]; then
        rm "$target"
        log_success "Symlink removido: $target"
    else
        log_warning "Não é um symlink, pulando: $target"
    fi
}

restore_backup() {
    local target="$1"
    local name="$(basename "$target")"
    local chosen_backup="$2"

    if [ -e "$chosen_backup/$name" ]; then
        mv "$chosen_backup/$name" "$target"
        log_success "Backup restaurado: $target"
    else
        log_warning "Nenhum backup encontrado para: $target em $chosen_backup"
    fi
}

echo ""
echo "🗑️  Desinstalando dotfiles..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

TARGETS=(
    "$HOME/.config/hypr"
    "$HOME/.config/waybar"
    "$HOME/.config/alacritty"
    "$HOME/.config/nvim"
    "$HOME/.config/ghostty"
    "$HOME/.bashrc"
)

if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
    log_warning "Nenhum backup encontrado em: $BACKUP_DIR"
    echo ""
    echo "Deseja apenas remover os symlinks e rodar o boot do Omarchy? (s/n)"
    read -r REPLY
    if [[ "$REPLY" =~ ^[Ss]$ ]]; then
        for target in "${TARGETS[@]}"; do
            remove_link "$target"
        done
        bash "$HOME/.local/share/omarchy/boot.sh"
        exit 0
    else
        echo "Abortando..."
        exit 1
    fi
fi

echo "📦 Backups disponíveis:"
echo ""
mapfile -t BACKUPS < <(ls -td "$BACKUP_DIR"/*/ 2>/dev/null)

for i in "${!BACKUPS[@]}"; do
    local_date=$(basename "${BACKUPS[$i]}")
    echo "  [$((i+1))] $local_date"
done

echo ""
echo "Escolha um backup para restaurar (número) ou 0 para apenas remover os symlinks:"
read -r CHOICE

echo ""
echo "🔗 Removendo symlinks..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

ERRORS=0

for target in "${TARGETS[@]}"; do
    remove_link "$target" || ((ERRORS++))
done

if [ "$CHOICE" -gt 0 ] 2>/dev/null && [ "$CHOICE" -le "${#BACKUPS[@]}" ]; then
    CHOSEN_BACKUP="${BACKUPS[$((CHOICE-1))]}"
    log_info "Restaurando backup: $(basename "$CHOSEN_BACKUP")"

    echo ""
    echo "🔄 Restaurando backups..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    for target in "${TARGETS[@]}"; do
        restore_backup "$target" "$CHOSEN_BACKUP" || ((ERRORS++))
    done
else
    log_info "Nenhum backup selecionado. Rodando boot do Omarchy..."
    echo ""
    echo "🔁 Restaurando configs originais do Omarchy..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    if [ -f "$HOME/.local/share/omarchy/boot.sh" ]; then
        bash "$HOME/.local/share/omarchy/boot.sh"
        log_success "Omarchy restaurado!"
    else
        log_warning "boot.sh do Omarchy não encontrado."
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ "$ERRORS" -eq 0 ]; then
    log_success "Dotfiles desinstalados com sucesso!"
else
    log_warning "$ERRORS item(ns) com falha. Verifique as mensagens acima."
fi

echo ""