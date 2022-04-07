ZSH_GIT_PROMPT_SHOW_UPSTREAM="no"

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}⟳ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[yellow]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

function __zshrc_prompt_shortpath {
  local tmp='%~'

  if [[ ${(%)tmp} = '~' ]]; then
    echo "~"
    exit 0
  fi

  local shortpath=$(__zshrc_sdirname ${(%)tmp})
  echo "$shortpath${PWD/*\//}"
}

function __zshrc_sdirname {
  local dirn=$(dirname $1)

  local paths=(${(s:/:)dirn})

  local cur_path='/'
  local cur_short_path='/'

  if [[ ${paths[1]} == '~' ]]; then
    cur_path="$HOME/"
    cur_short_path='~/'
    paths=("${paths[@]:1}")
  fi

  for directory in ${paths[@]}
  do
    local cur_dir=''
    for (( i=0; i<${#directory}; i++ )); do
      cur_dir+="${directory:$i:1}"
      local matching=("$cur_path"/"$cur_dir"*/)
      if [[ ${#matching[@]} -eq 1 ]]; then
        break
      fi
    done
    cur_short_path+="$cur_dir/"
    cur_path+="$directory/"
  done

  echo "$cur_short_path"
}

PROMPT='%F{green}$(__zshrc_prompt_shortpath) %F{reset_color}%b$(gitprompt)%F{reset_color}$ '
RPROMPT=''
