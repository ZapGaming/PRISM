# PRISM OS Live Auto-Start
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Auto-start X on tty1 (live mode)
if [[ -z $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
    echo "🌈 Starting PRISM OS..."
    sleep 1
    exec startx
fi
