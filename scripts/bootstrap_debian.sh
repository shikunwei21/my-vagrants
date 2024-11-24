#!/bin/bash

# 严格模式
set -euo pipefail

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 日志函数
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查是否为root用户
check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "此脚本必须以root权限运行"
        exit 1
    fi
}

# 检查网络连接
check_network() {
    if ! ping -c 1 google.com &> /dev/null; then
        log_warn "无法连接到互联网，请检查网络设置"
        return 1
    fi
    return 0
}

# 更新系统包
update_system() {
    log_info "更新系统包列表..."
    apt-get update -y || {
        log_error "更新系统包列表失败"
        return 1
    }
}

# 安装包函数
apt_install() {
    local packages=("$@")
    for package in "${packages[@]}"; do
        log_info "正在安装 $package..."
        if ! DEBIAN_FRONTEND=noninteractive apt-get install -y "$package"; then
            log_error "安装 $package 失败"
            return 1
        fi
    done
    return 0
}

# 配置Git
setup_git() {
    log_info "配置 Git..."
    if ! command -v git &> /dev/null; then
        log_error "Git 未安装"
        return 1
    fi
    
    git config --global user.name "shikunwei"
    git config --global user.email "shikunwei.21@gmail.com"
    git config --global credential.helper store
    git config --global pull.ff only
    log_info "Git 配置完成"
}

# 配置 Oh My Zsh
setup_zsh() {
    log_info "配置 Oh My Zsh..."
    
    # 安装 Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # 切换默认shell为zsh
    chsh -s "$(which zsh)"

    # 只保留最常用的插件
    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    # 安装主题和插件
    local plugins=(
        "romkatv/powerlevel10k:themes/powerlevel10k"
        "zsh-users/zsh-autosuggestions:plugins/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting:plugins/zsh-syntax-highlighting"
        "agkozak/zsh-z:plugins/zsh-z"
    )

    for plugin in "${plugins[@]}"; do
        IFS=: read -r repo path <<< "${plugin}"
        local target="$ZSH_CUSTOM/$path"
        
        if [ ! -d "$target" ]; then
            log_info "安装 ${repo##*/}..."
            git clone --depth=1 "https://github.com/$repo.git" "$target"
        fi
    done

    # 配置 .zshrc
    local zshrc="$HOME/.zshrc"
    sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$zshrc"
    sed -i 's/^plugins=.*$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-z extract)/' "$zshrc"

    log_info "Oh My Zsh 配置完成"
}

# 清理系统
cleanup() {
    log_info "清理系统..."
    apt-get -y autoremove --purge
    apt-get -y clean
    log_info "清理完成"
}

# 主函数
main() {
    log_info "开始系统初始化配置..."
    
    check_root
    check_network || log_warn "继续执行，但可能会影响某些功能"
    
    # 更新系统
    update_system || exit 1
    
    # 安装基础包
    local base_packages=(
        "wget"
        "git"
        "curl"
        "vim"
        "net-tools"
        "gnupg"
        "zsh"
    )
    
    apt_install "${base_packages[@]}" || exit 1
    
    setup_git || log_warn "Git 配置失败"
    setup_zsh || log_warn "Zsh 配置失败"
    cleanup
    
    log_info "系统初始化配置完成！"
}

# 脚本入口
main "$@"