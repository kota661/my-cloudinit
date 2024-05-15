# $HOME/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes
force_color_prompt=yes #カラー表示する

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # \u ユーザ名
    # \h ホスト名
    # \w カレントディレクトリ
    # \$ 実効UIDが0の場合に#、それ以外の場合は$
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# $HOME/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# -----------------------------
# Custom
# -----------------------------
# alias
# alias -g L='less'
# alias -g H='head'
# alias -g G='grep'
# alias -g O='open'

alias g='git'
alias v='vim'
alias vi='vim'

## alias/ls
alias ls='ls --color=auto -G'
alias la='ls -lAG'
alias ll='ls -lG'

## alias/k8s
alias k="kubectl"
# apply, create
alias ka="kubectl apply"
alias kaf="kubectl apply -f"
alias kc="kubectl create"
alias kcf="kubectl create -f"
# get
alias kg="kubectl get"
alias kgp="kubectl get pod"
alias kgs="kubectl get svc"
alias kgd="kubectl get deploy"
alias kga="kubectl get deploy,replicasets,daemonsets,job,pod,services,endpoints,ingress,pv,pvc,configmap,secret"
alias kgaa="kubectl get namespaces --all-namespaces; kga --all-namespaces"
alias kgaaa="kci; echo ; kgaa;"
alias kgf="kubectl get -f"
# other
alias kl="kubectl logs"
alias ke="kubectl edit"
alias kd="kubectl describe"
alias kci="kubectl config get-contexts; echo ;kubectl cluster-info; kubectl get componentstatuses,node"

## alias/docker
alias d="docker"
alias dg="docker ps"
alias dgi="docker images"
alias dga="docker ps; docker images"
alias dgaa="docker ps -a; docker images"
alias dd="docker inspect"
alias db="docker build"

## alias/podman
alias p="podman"

## alias/docker-compose
alias dc="docker compose"

## alias/ibmcloud
alias ic="ibmcloud"

## alias/gcloud
alias gcp="gcloud"

# -----------------------------
# func
# -----------------------------

function myip() {
    # -----------------------------
    # func/myip
    # -----------------------------
    CHECKIP_URL=https://domains.google.com/checkip
    echo "curl -4 $CHECKIP_URL || wget -O - -q --inet4-only $CHECKIP_URL"
    echo IPv4:
    curl -4 $CHECKIP_URL || wget -O - -q --inet4-only $CHECKIP_URL
    echo
    echo IPv6:
    curl -6 $CHECKIP_URL || wget -O - -q --inet6-only $CHECKIP_URL
    echo
}
