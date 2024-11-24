# Debian Development Environment

基于 Debian 11 (Bullseye) 的轻量级开发环境。

## 环境特性

### 基础环境
- Oh My Zsh (默认主题)
- Git 配置
- 基础开发工具

### Python 开发环境
- Python 3.11.8 (通过 pyenv 管理)
- pip (配置清华镜像源)
- 基础工具：pipenv、ipython

### NodeJS 开发环境
- Node.js 18 LTS (通过 nvm 管理)
- npm (配置淘宝镜像源)
- pnpm 包管理器
- npm-check-updates

### Docker 容器环境
- Docker Engine
- Docker Compose
- 基础日志配置

## 系统要求

- VirtualBox 6.1+
- Vagrant 2.2+
- 硬件要求：
  - CPU：4核心
  - 内存：4GB RAM
  - 磁盘：30GB 可用空间
- 网络：需要互联网连接

## 快速开始

1. 克隆仓库
2. 配置 Vagrantfile 中的共享文件夹和 SSH 密钥路径
3. 运行 `vagrant up`

## 环境配置

- IP: 10.0.0.30
- 内存: 4GB
- CPU: 4核
- 磁盘: 30GB

## 注意事项

1. 确保 SSH 密钥文件存在且权限正确
2. 共享文件夹路径必须存在
3. 需要设置 VAGRANT_EXPERIMENTAL="disks" 环境变量

## 扩展安装

如需安装数据科学、Web开发等额外工具，请参考 docs/extensions.md