#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=7300

#PS1='[\u@\h \W]\$ '
PS1='\[\e[1;32m\]$EMO Arch`uname -sr` >>>> \[\e[1;5;42;31m\]$FES\[\e[0m\]\n'
PS1+='  \[\e[01;35m\]\\~> \d @ \w\n'
PS1+='   \[\e[01;34m\]\\~> \u@\h\$\[\e[01;36m\] '

alias ls='ls --color=auto'
alias vi='vim'
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias sudo='cowsay -f tux "If you have the power to continue, use it wisely"; sudo'
alias clear="printf '\033[2J\033[3J\033[1;1H'"

export Programs='/home/xchel/Documents/softshell'
export Silicon='/home/xchel/Documents/Silicio'
export Web='/home/xchel/Documents/xchelnet'
export Made='/home/xchel/Documents/softshell/Java/Madeni'

shopt -s globstar
shopt -s extglob

Options=(alien armadillo atat atom C3PO cake cat dalek dolphin dragon fox fsm ghost ghostbusters happy-whale jellyfish llama link-windwaker nyan octopus owl r2d2 rocko seahorse stegosaurus turtle tux-big tux walter whale yoda yoshi)

#El=`rand -M ${#Options[*]}`
if [ $(($RANDOM%3)) = 0 ]; then
   cbonsai -lpt .003 -m "Here's the fortune!!!";echo ""; fortune -a;
else
   El=$(($RANDOM%${#Options[*]}))

   if [ "${Options[$El]}" = "fsm" -o "${Options[$El]}" = "link-windwaker" -o "${Options[$El]}" = "r2d2" -o "${Options[$El]}" = "rocko" -o "${Options[$El]}" = "walter" -o "${Options[$El]}" = "yoda" -o "${Options[$El]}" = "yoshi" ]; then
	cowsay -f "${Options[$El]}" "Here's the fortune of the moment!
	--${Options[$El]}"; echo "
	"; fortune -ac;
   else
	cowsay -f "${Options[$El]}" "Here's the fortune of the moment!
	--${Options[$El]}" | lolcat; echo "
	"; fortune -ac;
   fi
fi
