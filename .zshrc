# Lines configured by zsh-newuser-install

# Load zprofile
if [[ -f ${HOME}/.zprofile ]]; then
  source ${HOME}/.zprofile
fi

#--------------------------------------------------
# zplug
#--------------------------------------------------
source ~/.zplug/init.zsh

# Self management [zplug]
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Prompt theme [powerlevel9k]
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-aheadbehind git-remotebranch git-tagname)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir newline vcs)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="072"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="007"

# Syntax highlight for zsh [zsh-syntax-highlighting]
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Fuzzy finder [fzf]
if [[ $OSTYPE = *darwin* && $(uname -m) = x86_64 ]]; then
  zplug "junegunn/fzf-bin", from:gh-r, as:command, \
    rename-to:fzf, use:"*darwin*amd64*"
elif [[ $OSTYPE = *linux* && $(arch) = x86_64 ]]; then
  zplug "junegunn/fzf-bin", from:gh-r, as:command, \
    rename-to:fzf, use:"*linux*amd64*"
fi
# tmuxでfzfを使えるようにするプラグイン
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
# dockerでfzfを使えるようにする
if [ -f "~/.ghq/github.com/kwhrtsk/docker-fzf-completion/docker-fzf.zsh" ]; then
  source ~/.ghq/github.com/kwhrtsk/docker-fzf-completion/docker-fzf.zsh
fi
# Ctrl-Rで履歴検索、Ctrl-Tでファイル名検索補完できる
zplug "junegunn/fzf", use:shell/key-bindings.zsh
# cd **[TAB], vim **[TAB]などでファイル名を補完できる
zplug "junegunn/fzf", use:shell/completion.zsh

# next generation ls [exa]
if [[ $OSTYPE = *darwin* && $(uname -m) = x86_64 ]]; then
  zplug "ogham/exa", from:gh-r, as:command, \
    rename-to:exa, use:"*macos*x86_64*"
elif [[ $OSTYPE = *linux* && $(arch) = x86_64 ]]; then
  zplug "ogham/exa", from:gh-r, as:command, \
    rename-to:exa, use:"*linux*x86_64*"
fi

# Auto suggestion [zsh-autosuggestions]
zplug "zsh-users/zsh-autosuggestions"

# Auto complete [zsh-completions]
zplug "zsh-users/zsh-completions"

# cd enhance [enhancd]
zplug "b4b4r07/enhancd", use:init.sh

# cd to top directory of git []
zplug "mollifier/cd-gitroot"
alias cdu='cd-gitroot'

# zsh 256color [zsh-256color]
zplug "chrissicool/zsh-256color"

# zsh abbrev alias
zplug "momo-lab/zsh-abbrev-alias"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Maximum history size 1M
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt appendhistory autocd beep nomatch notify hist_ignore_dups

# Emacs key binding
bindkey -e

# Move completion options using C-f, C-b, C-p, C-n
zstyle ':completion:*:default' menu select=1

# Set options
setopt correct auto_name_dirs auto_remove_slash extended_history
setopt prompt_subst no_promptcr pushd_ignore_dups ignore_eof auto_pushd

# C-w can eliminate a part of the path until slash
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Completion settings
setopt auto_list list_packed

# Colorize basic commands
if exa &> /dev/null; then
  alias ls=exa
elif dircolors -b &> /dev/null; then
  eval "`dircolors -b`"
fi
if ! exa &> /dev/null; then
  if [ $OS = 'OSX' ]; then
    alias ls='ls -G'
  else
    alias ls='ls --color=auto'
  fi
fi
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Some aliases
alias ll='ls -alF'
alias la='ls -a'
alias l='ls -F'
alias -g L="| less"
alias -g G="| grep"
alias -g H="| head"
alias -g T="| tail"
alias -g W="| wc"
alias -g S="| sed"
alias -g A="| ask"
alias e='open_via_emacs_async'
if [ $OS != 'OSX' ]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi
alias cmakedebug='cmake -DCMAKE_BUILD_TYPE=Debug'
alias cmakerelease='cmake -DCMAKE_BUILD_TYPE=Release'
alias cmakedebugicpc='cmakedebug -DCMAKE_CXX_COMPILER=icpc'
alias cmakereleaseicpc='cmakerelease -DCMAKE_CXX_COMPILER=icpc'
alias cmakedebugclang++='cmakedebug -DCMAKE_CXX_COMPILER=clang++'
alias cmakereleaseclang++='cmakerelease -DCMAKE_CXX_COMPILER=clang++'
# git
abbrev-alias gs="git status -s"
abbrev-alias gcb="git checkout -b"
abbrev-alias gd="git diff --histogram --indent-heuristic --ignore-space-change"
abbrev-alias -f gpull="git status -uno &> /dev/null && git symbolic-ref --short HEAD | xargs echo git pull origin "
abbrev-alias -f gpush="git status -uno &> /dev/null && git symbolic-ref --short HEAD | xargs echo git push origin "
# tidy
abbrev-alias tidy="tidy -utf8"

# docker
alias docker='sudo docker'
alias docker-rm-all="docker ps -a | tail +2 | awk '{print \$1}' | xargs sudo docker rm"
abbrev-alias dp="docker ps -a"
abbrev-alias di="docker images"
abbrev-alias dr="docker run --rm"
abbrev-alias de="docker exec"
abbrev-alias dc="docker-compose"

# kubernetes
abbrev-alias k="kubectl"
abbrev-alias mk="microk8s.kubectl"
abbrev-alias me="microk8s.enable"
abbrev-alias mstop="sudo microk8s.stop"
abbrev-alias mstart="sudo microk8s.start"

# For gnuplot
function plot () {
    for file in $@; do
        gnuplot -p -e "plot '$file'"
    done
}

function plotl () {
    for file in $@; do
	gnuplot -p -e "set grid; set zeroaxis lt -1 lw 0.5; set mxtics; set mytics; plot '$file' w lines"
    done
}

function splot() {
    for file in $@; do
        gnuplot -p -e "splot '$file'"
    done
}

function splotl() {
    for file in $@; do
        gnuplot -p -e "splot '$file' w lines" 
    done
}

# For git
function gc () {
    local branches branch
    branches=$(git branch) &&
    if [ -n "$1" ]; then
        branch=$(echo "$branches" | fzf +m --ansi --height 40% --reverse -q $1) || return $?
    else
        branch=$(echo "$branches" | fzf +m --ansi --height 40% --reverse) || return $?
    fi
    git checkout $(echo "$branch" | awk '{print $1}' | sed 's/.* //')
}

function gcr() {
    local branches branch
    branches=$(git branch -a) &&
    if [[ -n "$1" ]]; then
        branch=$(echo "$branches" | fzf +m --ansi --height 40% --reverse -q $1) || return $?
    else
        branch=$(echo "$branches" | fzf +m --ansi --height 40% --reverse) || return $?
    fi
    git checkout $(echo "$branch" | awk '{print $1}' | sed 's/.* //' | sed 's$remotes/origin/$$')
}

function gbd() {
    local branches branch
    branches=$(git branch) &&
    if [ -n "$1" ]; then
        branch=$(echo "$branches" | fzf +m --ansi --height 40% --reverse -q $1) || return $?
    else
        branch=$(echo "$branches" | fzf +m --ansi --height 40% --reverse) || return $?
    fi
    branch=$(echo "$branch" | awk '{print $1}' | sed 's/.* //')
    git push origin :$branch
    git branch -d $branch
}

function gb() {
    local branches
    branches=$(git branch -vv) &&
    if [ -n "$1" ]; then
        branch=$(echo "$branches" | fzf +m --ansi --height 40% --reverse -q $1) || return $?
    else
        branch=$(echo "$branches" | fzf +m --ansi --height 40% --reverse) || return $?
    fi
    echo "$branch" | awk '{print $1}'| sed 's/.* //' | sed "s/\n//" | pbcopy
}

# For Emacs
source ~/.zsh.d/lib_open_via_emacs.sh

# For docker
source ~/.zsh.d/docker.zsh

# For GHQ
source ~/.zsh.d/ghq-cd.zsh

# For google cloud
source ~/.zsh.d/gimages.zsh

# For kubectl
if kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

# For stern
if stern &> /dev/null; then
  source <(stern --completion=zsh)
fi

## Invoke the ``dired'' of current working directory in Emacs buffer.
function dired () {
  open_via_emacs_async -e "(dired \"${1:a}\")"
}

## Chdir to the ``default-directory'' of currently opened in Emacs buffer.
function cde () {
    EMACS_CWD=`emacsclient -e "
     (expand-file-name
      (with-current-buffer
          (if (featurep 'elscreen)
              (let* ((frame-confs (elscreen-get-frame-confs (selected-frame)))
                     (num (nth 1 (assoc 'screen-history frame-confs)))
                     (cur-window-conf (cadr (assoc num (assoc 'screen-property frame-confs))))
                     (marker (nth 2 cur-window-conf)))
                (marker-buffer marker))
            (nth 1
                 (assoc 'buffer-list
                        (nth 1 (nth 1 (current-frame-configuration))))))
        default-directory))" | sed 's/^"\(.*\)"$/\1/'`

    echo "chdir to $EMACS_CWD"
    cd "${EMACS_CWD}"
    unset EMACS_CWD
}

# Add ssh key if not added yet.
if [ -S "$SSH_AUTH_SOCK" ]; then
  if ! ssh-add -l > /dev/null; then
    if [ -f "$HOME/.ssh/id_rsa" ]; then
      ssh-add "$HOME/.ssh/id_rsa"
    fi
    if [ -f "$HOME/.ssh/id_rsa_priv" ]; then
      ssh-add "$HOME/.ssh/id_rsa_priv"
    fi
  fi
fi


# Environment
export SVN_EDITOR=/usr/bin/vim

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/goto/google-cloud-sdk/path.zsh.inc' ]; then . '/home/goto/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/goto/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/goto/google-cloud-sdk/completion.zsh.inc'; fi

# The next lines enable nvm commands and completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set editor settings if exists vim
if which vim &> /dev/null; then
  export EDITOR=vim
fi
