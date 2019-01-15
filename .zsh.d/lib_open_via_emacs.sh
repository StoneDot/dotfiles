# For Emacs
## Emacsを使ってファイルを開く。
function open_via_emacs () {
    emacsclient $* 2> /dev/null
    ok=$?
    if [[ $ok -ne 0 ]]; then
        emacs &> /dev/null &!
	while [[ $ok -ne 0 ]]; do
            sleep 0.1
            emacsclient $* &> /dev/null
            ok=$?
        done
    fi
}

## Emacsを使って非同期でファイルを開く。
function open_via_emacs_async() {
    open_via_emacs $* &> /dev/null &!
}
