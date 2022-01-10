#!/usr/bin/env bash

# An installer of oh-my-zsh with powerlevel10k, zsh-auto-suggestions, and zsh-syntax-highlighting automatically installed.
# Note: This script assumes you already have zsh installed when running this script.
# Run the script with `bash ./zsh-setup.sh`

#Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git not found, please install it."
    exit 1
fi

function checkMacOrLinux {
    if [[ -z "$1" ]] \
    || [[ "$1" = "Linux" ]] \
    || [[ "$1" = "linux" ]] \
    || [[ "$1" = "l" ]] \
    || [[ "$1" = "L" ]]  \
    ;
    then
        doubleConfirmOs "linux"
        echo -n "Linux Chosen. "
        fontsDir=~/.local/share/fonts/meslo
    elif [[ "$1" = "Mac" ]] \
        || [[ "$1" = "mac" ]] \
        || [[ "$1" = "m" ]] \
        || [[ "$1" = "M" ]] \
    ;
    then
        macWarningMessage
        doubleConfirmOs "mac"
        echo -n "Mac Chosen. "
        fontsDir=~/Library/Fonts/meslo
    else
        echo "Invalid choice. Exiting."
        exit 1
    fi
}

function macWarningMessage {
    macMsg="Note: I have not fully tested the Mac version of this script, and will do so once I need to"
    macMsg="$macMsg reinstall Oh My Zsh onto a Mac. Do you wish to continue (and test this for me!?) [$(tput bold)Y$(tput sgr0)|n]: "
    read -p "$macMsg" macContinueWarning
    if [[ -z "$macContinueWarning" ]] \
    || [[ "$macContinueWarning" = "Y" ]] \
    || [[ "$macContinueWarning" = "y" ]] \
    ;
    then
        echo
        echo "Good Luck!"
        echo
    else
        echo
        echo "Exiting... Feel free to come back once it's been tested!"
        exit 1
    fi
}

function doubleConfirmOs {
    unameOut="$(uname -s)"
    if [[ ( "$unameOut" == "Darwin" && "$1" == "linux" ) || ( "$unameOut" == "Linux" && "$1" == "mac" ) ]]; then
        read -p "Alert: Detected different OS compared to choice. Continue? [$(tput bold)Y$(tput sgr0)|n]: " doubleconfirmContinue      
        if [[ -z "$doubleconfirmContinue" ]] \
        || [[ "$macContinueWarning" = "Y" ]] \
        || [[ "$macContinueWarning" = "y" ]] \
        ;
        then
            echo
            echo "Continuing..."
            echo
        else
            echo
            echo "Exiting..."
            exit 1
        fi
    fi
}

# Determine fonts directory by checking if using Mac or Linux.
read -p "Are you installing on Mac or Linux? [$(tput bold)(L)inux$(tput sgr0)|(M)ac]: " macOrLinux
echo
checkMacOrLinux $macOrLinux

echo "Setting fonts directory to ${fontsDir}..."
echo

echo "Creating temporary directory for script..."
echo
mkdir ./ohmyzsh-nj-setup
cd ./ohmyzsh-nj-setup

# Get and Run the ohmyzsh install.sh (passing variable to make it not launch when ran)
echo "Installing oh-my-zsh..."
echo
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
RUNZSH='no' sh install.sh

# Getting recommended fonts
echo "Downloading recommended fonts..."
echo
curl --remote-name-all https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20{Regular,Italic,Bold,Bold%20Italic}.ttf

# Installing fonts (by moving them into fonts directory)
echo "Installing fonts..."
echo

# Check for dir, if not found create it using the mkdir
[ ! -d "$fontsdir" ] && mkdir -p "$fontsdir"
mv -t $fontsdir MesloLGS%20NF%20Regular.ttf MesloLGS%20NF%20Italic.ttf MesloLGS%20NF%20Bold.ttf MesloLGS%20NF%20Bold%20Italic.ttf

# Get powerlevel10k from github and put into folder
echo "Getting powerlevel10k theme from github..." 
echo
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Applying powerlevel10k theme to .zshrc by changing the default (ZSH_THEME="robbyrussell")
echo "Applying p10k theme to .zshrc..."
echo
sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/" ~/.zshrc

# Get zsh-auto-suggestions
echo "Getting zsh-auto-suggestions..."
echo
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
additionalPlugins='zsh-auto-suggestions'

# Get zsh-syntax-highlighting
echo "Getting zsh-syntax-highlighting..."
echo
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
additionalPlugins="${additionalPlugins} zsh-syntax-highlighting"

# Find plugins section and update
echo "Adding plugins to ~/.zshrc"
echo
sed -i "s/plugins=(git)/plugins=(git ${additionalPlugins})/" ~/.zshrc

# Clean up
echo "Cleaning up..."
echo
cd .. && rm -rf ./zsh-setup 

echo "Success! Reboot terminal to configure powerlevel10k."
echo
echo "Note: You will have to manually update your terminal's font to use the MesloLGS for power level 10k to look render correctly."
