export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export DENO_INSTALL="/home/user/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export XDG_CACHE_HOME="$HOME/.cache"
export RUFF_CACHE_DIR="$XDG_CACHE_HOME/ruff"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$HOME/sands.sh" ]
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
eval "$(pyenv virtualenv-init -)"
eval "$(pyenv init --path)"
eval "$(sheldon source)"
eval "$(gh completion -s zsh)"

alias rmd='rmdir'
alias c='clear'
alias open='nautilus'
alias vz='neovide ~/user.zsh'
alias ez='code ~/user.zsh'
alias vv='neovide ~/.config/nvim/lua'
alias y2s='yt-dlp -f bestaudio -x --audio-format mp3 -o "~/Music/Downloads/%(title)s.%(ext)s"'
alias y2v='yt-dlp -f "bestvideo+bestaudio" --merge-output-format mp4 -o "~/Videos/Downloads/%(title)s.%(ext)s"'
alias y4k='yt-dlp -f "bestvideo[ext=mp4][height<=2160]+bestaudio[ext=m4a]/bestvideo[ext=mp4][height<=21160]+bestaudio[ext=m4a]/bestvideo[ext=mp4][height<=21160]+bestaudio[ext=m4a]"'
alias skk='yaskkserv2  --config-filename /home/user/.skk/linux_yaskkserv2.conf'

# Docker
# https://github.com/webyneter/docker-aliases/blob/master/docker-aliases.plugin.zsh
alias di='docker images'
alias drmi='docker rmi'
alias dbu='docker build'c
alias drmi_all='docker rmi $* $(docker images -a -q)'
alias drmi_dang='docker rmi $* $(docker images -q -f "dangling=true")'
alias dhi='docker history $*'
dhi_neat() {
    docker history "${1}" \
        --format "{{ .Size }}\t{{ .CreatedBy }}" \
        ${2:-} |
    sort \
        --key=1 \
        --human-numeric-sort \
        --reverse
}
alias dps='docker ps'
alias drit='docker run -it'
alias deit='docker exec -it'
alias dlog='docker logs'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}" $*'
alias dstop_all='docker stop $* $(docker ps -q -f "status=running")'
alias drm='docker rm'
alias drm_stopped='docker rm $* $(docker ps -q -f "status=exited")'
alias drmv_stopped='docker rm -v $* $(docker ps -q -f "status=exited")'
alias drm_all='docker rm $* $(docker ps -a -q)'
alias drmv_all='docker rm -v $* $(docker ps -a -q)'
alias dvls='docker volume ls $*'
alias dvrm_all='docker volume rm $(docker volume ls -q)'
alias dvrm_dang='docker volume rm $(docker volume ls -q -f "dangling=true")'

# Git Aliases
# https://github.com/lewisacidic/fish-git-abbr
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gapt='git apply --3way'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbdf='git branch -d -f'
alias gbD='git branch -D'
alias gbDf='git branch -D -f'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbl='git blame -b -w'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc='git commit -v'
alias gci='git commit -v --allow-empty -m "chore: initial commit"'
alias gc!='git commit -v --amend'
alias gcn='git commit -v --no-edit'
alias gcn!='git commit -v --amend --no-edit'
alias gca='git commit -a -v'
alias gca!='git commit -a -v --amend'
alias gcan!='git commit -a -v --no-edit --amend'
alias gcans!='git commit -a -v -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcas='git commit -a -s'
alias gcasm='git commit -a -s -m'
alias gcsm='git commit -s -m'
alias gcm='git commit -m'
alias gcs='git commit -S'
alias gcf='git config --list'
alias gcl='git clone --recurse-submodules'
alias gclean='git clean -id'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout main'
alias gcod='git checkout dev'
alias gcof='git checkout feature/'
alias gcoh='git checkout hotfix/'
alias gcor='git checkout release/'
alias gcos='git checkout support/'
alias gcors='git checkout --recurse-submodules'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'
alias ghh='git help'
alias gi='git init'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v'
alias gk='gitk --all --branches &!'
alias gke='gitk --all $(git log -g --pretty=%h) &!'
alias gfg='git ls-files'
alias gl='git log'
alias gls='git log --stat'
alias glsp='git log --stat -p'
alias glg='git log --graph'
alias glgda='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias gm='git merge'
alias gmom='git merge origin/main'
alias gmum='git merge upstream/main'

alias ai='sudo apt-get install -y'
alias au='sudo apt-get update -y'
alias aun='sudo apt-get uninstall -y'

# abbr import-git-aliases -g -S
# abbr import-aliases
# abbr erase cat
# abbr erase rcat

cursor() {
    run_app() {
        /opt/cursor/cursor.appimage "$@" </dev/null &>/dev/null &
    }

    case "$1" in
        -d | --diff)
            run_app --diff "$2" "$3"
            ;;
        -a | --add)
            run_app --add "$2"
            ;;
        -g | --goto)
            run_app --goto "$2"
            ;;
        -n | --new-window)
            run_app --new-window
            ;;
        -r | --reuse-window)
            run_app --reuse-window
            ;;
        -w | --wait)
            run_app --wait
            ;;
        --locale)
            run_app --locale "$2"
            ;;
        --user-data-dir)
            run_app --user-data-dir "$2"
            ;;
        *)
            if [ -z "$1" ]; then
                run_app
            else
                run_app "$@"
            fi
            ;;
    esac
}
alias e='cursor'
alias v='neovide'

function lr() {
    local exa_cmd="eza --icons --long --group-directories-first --blocks --no-user --no-permissions"
    # local exa_cmd="exa -lbghHmuSa --group-directories-first"
    # 引数がある場合は exa | grep を実行
    if [ $# -gt 0 ]; then
        eval "$exa_cmd" | grep "$@"
    else
        # 引数がない場合は exa | peco を実行
        local selected_line=$(eval "$exa_cmd" | peco)

        if [ -z "$selected_line" ] || [ $(echo "$selected_line" | wc -l) -ne 1 ]; then
            return
        fi

        # 選択された行からファイル名のみを抽出
        local selected_file=$(echo "$selected_line" | awk '{print $NF}')

        if [ -d "$selected_file" ]; then
            cd "$selected_file"
        elif [ -L "$selected_file" ]; then
            cd "$(dirname "$(readlink "$selected_file")")"
        elif file "$selected_file" | grep -q text; then
            cat "$selected_file"
        else
            xdg-open "$selected_file"
        fi
    fi
}

function ghcr() {
    gh repo create $1 --private
    ghq get $1
    cd "$(ghq list --full-path -e $1)"
}
