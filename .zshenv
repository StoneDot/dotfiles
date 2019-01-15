# PATH configuration
export GOPATH=$HOME/workspace/go
export PATH=$HOME/go/bin:$HOME/.zsh.d/commands:$GOPATH/bin:/opt/p4v/bin:$PATH
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
