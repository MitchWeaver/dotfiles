DOTS_DIR = ${HOME}/Documents/src/dots

all:
	@>&2 echo "Use 'make install'."

install:
	ln -sf ${DOTS_DIR}/.Xresources ${HOME}/.Xresources
	ln -sf ${DOTS_DIR}/.xinitrc ${HOME}/.xinitrc
	ln -sf ${DOTS_DIR}/.xinitrc ${HOME}/.xsessionrc
	ln -sf ${DOTS_DIR}/.profile    ${HOME}/.profile
	ln -sf ${DOTS_DIR}/.shellrc ${HOME}/.bashrc
	ln -sf ${DOTS_DIR}/.shellrc ${HOME}/.kshrc
	xrdb load ${HOME}/.Xresources
	mkdir -p ${HOME}/.config/nvim
	ln -sf ${DOTS_DIR}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim
	ln -sf ${DOTS_DIR}/.vimrc ${HOME}/.vimrc
	ln -sf ${DOTS_DIR}/.xmodmaprc ${HOME}/.xmodmaprc
	mkdir -p ${HOME}/.config/mpv
	ln -sf ${DOTS_DIR}/.config/mpv/mpv.conf ${HOME}/.config/mpv/mpv.conf
	mkdir -p ${HOME}/.config/cava
	ln -sf ${DOTS_DIR}/.config/cava/cava.conf ${HOME}/.config/cava/cava.conf
	mkdir -p ${HOME}/.config/ranger
	ln -sf ${DOTS_DIR}/.config/ranger/scope.sh ${HOME}/.config/ranger/scope.sh
	ln -sf ${DOTS_DIR}/.config/ranger/rifle.conf ${HOME}/.config/ranger/rifle.conf
	ln -sf ${DOTS_DIR}/.config/ranger/rc.conf ${HOME}/.config/ranger/rc.conf
	ln -sf ${DOTS_DIR}/.gitconfig ${HOME}/.gitconfig
	ln -sf ${DOTS_DIR}/.config/autostart ${HOME}/.config/autostart
	mkdir -p ${HOME}/.config/alacritty
	ln -sf ${DOTS_DIR}/.config/alacritty/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml