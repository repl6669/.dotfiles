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
    brew unlink php@8.0 php@8.1
    brew link --force --overwrite $1
    brew services start $1
    composer global update
    rm -f ~/.config/valet/valet.sock
    valet install
}

alias php74="phpv php@7.4"
alias php80="phpv php@8.0"
alias php81="phpv php@8.1"

composer-link() {
    composer config repositories.local '{"type": "path", "url": "'$1'"}' --file composer.json
}

function stage {
    SOURCE_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    echo "pull existing changes..." &&
    git pull &&
    echo "checking out staging..." &&
    git checkout staging &&
    echo "pulling staging..." &&
    git pull
    echo "merging $SOURCE_BRANCH.." &&
    git merge $SOURCE_BRANCH --no-edit &&
    echo "pushing to staging..." &&
    git push &&
    echo "checkout back to $SOURCE_BRANCH" &&
    git checkout $SOURCE_BRANCH
}
