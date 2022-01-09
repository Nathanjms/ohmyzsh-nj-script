#!/bin/sh

# An installer of oh-my-zsh with powerlevel10k, zsh-auto-suggestions, and zsh-syntax-highlighting automatically installed.
# Note: Please ensure you already have zsh installed when running this script.
# Run the scrip with `bash ./zsh-setup.sh`

echo "Creating temporary directory..."
echo
mkdir ./ohmyzsh-nj-setup
cd ./ohmyzsh-nj-setup

#Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git not found, please install it."
    exit 1
fi

# Get and Run the ohmyzsh install.sh (passing variable to make it not launch when ran)
echo "Installing oh-my-zsh..."
echo
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
RUNZSH='no' sh install.sh

# Getting recommended fonts
echo "Downloading recommended fonts..."
echo
curl --remote-name-all https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20{Regular,Italic,Bold,Bold%20Italic}.ttf

# Installing fonts (by moving them into fonts directory)
echo "Installing fonts..."
echo
fontsdir=~/.local/share/fonts/meslo

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
echo "Removing temporary directory and all files..."
echo
cd .. && rm -rf ./zsh-setup 

echo "Success! Reboot terminal to configure powerlevel10k."
echo
echo "Note: You will have to manually update your terminal's font to use the MesloLGS for power level 10k to look render correctly."
