#### Requirements
- git
- curl
- tmux
- vim
- fonts-powerline

```
apt-get update && apt-get install git curl tmux vim fonts-powerline xclip
```

#### Installation

Clone the repository to your home directory.
```
cd ~
git clone https://github.com/jfortunato/dotfiles.git .dotfiles
```

Symlink all the configs to the home directory.
> **Warning:** this will overwrite any existing files.
```
./.dotfiles/install.sh
```

Install vim plugins
```
vim
```
