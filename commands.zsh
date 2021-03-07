# Commands

lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

phpv() {
    valet stop
    brew unlink php@7.4 php@8.0
    brew link --force --overwrite $1
    brew services start $1
    composer global update
    rm -f ~/.config/valet/valet.sock
    valet install
}

alias php74="phpv php@7.4"
alias php80="phpv php@8.0"

composer-link() {
    composer config repositories.local '{"type": "path", "url": "'$1'"}' --file composer.json
}
