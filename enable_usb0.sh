#!/usr/bin/env zsh

if ! grep "dwc2,g_ether" /boot/firmware/cmdline.txt &>/dev/null; then
  sed -i 's/rootwait /&modules-load=dwc2,g_ether /' /boot/firmware/cmdline.txt
fi

if ! grep -E "dtoverlay=dwc2$" /boot/firmware/config.txt &>/dev/null; then
  sed -i 's/\[all\]/&\ndtoverlay=dwc2/' /boot/firmware/config.txt
fi

if [ ! -e "/etc/NetworkManager/system-connections/ethernet-usb0.nmconnection" ]; then
  nmcli con add type ethernet con-name ethernet-usb0
  sed -i 's/type=ethernet/&\nautoconnect=true\ninterface-name=usb0\n/' /etc/NetworkManager/system-connections/ethernet-usb0.nmconnection
  sed -i '/ipv4/,/^$/s#method=.*#method=shared#' /etc/NetworkManager/system-connections/ethernet-usb0.nmconnection
fi

cat <<EOF >/usr/local/sbin/usb-gadget.sh
#!/bin/bash

nmcli con up ethernet-usb0
EOF

chmod a+rx /usr/local/sbin/usb-gadget.sh

cat <<EOF >/lib/systemd/system/usbgadget.service
[Unit]
Description=My USB gadget
After=NetworkManager.service
Wants=NetworkManager.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/local/sbin/usb-gadget.sh

[Install]
WantedBy=sysinit.target
EOF

systemctl enable usbgadget.service

read -r -p "Reboot now. Press Enter: "
reboot
