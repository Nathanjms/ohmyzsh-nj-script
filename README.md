# Oh My Zsh - Custom Install Script

## What is this?

A script file to install [Oh My Zsh](https://ohmyz.sh/) as usual, but then to also install:
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

I made this to speed up this process when instaling a different Linux Distribution. The plugins and the theme are added automatically to the `~/.zshrc`, and the theme's [recommended font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) (MesloLGS) is installed for the user.

## How to run

You can download the script file and run it with:
```shell
bash .ohmyzsh-nj-setup.sh
```
Or get it from GitHub directly with:
```shell
bash <(curl -Ls https://raw.githubusercontent.com/Nathanjms/ohmyzsh-nj-script/main/ohmyzsh-nj-setup.sh)
```

## Compatability

- This script work on any Linux distro, but the font directory may need updating if (for whatever reason) that distro does not store user fonts in `~/.local/share/fonts`
- `git` is required for this to work. 

## Future Plans

I currently have no future plans, but if I come across any plugins I like, I may add them to the script. 

Another idea is to allow the user to input which plugins to add automatically, but at the moment these are my favourite which end up on every Oh My Zsh terminal I use.
