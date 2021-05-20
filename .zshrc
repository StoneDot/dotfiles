# Lines configured by zsh-newuser-install

# Delete duplication
typeset -gU PATH

# Load zprofile
if [[ -f ${HOME}/.zprofile ]]; then
  source ${HOME}/.zprofile
fi

#--------------------------------------------------
# zinit
#--------------------------------------------------
### Added by Zinit's installer
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin installer's chunk

# Prompt theme [powerlevel10k]
zplugin light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.zsh.d/p10k.zsh ]] && source ~/.zsh.d/p10k.zsh

# Fuzzy finder [fzf]
zplugin ice from"gh-r" as"program" mv"fzf* -> fzf"
zplugin light junegunn/fzf-bin

# dockerでfzfを使えるようにする
zplugin ice pick"docker-fzf.zsh"
zplugin light kwhrtsk/docker-fzf-completion

# tmuxでfzfを使えるようにするプラグイン
zplugin ice as"program" cp"bin/fzf-tmux -> fzf-tmuz"

# Ctrl-Rで履歴検索、Ctrl-Tでファイル名検索補完できる
# cd **[TAB], vim **[TAB]などでファイル名を補完できる
zplugin ice depth"1" multisrc"shell/key-bindings.zsh shell/completion.zsh"
zplugin light junegunn/fzf

# next generation ls [exa]
if [ "$(uname)" = 'Darwin' ]; then
  zplugin ice from"gh-r" as"program" mv"exa* -> exa" bpick"*macos*"
  zplugin light ogham/exa
else
  zplugin ice as"program" mv"exa* -> exa"
  zplugin light ogham/exa
fi

# Auto suggestion [zsh-autosuggestions]
zplugin ice wait atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

# Auto complete [zsh-completions]
zplugin light "zsh-users/zsh-completions"

# cd to top directory of git []
zplugin light "mollifier/cd-gitroot"
alias cdu='cd-gitroot'

# zsh 256color [zsh-256color]
zplugin light "chrissicool/zsh-256color"

# zsh abbrev alias
zplugin light "momo-lab/zsh-abbrev-alias"

# Z commnad
zplugin ice wait
zplugin light rupa/z

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

# C-w work as kill-region in selection-mode
function backward-kill-word-or-region() {
    if [ $REGION_ACTIVE -eq 0 ]; then
        zle backward-kill-word
    else
        zle kill-region
    fi
}
zle -N backward-kill-word-or-region
bindkey "^w" backward-kill-word-or-region

# Completion settings
setopt auto_list list_packed

# Colorize basic commands
if exa &> /dev/null; then
  alias ls=exa
elif dircolors -b &> /dev/null; then
  eval "`dircolors -b`"
fi
if ! exa &> /dev/null; then
  if [ "$(uname)" = 'Darwin' ]; then
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
if [ "$(uname)" != 'Darwin' ]; then
  if which xsel >/dev/null; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  else
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  fi
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
abbrev-alias gd="git diff --histogram --indent-heuristic --ignore-space-change -- . ':!*.map'"
abbrev-alias -g -e gpull='$(git status -uno &> /dev/null && git symbolic-ref --short HEAD | xargs echo git pull origin )'
abbrev-alias -g -e gpush='$(git status -uno &> /dev/null && git symbolic-ref --short HEAD | xargs echo git push origin )'
abbrev-alias -g -e gupull='$(git status -uno &> /dev/null && git symbolic-ref --short HEAD | xargs echo git pull upstream )'
abbrev-alias -g -e gupush='$(git status -uno &> /dev/null && git symbolic-ref --short HEAD | xargs echo git push upstream )'
abbrev-alias -g -e groot='$(git rev-parse --show-toplevel 2> /dev/null)'
# tidy
abbrev-alias tidy="tidy -utf8"

# docker
ALLOW_DOCKER_ROOTLESS=0
if [[ -n /etc/lsb-release && "$(uname)" = "Linux" ]]; then
  ALLOW_DOCKER_ROOTLESS="$(echo "$(cat /etc/lsb-release | grep DISTRIB_RELEASE | cut -d= -f2) >= 20.04" | bc)"
fi
if [[ "$(uname)" != 'Darwin' && $ALLOW_DOCKER_ROOTLESS = 0 ]]; then
  alias docker='sudo docker'
fi
alias docker-rm-all="docker ps -a | tail +2 | awk '{print \$1}' | xargs sudo docker rm"
abbrev-alias dp="docker ps -a"
abbrev-alias di="docker images"
abbrev-alias -g -e dr='docker run --rm -ti $(select-docker-image)'
abbrev-alias -g -e de='docker exec -ti $(select-docker-ps)'
abbrev-alias -g -e dbash='docker exec -ti $(select-docker-ps) /bin/bash'
abbrev-alias -g -e dsh='docker exec -ti $(select-docker-ps) /bin/sh'
abbrev-alias dc="docker-compose"
abbrev-alias glue-jupyter="docker run -itd --rm -p 8888:8888 -p 4040:4040 -v ~/.aws:/root/.aws:ro -v ~/workspace/notebooks:/home/jupyter/jupyter_default_dir --name glue_jupyter glue-dev-env:1.0.0 /home/jupyter/jupyter_start.sh"

function select-docker-image () {
    local images image
    images=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep -v '<none>')
    image=$(echo "${images}" | fzf +m --ansi --height 40% --reverse) || return $?
    echo $image
}
function select-docker-ps () {
    local containers container
    containers=$(docker ps --format "[{{.Image}}] {{.Names}} {{.Command}}")
    container=$(echo "${containers}" | fzf +m --ansi --height 40% --reverse) || return $?
    echo "${container}" | awk '{print $2}'
}

# kubernetes
abbrev-alias k="kubectl"
abbrev-alias mk="microk8s.kubectl"
abbrev-alias me="microk8s.enable"
abbrev-alias mstop="sudo microk8s.stop"
abbrev-alias mstart="sudo microk8s.start"

# ansible
abbrev-alias ap="ansible-playbook --inventory-file=/usr/local/bin/terraform-inventory"

# Glue
alias runglue="docker run -itd -p 8888:8888 -p 4040:4040 -v ~/.aws:/root/.aws:ro -v ~/workspace/notebooks:/home/jupyter/jupyter_default_dir --name glue_jupyter amazon/aws-glue-libs:glue_libs_1.0.0_image_01 /home/jupyter/jupyter_start.sh"
alias stopglue="docker stop glue_jupyter && docker rm glue_jupyter"

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

# working directory history search
function j () {
    local result
    if [ -z "$1" ]; then
        result=$(z | sort -rn | awk '{print $2}' | fzf -1 +m --ansi --height 40% --reverse )
    else
      result=$(z | sort -rn | awk '{print $2}' | fzf -1 +m --ansi --height 40% --reverse -q "$1")
    fi
    if [ -n "$result" ]; then
      cd $result
    else
      return 1
    fi
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
    echo "$branch" | sed 's/\* *//' | awk '{print $1}' | sed 's/.* //' | sed "s/\n//" | perl -pe 'chomp' | pbcopy
}

function gcopy() {
    git symbolic-ref --short HEAD | perl -pe 'chomp' | pbcopy
}


# For Emacs
source ~/.zsh.d/lib_open_via_emacs.sh

# For GHQ
source ~/.zsh.d/ghq-cd.zsh

# For google cloud
source ~/.zsh.d/gimages.zsh

# For general functions
fpath+=~/.zsh.d/functions

# For linux brew completion
if [[ -d /home/linuxbrew/.linuxbrew/share/zsh/site-functions ]]; then
  fpath+=/home/linuxbrew/.linuxbrew/share/zsh/site-functions
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

# Load rbenv settings
if which rbenv &> /dev/null; then
  eval "$(rbenv init -)"
  export PATH="${HOME}/.rbenv/bin:${PATH}"
fi

# Set editor settings if exists vim
if which vim &> /dev/null; then
  export EDITOR=vim
fi

# For kubectl completion
if kubectl &> /dev/null; then
  if ! [ -f ${HOME}/.zsh.d/generated/kubectl.zsh ]; then
    kubectl completion zsh > ${HOME}/.zsh.d/generated/kubectl.zsh
  fi
  zplugin ice wait
  zplugin snippet ${HOME}/.zsh.d/generated/kubectl.zsh
fi

# For docker completion
zplugin load ~/.zsh.d/docker.zsh

# For stern completion
if stern &> /dev/null; then
  if ! [ -f ${HOME}/.zsh.d/generated/stern.zsh ]; then
    stern --completion=zsh > "${HOME}/.zsh.d/generated/stern.zsh"
  fi
  zplugin ice wait
  zplugin snippet ${HOME}/.zsh.d/generated/stern.zsh
fi

# SSH completion settings
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# Enable completion
autoload -Uz compinit
compinit
zplugin cdreplay -q
# zplugin cdlist

# The next lines enable nvm commands and completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Syntax highlight for zsh [zsh-syntax-highlighting]
zplugin light zsh-users/zsh-syntax-highlighting
abbrev-alias --init

# added by travis gem
[ ! -s /home/goto/.travis/travis.sh ] || source /home/goto/.travis/travis.sh
