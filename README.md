#### Requirements
- nix

#### Installation

Clone the repository to your home directory.
```
cd ~
git clone https://github.com/jfortunato/dotfiles.git .dotfiles
```

Allow nix home-manager to configure everything.
```
nix run home-manager -- init ~/.dotfiles/nix/
```

Install vim plugins
```
vim
```

#### Updating Packages

All the packages can be updated by running:

```
nix flake update --commit-lock-file
```

However since I'd like package updates to happen more frequently I'd rather not pollute the commit history with a bunch of these commits. Instead I can just live on a different branch, update as often as needed, and then periodically squash merge back into the main branch.
