.DEFAULT_GOAL := all

profile:
	chmod 644 ./etc/profile.d/*
	cp -u ./etc/profile.d/* /etc/profile.d/
	chown -R root:root /etc/profile.d/

powerline:
	find ./etc/powerline/ -type f -exec chmod 644 \{} \;
	find ./etc/powerline/ -type d -exec chmod 755 \{} \;
	cp -ru ./etc/powerline/ /etc/
	chown -R root:root /etc/powerline/
	mkdir -p ~/.config/
	ln -s /etc/powerline/ ~/.config/powerline/

all: profile powerline
