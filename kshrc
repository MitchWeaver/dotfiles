#!/bin/ksh
#
# http://github.com/mitchweaver/dots
#
# This thing is a mess... But I try to keep the beast at bay.
#
# Check out http://github.com/mitchweaver/bin for where
# more complicated stuff gets moved when it grows too unruly.
#
#  #             #
#  #   m   mmm   # mm    m mm   mmm
#  # m"   #   "  #"  #   #"  " #"  "
#  #"#     """m  #   #   #     #
#  #  "m  "mmm"  #   #   #     "#mm"
#

ulimit -c 0

set -o bgnice
set -o trackall
set -o csh-history
set -o vi

export HISTFILE=${HOME}/.cache/.ksh_history \
       HISTCONTROL=ignoreboth \
       HISTSIZE=500 \
       SAVEHIST=500

cd() { 
    if [ "$1" ] ; then
        builtin cd --  "$*"  ||
        builtin cd --  "$*"* ||
        builtin cd -- *"$*"  ||
        builtin cd -- *"$*"*
    else
        builtin cd -- ${HOME}
    fi 2>/dev/null
    if [ "$RANGER_LEVEL" ] ; then
        PS1="[ranger: $(_get_PS1)] "
    else
        PS1="$(_get_PS1)"
    fi
    export PS1
}

# get which git branch we're on, used in our PS1
_parse_branch() { 
    set -- $(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null)
    [ "$1" ] && echo -n " ($*)"
}

_get_PS1() {
    case "$TERM" in
        dumb)
            echo '% '
            ;;
        *)
            case ${USER} in
                mitch) echo -n "\[\e[1;35m\]m\[\e[0;32m\]i\[\e[0;33m\]t\[\e[0;34m\]c\[\e[1;31m\]h\[\e[1;36m\] \W$(_parse_branch)\[\e[1;37m\] " ;;
                root)  echo -n "\[\e[1;37m\]root \W " ;;
                *)     echo -n '% \W '
            esac
    esac
}

# check if we're in ranger
[ "$RANGER_LEVEL" ] && clear

# this activates our PS1
cd .

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
# begin generic aliases
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

# dynamic 'c' utility
c() {
    if [ -d "$1" ] ; then
        cd "$1"
    elif [ -f "$1" ] ; then
        cat -- "$1"
    else
        clear
    fi
}

case "$TERM" in
    dumb) alias ls='ls -F' ;;
       *) ls() { exa -F "$@" 2>/dev/null || command ls -F "$@" ; }
esac

# generic aliases
alias {cc,cll,clear,clar,clea,clera}=clear
alias {x,xx,xxx,q,qq,qqq,:q,:Q,:wq,:w,exi}=exit
alias {l,sls,sl}=ls
alias ll='l -l'
alias la='l -a'
alias {lla,lal}='l -al'
alias lsf='l "$PWD"/*'
alias {cls,csl,cl,lc}='c;l'
alias {e,ech,eho}=echo
alias {g,gr,gre,Grep,gerp,grpe}=grep
alias pgrpe=pgrep
alias dg='d | g -i'
alias lg='ls | g -i'
alias cp='cp -irv'
alias mv='mv -iv'
alias {mkdir,mkd,mkdr}='mkdir -p'
alias df='df -h'
alias bn=basename
alias date="command date '+%a %b %d - %I:%M %p'"
alias dmegs=dmesg
alias h='head -n 15'
alias t='tail -n 15'
alias tf='tail -f'
alias ex=export
alias cx='chmod +x'
alias {reboot,restart}='doas reboot'
alias chroot='doas chroot'
alias su='su -'
alias h1='head -n 1'
alias t1='tail -n 1'
alias cmd=command

# common program aliases
alias diff='diff -u'
alias less='less -QRd'
alias {rs,rsync}='rsync -rtvuh --progress --delete --partial' #-c
alias scp='scp -rp'
alias hme='htop -u ${USER}'
alias hroot='htop -u root'
alias w=which
alias py=python3.7
alias dm='dmesg | tail -n 20'
alias {feh,mpv}=opn
alias branch='git branch'

dl() { curl -q -L -C - -# --url "$1" --output "$(basename "$1")" ; }
alias wget=dl

# weather
alias weather='curl -s wttr.in/madison,sd?u0TQ'
alias forecast='curl -s http://wttr.in/madison,sd?u | \
   tail -n 33 | sed $\ d | sed $\ d'

alias jpg='find . -type f -name "*.jp*" -exec jpegoptim -s {} \;'

mkcd() { mkd "$_" && cd "$_" ; }
mvcd() { mv "$1" "$2" && cd "$2" ; }
cpcd() { cp "$1" "$2" && cd "$2" ; }

# openbsd
alias sg='sysctl | grep -i'
alias disks='sysctl -n hw.disknames'
alias poweroff='doas halt -p'
alias net='doas sh /etc/netstart $(interface)'
alias games='export PATH="/usr/games:$PATH"; echo "/usr/games added to your \$PATH"'

# make
alias {make,mak,mk}="make -j${NPROC:-1}"
alias {makec,makc,mkc}='make clean'
alias {makei,maki,mki}='make install'
alias {makeu,maku,mku}='make uninstall'

unalias r
r() { ranger "$@" ; c ; }

# quick fix ps1 if bugged out
ps1() { export PS1='% ' ; }

# search history for command: "history grep", no its not mercurial.
hg() { [ "$1" ] && grep -i "$*" $HISTFILE | grep -v '^hg' | head -n 20 ; }

cheat() { curl -s cheat.sh/$1 ; }

reload() {
    . ~/src/dots/kshrc
    xrdb load ~/src/dots/Xresources
    xmodmap ~/src/dots/Xmodmap
    xset m 0 0 
    xset b off 
    xset +fp ~/.fonts
    xset fp rehash
    fc-cache
    if pgrep -x sxhkd >/dev/null ; then
        pkill -x sxhkd
        sxhkd -c ~/src/dots/sxhkdrc &
    fi
} >/dev/null 2>&1

w3m() {
    [ "$1" ] || set https://duckduckgo.com/lite
    command w3m -F "$@"
}
alias wdump='w3m -dump'

ytdl() { 
    for i ; do
        youtube-dl -c -R 50 --geo-bypass --prefer-ffmpeg "$i"
    done
}
ytdlm() { 
    for i ; do
        youtube-dl -c -R 50 --geo-bypass --prefer-ffmpeg --extract-audio \
            --audio-quality 0 --audio-format mp3 --no-playlist "$i"
    done
}
ytdlpm() { 
    for i ; do
        youtube-dl -c -R 50 --geo-bypass --prefer-ffmpeg --extract-audio \
            --audio-quality 0 --audio-format mp3 "$i"
    done
}

alias getres='ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0'

# imagemagick
resize_75() { mogrify -resize '75%X75%' "$@" ; }
resize_50() { mogrify -resize '50%X50%' "$@" ; }
resize_25() { mogrify -resize '25%X25%' "$@" ; }
rotate_90() { convert -rotate 90 "$1" "$1" ; }
transparent() {
    #turns a PNG white background -> transparent
    convert "$1" -transparent white "${1%.*}"_transparent.png
}
png2jpg() {
    for i ; do
        [ -f "$i" ] || continue
        convert "$i" "${i%png}"jpg || exit 1
        jpegoptim -s "${i%png}"jpg || exit 1
        rm "$1"
    done
}

# translate-shell
alias trans='trans -no-auto -b "$@"'
# note: $1 needs to be language code, ex: 'de'
alias rtrans='command trans -from en -to'
alias rde='rtrans de'

# ----------------- movement commands -----------------------
alias {..,cd..}='cd ..'
alias ...='.. ; ..'
alias ....='.. ; ...'

# directory marking
# usage: 'm1' = mark 1
#        'g1' = return to m1
for i in 1 2 3 4 5 6 7 8 9 ; do
    eval "m${i}() { export _MARK${i}=\$PWD ; }"
    eval "g${i}() { cd \$_MARK${i} ; }"
done

_g() { _a=$1 ; shift ; cd $_a/"$*" ; ls ; }

alias gB="_g /bin"
alias gT="_g /tmp"
alias gM='_g /mnt'

alias gb="_g ~/bin"
alias ge="_g ~/env"
alias gt="_g ~/tmp"
alias gs="_g ~/src"
alias gf="_g ~/files"
alias gi="_g ~/images"
alias gm="_g ~/music"
alias gv="_g ~/videos"
alias gd="_g ~/Downloads"
alias gcf='_g ~/src/dots/config'
alias g_='_g ~/.trash'
alias gyt='_g ~/videos/youtube/completed'
alias gW='_g ~/images/wallpapers'
alias gV='_g /var'
alias gE='_g /etc'

mT() { mv "$@" /tmp  ; }
YT() { cp "$@" /tmp  ; }

Yf() { cp "$@" ~/files     ; }
Yd() { cp "$@" ~/Downloads ; }
Yi() { cp "$@" ~/images    ; }
Ym() { cp "$@" ~/music     ; }
Ys() { cp "$@" ~/src       ; }
Yvi(){ cp "$@" ~/videos    ; }
Yb() { cp "$@" ~/bin ; }
Yt() { cp "$@" ~/tmp ; }
Ye() { cp "$@" ~/env ; }
Y_() { cp "$@" ~/.trash ; }

mf() { mv "$@" ~/files     ; }
md() { mv "$@" ~/Downloads ; }
mi() { mv "$@" ~/images    ; }
mm() { mv "$@" ~/music     ; }
ms() { mv "$@" ~/src       ; }
mvi(){ mv "$@" ~/videos    ; }
mb() { mv "$@" ~/bin ; }
me() { mv "$@" ~/env ; }
mt() { mv "$@" ~/tmp ; }
m_() { mv "$@" ~/.trash ; }
mW() { mv "$@" ~/images/wallpapers ; }
alias trash=m_

alias lD='ls ~/Downloads'
alias lt='ls ~/tmp'
alias lT='ls /tmp'
alias l_='ls ~/.trash'

alias profile='v ~/src/dots/profile'
alias {vssh,sshv}='v ~/.ssh/config'

alias vimrc="v ~/src/dots/vimrc"
alias kshrc="v ~/src/dots/kshrc"
# ----------- end movement commands ------------------

gud() {
    # activate my PS1 git branch detection after
    # git commands
    command gud "$@" ; cd .
}

recomp() { P="$PWD" ; cd ~/src/suckless ; ./build.sh "$@" ; cd "$P" ; }
alias rcp=recomp

cover() { curl -q "$1" -o cover.jpg ; }
band()  { curl -q "$1" -o band.jpg  ; }
logo()  { curl -q "$1" -o logo.jpg  ; }

addyt() { ytdl-queue -a "$1" ; }
addtorrent() { torrent-queue -a "$1" ; }

sxiv() {
    [ "$1" ] || set .
    command sxiv -t "$1"
}

# net testing
ping() {
    [ "$1" ] || set eff.org
    command ping -L -n -s 1 -w 2 $@
}
pingd() { ping $(dns) ; }
pingpi() { ping $(grep -A 1 'Host pi' .ssh/config | grep -oE '[0-9]+.*') ; }
alias p=ping
alias pd=pingd
alias pp=pingpi
alias p8='ping 8.8.8.8'
alias cv='curl -v'
alias cvd='curl -v dns.watch'
alias cvg='curl -v google.com'

cw() { cat $(which $1) ; }

alias cmptn='pgrep -x compton ; compton --config ${HOME}/src/dots/compton.conf -b'

alias heart='printf "%b\n" "\xe2\x9d\xa4"'

alias hw='n -f ~/files/hw.txt'

# ----- old stuff I rarely use but still want to keep:------
# rgb2hex() { printf "#%02x%02x%02x\n" "$@" ; }
# alias click='xdotool click 1'
#
## Hack!
# echossh() {
#     if [ $# -lt 3 ] ; then
#         >&2 echo 'usage: echossh user@host file $@'
#         return 1
#     else
#         local user_at_host="$1"
#         local file="$2"
#         shift 2
#         echo "$@" | ssh "$user_at_host" \
#             sh -c "cat /dev/stdin >> $file"
#     fi
# }
