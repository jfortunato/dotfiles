#### Requirements
- nix

#### Installation

First install the nix package manager.
```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Once nix is installed, we don't even have to clone the repository. We can just use the flake to install everything.
```
nix --extra-experimental-features "nix-command flakes" run home-manager -- --extra-experimental-features "nix-command flakes" switch --flake github:jfortunato/dotfiles?dir=nix
```

> The experimental features can be added to the nix configuration file to avoid having to specify them every time.

> Some files may need to be removed from the home directory, like a pre-existing .bashrc or .profile.

> Restart after running the above command to ensure all changes take effect.

Install vim plugins
```
vim
```

#### Usage

Instead of working with a remote git repository, we can clone the repository and work with it locally.
```
cd ~
git clone https://github.com/jfortunato/dotfiles.git .dotfiles
```

Now we can work locally and tell home-manager to use the flake in the local repository.
```
home-manager switch --flake ~/.dotfiles/nix
```

#### Updating Packages

All the packages can be updated by running:

```
nix flake update --commit-lock-file
```

However since I'd like package updates to happen more frequently I'd rather not pollute the commit history with a bunch of these commits. Instead I can just live on a different branch, update as often as needed, and then periodically squash merge back into the main branch.
