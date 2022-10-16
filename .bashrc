# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide files.
source /etc/bashrc

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1='\u@\h \w [env]\$ '
else
    PS1='\u@\h \w\$ '
fi

alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias pollute='source $HOME/.bin/pollute.sh'

bind '"\e[3;5~":kill-word'
bind '"\C-h":backward-kill-word'


# Theming
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

PS1="\[\033[01;34m\]\w\[\033[01;35m\]\$(parse_git_branch) \[\033[00m\]\[\033[01;32m\]λ\[\033[00m\] "
