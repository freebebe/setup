# Created by newuser for 5.8
#
#####################################################################
# Plug
#####################################################################
source ~/.zplug/init.zsh

## Packgage with third
zplug "zsh-users/zsh-autosuggestions"              
## Packgage with ohMyZsh                            
# zplug "plugins/git",                from:oh-my-zsh
zplug "plugins/vi-mode",            from:oh-my-zsh 
zplug "plugins/autojump",           from:oh-my-zsh 
zplug "plugins/safe-paste",         from:oh-my-zsh 
zplug "plugins/alias-finder",       from:oh-my-zsh 
                                                  
# Install plugins if there are plugins that have no
if ! zplug check --verbose; then                   
   printf "Install? [y/N]: "                      
   if read -q; then                               
        echo; zplug install                        
   fi                                             
fi                                                 
                                                  
# Then, source plugins and add commands to $PATH   
zplug load --verbose

#####################################################################
# environment
#####################################################################

export EDITOR=nvim
export LANG=en_US.UTF-8

# Better umask
umask 022

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Print core files?
#unlimit
#limit core 0
#limit -s
#limit coredumpsize  0

# improved less option
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'

# ワード単位移動の挙動
export WORDCHARS=

if [ -d $HOME/.cargo/bin ]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

if [ -d $HOME/.opam ]; then
    export PATH=$HOME/.opam/system/bin:$PATH
    # OPAM configuration
    source ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

export DOTZSH=$HOME/.zsh
if [ ! -d $DOTZSH ]; then
    mkdir -p $DOTZSH
fi

# デフォルトで venv 以外で pip install できないようにする
# グローバルでインストールしたい時は PIP_REQUIRE_VENV= pip install を使う
export PIP_REQUIRE_VENV=true
export PIP_REQUIRE_VIRTUALENV=false
# }}}

# for nvim-deoplete_tern
ulimit -n 2048

#####################################################################
# completions
#####################################################################

# Enable completions
if [ -d ~/.zsh/comp ]; then
    fpath=(~/.zsh/comp $fpath)
    autoload -U ~/.zsh/comp/*(:t)
fi

zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:options' verbose yes
zstyle ':completion:*:values' verbose yes
zstyle ':completion:*:options' prefix-needed yes
# Use cache completion
# apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perl -M,
# bogofilter (zsh 4.2.1 >=), fink, mac_apps...
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list \
    '' \
    'm:{a-z}={A-Z}' \
    'l:|=* r:|[.,_-]=* r:|=* m:{a-z}={A-Z}'
# sudo completions
# zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
    # /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# zstyle ':completion:*' menu select
# zstyle ':completion:*' keep-prefix
# zstyle ':completion:*' completer _oldlist _complete _match _ignored \
    # _approximate _list _history

autoload -U compinit

# cd search path
cdpath=($HOME)

zstyle ':completion:*:processes' command "ps -u $USER -o pid,stat,%cpu,%mem,cputime,command"

# {{{
# 補完に使うソース
zstyle ':completion:*' completer _complete _expand _list _match _prefix

# 補完候補の色付け
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# スマートケースで補完
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# 補完を選択できるように
zstyle ':completion:*' menu select=2

# sudo を含めても保管できるようにする
# zstyle ':completion:*:sudo:*' command-path $sudo_path $path

# キャッシュ
zstyle ':completion:*' use-cache true

# git をエイリアス時にも補完できるようにする
compdef _git g=git
compdef _docker d=docker
# }}}

#####################################################################
# colors
#####################################################################

# Color settings for zsh complete candidates
alias ls='ls -F --show-control-chars '
# alias ls='ls -F --show-control-chars --color=always'
alias la='ls -aF --show-control-chars '
# alias la='ls -aF --show-control-chars --color=always'
alias ll='ls -lF --show-control-chars '
# alias ll='ls -lF --show-control-chars --color=always'
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# Use vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# PROMPT='%{[33m%}[%35<..<%~]%{[m%}${vcs_info_msg_0_}
# %{[$[31+$RANDOM % 7]m%}%U%B%#'"%b%{[m%}%u "
#
# if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] ; then
    # PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
# fi
#
# if [ $UID = "0" ]; then
    # PROMPT="%B%{[31m%}%/#%{^[[m%}%b "
    # PROMPT2="%B%{[31m%}%_#%{^[[m%}%b "
# fi

# Multi line prompt
PROMPT2="%_%% "
# Spell miss prompt
SPROMPT="correct> %R -> %r [n,y,a,e]? "

#####################################################################
# keybinds
######################################################################

# emacs keybinds
bindkey -e

# History completion
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# Like bash
bindkey "^u" backward-kill-line

#turn left or right 
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word 

# ^J で parent directory に移動
function _parent() {
    pushd .. > /dev/null
    zle reset-prompt
}
zle -N _parent
bindkey -M viins "^J" _parent

# ^O で popd する
function _pop_hist(){
    popd > /dev/null
    zle reset-prompt
}
zle -N _pop_hist
bindkey -M viins "^O" _pop_hist

# last word you typed with command
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey -M viins '^]' insert-last-word

# end of single quote
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey -M viins '^Q' _quote-previous-word-in-single

# end of double quote
_quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey -M viins '^Xq' _quote-previous-word-in-double

# search revech with [Shift + Tab]
bindkey -M viins "$terminfo[kcbt]" reverse-menu-complete

# ファイルを確認する
function _ls_files() {
    echo
    local -a opt_ls
    case "${OSTYPE}" in
        freebsd*|darwin*)
            opt_ls=('-ACFG')
            ;;
        *)
            opt_ls=('-ACF' '--color=always')
            ;;
    esac

    command ls ${opt_ls[@]}
    zle reset-prompt
}
zle -N _ls_files
# }}}

#######################
#   Histroy setting   #
#######################
# {{{
HISTFILE=$DOTZSH/zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# working history
#add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-max 5000
# }}}

#####################################################################
# alias
######################################################################

# Better mv, cp, mkdir
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# Improve du, df
alias du="du -h"
alias df="df -h"

# Improve od for hexdump
alias od='od -Ax -tx1z'
alias hexdump='hexdump -C'

alias vim='TERM=xterm-256color nvim'
#alias nvim-qt='nvim-qt --geometry 1800x1200'
alias goneovim='~/Downloads/goneovim/goneovim &>/dev/null &'
alias gn=goneovim
alias lock='i3exit lock'

#####################################################################
# options
######################################################################

setopt auto_resume
# Ignore <C-d> logout
setopt ignore_eof
# Disable beeps
setopt no_beep
# {a-c} -> a b c
setopt brace_ccl
# Enable spellcheck
setopt correct
# Enable "=command" feature
setopt equals
# Disable flow control
setopt no_flow_control
# Ignore dups
setopt hist_ignore_dups
# Reduce spaces
setopt hist_reduce_blanks
# Ignore add history if space
setopt hist_ignore_space
# Save time stamp
setopt extended_history
# Expand history
setopt hist_expand
# Better jobs
setopt long_list_jobs
# Enable completion in "--option=arg"
setopt magic_equal_subst
# Add "/" if completes directory
setopt mark_dirs
# Disable menu complete for vimshell
setopt no_menu_complete
setopt list_rows_first
# Expand globs when completion
setopt glob_complete
# Enable multi io redirection
setopt multios
# Can search subdirectory in $PATH
setopt path_dirs
# For multi byte
setopt print_eightbit
# Print exit value if return code is non-zero
setopt print_exit_value
setopt pushd_ignore_dups
setopt pushd_silent
# Short statements in for, repeat, select, if, function
setopt short_loops
# Ignore history (fc -l) command in history
setopt hist_no_store
setopt transient_rprompt
unsetopt promptcr
setopt hash_cmds
setopt numeric_glob_sort
# Enable comment string
setopt interactive_comments
# Improve rm *
setopt rm_star_wait
# Enable extended glob
setopt extended_glob
# Note: It is a lot of errors in script
# setopt no_unset
# Prompt substitution
setopt prompt_subst
setopt always_last_prompt
# List completion
setopt auto_list
setopt auto_param_slash
setopt auto_param_keys
# List like "ls -F"
setopt list_types
# Compact completion
setopt list_packed
setopt auto_cd
setopt auto_pushd
setopt pushd_minus
setopt pushd_ignore_dups
# Check original command in alias completion
setopt complete_aliases
unsetopt hist_verify

# Ignore some command histories
export HISTORY_IGNORE="(cd|pwd|l[sal]|rm|mv|shutdown|exit|rmdir)"

# show path 
if [ -n "$BASH_VERSION" ]; then
    export PS1='\u@\h:\w\$ '
else
    if [ "$UID" -eq 0 ]; then
        export PROMPT='%f%n@%m:%~%# '
    else
        export PROMPT='%f%n@%m:%~\$ '
    fi
fi

#####################################################################
# others
######################################################################

# Improve terminal title
case "${TERM}" in
    kterm*|xterm*|vt100|st*|rxvt*)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
            vcs_info
        }
        ;;
esac

# Share zsh histories
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=20000
setopt inc_append_history
setopt share_history

# Enable math functions
zmodload zsh/mathfunc

# Use dtach or abduco instead screen/tmux
# C-\ is detach
# dtach command, dtach -A command, dtach -a session
# adbuco -c session,abduco -c session command, abduco -a command

                                        # if ( which zprof > /dev/null ); then
                                            # zprof | less
                                        # fi

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# フロー制御の無効化
stty -ixon

# rbenv
if hash rbenv 2> /dev/null; then
    # initialize rbenv
    eval "$(rbenv init -)"
    # rehash rbenv executable file database at [un]installation
    function gem(){
        "$HOME/.rbenv/shims/gem" $*
        if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
        then
            rbenv rehash
            rehash
        fi
    }
fi

# PWD を移動するごとにディレクトリ内のファイルを表示
# ただし，ファイルが多すぎるときは省略する
_ls_abbrev() {
    if [[ $- != *i* ]]; then
        # インタラクティブシェル以外ではスキップする
        return
    fi

    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    case "${OSTYPE}" in
        freebsd*|darwin*)
            opt_ls=('-ACFG')
            ;;
        *)
            opt_ls=('-ACF' '--color=always')
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 8 ]; then
        echo "$ls_result" | head -n 3
        echo '...'
        echo "$ls_result" | tail -n 3
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}
#add-zsh-hook chpwd _ls_abbrev


###############
#   FILTER    #
###############
export FILTER_CMD=fzf
export FILTER_OPTS="--layout=reverse"
if hash "$FILTER_CMD" 2> /dev/null; then
# {{{
alias -g F="| $FILTER_CMD $FILTER_OPTS"
alias -g FX="| $FILTER_CMD $FILTER_OPTS $FILTER_OPTS | xargs"

function filter-pgrep() {
    if [[ $1 == "" ]]; then
        filter="$FILTER_CMD $FILTER_OPTS"
    else
        filter="$FILTER_CMD $FILTER_OPTS --query \"$1\""
    fi
    ps aux | eval $FILTER_CMD $FILTER_OPTS --prompt "\"pgrep> \"" | awk '{ print $2 }'
}
zle -N filter-pgrep

function filter-pkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    filter-pgrep $QUERY | xargs kill $*
}
zle -N filter-pkill

function filter-history-insert() {
    local tac
    hash gtac 2> /dev/null && tac="gtac" || { hash tac 2> /dev/null && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | $FILTER_CMD $FILTER_OPTS  --prompt 'history-insert> ' --query "$LBUFFER")
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
}
zle -N filter-history-insert

function filter-history() {
    local tac
    hash gtac 2> /dev/null && tac="gtac" || { hash tac 2> /dev/null && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | $FILTER_CMD $FILTER_OPTS --prompt 'history> ' --query "$LBUFFER")
    zle clear-screen
    zle accept-line
}
zle -N filter-history
bindkey -M viins '^ h' filter-history

function filter-cdr-impl() {
    cdr -l | \
        sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
        $FILTER_CMD $FILTER_OPTS --prompt 'cdr> ' --query "$LBUFFER"
}
function filter-cdr-insert() {
    local selected
    selected=$(cdr -l | sed -e 's/^[[:digit:]]*[[:blank:]]*//' | $FILTER_CMD $FILTER_OPTS --prompt 'cdr-insert> ')
    BUFFER=${BUFFER}${selected}
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N filter-cdr-insert

function filter-cdr() {
    local destination="$(filter-cdr-impl)"
    if [ -n "$destination" ]; then
        BUFFER="cd $destination"
        zle accept-line
    else
        zle reset-prompt
    fi
}
zle -N filter-cdr

function _advanced_tab(){
if [[ $#BUFFER == 0 ]]; then
    filter-cdr
    zle redisplay
else
    zle expand-or-complete
fi
}
zle -N _advanced_tab

bindkey -M viins '^I' _advanced_tab
bindkey -M viins '^ r' filter-cdr

if hash ghq 2> /dev/null; then
    function filter-ghq() {
        local selected_dir=$(ghq list | $FILTER_CMD $FILTER_OPTS --prompt 'ghq> ' --query "$LBUFFER")
        if [ -n "$selected_dir" ]; then
            BUFFER="cd $(ghq root)/${selected_dir}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N filter-ghq
    bindkey -M viins '^ ^g' filter-ghq
fi

if [[ "$GOPATH" != "" ]]; then
    function filter-gopath() {
        local selected=$(find "$GOPATH/src" -maxdepth 3 -mindepth 3 -name "*" -type d | $FILTER_CMD $FILTER_OPTS --prompt 'GOPATH> ' --query "$LBUFFER")
        if [ -n "$selected" ]; then
            BUFFER="cd $selected"
            zle accept-line
        else
            zle reset-prompt
        fi
    }
    zle -N filter-gopath
    bindkey -M viins '^ p' filter-gopath
fi

function filter-repos() {
    local input go vim

    input="$(ghq list | sed "s#^#$(ghq root)/#")"
    go="$(find "$GOPATH/src" -maxdepth 3 -mindepth 3 -name "*" -type d)"
    if [ -n "$go" ]; then
        input="${input}\n${go}"
    fi
    vim="$(ls -1 -d "$HOME/.vim/bundle/"*)"
    if [ -n "$vim" ]; then
        input="${input}\n${vim}"
    fi
    input="$(echo "$input" | sed "s#^$HOME#~#g")"

    local selected_dir=$(echo "${input}" | $FILTER_CMD $FILTER_OPTS --prompt 'repos> ' --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N filter-repos
bindkey -M viins '^ ^ ' filter-repos

function filter-git-log() {
    local sed
    case $OSTYPE in
    darwin*)
        sed="gsed"
        ;;
    linux*)
        sed="sed"
        ;;
    esac

    local commit
    commit=$(git log --no-color --oneline --graph --all --decorate | $FILTER_CMD $FILTER_OPTS --prompt 'git-log> ' | $sed -e "s/^\W\+\([0-9A-Fa-f]\+\).*$/\1/")
    BUFFER="${BUFFER}${commit}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N filter-git-log
bindkey -M viins '^ o' filter-git-log

function filter-ls-l-insert(){
    local selected
    selected=$(ls -l | grep -v ^total | $FILTER_CMD $FILTER_OPTS --prompt 'ls-l-insert> ' | awk '{print $(NF)}')
    BUFFER="${BUFFER}$selected"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N filter-ls-l-insert
bindkey -M viins '^ l' filter-ls-l-insert

function filter-find-insert(){
    local selected
    selected=$(find ./* | $FILTER_CMD $FILTER_OPTS --prompt 'find-insert> ')
    BUFFER="${BUFFER}${selected}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N filter-find-insert
bindkey -M viins '^ f' filter-find-insert

function filter-directory-entries() {
    if ! [ -d "$1" ]; then
        return
    fi

    local selected
    selected=$(ls -1 "$1" | $FILTER_CMD $FILTER_OPTS --prompt "$(basename "$1")> ")
    if [[ "$selected" != "" ]]; then
        echo "$1/$selected"
    fi
}

function filter-neobundle(){
    BUFFER="cd $(filter-directory-entries "$HOME/.vim/bundle")"
    zle accept-line
}
zle -N filter-neobundle
bindkey -M viins '^ b' filter-neobundle

function filter-man-list-all() {
    local parent dir file
    local paths=("${(s/:/)$(man -aw)}")
    for parent in $paths; do
        for dir in $(/bin/ls -1 $parent); do
            local p="${parent}/${dir}"
            if [ -d "$p" ]; then
                IFS=$'\n' local lines=($(/bin/ls -1 "$p"))
                for file in $lines; do
                    echo "${p}/${file}"
                done
            fi
        done
    done
}

function filter-man() {
    local selected=$(filter-man-list-all | $FILTER_CMD $FILTER_OPTS --prompt 'man> ')
    if [[ "$selected" != "" ]]; then
        man "$selected"
    fi
}
zle -N filter-man
bindkey -M viins '^ m' filter-man

function filter-git-cd() {
    local cdup
    cdup="$(git rev-parse --show-cdup 2>/dev/null)"
    if [[ $? != 0 ]]; then
        zle accept-line
        return
    fi

    local selected="$(git ls-files "$cdup" | grep '/' | sed 's/\/[^\/]*$//g' | sort | uniq | $FILTER_CMD $FILTER_OPTS --prompt 'git-cd> ')"
    if [[ "$selected" != "" ]]; then
        BUFFER="cd $selected"
        zle accept-line
    fi
}
zle -N filter-git-cd
bindkey -M viins '^ g' filter-git-cd

function filter-source(){
    local sources
    local selected_source
    sources=( \
        pgrep \
        pkill \
        history \
        history-insert \
        cdr \
        cdr-insert \
        ghq \
        git-log \
        git-cd \
        gopath \
        ls-l-insert \
        find-insert \
        locate \
        man \
        neobundle \
        repos \
    )
    selected_source=$(echo ${(j/\n/)sources} | $FILTER_CMD $FILTER_OPTS --prompt 'source> ')
    zle clear-screen
    if [[ "$selected_source" != "" ]]; then
        zle filter-${selected_source}
    fi
}
zle -N filter-source
bindkey -M viins '^ ' filter-source
# }}}
fi

##########################################
#   source platform-dependant settings   #
##########################################

case $OSTYPE in
    darwin*)

        # Git
        export PATH=$PATH:/usr/local/opt/git/share/git-core/contrib/diff-highlight

        # Linux {{{
        # export PACMAN=pacman-color
        # export BROWSER=google-chrome:firefox:$BROWSER
            # >> they only for arch && manjaro

        # for Tmux 256 bit color
        if [[ $TERM == "xterm" ]]; then
            export TERM=xterm-256color
        fi

        # cleverer umount command
        if ! hash um 2> /dev/null; then
            function um(){
                local dirs_in_media
                dirs_in_media=$(ls -l /media/ | grep -e ^d)
                if [[ "$(echo "$dirs_in_media" | wc -l)" == 1 ]]; then
                    local media_dir
                    media_dir=${"$(echo "$dirs_in_media" | head -n 1)"##* }
                    echo -n "unmounting ${media_dir}... "
                    umount $@ /media/"$media_dir"
                    $? && echo "done."
                else
                    umount $@
                fi
            }
        fi
        # }}}
        ;;
esac

# source-file $HOME/.local.zshrc

# Prevent a dog from crying at start up!
true

# TheFuck
eval $(thefuck --alias)

# npm
export NPM_CONFIG_PREFIX=~/.npm-global
export PATH=$PATH:~/.npm-global/bin

# Ruby & rbenv                                                                   
export PATH="$HOME/.rbenv/bin:$PATH"                                             
eval "$(rbenv init -)"                                                           
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# sway -> firefox == xwayland(windows manages)
# export MOZ_ENABLE_WAYLAND=1

##########################################
#   Vi------mod                          #
##########################################
bindkey -v
export KEYTIMEOUT=1
# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line
# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-r to perform backward search in history
bindkey '^r' history-incremental-search-backward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
