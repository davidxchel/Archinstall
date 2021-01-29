#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias sudo='cowsay -f tux "If you have the power to continue, use it wisely"; sudo'
PS1='\e[01;32m\]<o__o> `uname -sr`\n  \e[01;35m\~> \d @ \w\n   \e[01;34m\~> \u@\h\$ \e[01;36m'

export Programs='/home/xchel/Documents/softshell'
export Silicon='/home/xchel/Documents/Silicio'
export Web='/home/xchel/Documents/xchelnet'
export Made='/home/xchel/Documents/softshell/Java/Madeni'
HISTSIZE=7300

Options=(alien armadillo atat atom C3PO cake cat dalek dolphin dragon fox fsm ghost ghostbusters happy-whale jellyfish kangaroo llama link-windwaker nyan octopus owl r2d2 rocko seahorse stegosaurus turtle tux-big tux walter whale yoda yoshi)
#El=`rand -M ${#Options[*]}`
El=$(($RANDOM%${#Options[*]}))

if [ "${Options[$El]}" = "fsm" -o "${Options[$El]}" = "link-windwaker" -o "${Options[$El]}" = "r2d2" -o "${Options[$El]}" = "rocko" -o "${Options[$El]}" = "walter" -o "${Options[$El]}" = "yoda" -o "${Options[$El]}" = "yoshi" ]; then
	cowsay -f "${Options[$El]}" "Here's the fortune of the moment!
	--${Options[$El]}"; echo "
	"; fortune -a;
else
	cowsay -f "${Options[$El]}" "Here's the fortune of the moment!
	--${Options[$El]}" | lolcat; echo "
	"; fortune -a;
fi
