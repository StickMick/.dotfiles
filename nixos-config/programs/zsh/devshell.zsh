eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
alias cd=z
vis() { nvim $(fzf --query="$1" --preview 'bat --style=numbers --color=always {}') }
