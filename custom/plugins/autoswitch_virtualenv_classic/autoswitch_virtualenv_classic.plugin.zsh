# Original: https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv/blob/master/autoswitch_virtualenv.plugin.zsh
# Modified to work with normal https://pypi.python.org/pypi/virtualenv in working directory

function _maybeswitch() {
  if [[ -z "$VIRTUAL_ENV" ]]; then
     if [ -z "$AUTOSWITCH_VIRTUALENV_SILENT" ]; then
        printf "Switching virtualenv: %s  " $1
     fi

     source "$1/bin/activate"

     if [ -z "$AUTOSWITCH_VIRTUALENV_SILENT" ]; then
       # For some reason python --version writes to stderr
       printf "[%s]\n" "$(python --version 2>&1)"
     fi
  fi
}


# Gives the path to the nearest parent .venv file or nothing if it gets to root
function _check_venv_path()
{
    local check_dir=$1

    if [[ -f "${check_dir}/$AUTOSWITCH_VIRTUALENV_NAME/bin/activate" ]]; then
        echo "${check_dir}/$AUTOSWITCH_VIRTUALENV_NAME"
        return
    else
        if [ "$check_dir" = "/" ]; then
            return
        fi
        _check_venv_path "$(dirname "$check_dir")"
    fi
}


# Automatically switch virtualenv when $AUTOSWITCH_VIRTUALENV_NAME directory is detected
function check_venv()
{
    if [ "$PWD" != "$MYOLDPWD" ]; then
        MYOLDPWD="$PWD"

        # Get the $AUTOSWITCH_VIRTUALENV_NAME directory, scanning parent directories
        venv_path=$(_check_venv_path "$PWD")

        if [[ -n "$venv_path" ]]; then
          _maybeswitch "$venv_path"
        elif [[ -n "$VIRTUAL_ENV" ]]; then
          deactivate
        fi
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook -D chpwd check_venv
add-zsh-hook chpwd check_venv

# auto-detect virtualenv on zsh startup
[[ -o interactive ]] && check_venv
