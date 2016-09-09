I recomend create backup of current $HOME/.emacs.d and $HOME/.emacs

> rm $HOME/.emacs
> ln -s $PATH_REPOS/dot-files/.emacs.d/init.el $HOME/.emacs.d/init.el
> ln -s $PATH_REPOS/dot-files/.emacs.d/settings $HOME/.emacs.d/settings

JS completion:
git clone https://github.com/ternjs/tern.git
cd tern
npm

add path to tern into $PATH

