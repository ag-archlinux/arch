#!/bin/bash
#####     Created by: ag
#####     File: install3.sh
#####     --------------------------------------------------
#####  INPUTS                                  #####
	##### username
	echo -n "Window manager: (dwm or bspwm) "
	read DM
	if [ "$DM" != "dwm" ] && [ "$DM" != "bspwm" ] ;then
		exit 1
    fi
#####     -------------------------------------------------- 
	  # B. LOGIN AS USER  	
	##### a) update & xorg & important packages
		sudo pacman --noconfirm --needed -Syu
		sudo pacman --noconfirm --needed -S xorg-server xorg-xinit xorg-xsetroot xorg-apps gcc make pkg-config libx11 libxft libxinerama libxcb xcb-util xcb-util-keysyms xcb-util-wm
	##### b) install aur helpers
		sudo pacman -S git
		cd $HOME
		  ##  install yay  #####
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd $HOME
		  ##  install trizen  #####
		git clone https://aur.archlinux.org/trizen.git
		cd trizen
		sudo makepkg -si
		cd $HOME
	##### c) another programs
		sudo pacman --noconfirm --needed -S filezilla gimp inkscape firefox neovim rxvt-unicode zip unrar unzip ranger htop libreoffice
		sudo pacman --noconfirm --needed -S scrot w3m lynx atool highlight xclip mupdf mplayer transmission-cli openssh
		sudo pacman --noconfirm --needed -S ncmpcpp wget zathura zathura-pdf-poppler 2conky 
		sudo pacman --noconfirm --needed -S nitrogen compton youtube-dl sxiv entr feh sxiv
		sudo pacman --noconfirm --needed -S gimp kodi qrencode netcat feh mediainfo
		sudo pacman --noconfirm --needed -S termbin neomutt urlview expac hwinfo reflector
		  # sound
		sudo pacman --noconfirm --needed -S pulseaudio pulseaudio-alsa pavucontrol alsa-utils alsa-plugins alsa-lib alsa-firmware gstreamer gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly volumeicon playerctl
		  # bluetooth
		sudo pacman -S --noconfirm --needed pulseaudio-bluetooth bluez bluez-libs bluez-utils blueberry
		  # printers
		sudo pacman --noconfirm --needed -S ghostscript gsfonts gutenprint gtk3-print-backends libcups hplip system-config-printer
		  # fonts
		sudo pacman --noconfirm --needed -S adobe-source-sans-pro-fonts cantarell-fonts noto-fonts terminus-font ttf-bitstream-vera ttf-dejavu ttf-droid ttf-inconsolata ttf-liberation ttf-roboto ttf-ubuntu-font-family tamsyn-font
	##### #) graphics driver & dislpay manager	
		lspci | grep -e VGA -e 3D
		#sudo pacman -S lightdm
		#sudo pacman -S lightdm-gtk-greeter lightdm-gtk-greeter-settings
     	#sudo systemctl enable lightdm.service
    ##### d) window manager => git & packages
    	cd $HOME
		sudo pacman --noconfirm --needed -S git wget
		git clone https://github.com/ag-archlinux/arch-dwm

		git clone https://git.suckless.org/dmenu
		git clone https://git.suckless.org/st
		sudo pacman --noconfirm --needed -S gcr webkit2gtk
		git clone https://git.suckless.org/surf
		
		cd $HOME/dmenu/ && sudo make clean install
		cd $HOME/st/   && sudo make clean install
		cd $HOME/surf/ && sudo make clean install
		if [ "$DM" = "dwm" ] ;then
			cd $HOME
			git clone https://git.suckless.org/dwm	
			cd $HOME/dwm/   && sudo make clean install
		fi
		if [ "$DM" = "bspwm" ]; then
			sudo pacman --noconfirm --needed -S bspwm sxhkd
		fi
	##### e) copy my config files
		  ## .xinitrc
		cp $HOME/arch-dwm/home/.xinitrc $HOME/.xinitrc
		  ## bspwm
		mkdir $HOME/.config/bspwm
		cp $HOME/arch-dwm/home/config/bspwm/bspwmrc.sh $HOME/.config/bspwm/bspwmrc
		chmod +x $HOME/.config/bspwm/bspwmrc
		  ## sxhkd
		mkdir $HOME/.config/sxhkd
		cp $HOME/arch-dwm/home/config/sxhkd/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
		chmod +x $HOME/.config/sxhkd/sxhkdrc
	##### f) startx 
		sudo rm install3.sh
		startx
#####     -------------------------------------------------- 