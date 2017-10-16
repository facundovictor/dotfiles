.DEFAULT_GOAL := all

profile:
	cp -u ./etc/profile.d/* /etc/profile.d/

powerline:
	cp -ru ./etc/powerline/ /etc/

all: profile powerline
