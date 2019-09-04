# Default prompt theme
export PROMPT_THEME="bigdigsquig"

# Path of base directory (used in theme scripts to find bin folder)
export PROMPT_BASE_DIR="$HOME/bin/ptheme"

# Path of prompt theme directory (used to avoid rewriting the path)
export PROMPT_THEME_DIR="$PROMPT_BASE_DIR/themes"


prompt_command ()
{
    PS1="$("$PROMPT_THEME_DIR"/"$PROMPT_THEME" "$?")"
}

precmd_functions=(prompt_command)
