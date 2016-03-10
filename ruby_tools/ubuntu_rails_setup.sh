#!/bin/bash
sudo apt-get -y update && sudo apt-get -y upgrade 
sudo apt-get install -y  build-essential git libssl-dev libreadline-dev zlib1g-dev sqlite3 libsqlite3-dev nodejs

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

cd ~/.rbenv && src/configure && make -C src
cd ~

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"'  >> ~/.bashrc

source ~/.bashrc

rbenv install 2.3.0

rbenv rehash

rbenv global 2.3.0

gem install rails
