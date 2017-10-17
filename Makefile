.DEFAULT_GOAL := all

ag:
	dnf install the_silver_searcher

ctop:
	mkdir -p /opt/ctop/
	wget https://github.com/bcicen/ctop/releases/download/v0.6.1/ctop-0.6.1-linux-amd64 -O /opt/ctop/ctop
	chmod u+x /opt/ctop/ctop

profile:
	chmod 644 ./etc/profile.d/*
	cp -u ./etc/profile.d/* /etc/profile.d/
	chown -R root:root /etc/profile.d/

powerline:
	dnf install powerline powerline-fonts
	find ./etc/powerline/ -type f -exec chmod 644 \{} \;
	find ./etc/powerline/ -type d -exec chmod 755 \{} \;
	cp -ru ./etc/powerline/ /etc/
	chown -R root:root /etc/powerline/
	mkdir -p ~/.config/
	ln -s /etc/powerline/ ~/.config/powerline

all: profile ag powerline ctop
