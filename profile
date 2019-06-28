umask 022

export PATH="$PATH:${HOME}/.local/bin:${HOME}/.local/pk/prefix/bin"
export PYTHONPATH="$PYTHONPATH:/home/mitch/.local/pk/prefix/lib/python2.7/site-packages:/tmp/bin/python2.7/site-packages"
export PYTHONPATH="$PYTHONPATH:/home/mitch/.local/pk/prefix/lib/python3.6/site-packages:/tmp/bin/python3.6/site-packages"
export PYTHONPATH="$PYTHONPATH:/home/mitch/.local/pk/prefix/lib/python3.7/site-packages:/tmp/bin/python3.6/site-packages"
export _JAVA_AWT_WM_NONREPARENTING=1

export LD_LIBRARY_PATH="/usr/lib32:$LD_LIBRARY_PATH"

p() { for i ; do export PATH="$i":$PATH ; done ; }

p /usr/{bin,sbin,local/bin,local/sbin,X11R6/bin,bin/rs} /bin /sbin \
   ${HOME}/{{bin,bin/local/bin,bin/chroots},usr/{bin,bin/ascii},.local/bin} \
   ${HOME}/bin/{file,mpv,misc,net,rice,text,util,wrapper,xorg}

#/opt/openjdk/bin

# commonly used programs stored in a tmpfs, copied in /etc/rc.local
if [ -d /tmp/bin ] ; then
    p /tmp/bin
    export SHELL=/tmp/bin/mksh
else
    p ${HOME}/usr/local/bin
fi

unset -f p

if [ "$(uname)" = "OpenBSD" ] ; then
    if [ -d /usr/local/jdk* ] ; then
        export PATH=$PATH:/usr/local/jdk-1.{$(jot -n \
            -s , 2 7)}.{$(jot -n -s , 10 0)}/bin
    fi
fi

# clear tmp
rm -rf ${HOME}/tmp 2> /dev/null && mkdir -p ${HOME}/tmp

[ -z "$SHELL" ] &&
    for i in mk k a ba da ; do
        [ -f /bin/${i}sh ] &&
            { export SHELL=/bin/${i}sh ; break ; }
    done

[ -d ${HOME}/etc ] &&
    case $SHELL in
        *ksh) export ENV=${HOME}/etc/kshrc ;;
        *) export ENV=${HOME}/etc/aliases
    esac

for i in nvim vim vis vi nano ; do
    type $i > /dev/null 2>&1 &&
        { export EDITOR=$i VISUAL=$i ; break ; }
done

for i in chromium chromium-browser google-chrome \
        google-chrome-stable firefox surf ; do
    if type $i > /dev/null 2>&1 ; then
        export BROWSER=$i
        break
    fi
done

ulimit -c 0 2> /dev/null

for i in LANG LANGUAGE LC_ALL LOCALE LC_CTYPE ; do
    export $i='en_US.UTF-8'
done
export LESSCHARSET='utf-8' \
    PYTHONIOENCODING='UTF-8' \
    LESS='-QRd' \
    MANPAGER='less' \
    "$(dbus-launch)"

export ALIASES=${HOME}/etc/aliases

type xdg-open > /dev/null 2>&1 &&
    export XDG_DESKTOP_DIR="/non/existent" \
           XDG_PUBLICSHARE_DIR="/non/existent" \
           XDG_CONFIG_HOME="${HOME}/etc/config" \
           XDG_DOCUMENTS_DIR="${HOME}/var/files" \
           XDG_DOWNLOAD_DIR="${HOME}/var/downloads" \
           XDG_MUSIC_DIR="${HOME}/var/music" \
           XDG_PICTURES_DIR="${HOME}/var/images" \
           XDG_VIDEOS_DIR="${HOME}/var/videos"

unset i

if ! pgrep X > /dev/null ; then
    rm -rf ${HOME}/.{Xauthority*,serverauth*}
    startx
fi > /dev/null 2>&1
