#!/bin/bash

rm ~/.bashrc ~/.zshrc ~/.vimrc ~/.p10k.zsh ~/.profile ~/.config/kitty/kitty.conf
ln -s ${PWD}/bash ~/.bashrc
ln -s ${PWD}/zsh ~/.zshrc
ln -s ${PWD}/vim ~/.vimrc
ln -s ${PWD}/p10k ~/.p10k.zsh
ln -s ${PWD}/profile ~/.profile
ln -s ${PWD}/kitty ~/.config/kitty/kitty.conf
