function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

function y
    set tmp (mktemp -t yazi-cwd.XXXXXX)
    yazi $argv --cwd-file="$tmp"

    echo "TMP FILE CONTENT:"
    cat "$tmp"

    if test -s "$tmp"
        read -l cwd < "$tmp"
        echo "CWD TO CD: $cwd"
        if test -n "$cwd"; and test "$cwd" != "$PWD"
            cd "$cwd"
        end
    end

    rm -f "$tmp"
end




if status is-interactive
    set fish_greeting

    # Enable vi mode
    set -g fish_key_bindings fish_user_key_bindings
    # Source - https://stackoverflow.com/a

   function fish_user_key_bindings
         fish_vi_key_bindings
        bind -M insert -m default jj backward-char force-repaint

   end



    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
end

# PATH / editor
export PATH="$HOME/.cargo/bin:$PATH"
set -Ux PATH $HOME/.local/share/lua-language-server/bin $PATH
set -Ux PATH /usr/local/bin /usr/bin $PATH
set -Ux EDITOR nvim

