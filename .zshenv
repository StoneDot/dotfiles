# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1

# PATH configuration
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi
export GOPATH=$HOME/workspace/go
if [ -d /opt/p4v/bin ]; then
  PATH=/opt/p4v/bin:$PATH
fi
if [ -d $HOME/go/bin ]; then
  PATH=$HOME/go/bin:$PATH
fi
if [ -d $HOME/.zsh.d/commands ]; then
  PATH=$HOME/.zsh.d/commands:$PATH
fi
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export TERM=xterm-256color

# For pip
if [[ -e /home/goto/.local/bin ]]; then
     PATH="$HOME/.local/bin:$PATH"
fi

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

if [ $(uname) = "Linux" -a $(cat /etc/lsb-release | head -1 | cut -d= -f2) = "Ubuntu" ]; then
    # For linux brew
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
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
