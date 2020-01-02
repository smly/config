# smly/config

<div align="center"><img src="https://raw.githubusercontent.com/smly/config/master/dev_env_thumb.png" width="768"/></div>

Last update: 2020-01-02

* terminal emulator: urxvt (w/o icons), Terminator (with icons)
* font: SFMonoSquare + Nerd Font patch, disable RGBA antialiasing
* editor: nvim (color: onedark)
* browser: chrome 50%, qutebrowser 50%
* tmux: tmux-battery, tmux-cpu, tmux-mem-cpu-load, tmux-wifi
* window manager: evilwm fork, xlock-howdy fork + rofi support

メモ: urxvt は emoji/icon を簡単に表示できない一方で Terminator は何も躓くことなく設定できた。
その代わり Terminator + nvim で NERDTree を表示したときカーソル移動に 500ms ほど遅延が発生してしまった。
emoji/icon を表示しないき urxvt + nvim だとそういった問題は起きなかったので、emoji/icon は諦めて urxvt を使う。
