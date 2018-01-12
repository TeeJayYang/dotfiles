#!/usr/bin/env bash

## Get current dirctory
export DOTFILES_DIR
DOTFILES_DIR=$(pwd)

shopt -s nullglob
shopt -s dotglob

## Link to ~
for folder in vim system; do
    for f in $DOTFILES_DIR/$folder/*; do
        ln -sfv "$f" ~
    done
done

## Link to ~/.$folder
for folder in bin; do
  # rm -rf ~/.$folder
  mkdir -pv ~/.$folder
  for f in $DOTFILES_DIR/$folder/*; do
    ln -sfv "$f" ~/.$folder
  done
done

## Link to .config/$folder
for folder in compton i3 i3status; do
    mkdir -pv ~/.config/$folder
    for f in $DOTFILES_DIR/$folder/*; do
        ln -sfv "$f" ~/.config/$folder
    done
done

