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
export PATH
. "$HOME/.cargo/env"
export TERM=xterm-256color

# For Intel MKL
if [[ -e /opt/intel/bin/compilervars.sh ]]; then
    source /opt/intel/bin/compilervars.sh intel64
fi
if [[ -e /opt/intel/mkl/bin/mklvars.sh ]]; then
    source /opt/intel/mkl/bin/mklvars.sh intel64
fi
if [[ -e /opt/intel/tbb/bin/tbbvars.sh ]]; then
    source /opt/intel/tbb/bin/tbbvars.sh intel64
fi

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

# For hadoop
if [[ -e ${HOME}/hadoop-3.3.0/bin ]] then
    export PATH=${HOME}/hadoop-3.3.0/bin:$PATH
fi
if [[ -e ${HOME}/hadoop-3.3.0/sbin ]]; then
    export PATH=${HOME}/hadoop-3.3.0/sbin:$PATH
fi
if [[ -e ${HOME}/spark-3.1.2-bin-hadoop3.2/bin ]]; then
    export PATH=${HOME}/spark-3.1.2-bin-hadoop3.2/bin:$PATH
fi
