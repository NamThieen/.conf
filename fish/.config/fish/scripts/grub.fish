#! /usr/bin/fish
sudin redhat-lsb
echo 'GRUB_TIMEOUT=2
GRUB_DISTRIBUTOR="lsb_release -i -s 2> /dev/null"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="quiet loglevel=3"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true' | sudo tee /etc/default/grub >/dev/null

update-grub
