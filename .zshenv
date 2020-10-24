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
