alias gits="git status"
alias nautilus-here="gtk-launch org.gnome.Nautilus.desktop ."
alias gedit="gnome-text-editor"
alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'

gitamend()
{
    git commit --amend --no-edit "$@" --date=now
}
