SHELL:=/bin/bash

all: apps bash neovim fonts mpv git i3 twitch tmux desktop-files lombok

apps:
	sudo apt install -y \
			 nload \
			 tmux \
			 pandoc \
			 texlive-xetex \
			 jq \
			 clangd-9 \
			 clang-format \
			 acpi \
			 git-lfs \
			 xfce4-terminal \
			 fd-find \
			 silversearcher-ag \
			 nmap \
			 stow \
			 curl \
			 mpv \
			 python3-venv \
			 python3-pip && \
	sudo ln -s /usr/bin/fdfind /usr/bin/fd || true && \
	sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100

kwin:
	stow -R -v kwin -t ~/

kitty:
	sudo apt install kitty -y && \
	stow -R -v kitty -t ~/

nodejs:
	sudo rm /etc/apt/sources.list.d/nodesource.list* && \
	curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash - && \
	sudo apt install nodejs -y

language-server: nodejs
	npm config set prefix ~/.local && \
	npm cache clean --force && \
	npm install -g \
		typescript \
		typescript-language-server \
		vls \
		lua-fmt \
		prettier \
		@prettier/plugin-xml \
		vscode-json-languageserver \
		bash-language-server \
		yaml-language-server && \
	pip3 install python-language-server black isort docformatter pyflakes && \
	wget -O ~/.local/bin/shfmt 'https://github.com/mvdan/sh/releases/download/v3.2.0/shfmt_v3.2.0_linux_amd64' && \
	chmod +x ~/.local/bin/shfmt

desktop-files:
	mkdir ~/.local/share/applications/ && \
	stow -R -v desktop-files/ -t ~/.local/share/applications/

xfce4-terminal:
	stow -S xfce4-terminal

golang:
	wget -O ~/Downloads/golang.tar.gz https://golang.org/dl/go1.15.5.linux-amd64.tar.gz && \
	sudo tar -C /usr/local -xzf ~/Downloads/golang.tar.gz && \
	rm ~/Downloads/golang.tar.gz

neovim-source:
	./neovim/build.sh 

neovim: apps language-server vsnip nodejs
	./neovim/install.sh && \
	mkdir -p ~/.config/nvim && \
	stow -R -v neovim -t ~/.config/nvim && \
	pip3 install pynvim && \
	nvim -c 'PlugInstall'

fonts:
	rm -rf ~/.fonts && \
	stow -R -v fonts -t ~/ && \
	fc-cache -fv

xfce-themes:
	mkdir -p ~/.themes/temp && \
	mkdir -p ~/.themes/temp2 && \
	git clone https://github.com/addy-dclxvi/xfwm4-theme-collections.git ~/.themes/temp && \
	git clone https://github.com/addy-dclxvi/gtk-theme-collections.git ~/.themes/temp2 && \
	mv ~/.themes/temp/* ~/.themes/ && \
	mv ~/.themes/temp2/* ~/.themes/ && \
	rm -rf ~/.themes/temp ~/.themes/temp2

bash:
	rm ~/.bash* ~/.profile ~/.inputrc || true && \
	stow -R -v bash -t ~/ && \
	source ~/.bashrc

mpv:
	stow -R -v mpv -t ~/

git:
	stow -R -v git -t ~/

i3:
	rm -rf ~/.config/i3 && \
	stow -R -v i3 -t ~/

tmux: apps
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
	stow -S tmux

vsnip:
	stow -v -S vsnip

twitch: apps
	pip3 install --user -U streamlink && \
	stow -R -v twitch -t ~/

intellij:
	wget -nc -O '/tmp/intellij.tar.gz' 'https://download.jetbrains.com/idea/ideaIC-2020.2.3.tar.gz' ; \
	mkdir /tmp/intellij/ && \
	tar xvf /tmp/intellij.tar.gz -C /tmp/intellij/ && \
	mv /tmp/intellij/idea* ~/idea/

lombok: 
	wget 'https://projectlombok.org/downloads/lombok.jar' -O ~/.local/bin/lombok.jar

prolog:
	sudo add-apt-repository -y ppa:swi-prolog/stable && \
	sudo apt-get update && \
	sudo apt-get install swi-prolog -y && \
	swipl -g 'pack_install(lsp_server).' -t halt && \
	stow -R -v prolog -t ~/
