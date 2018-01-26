function collapse_pwd {
	echo $(pwd | sed -e "s,^$HOME,~,")
}

PROMPT='$(git_prompt_info)%{$fg[magenta]%}%n%{$reset_color%}@%(#.%{$fg[red]%}.%{$fg[yellow]%})%m%{$reset_color%}:%{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}%(#.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg[blue]%}(%{$reset_color%}%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} %{$fg_bold[red]%}»%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
