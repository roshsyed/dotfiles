export LOCAL_CONFIG="$HOME/.config"
export EDITOR_CONFIG="$LOCAL_CONFIG/nvim/lua"

if command -v nvim &> /dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vi
fi
