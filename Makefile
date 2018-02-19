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

ctop:
	mkdir -p /opt/ctop/
	if [ ! -e /opt/ctop/ctop ] ; then \
		wget https://github.com/bcicen/ctop/releases/download/v0.6.1/ctop-0.6.1-linux-amd64 -O /opt/ctop/ctop; \
		chmod u+x /opt/ctop/ctop; \
	fi

encryption:
	dnf install openssl

expect:
	# A program-script interaction and testing utility (includes unbuffer)
	dnf install expect

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


all: _ensure_base langs ag ripgrep powerline virtualenvwrapper ctop tmuxp vim profile
