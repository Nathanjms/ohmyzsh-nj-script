# Oh My Zsh - Custom Install Script

## What is this?

A script file to install [Oh My Zsh](https://ohmyz.sh/) as usual, but then to also install:
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

I made this to speed up this process when installing a different Linux Distribution. The plugins and the theme are added automatically to the `~/.zshrc`, and the theme's [recommended font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) (MesloLGS) is installed for the user.

## How to run

You can download and run the script file directly from GitHub with:
```shell
bash <(curl -Ls https://raw.githubusercontent.com/Nathanjms/ohmyzsh-nj-script/main/ohmyzsh-nj-setup.sh)
```
Or you can download the script file and run it with:
```shell
bash ./ohmyzsh-nj-setup.sh
```

## Compatibility

- This script work on any Linux distro, but the font directory may need updating if (for whatever reason) that distro does not store user fonts in `~/.local/share/fonts`
- This script should also work on Mac (Untested currently)
- `git` is required for this to work (and `curl`, but this is a dependency of `git`).

## Future Plans

I currently have no future plans, but if I come across any plugins I like, I may add them to the script. 

Another idea is to allow the user to input which plugins to add automatically, but at the moment these are my favourite which end up on every Oh My Zsh terminal I use.

#### *"Never spend 6 minutes doing something by hand when you can spend 6 hours failing to automate it."* - [Zhuowei Zhang](https://twitter.com/zhuowei/status/1254266079532154880?lang=en-GB)
