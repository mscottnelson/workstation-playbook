#!/bin/sh
#
# My initial config of new macbook for development
# Place this file in home directory and make it executable:
# chmod +x ./initial_mac_config.sh
# Brew should install XCode cl tools if you don't have them already

echo "::Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# make sure current owner of needed brew directories is current user
echo "::Ensuring correct ownership of directories for brew"
sudo chown -R $(whoami) /usr/local
sudo chown -R $(whoami) /Library/Caches/Homebrew

# make sure you have the latest in homebrew installed
echo "::Double checking brew is fully updated and correctly linked"
brew update
brew doctor
echo "::Continue? (select '1' or '2')"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo "::Install common *nix brew packages"
brew install bash
brew install wget
brew install git
brew install vim
brew install python

echo "::Install pretty shell oh-my-zsh, invoke with 'zsh'"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "::Install nvm (node version manager), then node 6.11.1"
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install v6.11.
echo 'nvm use v6.11.1' >> ~/.bash_profile

echo "::Install cask packages"
brew tap caskroom/cask
brew cask install google-chrome
brew cask install iterm2 # alternate terminal with better colors...very nice with oh-my-zsh
brew cask install flux # dims blues during evening hours (promotes good 'sleep hygiene')
brew cask install keepingyouawake # menubar tool: temporarily disable screen sleep
brew cask install shiftit # windows style window management (eg CMD-LEFT shifts window to left side of screen)
brew cask install atom # everyone's favorite open source extendible text editor
brew cask install visual-studio-code # except for me, this is my favorite
# brew cask install sublime-text3
brew cask install macvim # allows integrating vim into macOS GUI
brew cask install firefox
brew cask install brave # the hippest browser on the block
brew cask install daisydisk # local disk usage visualization tool
brew cask install keepassx # open source password manager
brew cask install slack
brew cask install sourcetree # git tree visualization
brew cask install the-unarchiver # additional archive support
brew cask install cyberduck # ftp etc
echo "::\033[1mVirtualbox requires password to confirm Terms and finalize installation:\033[0m"
brew cask install virtualbox
brew cask install virtualbox-extension-pack
echo "::\033[1mVagrant requires password to confirm Terms and finalize installation:\033[0m"
brew cask install vagrant # build and manage virtual machines
brew cask install vagrant-manager # superfluous vagrant GUI
brew install jfrog-cli-go # automate access to Artifactory, Bintray, Mission Control
brew install vault # token/password/certificate/API-key/etc management
brew install consul
brew cask info java # check which version will be installed
brew cask install java
brew install ant # our build tool, requires Java

echo "::Cleanup"
brew cask cleanup
brew cleanup

echo "::Install Angular and Typescript CLI globally (only needed for front-end dev)"
npm install -g @angular/cli
npm install -g typescript

echo "::Double check important versions"
java -version
node -v
ant -version
#  Note that environment variables as referenced in the project (eg ANT_HOME) can be setup by your plist config

# post-setup reminders
echo
echo "\033[1mFinal setup steps (optional):\033[0m"
echo "::\033[0mSwitch your default shell to oh-my-zsh with 'chsh -s /bin/zsh' \033[0m"
echo "::\033[0mConfigue Shiftit\033[0m"
echo "::\033[0mRun atom-packages script\033[0m"
echo "::\033[0mClone the project repo\033[0m"
