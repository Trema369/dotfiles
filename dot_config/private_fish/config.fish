set -g fish_greeting
if status is-interactive
set -gx GOPATH $HOME/go
 starship init fish | source
   alias ls 'eza --icons'
   alias la 'eza -lh --icons --group-directories-first'
   alias ll 'eza -lh --icons --group-directories-first'
	fish_add_path ~/.local/bin
   alias lah 'eza -lah --icons --group-directories-first'
	alias bottles="flatpak run com.usebottles.bottles"
end

# kimi-code
fish_add_path -g "/home/trema/.kimi-code/bin"
