conky.config = {
    alignment = 'top_right',
    gap_x = 50,
    gap_y = 50,
    update_interval = 1,
    own_window = true,
    own_window_type = 'desktop',
    own_window_transparent = true,
    double_buffer = true,
    use_xft = true,
    font = 'DejaVu Sans Mono:size=16',
};

conky.text = [[
${color grey}Eslatmalar:${color}
${exec cat ~/eslatmalar.txt}

${color #FF5733}${time %H:%M:%S}${color}
]];

#sudo apt update
#sudo apt install conky-all
#nano ~/.conkyrc
# nano ~/.config/autostart/conky.desktop
#[Desktop Entry]
 #Type=Application
 #Exec=conky
 #Hidden=false
 #NoDisplay=false
 #X-GNOME-Autostart-enabled=true
 #Name=Conky
 #Comment=Eslatmalarni ko'rsatish uchun Conky