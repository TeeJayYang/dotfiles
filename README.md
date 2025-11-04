# dotfiles
Configs for Linux

# Software
```
distro          ->  ubuntu
de/wm           ->  i3-gaps w/ polybar
editor          ->  vim
file explorer   ->  ranger
image viewer    ->  sxiv (unused)
pdf viewer      ->  zathura (unused)
shell           ->  bash
terminal        ->  urxvt
dmenu           ->  rofi
```

# Screenshots
![](screenshots/dirty.png "Dirty")

# Installation

1. Clone the repository
```
git clone https://github.com/TeeJayYang/dotfiles.git
cd dotfiles
```

2. Create and source a virtual environment
```
python -m venv venv
source venv/bin/activate
```

3. Install and run `dotinstall`
```
pip install dotinstall
dotinstall
```

4. Restart your computer and select i3 as your desktop environment
