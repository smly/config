escape ^]^]

termcapinfo xterm 'is=\E[r\E[m\E[2J\E[H\E[?7h\E[?1;4;6l'
flow off
# key bindings
bindkey -k k1 select 0
bindkey -k k2 select 1
bindkey -k k3 select 2
bindkey -k k4 select 3
bindkey -k k5 select 4
bindkey -k k6 select 5
bindkey -k k7 select 6
bindkey -k k8 select 7
bindkey -k k9 select 8

bind ^w windowlist -b

#bind -c REGION S split
#bind -c REGION ^v split -v
#bind -c REGION v split -v
bind -c REGION o only
bind -c REGION c remove
bind -c REGION h focus up
bind -c REGION j focus down
bind -c REGION k focus up
bind -c REGION l focus down
bind -c REGION r command -c resize
bind w command -c REGION

## http://www.rubyist.net/~rubikitch/computer/screen/#label:11
bind r eval 'echo "Resize window"' 'command -c RESIZE'
bind -c RESIZE ^]  command
bind -c RESIZE j eval 'resize +1' 'command -c RESIZE'
bind -c RESIZE k eval 'resize -1' 'command -c RESIZE'
bind -c RESIZE h eval 'resize -v -1' 'command -c RESIZE'
bind -c RESIZE l eval 'resize -v +1' 'command -c RESIZE'

#bind ^l layout next
#bind -c LAYOUT s layout show
#bind -c LAYOUT t layout title
#bind l command -c LAYOUT
#layout save desktop1

bind ^G
bind g

# options

defbce on
term xterm-256color
defscrollback 4000
vbell off

## caption & status
# Color table:
# 0 Black . leave color unchanged
# 1 Red b blue
# 2 Green c cyan
# 3 Brown / yellow d default color
# 4 Blue g green b bold
# 5 Purple k blacK B blinking
# 6 Cyan m magenta d dim
# 7 White r red r reverse
# 8 unused/illegal w white s standout
# 9 transparent y yellow u underline
caption splitonly "%3n %f %t"
hardstatus alwayslastline "%{gk}]: %-w %{..w}%{!}%n%f%t%{gk} %+w %=  %{..r}%0`"

#backtick 0 0 0 ${HOME}/.screen/backtick.rb
#backtick 1 0 0 ${HOME}/.screen/feed.rb

hardcopydir ${HOME}/.screen

cjkwidth on
