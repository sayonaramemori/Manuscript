## 1. WSL Basics and UI configuration  
# Configuration for repository 1

### 1.1 WSL 常用操作  
```shell
sl -l -v                 # 列出已安装的Linux发行版及其状态
wsl -t <Distro>           # 停止指定的Linux发行版
wsl --unregister <Distro> # 移除指定的Linux发行版

# 保存快照.tar
wsl --export <Distro> <FileName>
# 加载快照
wsl --import <Distro> <InstallLocation> <FileName>
```

### 1.2 安装 Nerdfont 字体
- [Download Nerdfont](https://www.nerdfonts.com/font-downloads)


### 1.3 配置终端样式  
> 点击下拉框打开设置  
1. 在 **操作** 选项中为 **切换专注模式** 添加快捷键  
2. 点击要配置的终端选项卡, 进入 **外观设置** ,将字体设置为下载的 **NerdFont**  
3. 依个人喜好设置 **配色方案** ，**背景图像** 和 **透明度** 等

### 1.4 Ubuntu Prerequisite  
```
sudo apt update && sudo apt install -y net-tools gcc g++ unzip make

sudo apt search '^python3.[0-9]+.*-venv$'
```

## 2. Mihomo  

- [Github Page](https://github.com/MetaCubeX/mihomo/tree/v1.18.10)  
- [Release Page](https://github.com/MetaCubeX/mihomo/releases/tag/v1.18.10)  
- [Wiki Page](https://wiki.metacubex.one/startup/service/)  


### 2.1 安装和配置  

#### 2.1.1 Installation  
- Download the installer, with [Github Proxy](https://ghp.ci/).  
```shell
# Using Github proxy ,here is https://ghp.ci
# Please check whether the Github Proxy is still accessible.

curl -L https://ghp.ci/https://github.com/MetaCubeX/mihomo/releases/download/v1.18.10/mihomo-linux-amd64-compatible-go120-v1.18.10.deb -o mihomo.deb  &&
sudo apt install ./mihomo.deb
```
#### 2.1.2 Configuration  
1. 方式一：Windows 中打开配置目录，复制 `clash-verge.yaml` and `Country.mmdb` 到 `/etc/mihomo`  
```shell
# For wsl, just manually copy them
explorer.exe .

# Back to Linux
sudo mv ~/Country.mmdb /etc/mihomo/ && 
sudo mv ~/clash-verge.yaml /etc/mihomo/config.yaml  && 
sudo vim /etc/mihomo/config.yaml

# before
external-controller: 127.0.0.1:9097
# after
external-controller: 0.0.0.0:9097
```
2. 方式二：复制基础配置`config.yaml`，并将订阅链接填入  
```shell
# Download the base config
wget https://ghp.ci/https://github.com/sayonaramemori/Manuscript/blob/main/config.yaml &&
sudo cp ./config.yaml /etc/mihomo/config.yaml

wget https://ghp.ci/https://github.com/mikefarah/yq/releases/download/v4.44.5/yq_linux_amd64 -o yq &&
sudo chmod +x yq &&
sudo mv yq /usr/bin/yq

sudo systemctl start mihomo
cd /etc/mihomo/
yq ea '. as $item ireduce ({}; . * $item )' ./proxies/TARGET config.yaml > config.yaml
sudo systemctl restart mihomo
```

#### 2.1.3 Do Test  
```
# Port is set in config.yaml with configuration item -- port. In this example, port is 7899

sudo systemctl start mihomo
sleep 1
curl -i google.com --proxy http://127.0.0.1:7899

# If failing, try below and inspect the log
journalctl -u mihomo | tail
```

### 2.2 配置 Web 仪表盘  
> 只有方案一需要配置，方案二已自动配置  
```shell
# Caution: Github proxy also used here
# Insert the three lines into config.yaml
# Access via http://{{external-controller}}/ui in browser
# The IP of your host is needed for accessment.
# Add port 9097 to your security-group if you are using cloud-server and check your fire-wall
# Do remember set secret for security.

sudo cat << 'EOF' > /etc/mihomo/temp.yaml
proxy-providers:
  kuajing:
    type: http
    interval: 1800
    proxy: DIRECT
    url: "[YOU_SUBSCRIPTION_URL]"
global-ua: clash.meta
geodata-mode: false
geodate-loader: standard
geo-auto-update: true
geo-update-interval: 48
geox-url:
  geosite: "https://mirror.ghproxy.com/https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.dat"
  mmdb: "https://mirror.ghproxy.com/https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geoip-lite.metadb"
  geoip: "https://mirror.ghproxy.com/https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geoip-lite.dat"
  asn: "https://mirror.ghproxy.com/https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/GeoLite2-ASN.mmdb"
external-ui: /etc/mihomo/ui
external-ui-name: my-ui
external-ui-url: "https://ghp.ci/https://github.com/MetaCubeX/metacubexd/archive/refs/heads/gh-pages.zip"
EOF

sudo cat /etc/mihomo/config.yaml >> /etc/mihomo/temp.yaml  &&
sudo mv /etc/mihomo/temp.yaml /etc/mihomo/config.yaml  &&
sudo mkdir /etc/mihomo/ui -p &&
sudo systemctl restart mihomo &&
ip=`ifconfig | grep inet | grep -v 127.0.0.1 | grep -v inet6 | awk '{print$2}'`
echo "DashBoard-Url: http://${ip}:9097/ui"
```

> Test whether web-GUI works fine. Access via http://IP:9097/ui
```
cat << 'EOF' > ~/test_dashboard.sh
#!/bin/bash
curl -i google.com --proxy http://127.0.0.1:7899
curl -i youtube.com --proxy http://127.0.0.1:7899
journalctl -u mihomo | tail -n 2
EOF
chmod +x ~/test_dashboard.sh &&
bash ~/test_dashboard.sh &&
rm ~/test_dashboard.sh
```


## 3. Neovim  
- [Github Page](https://github.com/neovim/neovim/blob/master/INSTALL.md)  
- Plugin Markdown-Preview Needs [Nodejs](https://nodejs.org/en/download/package-manager)  

> 首先运行如下指令  
```shell
export http_proxy=http://127.0.0.1:7899 && export https_proxy=$http_proxy
```


### 3.1 安装 Neovim  
```shell
curl -LO --proxy http://127.0.0.1:7899 https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz &&
sudo rm -rf /opt/nvim  &&
sudo tar -C /opt -xzf nvim-linux64.tar.gz &&
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim &&
sudo rm -rf ./nvim-linux64.tar.gz -
```

### 3.2 配置 Neovim  
- 这里套用个人配置，可自行搜索Neovim相关配置 :D  
- 推荐配置： [LunarVim](https://github.com/LunarVim/LunarVim)  
- Create link for root : `sudo mkdir /root/.config -p && sudo ln -s /home/{USER_NAME}/.config/nvim /root/.config/nvim`
```
git clone https://github.com/sayonaramemori/Manuscript.git  &&
cd Manuscript && cd nvim &&
mkdir ~/.config/nvim -p &&
cp ./init.lua ~/.config/nvim/init.lua &&
cp -r ./lua ~/.config/nvim/ &&
echo "Done! Using nvim to start editing"
```

## 4. Yazi  
- [Official Docs](https://yazi-rs.github.io/docs/installation)  
- [Release Page](https://github.com/sxyazi/yazi/releases)  

### 4.1 安装 Yazi  
```shell
# 通过 Official release 安装
curl -L --proxy http://127.0.0.1:7899 https://github.com/sxyazi/yazi/releases/download/v0.3.3/yazi-x86_64-unknown-linux-musl.zip -o yazi.zip  &&
unzip yazi.zip  &&
cd yazi-x86_64-unknown-linux-musl  &&
sudo mv ./yazi /usr/bin/  &&
sudo mv ./ya /usr/bin/
```


### 4.2 Shell Wrapper  
> Provides the ability to change the current working directory when exiting Yazi.  

-  Use `ra` to invoke Yazi.  
-  **Run** `. ~/.profile` after operation  
```shell
cat << 'EOF' >> ~/.profile
function ra() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
EOF
```

```cmd
# For windows, Create the file ra.cmd and place it in your %PATH%.
# For Command Prompt

@echo off
set tmpfile=%TEMP%\yazi-cwd.%random%
yazi %* --cwd-file="%tmpfile%"
set /p cwd=<"%tmpfile%"
if not "%cwd%"=="" (
    cd /d "%cwd%"
)
del "%tmpfile%"
```


### 4.3 Configuration  
> 这里套用个人配置，详细配置可前往[官网](https://yazi-rs.github.io/docs/installation)查看  

- For Unix-like system, they should be placed at `~/.config/yazi/`  
- For Windows, `C:\Users\Username\AppData\Roming\yazi\config\` is the right place.  

```
mkdir ~/.config/yazi -p &&
cd ~/Manuscript/yazi    &&
cp -r ./* ~/.config/yazi/  &&
ya pack -a h-hg/yamb    &&
ya pack -a yazi-rs/plugins:full-border
```

> 指定 Neovim 为编辑器  
- For windows, environment variable `YAZI_FILE_ONE` for file is needed. 
- For example `YAZI_FILE_ONE=C:\Program Files\Git\usr\bin\file.exe`  
```toml
[opener]
edit = [ { run = "nvim %*",  block = true, desc = "nvim", for = "windows" }, ]
```

### 4.4 Plugins  
- [Awesome Plugins](https://yazi-rs.github.io/docs/resources)  
    1. BookMarks - [yamb.yazi](https://github.com/h-hg/yamb.yazi)  
    2. Border - [full-border](https://github.com/yazi-rs/plugins/tree/main/full-border.yazi)  

## 5. Oh My Zsh  

### 5.1 Installation  
```
sudo apt install zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 5.2 Configuration  
> Plugin Installation  
```
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

> Modify your `.zshrc`, be careful of the order  
```
plugins=(
  git zsh-autosuggestions zsh-syntax-highlighting copypath
)
ZSH_THEME="powerlevel10k/powerlevel10k"

# For yazi
. ~/.profile
```

## 6. 杂项  

### 6.1 安装 Docker
- [Docker Docs](https://docs.docker.com/get-started/)  
```shell
#!/bin/bash

# Set proxy variables
HTTP_PROXY="http://127.0.0.1:7899/"
HTTPS_PROXY=$HTTP_PROXY

# Step 1: Configure apt to use the proxy
echo "Configuring apt to use proxy..."
sudo sh -c "echo 'Acquire::http::Proxy \"$HTTP_PROXY\";' > /etc/apt/apt.conf.d/01proxy"
sudo sh -c "echo 'Acquire::https::Proxy \"$HTTPS_PROXY\";' >> /etc/apt/apt.conf.d/01proxy"

# Step 2: Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc --proxy "$HTTP_PROXY"
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Step 3: Add the Docker repository to apt sources
echo "Adding Docker repository to apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

      # Step 4: Install Docker
      echo "Installing Docker..."
      sudo apt-get update
	  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

      # Step 5: Configure Docker to use the proxy
      echo "Configuring Docker to use proxy..."
      sudo mkdir -p /etc/systemd/system/docker.service.d
      sudo sh -c "echo '[Service]\nEnvironment=\"HTTP_PROXY=$HTTP_PROXY\"\nEnvironment=\"HTTPS_PROXY=$HTTPS_PROXY\"\nEnvironment=\"NO_PROXY=localhost,127.0.0.1\"' > /etc/systemd/system/docker.service.d/http-proxy.conf"

      # Step 6: Reload systemd and restart Docker
      echo "Reloading systemd and restarting Docker..."
      sudo systemctl daemon-reload &&
      sudo systemctl restart docker

      # Step 7: Test Docker installation by pulling an image
      echo "Testing Docker installation by pulling the hello-world image..."
      docker pull hello-world
      # docker pull teddysun/v2ray

      # Step 8: Clear apt proxy configuration
      echo "Clearing apt proxy configuration..."
      sudo rm /etc/apt/apt.conf.d/01proxy

      # Step 9: Clear Docker proxy configuration
      echo "Clearing Docker proxy configuration..."
      sudo rm /etc/systemd/system/docker.service.d/http-proxy.conf
      sudo systemctl daemon-reload &&
      sudo systemctl restart docker

      sudo docker run --rm --name ciallo hello-world
```

### 6.2 安装 NodeJs  
- [Nodejs Installation Page](https://nodejs.org/en/download/package-manager)  

### 6.3 安装 Cmake  
- [Cmake](https://cmake.org/download/)  

### 6.4 安装 Anaconda  
- Select your version from the [Distribution Page](https://repo.anaconda.com/archive/).  

### 6.5 安装 rust
- `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`  



