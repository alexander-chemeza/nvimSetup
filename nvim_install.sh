#!/bin/bash

echo -e "\e[93mInstalling dependencies...\e[0m"
sudo apt install gcc make ripgrep tmux xclip fd-find golang rustc ruby php-cli nodejs npm
sudo npm install -g @angular/language-server typescript-language-server eslint_d @fsouza/prettierd markdownlint-cli fixjson jsonlint nginxbeautifier

url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
filename=$(basename "$url")
echo -e "\e[93mStarting downloading of $filename ...\e[0m"
wget -N $url

if [ $? -eq 0 ]; then
    echo -e "\e[32mDownload completed successfully!\e[0m"
    echo -e "\e[93mUnpacking...\e[0m"
    tar xf $filename --overwrite
    if [ $? -eq 0 ]; then
        echo -e "\e[32mExtraction successful\e[0m"
        folder=$(basename "$filename" .tar.gz)
        sudo mv $folder /opt/nvim
        sudo ln -s /opt/nvim/bin/nvim /usr/bin/nvim
        rm $filename
        echo -e "\e[32mSymlink is created. Neovim installed. Check version with nvim --version\e[0m"

        fonts_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
        fonts_filename=$(basename "$fonts_url")
        fonts_folder=$(basename "$fonts_filename" .zip)
        echo -e "\e[93mFonts downloading...\e[0m"
        wget -N $fonts_url
        if [ $? -eq 0 ]; then
            echo -e "\e[32mFonts downloaded successfully\e[0m"
            echo -e "\e[93mUnpacking...\e[0m"
            unzip -o $fonts_filename -d ./$fonts_folder
            if [ $? -eq 0 ]; then
                echo -e "\e[32mExtraction successful\e[0m"
                sudo mv $fonts_folder /usr/share/fonts
                rm $fonts_filename
            else
                echo -e "\e[31mExtraction failed!\e[0m" >&2
                exit 1
            fi
        else
            echo -e "\e[31mDownload failed!\e[0m" >&2
            exit 1
        fi
    else
        echo -e "\e[31mExtraction failed!\e[0m" >&2
        exit 1
    fi
else
    echo -e "\e[31mDownload failed!\e[0m" >&2
    exit 1
fi

echo -e "\e[93mApplying configs...\e[0m"
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

mkdir ~/.config/nvim
cp -r ./lua ./init.lua ./lazy-lock.json ~/.config/nvim
echo -e "\e[32mConfigs applied...\e[0m"

repo_folder=$(pwd)
read -p "Do you want to delete cloned repository directory '$repo_folder' and its contents? [y/N] " -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Move up one level
    cd ..
    # Remove the directory
    rm -rf "$repo_folder"
    echo "Directory '$repo_folder' has been removed."
else
    echo "Directory was not deleted."
fi
