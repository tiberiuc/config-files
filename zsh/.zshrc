# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="TheOne"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(extract history git vi-mode history-substring-search brew macos tmux mix npm docker web-search zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
command_exists () {
  type "$1" &> /dev/null ;
}
if command_exists dircolors; then
  eval `dircolors ~/.dir_colors`
fi

# Customize to your needs...
export PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.gem/ruby/3.0.0/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH

export VIRTUAL_ENV_DISABLE_PROMPT=true

#enable vi keybindings
bindkey -v

# Make 'z' work like autojump.
alias j="z"
# Slash after directories, colorize, KB,MB,... when appropriate
alias ls='ls -GFh'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Disable setting of terminal titles.
DISABLE_AUTO_TITLE="true"

# Show red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

###############################################################################
# Enable history substring search with vi and emacs keys. Much more intuitive!
# From https://github.com/zsh-users/zsh-history-substring-search/issues/12
bindkey -M emacs "^P" history-substring-search-up
bindkey -M emacs "^N" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" '\e[A' history-substring-search-up
    bindkey -M "$keymap" '\e[B' history-substring-search-down
done
unset keymap

# Remove the ugly pink default color!
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white,bold'

#. ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# source ~/.shell-prompt.sh
# PROMPT="%B%{$fg[blue]%}[%{$fg[white]%}%{$fg[white]%}%n%{$fg[blue]%}]%{$reset_color%}%  %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} '
# RPROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zleush-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

export TERM=screen-256color

# gitall
function gall () {
  git add .
  if [ "$1" != "" ] # or better, if [ -n "$1" ]
  then
    git commit -am "$1"
  else
    git commit -am update
  fi
  git push
}

function rssh () {
  local -a arr

  arr=()

  local addr=("${(@s/:/)1}")
  arr+=$addr[1]
  if [ "${addr[2]}" != "" ]
  then
    arr+="-p"
    arr+=$addr[2]
  fi

  # local sPORTS="${@:2}"

  for PORT in "${@:2}"; do
    arr+="-L"
    arr+="${PORT}:localhost:${PORT}"
  done

  ssh $arr
}

alias rssh='rssh'
alias tmux='tmux -2'
alias mc="mc --nosubshell"
alias v='lvim'
alias m='vifm'
alias c='cd'
alias co='git checkout'
alias up='git up'
alias push='git push'
alias pull='git pull'
alias add='git add .'
alias com='git commit -am'
alias gall='gall'
alias g='git'
alias gf='git flow'
alias status='git status'
alias gs='git status'
alias gd='git diff'
alias gl='lazygit'
alias feature='git flow feature'
alias hotfix='git flow hotfix'
alias fstart='git flow feature start'
alias ffinish='git flow feature finish'
alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias r='ranger'
alias rc='rake clean'
alias dev='git checkout develop'
alias master='git checkout master'
alias merge='git merge'
alias nn='/usr/sbin/n'
alias n='nnn'

# docker aliases
alias d='docker'
alias de='docker exec -it'
alias dl='docker logs -f'
alias dps='docker ps -a'
alias db='docker build'
alias di='docker images'
alias drm='docker rm -f'
alias drmi='docker rmi -f'
alias dr='docker run'
alias dco='docker-compose'
alias dcr='dcr(){ docker-compose run $1 sh  }; dcr'
alias dce='dce(){ docker-compose exec $1 sh  }; dce'
alias dcre='docker-compose restart'
alias dcl='docker-compose logs -f'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

unalias gm

export EDITOR=lvim

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'


transfer() {
  # check arguments
  if [ $# -eq 0 ];
  then
    echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
    return 1
  fi

  # get temporarily filename, output is written to this file showrogress can be showed
  tmpfile=$( mktemp -t transferXXX )

  # upload stdin or file
  file=$1

  if tty -s;
  then
    basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g')

    if [ ! -e $file ];
    then
      echo "File $file doesn't exists."
      return 1
    fi

    if [ -d $file ];
    then
      # zip directory and transfer
      zipfile=$( mktemp -t transferXXX.zip )
      cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
      curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
      rm -f $zipfile
    else
      # transfer file
      curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
    fi
  else
    # transferipe
    curl --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
  fi

  # cat output link
  cat $tmpfile

  # cleanup
  rm -f $tmpfile
}




# Start tmux at login
if [ -z $MC_SID ]; then
  if [ -z $TMUX ]; then
    if [[ ! "$OSTYPE" == "darwin"*  ]]; then
      TERM=screen-256color tmux attach || tmux
    fi
  fi
fi
export PATH="/home/linuxbrew/.linuxbrew/Homebrew/bin:$PATH"
export PATH=$HOME/.asdf/shims/:/opt/asdf-vm/bin:/home/tibi/.cargo/bin:$PATH
#source /usr/share/nvm/init-nvm.sh


export FLYCTL_INSTALL="/home/tibi/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

export EDITOR=lvim
export BROWSER=brave
export _JAVA_AWT_WM_NONREPARENTING=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
