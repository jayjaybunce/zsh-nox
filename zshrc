# Base path of zsh-nox and some other good to know stuff.
ZSHNOX=$(dirname $(readlink $HOME/.zshrc))
ZSH_CUSTOM="$ZSHNOX/custom"

# Path to your oh-my-zsh configuration.
ZSH=$ZSHNOX/external/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="nox"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(yes_iam_lazy autoswitch_virtualenv_classic)

# For autoswitch_virutalenv_classic
AUTOSWITCH_VIRTUALENV_NAME="pyenv"
# Silence autoswitch_virutalenv_classic
# AUTOSWITCH_VIRTUALENV_SILENT="yes"

# Default PATH, override in $HOME/.zshnox
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

# Load profile.d
if [ -d /etc/profile.d ]; then
	for i in /etc/profile.d/*.sh; do
		if [ -r $i ]; then
			. $i
		fi
	done
	unset i
fi

if [[ -f $HOME/.zshnox ]]; then
	source $HOME/.zshnox
fi

source $ZSH/oh-my-zsh.sh

if [[ "$OSTYPE" = linux* ]]; then
	eval $(dircolors)
	alias ls='ls --color=auto'
elif [[ "$OSTYPE" = darwin* ]]; then
	alias ls='ls -G'
fi

if [[ ! -n "${EDITOR+1}" ]]; then
	AVAILABLE_EDITOR=("${(f)$(which vim vim.tiny vim.basic joe nano)}")
	for AV in $AVAILABLE_EDITOR; do
		if [[ -x "$AV" ]]; then
			# Found a editor
			EDITOR=$(basename $AV)
			break
		fi
	done

	# Sane default setup for EDITOR
	# Override in $HOME/.zshnox
	if [[ $EDITOR == "vim*" ]]; then
		export EDITOR
	elif [[ $EDITOR == "joe" ]]; then
		EDITOR="$EDITOR -nobackups"
		export EDITOR
	elif [[ $EDITOR == "nano" ]]; then
		EDITOR="$EDITOR -w"
		export EDITOR
	fi
fi

# Override in $HOME/.zshnox
if [[ ! -n "${LANG+1}" ]]; then
	export LANG="en_US.UTF-8"
	export LC_CTYPE="sv_SE.UTF-8"
fi

# Syntax highlighting for command line, needs to be loaded last
source $ZSHNOX/external/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
