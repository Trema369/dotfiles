if status is-interactive
   starship init fish | source
   alias ls 'eza --icons'
   alias la 'eza -lh --icons --group-directories-first'
   alias ll 'eza -lh --icons --group-directories-first'
   alias lah 'eza -lah --icons --group-directories-first'
end
