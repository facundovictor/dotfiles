.DEFAULT_GOAL := all

_ensure_base_git:
	dnf install git
	mkdir -p /etc/git/
	cp -u ./etc/git/.gitconfig /etc/git/.gitconfig
	chmod 644 /etc/git/.gitconfig
	if [ ! -e ~/.gitconfig ] ; then \
		ln -s /etc/git/.gitconfig ~/.gitconfig; \
	fi

_ensure_base_pip:
	dnf install python-pip
	pip install --upgrade pip

_ensure_base: _ensure_base_pip _ensure_base_git
	dnf install wget

ag:
	dnf install the_silver_searcher

ctags:
	dnf install ctags

ctop:
	mkdir -p /opt/ctop/
	if [ ! -e /opt/ctop/ctop ] ; then \
		wget https://github.com/bcicen/ctop/releases/download/v0.6.1/ctop-0.6.1-linux-amd64 -O /opt/ctop/ctop; \
		chmod u+x /opt/ctop/ctop; \
	fi

dockviz:
	mkdir -p /opt/dockviz/
	if [ ! -e /opt/dockviz/dockviz ] ; then \
		wget https://github.com/justone/dockviz/releases/download/v0.5.0/dockviz_linux_amd64 -O /opt/dockviz/dockviz; \
		chmod u+x /opt/dockviz/dockviz; \
	fi

encryption:
	dnf install openssl

expect:
	# A program-script interaction and testing utility (includes unbuffer)
	dnf install expect

moreutils:
	# Install unix utils
	dnf install moreutils

networking:
	dnf install openvpn openconnect

powerline:
	dnf install powerline powerline-fonts
	find ./etc/powerline/ -type f -exec chmod 644 \{} \;
	find ./etc/powerline/ -type d -exec chmod 755 \{} \;
	cp -ru ./etc/powerline/ /etc/
	chown -R root:root /etc/powerline/
	mkdir -p ~/.config/
	if [ ! -e ~/.config/powerline ] ; then \
		ln -s /etc/powerline/ ~/.config/powerline; \
	fi

profile:
	chmod 644 ./etc/profile.d/*
	cp -u ./etc/profile.d/* /etc/profile.d/
	chown -R root:root /etc/profile.d/

tfenv:
	mkdir -p /opt/tfenv/
	if [ ! -e /opt/tfenv/bin/tfenv ] ; then \
		wget https://github.com/tfutils/tfenv/archive/refs/tags/v2.2.2.tar.gz -O /opt/tfenv/tfenv.tar.gz; \
		tar --directory=/opt/tfenv/ -xvzf /opt/tfenv/tfenv.tar.gz; \
		mv /opt/tfenv/tfenv-2.2.2/* /opt/tfenv/; \
		chmod u+x /opt/tfenv/bin/tfenv; \
		mkdir -p /opt/tfenv/versions/;\
		chmod 777 /opt/tfenv/versions/;\
	fi

ripgrep:
	dnf copr enable carlwgeorge/ripgrep
	dnf install ripgrep

sensors:
	dnf install lm_sensors

langs:
	# https://github.com/koalaman/shellcheck
	dnf install ShellCheck

tmuxp:
	pip install tmuxp

vim:
	dnf install vim-X11

virtualenvwrapper:
	pip install virtualenvwrapper


all: _ensure_base encryption langs ag ripgrep powerline virtualenvwrapper ctags ctop tmuxp vim profile
