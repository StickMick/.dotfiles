eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
alias cd=z
vis() { nvim $(fzf --query="$1" --preview 'bat --style=numbers --color=always {}') }
export PATH="$PATH:$HOME/.dotnet/tools"
if command -v dotnet &> /dev/null; then
    export DOTNET_ROOT=$(dirname $(realpath $(which dotnet)))
fi
