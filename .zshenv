# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1

# PATH configuration
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi
if [ -d /opt/p4v/bin ]; then
  path=("/opt/p4v/bin" $path)
fi
if [ -d $HOME/.zsh.d/commands ]; then
  path=($HOME/.zsh.d/commands $path)
fi
if [ -d $HOME/.local/bin ]; then
  path=("$HOME/.local/bin" $path)
fi
if [ -d /home/goto/go/bin ]; then
  path=("/usr/local/go/bin" $path)
fi
if [ -d $HOME/go/bin ]; then
  path=("$HOME/go/bin" $path)
fi
if [ -d /usr/lib/cargo/bin ]; then
  path=("/usr/lib/cargo/bin/" $path)
fi
export PATH
. "$HOME/.cargo/env"

export TERM=xterm-256color

if [ $(uname) = "Linux" -a ]; then
  if [ -e /etc/lsb-release ]; then
    if [ $(cat /etc/lsb-release | head -1 | cut -d= -f2) = "Ubuntu" ]; then
      # For linux brew
      eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    fi
  fi
fi

# For Java
if [[ -e /usr/lib/jvm/java-1.8.0-amazon-corretto ]]; then
    export JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto
fi
