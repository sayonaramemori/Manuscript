## 1. WSL Basics and UI configuration  

### 1.1 WSL 常用操作  
```shell
wsl -l -v                 # 列出已安装的Linux发行版及其状态
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

## 2. Mihomo  

- [Github Page](https://github.com/MetaCubeX/mihomo/tree/v1.18.10)  
- [Release Page](https://github.com/MetaCubeX/mihomo/releases/tag/v1.18.10)  
- [Wiki Page](https://wiki.metacubex.one/startup/service/)  


### 2.1 安装和配置  
1. Download the installer, with [Github Proxy](https://ghp.ci/).  
```shell
# Using Github proxy ,here is https://ghp.ci
# My cpu architecture is x86_64. Choose your version.

curl -L https://ghp.ci/https://github.com/MetaCubeX/mihomo/releases/download/v1.18.10/mihomo-linux-amd64-compatible-go120-v1.18.10.deb -o mihomo.deb  &&
sudo apt install ./mihomo.deb
```
2. 在 Windows 中打开配置目录，复制 `clash-verge.yaml` and `Country.mmdb` 到 `/etc/mihomo`  
```shell
# You could choose other elegant way to achieve file transfermation.
# For cloud-server, I use sftp here
# cd [YOUR_WINDOWS_CONFIG_DIR]
sftp user@host
put clash-verge.yaml
put Country.mmdb
bye

# For wsl, just manually copy them
explorer.exe .

# Back to Linux
sudo mv ~/Country.mmdb /etc/mihomo/ && sudo mv ~/clash-verge.yaml /etc/mihomo/config.yaml  && sudo vim /etc/mihomo/config.yaml

# before
external-controller: 127.0.0.1:9097
# after
external-controller: 0.0.0.0:9097
```

3. Do Test  
```
# Port is set in config.yaml with configuration item -- port.

sudo systemctl start mihomo &&
curl -i google.com --proxy http://127.0.0.1:7899

# If failing, try below and inspect the log
# journalctl -u mihomo
```

### 2.2 配置 Web 仪表盘  
> To select node freely with Web-GUI.  
```shell
# Caution: Github proxy also used here
# Insert the three lines into config.yaml
# Access via http://{{external-controller}}/ui in browser
# The IP of your host is needed for accessment.
# Do remember set secret for security.

sudo cat << 'EOF' > /etc/mihomo/temp.yaml
external-ui: /etc/mihomo/ui
external-ui-name: my-ui
external-ui-url: "https://ghp.ci/https://github.com/MetaCubeX/metacubexd/archive/refs/heads/gh-pages.zip"
EOF
sudo cat /etc/mihomo/config.yaml >> /etc/mihomo/temp.yaml  &&
sudo mv /etc/mihomo/temp.yaml /etc/mihomo/config.yaml  &&
sudo mkdir /etc/mihomo/ui -p &&
sudo systemctl restart mihomo &&
sudo apt update &&
sudo apt install net-tools &&
ifconfig | grep inet
```

> Test whether web-GUI works fine. Access via http://IP:9097/ui
```
# My port is 7899 here 
# You should see some information of the node you just have selected

clear

cat << 'EOF' > ~/test_dashboard.sh
#!/bin/bash
curl -i google.com --proxy http://127.0.0.1:7899
curl -i youtube.com --proxy http://127.0.0.1:7899
curl -i baidu.com --proxy http://127.0.0.1:7899
journalctl -u mihomo | tail -n 3
EOF

chmod +x ~/test_dashboard.sh &&
bash ~/test_dashboard.sh &&
rm ~/test_dashboard.sh
```


## 3. Neovim  
> [Github Page](https://github.com/neovim/neovim/blob/master/INSTALL.md)  

> 首先运行如下指令  
```shell
export http_proxy=http://127.0.0.1:7899 && export https_proxy=$http_proxy
```


### 3.1 安装 Neovim  
> [Github home page](https://github.com/neovim/neovim/blob/master/INSTALL.md)  

> 安装后 **执行** `export PATH=$PATH:/opt/nvim-linux64/bin && source ~/.bashrc`  
```shell
curl -LO --proxy http://127.0.0.1:7899 https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz &&
sudo rm -rf /opt/nvim  &&
sudo tar -C /opt -xzf nvim-linux64.tar.gz
```

### 3.2 配置 Neovim  
> 这里套用个人配置，可自行搜索Neovim相关配置 :D  
>> 推荐配置： [LunarVim](https://github.com/LunarVim/LunarVim)  
```
git clone https://github.com/sayonaramemori/Manuscript.git  &&
cd Manuscript && cd nvim &&
mkdir ~/.config/nvim -p &&
cp ./init.lua ~/.config/nvim/init.lua &&
cp -r ./lua ~/.config/nvim/ &&
echo "Done! Using nvim to start editing"
```


## 4. Yazi  
> [Official Docs](https://yazi-rs.github.io/docs/installation)  

### 4.1 安装 Yazi  
> [Release Page](https://github.com/sxyazi/yazi/releases)  
```shell
# 通过 Official release 安装
cd ~/Manuscript/yazi &&
curl -L --proxy http://127.0.0.1:7899 https://github.com/sxyazi/yazi/releases/download/v0.3.3/yazi-x86_64-unknown-linux-musl.zip -o yazi.zip  &&
sudo apt install unzip  &&
unzip yazi.zip  &&
cd yazi-x86_64-unknown-linux-musl  &&
sudo mv ./yazi /usr/bin/  &&
sudo mv ./ya /usr/bin/
```


### 4.2 Shell Wrapper  
> Provides the ability to change the current working directory when exiting Yazi.
>> Use `ra` to invoke Yazi.  
>> **Run** `source ~/.bashrc` after operation  
```shell
# For bash or zsh

cat << 'EOF' >> ~/.bashrc
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
> There are three configuration files for Yazi.  
- `yazi.toml`  
- `keymap.toml`  
- `theme.toml`  
> For Unix-like system, they should be placed at `~/.config/yazi/`  
> For Windows, `C:\Users\Username\AppData\Roming\yazi\config\` is the right place.  

```
mkdir ~/.config/yazi -p &&
cd ~/Manuscript/yazi    &&
cp ./* ~/.config/yazi/  &&
ya pack -a h-hg/yamb    &&
ya pack -a yazi-rs/plugins:full-border
```

#### 指定 Neovim 为编辑器  
> For windows, environment variable `YAZI_FILE_ONE` for file is needed. 
>> For example `YAZI_FILE_ONE=C:\Program Files\Git\usr\bin\file.exe`  
```toml
# In yazi.toml  

[opener]
edit = [
	{ run = "nvim %*",  block = true, desc = "nvim", for = "windows" },
]
```

### 4.4 Plugins  
> [Awesome Plugins](https://yazi-rs.github.io/docs/resources)  


#### BookMarks  
> Use [yamb.yazi](https://github.com/h-hg/yamb.yazi)  
```shell
# Install plugin via this cmd
ya pack -a h-hg/yamb
```

```lua
-- create init.lua to the directory holds yazi.toml and add this below
-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
if ya.target_family() == "windows" then
  table.insert(bookmarks, {
    tag = "Scoop Local",
    
    path = (os.getenv("SCOOP") or home_path .. "\\scoop") .. "\\",
    key = "p"
  })
  table.insert(bookmarks, {
    tag = "Scoop Global",
    path = (os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop") .. "\\",
    key = "P"
  })
end
table.insert(bookmarks, {
  tag = "Desktop",
  path = home_path .. path_sep .. "Desktop" .. path_sep,
  key = "d"
})

require("yamb"):setup {
  -- Optional, the path ending with path seperator represents folder.
  bookmarks = bookmarks,
  -- Optional, recieve notification everytime you jump.
  jump_notify = true,
  -- Optional, the cli of fzf.
  cli = "fzf",
  -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- Optional, the path of bookmarks
  path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark") or
        (os.getenv("HOME") .. "/.config/yazi/bookmark"),
}

```
Add this to your `keymap.toml`  
```toml
[[manager.prepend_keymap]]
on = [ "b", "a" ]
run = "plugin yamb --args=save"
desc = "Add bookmark"

[[manager.prepend_keymap]]
on = [ "b", "g" ]
run = "plugin yamb --args=jump_by_key"
desc = "Jump bookmark by key"

[[manager.prepend_keymap]]
on = [ "b", "G" ]
run = "plugin yamb --args=jump_by_fzf"
desc = "Jump bookmark by fzf"

[[manager.prepend_keymap]]
on = [ "b", "d" ]
run = "plugin yamb --args=delete_by_key"
desc = "Delete bookmark by key"

[[manager.prepend_keymap]]
on = [ "b", "D" ]
run = "plugin yamb --args=delete_by_fzf"
desc = "Delete bookmark by fzf"

[[manager.prepend_keymap]]
on = [ "b", "A" ]
run = "plugin yamb --args=delete_all"
desc = "Delete all bookmarks"

[[manager.prepend_keymap]]
on = [ "b", "r" ]
run = "plugin yamb --args=rename_by_key"
desc = "Rename bookmark by key"

[[manager.prepend_keymap]]
on = [ "b", "R" ]
run = "plugin yamb --args=rename_by_fzf"
desc = "Rename bookmark by fzf"
```

#### Full Border  
```shell
ya pack -a yazi-rs/plugins:full-border

# Copu to your init.lua  
require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}
```

