# Delta
# Reference/Resources:
#
# Prompt Expansion:
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# http://unix.stackexchange.com/questions/157693/howto-include-output-of-a-script-into-the-zsh-prompt
#
# vcs_info
# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information

delta_prompt_title() {
    print -n '\e]0;'

    print -Pn '%~'

    print -n '\a'
}

delta_prompt_precmd() {
    vcs_info

    delta_prompt_title

    if [[ -z ${vcs_info_msg_0_} ]]; then
        print ""
        PROMPT=" %F{red}Δ%f %c > "
    else
        print ""
        PROMPT=" %F{red}Δ%f %c (${vcs_info_msg_0_}) > "
    fi
}

delta_prompt_init() {
    export PROMPT_EOL_MARK=''

    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    add-zsh-hook precmd delta_prompt_precmd

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' use-simple true
    zstyle ':vcs_info:git*' formats '%b'
    zstyle ':vcs_info:git*' actionformats '%b|%a'

    zstyle ':vcs_info:*' max-exports 2
}

delta_prompt_init "$@"
