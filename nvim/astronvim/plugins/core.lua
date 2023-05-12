local headers = {
    ["2346234"] = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⡋⠉⠙⠒⢤⡀⠀⠀⠀⠀⠀⢠⠖⠉⠉⠙⠢⡄⠀",
        "⠀⠀⠀⠀⠀⠀⢀⣼⣟⡒⠒⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀⢠⠃⠀⠀⠀⠀⠀⠹⡄",
        "⠀⠀⠀⠀⠀⠀⣼⠷⠖⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⢷",
        "⠀⠀⠀⠀⠀⠀⣷⡒⠀⠀⢐⣒⣒⡒⠀⣐⣒⣒⣧⠀⠀⡇⠀⢠⢤⢠⡠⠀⠀⢸",
        "⠀⠀⠀⠀⠀⢰⣛⣟⣂⠀⠘⠤⠬⠃⠰⠑⠥⠊⣿⠀⢴⠃⠀⠘⠚⠘⠑⠐⠀⢸",
        "⠀⠀⠀⠀⠀⢸⣿⡿⠤⠀⠀⠀⠀⠀⢀⡆⠀⠀⣿⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⣸",
        "⠀⠀⠀⠀⠀⠈⠿⣯⡭⠀⠀⠀⠀⢀⣀⠀⠀⠀⡟⠀⠀⢸⠀⠀⠀⠀⠀⠀⢠⠏",
        "⠀⠀⠀⠀⠀⠀⠀⠈⢯⡥⠄⠀⠀⠀⠀⠀⠀⡼⠁⠀⠀⠀⠳⢄⣀⣀⣀⡴⠃⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⡦⣄⣀⣀⣀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⠛⠃⠀⠀⠀⢹⠳⡶⣤⡤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⣠⢴⣿⣿⣿⡟⡷⢄⣀⣀⣀⡼⠳⡹⣿⣷⠞⣳⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢰⡯⠭⠹⡟⠿⠧⠷⣄⣀⣟⠛⣦⠔⠋⠛⠛⠋⠙⡆⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⢸⣿⠭⠉⠀⢠⣤⠀⠀⠀⠘⡷⣵⢻⠀⠀⠀⠀⣼⠀⣇⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⡇⣿⠍⠁⠀⢸⣗⠂⠀⠀⠀⣧⣿⣼⠀⠀⠀⠀⣯⠀⢸⠀⠀⠀⠀⠀⠀⠀",
    },
    ["me"] = {
        "саня лох",
        " ██████╗ ██╗   ██╗ ██╗███╗   ██╗███████╗██╗     ",
        "██╔═══██╗██║   ██║███║████╗  ██║██╔════╝██║     ",
        "██║   ██║██║   ██║╚██║██╔██╗ ██║█████╗  ██║     ",
        "██║▄▄ ██║██║   ██║ ██║██║╚██╗██║██╔══╝  ██║     ",
        "╚██████╔╝╚██████╔╝ ██║██║ ╚████║███████╗███████╗",
        " ╚══▀▀═╝  ╚═════╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝",
    },
    ["m1fnwf983n4f"] = {
        "⠀⠀⠀⠀⠀⠀⠀⢀⡤⠖⠚⠋⠙⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⡠⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⢀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⡄⠀⠀⠀⠀⠀⠀⠀⠀⢸⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⢀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⠀⠀⠀⠀⠀⠀⢀⡞⢸⠀⣀⠀⠀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⣷⣤⡀⠀⣠⡴⡟⢀⢏⡹⢀⡗⣉⣁⣠⣴⣖⣋⡉⠉⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⣎⠹⣷⣽⣿⡿⠋⢁⠜⠠⠞⢉⡤⢊⠇⠀⠀⠩⣉⠉⠉⠛⠓⠦⢄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠉⠒⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣮⡀⢿⣿⣿⠟⠋⠀⣐⣋⠤⠔⠊⠁⣠⡪⠖⠋⠀⠀⠀⠉⠛⢄⠀⠀⠀⢦⠉⠲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠈⠱⢆⡀⠀⠀⠀⠀⠀⣸⣷⣈⣿⣿⡿⢁⣾⢿⣱⣶⣆⠶⠾⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⠀⠈⣷⣶⡈⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠉⠲⢄⡀⠀⣸⣧⣘⣿⣿⠋⣠⠊⠀⢰⡀⡇⠀⠀⠉⠒⠲⣦⢤⣤⣤⠤⣤⣤⡤⠤⠒⠊⢧⡄⠀⡏⢳⣙⠗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠲⢦⣬⣿⠟⢡⠎⢣⠀⠀⠸⣇⠇⠀⠀⠀⠀⠀⠈⢦⡀⠉⠉⠫⢧⠠⢄⡀⠀⠸⣧⢠⠃⠈⣏⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠁⢠⠃⡀⠈⢦⡀⠀⠘⣆⠀⠀⠀⠀⠀⠀⠀⠙⢦⣀⠀⠀⢙⠢⠙⢦⣀⠃⣀⡠⣤⠿⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⠀⡎⢰⠁⠀⡇⠑⢦⡀⠈⢢⡀⠀⠀⠙⣄⠀⠀⠈⣎⠙⠢⢄⣉⠉⠉⠉⣹⣥⡞⠁⢰⠇⣾⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠀⠀⢸⠀⡿⠀⠀⢹⡄⠀⠈⠓⠦⣕⡀⠀⠀⡘⣷⣤⣈⣘⡦⠤⠤⠤⠽⢲⢫⠏⣉⠳⡀⢸⡏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠃⠀⣠⠏⠀⡟⠀⢠⠰⡿⡜⢆⡀⠀⠀⠉⠀⠀⠘⢾⡇⠀⠈⠹⡉⣩⠏⠀⣾⠞⣶⠀⢣⢧⠘⡽⣄⠀⠀⠀⠀⠀⠀⠀⠀⣠⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠒⠉⠀⡇⠀⡇⠀⠈⣷⡇⠘⠦⡙⢦⣄⡀⠀⠀⠀⠀⠹⣄⠀⢠⢿⡁⢀⡰⠃⠀⢈⡷⣇⡿⢠⠃⠈⠓⠀⠀⠀⠀⠀⠀⠀⢹⡇⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀⡇⢰⡀⠸⡇⠀⠀⢈⠓⠤⣌⡑⠢⣤⣀⣢⣌⠒⠛⠋⢫⣡⡤⠤⠤⣞⠟⠛⣖⠋⣖⠒⠲⠤⢤⣀⡀⠀⠀⠀⢘⡷⢼⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⢠⣄",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⡇⢸⣧⡀⠘⣄⠀⣾⣆⢰⣆⢹⡆⢸⡄⠀⠉⠉⠂⠀⠈⢯⡳⣄⠀⢿⣷⡄⢿⡆⠻⡆⠀⠀⠀⠀⠉⢳⠆⠀⢸⣿⣿⣿⡆⠀⠀⠀⠀⢀⣠⣴⣾⢿⣹⢜⣦⣵⡶⠞",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠴⠋⠀⡇⢸⣿⣿⡦⣌⣂⠻⡏⠘⠟⠀⠃⠀⡿⠀⠀⠀⠀⠀⠀⣸⣇⠘⢷⡄⠙⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⠏⠀⠀⣼⢷⣻⣿⡄⠀⢀⡤⢖⡯⢟⣿⣿⠯⠗⠋⠉⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⢿⣯⡙⠽⣿⡟⠙⠒⠒⠒⠊⠉⠀⠀⠀⠀⢀⣠⣚⣿⠙⣤⡿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞⠀⠀⠀⡿⢒⣿⣷⣿⣿⡯⣾⣿⡾⠟⠋⢀⡀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⣄⠹⣯⠒⠤⢽⣷⣄⠀⠈⠳⡦⢤⡤⠒⡞⢅⣰⢠⠏⢀⣿⠀⣸⠃⠀⠀⠀⠀⠀⠀⠀⢠⠞⣷⣤⣄⣼⡫⠟⣵⡿⣫⡿⣿⣷⣯⣿⣿⠏⠉⠉⠉⠙⠲⢄⡀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠦⠀⠁⠀⠚⠁⠉⠓⢤⣀⠈⠲⠬⣳⣀⡤⠟⠁⢠⡾⠯⠴⡟⠀⣀⠀⠀⠀⠀⢀⡠⠋⣸⢡⣷⣿⡿⢉⣼⣾⣾⣯⣪⣽⣿⣻⡿⣿⠀⡠⠖⠉⠉⠳⣦⣍⠆",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠀⠀⠀⠀⠉⣱⣶⢶⣤⣄⣀⣤⠻⡄⢠⠾⠋⠙⠩⣙⢦⡀⠒⠉⠀⡰⣡⢾⣿⣿⣇⠬⣓⠿⣾⢯⢷⣖⢍⣷⣽⣿⡇⠀⠀⠀⠀⠀⢻⡌⢲",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣤⡀⢄⠙⡄⢱⣇⠀⢀⠀⠀⠀⠓⢽⡆⠀⣠⠗⠁⠀⢿⣿⣿⣟⡢⡽⠝⣯⢝⣻⣿⣻⠽⣽⢷⡀⠀⠀⠀⠀⢸⣿⣲",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠞⠁⠀⠀⠀⠀⣠⠾⠛⠛⢛⣻⠿⢿⣿⠷⢵⠁⢸⣿⣦⡘⣆⢀⠀⠀⣸⡷⠋⠁⠀⠀⠀⠀⡄⢸⣿⣿⡾⡿⢴⡿⣳⢟⣿⣿⣧⠞⠀⠀⠀⠀⠀⠀⡻⡽",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠈⡗⠈⡹⠃⢀⡼⠃⠘⢻⣿⣷⣼⠏⣨⡴⠋⠀⠀⠀⠀⠀⠀⣀⠸⡌⠻⣿⡻⣯⣼⣯⣷⠟⠁⣠⠊⠀⠀⠀⠀⠀⠀⠀⣇⡧",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣆⣠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡇⢺⢄⠀⣾⡀⣠⣤⣠⠟⠛⠟⢿⡁⠠⠤⠤⣀⣀⣠⡴⠿⠋⣸⢷⡀⠀⠉⠁⠀⠀⠀⢀⡔⣿⠀⢀⣀⠀⠀⠀⠀⠀⠈⣷",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⢾⣹⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠾⠁⠀⡎⠀⢷⣉⡿⠏⠀⢁⠀⠀⠀⠀⠹⣆⠀⠀⠀⠀⠀⠀⠀⣰⠁⠸⡇⠉⢆⡀⠀⠀⠀⢰⢱⢸⠷⣆⠀⠉⠶⠀⠀⠀⠀⡿",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⠏⠉⠀⠀⠀⠀⠀⠀⠀⠀⣠⠔⢺⠁⠀⠀⢠⡇⠀⠈⢿⠀⠀⠀⠘⡄⠀⠀⠀⠀⣿⣿⣦⡀⠀⠀⢀⡴⡁⢦⣅⢧⠀⠀⠀⠀⠀⣠⠟⠃⡸⠀⠸⣆⠀⠀⠀⠀⠀⠀⠳",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠁⠀⡟⣇⢀⢸⣼⡇⠀⠀⠀⠳⡀⠀⠀⢣⠀⢰⠀⠀⣿⣿⣿⣿⣷⣶⠟⠉⠓⠲⠤⢼⡇⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠹⣆⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢇⠀⠀⣇⣿⣾⣿⣿⣿⡀⠀⠀⠀⠙⢆⠀⠈⡆⠀⠇⠀⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⣇⠀⠀⠀⠀⠀⠀⢰⠃⠀⠀⠀⠈⠢⡀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⡆⠀⢸⢹⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠱⢄⠘⡄⠘⡀⣿⣿⣿⣿⣿⡃⠀⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⠀⡸⠀⠀⠀⠀⠀⠀⠈⠢⣄⡀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠹⡀⠈⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠈⠳⢼⡀⢱⣿⣿⣿⡿⡱⠁⠀⠀⠀⠀⠀⠀⠀⢳⠀⠀⠤⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠝",
        "⠀⠀⠀⠀⠀⠀⠀⣀⣠⠤⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡀⠀⠱⡀⠱⣿⣿⣿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⠙⢸⣿⣿⡿⣱⠃⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⣰⢿⠉⠀⠀⢀⠙⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠀⠀⠘⢦⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⣀⠀⢸⣿⡿⣳⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⢰⠏⡜⠰⡆⠀⠘⠢⠄⠳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠸⡄⠀⠀⠀⠙⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣿⣟⡴⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢀⡏⠀⡇⠀⠇⠀⠀⠀⠀⠀⠈⠲⢤⡀⠀⠀⠀⠀⠀⠀⣷⠀⣀⡀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⣾⡷⡄⠀⠀⠀⠀⠘⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    },
    ["rose"] = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠖⠋⠉⠉⠳⡴⠒⠒⠒⠲⠤⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠊⠀⠀⡴⠚⡩⠟⠓⠒⡖⠲⡄⠀⠀⠈⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞⠁⢠⠒⠾⢥⣀⣇⣚⣹⡤⡟⠀⡇⢠⠀⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣄⣀⠀⡇⠀⠀⠀⠀⠀⢀⡜⠁⣸⢠⠎⣰⣃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡍⠀⠉⠉⠛⠦⣄⠀⢀⡴⣫⠴⠋⢹⡏⡼⠁⠈⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡽⣄⠀⠀⠀⠀⠈⠙⠻⣎⡁⠀⠀⣸⡾⠀⠀⠀⠀⣀⡹⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞⠁⠀⠈⢣⡀⠀⠀⠀⠀⠀⠀⠉⠓⠶⢟⠀⢀⡤⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠒⠦⡀⠙⠦⣀⠀⠀⠀⠀⠀⠀⢀⣴⡷⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢦⣀⠈⠓⣦⣤⣤⣤⢶⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢤⣤⣤⡤⠤⠤⠤⠤⣌⡉⠉⠁⠀⠀⢸⢸⠁⡠⠖⠒⠒⢒⣒⡶⣶⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠲⣍⠓⠦⣄⠀⠀⠙⣆⠀⠀⠀⡞⡼⡼⢀⣠⠴⠊⢉⡤⠚⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⠈⠙⢦⡀⢸⡀⠀⢰⢣⡧⠷⣯⣤⠤⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⣲⠤⠬⠿⠧⣠⢏⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠚⠉⠉⢉⣳⣄⣠⠏⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣟⣒⣋⣉⣉⡭⠟⢡⠏⡼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⢀⠏⣸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠓⠚⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ",
    },
    ["Mike"] = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⣀⣀⣀⣠⣤⡤⡤⢤⢤⣤⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠲⢭⣽⣛⣛⣛⣛⣶⠒⠒⠒⠋⠁⠀⠀⠀⠀⠉⠐⣒⣚⣿⣻⣿⣿⣉⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣶⠿⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠔⠚⠉⠷⠒⠒⠒⠿⣾⣽⣍⡓⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⡶⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⡿⠦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠞⢡⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⢃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣝⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣡⠟⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⣾⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣽⡏⠀⠀⡰⢃⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠟⡼⢀⡴⣋⠴⠋⠀⡼⠀⠀⠀⠀⠀⠀⢀⠀⢀⡞⠁⢀⡜⢠⡿⠀⠀⠀⡄⡀⠀⠀⠀⠀⠀⠀⠀⣄⢯⠺⣷⣀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⢾⣿⡽⠚⢁⡠⢚⢁⢇⠆⠀⠀⠀⡄⢀⡾⢁⡞⢀⡴⠋⣠⠏⡇⡆⢰⢸⣿⢹⣄⠘⡄⠀⠀⠀⠀⢹⡼⡄⠈⠉⠃⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⣿⡜⢀⡴⢋⡴⢃⢸⢸⠀⢠⡇⡼⢡⣾⢧⠏⣠⠏⢀⡼⠃⢰⠇⡇⡞⡼⢹⡆⡿⡜⣽⡀⠀⠀⢆⠘⣧⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⢠⠞⢡⣎⡜⠁⡾⣹⠀⣾⢰⣷⠏⣾⢿⠞⣡⠞⠻⠶⢖⣼⣸⣸⢡⠇⠈⣇⣷⢳⣞⣧⠀⠀⣜⣆⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⣱⡿⣰⢫⣎⣰⢠⣇⣽⣵⣇⡿⠃⣸⠏⣋⣉⣁⣠⣀⣀⠀⣧⢧⢇⡾⠶⠷⣿⣾⠼⣿⡿⣧⢠⢹⢾⣼⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢻⠇⣻⣿⡟⢿⢿⡿⠛⣸⢿⠃⠀⡲⡒⣟⣟⡗⠓⠶⡮⣹⠯⠏⠀⠀⣀⣤⣯⣃⠀⢷⣷⠘⣎⡿⡏⢻⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠁⡟⣴⣿⠐⡇⠈⡮⠇⠀⡴⠋⠀⠀⠈⠛⠿⠶⠶⠖⠛⠉⠈⠀⠀⠀⡼⢲⣲⣲⡾⠥⢼⣿⢰⣧⡗⡇⠀⠳⠄⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢐⣿⣽⣻⡏⣇⢠⣈⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⠈⠿⣷⣶⠾⢳⣯⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢟⣫⢿⣹⡼⣄⠀⠉⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡇⠀⠀⠀⠀⡾⣟⣸⠉⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⢟⣰⢻⡙⠒⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⡵⣒⠞⠀⠀⠀⢰⠇⠣⠏⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢉⣯⢾⠀⠀⠈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⣠⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⡞⠀⠀⠀⠀⠙⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠤⠶⠒⡒⠀⢀⣴⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃⠀⠀⠀⠀⠀⠈⠻⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⠉⢣⠿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣠⣤⣤⡤⡤⠤⣴⠖⠒⠏⠀⠀⠐⣇⠀⠀⠀⠀⠈⠙⢷⣄⡀⠀⠀⠀⠀⠀⣸⠁⠀⢸⠁⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡤⠶⠚⠛⠉⢀⣠⣀⣴⡚⠹⠟⠛⡘⠦⣄⠀⠀⠀⠀⣏⠁⠀⠀⠀⠀⠀⠀⠈⠛⠷⣦⣤⣀⣠⡏⠀⠀⡟⠀⠀⠀⠀⠀⠀⣴⠛⠉⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣛⣉⠡⠤⠄⣤⠴⠚⠉⢋⡩⠃⠀⠀⠀⢣⠀⠙⠢⣄⠀⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣹⠋⡽⠳⠶⢰⡇⠀⠀⠀⠀⠀⣴⠋⠀⠀⡼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⢠⡞⣽⠦⣢⡀⠀⠀⠰⠎⠁⣀⡠⠖⠉⠀⠀⠀⠀⠀⠀⠑⢄⡀⠈⠑⢦⡘⡇⠀⠀⠀⠀⠀⠀⠠⠤⢴⣾⠋⢷⠃⠀⠀⣼⠁⠀⠀⠀⢀⡞⠁⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠱⡀⠀⠀⠀⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠢⣄⡀⠉⠓⢤⣀⠀⠀⠀⠀⠘⠋⢩⣏⢀⡏⢰⡦⢰⠟⢦⡀⠀⣠⠏⠘⠒⢚⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⣾⡆⠀⠀⠀⠀⡀⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠲⢤⣀⠈⠉⠓⠦⢤⣄⣀⣸⢟⡞⠀⠀⠀⡿⠀⠀⢧⡴⣣⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⢀⡟⠀⠀⠀⠀⠀⠹⡄⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀⢰⠃⠀⣠⡞⠁⠣⠑⡴⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⢹⡄⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠁⠀⠀⢠⡏⠀⣰⠋⠀⠀⢀⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⡼⠀⠀⠀⡀⠀⠀⠀⠀⢳⡈⢧⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡤⠞⠁⠀⠀⠀⢼⡠⠞⠁⠀⠀⢀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⡇⠀⠀⠀⠹⡄⠀⠀⠀⠀⢷⠈⣆⠀⠀⠀⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣄⡤⠞⢋⣭⣤⡰⡄⠀⠀⠀⠀⠀⠀⠀⠀⣠⠏⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢸⠇⠀⠀⠀⠀⠘⡄⠀⠀⠀⠈⢧⠘⣆⠀⠀⠘⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡟⠁⠀⠈⢤⡀⡿⡀⠳⢍⣧⣀⠀⠀⠀⠀⠀⢠⡞⠁⠀⠀⢷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠘⣆⠸⡆⠀⠀⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢿⢦⠀⠀⠈⢳⠱⣷⣄⠀⠉⠊⠉⠉⠙⠳⣄⡟⠀⠀⠀⠀⠸⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠘⡆⢻⡄⠀⢸⡀⠀⠤⣄⡀⠀⠀⠀⠀⠀⣼⠀⢻⡁⠀⠀⠘⡆⠀⠙⠻⣲⢤⣀⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⢻⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⡇⠀⢰⠀⠀⠀⠀⠀⠀⠘⡆⠀⠀⠀⢹⡈⢿⡀⠀⡇⠀⣀⡀⠁⠀⠀⠀⠀⣰⡇⠀⢰⢳⡀⠀⠀⣇⠀⢀⡤⠷⡟⠙⠋⠃⠀⠀⢸⠀⠀⠀⠀⠀⠘⣿⠃⠉⠙⠒⠲⠤⢤⣀⣀⣀⣤⣴⣖⣚⠛",
        "⠀⠀⢠⡇⠀⢸⠀⠀⠀⠀⠀⠀⠀⠘⡆⠀⠀⠀⢳⠘⠃⠀⢻⠀⠈⢽⠁⠀⠀⠀⠀⢹⠁⠀⠸⣬⡃⠀⢀⣯⣧⡿⠀⠀⠉⠀⠀⠀⠀⣴⡏⠀⠀⠀⠀⠀⠀⢹⡆⠀⢀⢄⠀⠀⠀⠀⡉⠀⠈⢐⠶⠆⠀",
        "⠀⠀⢸⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠈⣇⠀⠀⢸⠀⠀⣼⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠉⠉⠉⠀⠷⠁⠀⠀⠀⠀⠀⠀⣺⠎⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠈⠀⠀⠀⢸⣆⣀⡐⠂⠀⠀⠀",
        "⠀⠀⡾⠀⠀⠀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠸⡄⠀⢸⡆⠀⣧⡆⠀⠀⢀⣞⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀⠈⢓⠆⠀⠀⠀⠀⠸⣇⠀⠀⠀⠀⠰⣿⠿⠛⠵⠲⠤⠤⢀",
        "⠀⠀⡇⠀⠀⢰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡄⠀⠀⢳⡀⠀⡇⢰⡿⠀⠀⣠⠏⢸⡳⡀⠀⠀⠀⠀⢀⡀⠀⠀⣆⣀⣀⡶⠚⠉⠀⠀⠀⠀⠀⠈⡄⠀⢏⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠚⠃",
        "⠀⢰⠇⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⢤⡤⣤⠤⢵⠀⠀⠀⣣⣠⡷⣾⠁⣀⡴⠋⠀⠀⠑⠭⠷⠶⠶⠚⠉⠀⠀⠀⠀⣠⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠀⠘⡆⠀⠀⠘⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠤⢉",
        "⠀⣸⠀⠀⡴⠚⠀⠀⠀⠀⢠⣤⡤⠤⠭⠶⠤⠄⠀⣀⣈⡯⠧⠞⣠⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⠁⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢣⡀⠸⡄⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠒",
        "⢠⡇⠀⢰⡛⠃⠀⢠⡤⣤⣄⣀⣀⣀⣀⣀⣀⠀⠀⠁⢈⣠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠋⡇⠀⠀⠉⠙⠒⠦⠄⠀⠀⠀⠀⠀⠀⢧⠀⢱⠀⠀⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠈⢧⡲⠇⠁⠀⠀⠀⢉⣀⣀⣀⣀⣀⡀⠀⠉⣇⣤⠾⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠘⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠈⡇⠀⠀⢽⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠈⣽⠁⠀⢀⣠⠖⠛⠉⠉⠀⠀⠀⠉⣉⡭⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠛⠀⢀⡀⠀⠀⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠹⣄⠀⠀⣷⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⣰⠃⠀⣰⠿⠂⠀⠀⠀⣀⣤⠖⠚⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠏⠰⢶⡉⠉⠉⢝⡲⢄⡈⠑⠲⠤⢤⣀⡀⠀⠀⠀⠀⠀⠸⣢⣀⠈⠑⣄⢸⡄⠹⡶⣄⠀⠀⠀⠀⠀⠀",
        "⠁⠀⠀⠁⠀⢀⣤⠶⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⢅⡀⠀⠀⠈⠑⠢⣄⡈⠉⠚⠳⢤⣀⠀⠀⠉⠓⠀⠀⠀⠀⠀⢉⡚⠧⠄⠈⢦⣷⡀⠈⠙⡷⣄⠀⠀⠀⠀",
        "⡀⠀⢀⣠⠞⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢀⡾⠁⠀⠉⠒⠤⣀⡀⠀⠀⠉⠓⢤⣀⠈⠚⠳⠦⢤⡀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠈⣯⡙⣆⠀⠉⠾⣇⠀⠀⠀",
    },
    ["man"] = {
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⠄⡀⠄⡀⢀⠄⡀⡀⠠⢀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡀⠠⢀⠄⡅⢔⠰⡨⢢⢡⢑⠔⠅⠕⠄⠅⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡀⠅⢔⠨⢐⠅⡌⢆⢣⠪⡪⡘⡌⡮⡱⡡⣊⢌⢀⢀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⡐⢄⠕⡡⡘⢔⢱⢨⢪⢪⢪⢪⡺⣪⢞⢮⢫⢮⢺⢔⢆⡢⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⢀⠐⠈⠄⡠⡊⢌⠢⡑⡌⡆⡇⡇⡇⡇⣇⢗⣝⢮⡺⣪⡳⣹⡪⣞⢵⢝⡵⡝⣕⠡⢀⢂⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⢠⢊⢂⠁⡔⡌⡢⢑⠌⡢⡱⡸⡸⡸⡪⡺⡸⣕⢵⡳⣝⢮⡺⣪⢞⣵⣫⡳⣕⢯⡺⡬⠄⠕⡕⡄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⡇⡇⡂⢢⢣⢣⠨⡂⡊⢔⢕⢱⡱⡝⣜⢝⡺⣜⡵⣝⢮⡳⡽⣵⣻⡺⣼⡺⡵⣳⢝⡮⡃⡕⡺⢄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⢸⡱⡱⡨⢪⢪⢢⠡⢂⢊⠢⡱⡱⡱⡝⡮⡳⣝⢞⢮⢗⡯⣯⢯⣗⡯⣟⣮⢯⣟⢮⡳⣝⢇⢇⢎⢵⡀⠄⠄⠄⠄⠄",
        "⠄⠄⠄⣕⢵⢣⢣⢑⢅⢆⢃⠢⠡⡡⡱⡱⡹⡪⡯⣺⢕⡯⣫⢯⢾⢽⢽⣺⢯⣗⡯⣗⣗⢗⣝⢮⡫⣏⢮⢒⢅⠄⠄⠄⠄⠄",
        "⠄⠄⢀⠮⡪⢪⠪⠢⡃⡪⡂⠅⢕⠰⢱⢸⢸⡱⣝⢮⡳⡽⣪⢏⡯⡯⣟⡾⣽⣺⢽⣳⡳⣝⢮⡳⣫⣳⢳⡱⡱⠄⠄⠄⠄⠄",
        "⠄⠄⢀⡃⡫⢔⢨⢕⢕⢔⢌⢌⠢⡑⡱⡘⢜⢜⢮⡳⣝⣞⢵⣫⢿⢽⣺⡽⡾⣾⢽⣳⢯⢮⡳⣝⣕⢗⢵⡑⡕⡀⠄⠄⠄⠄",
        "⠄⠄⠐⠢⡱⡐⢕⢵⣑⡑⢕⢐⠕⠸⠰⡑⠕⢕⢕⠽⡕⣏⢗⢽⢝⢽⠺⠽⠽⢽⢻⢽⢽⢵⢽⡸⣪⢳⢱⢱⡱⡽⡡⡀⠄⠄",
        "⠄⠄⠨⠈⢆⢊⢎⢖⢂⠃⠡⠐⠈⠈⠄⠄⠄⠄⠄⢑⢹⢘⣜⢕⠑⡈⠄⡈⣈⣐⠨⠘⡜⢕⡳⣝⢮⡳⡱⡱⡵⡯⡪⠂⠄⠄",
        "⠄⠄⠄⠅⢂⠑⡕⡕⠄⡢⢀⠄⠠⠄⠁⠁⡌⠠⢠⠄⠸⣸⣺⡪⣐⠅⢢⢈⠄⢬⢍⣆⢧⣳⡽⡮⣺⡪⡺⣘⢼⣝⠆⠄⠄⠄",
        "⠄⠄⠄⠨⡢⡢⡣⡳⢑⢰⢐⠠⡊⡪⣢⡣⡪⡰⠑⡀⠨⣪⢷⣝⡮⡫⡪⣪⢾⢝⣯⢾⣝⣗⡯⣟⢮⡪⡯⡷⣗⡯⠄⠄⠄⠄",
        "⠄⠄⠄⠄⢕⠄⡇⡣⡑⠔⢅⠇⡇⡏⡖⡕⡕⣌⢂⠂⠌⢮⢷⡳⡯⡯⡾⡵⣫⢯⢞⣗⡷⡯⣯⡳⣱⢱⢝⡽⣺⠁⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠡⡡⢱⢐⠨⠨⠐⡡⢃⢇⢇⡏⡞⡔⡐⠠⢑⢽⢽⢽⢽⢽⢽⣝⢗⡯⣟⢾⢽⢝⡞⣜⢜⢜⣽⣺⠎⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠊⠃⠂⡐⠄⠅⡐⡈⡢⡃⢇⠕⡢⠄⠨⢘⢮⢯⢯⣳⡫⡗⣗⢽⢝⡮⡯⡮⡣⡏⣎⢎⠞⠺⠊⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠂⡁⢂⠐⡈⡢⢑⠅⡕⡐⠈⠨⡨⢯⣻⢽⣺⢺⡺⡪⣏⢷⢽⢕⣯⡫⣞⢜⢜⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⡁⠄⠄⠂⡂⠌⠄⢕⢐⠌⢄⠄⠨⠨⢘⢥⢅⡵⣝⣝⢮⡳⡽⣝⡮⣺⢪⢎⣗⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⢂⢀⠡⠄⠌⠌⢂⢂⠪⠐⡌⢰⢰⢘⢼⢝⣞⢞⣞⡵⡯⣞⢵⣫⢮⡳⡣⡳⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠈⡀⠐⠄⠊⠄⠨⠐⠠⠈⠌⠘⠜⠵⡢⢳⢹⢜⢕⠕⠱⡹⡪⡳⣕⣳⢹⡸⠅⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⢄⠡⠁⠠⠄⠄⡀⠄⠐⠔⠔⠔⡢⠦⣒⢎⣎⢦⢢⢩⡫⣎⢮⢣⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⢰⣇⠄⠐⠠⠄⠁⠄⠡⢀⢂⢅⢔⢄⣆⣆⢕⢵⡹⣪⡳⣕⢵⢱⢕⢇⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠱⡿⣵⣀⠄⠄⠄⠈⠨⠨⡂⢇⢎⢕⢎⢞⡽⡵⣝⢮⢺⢸⠸⡘⣜⢼⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⢹⣺⣳⣧⣄⡀⠄⠄⡀⠂⠌⡂⠕⢌⠊⢎⠪⠪⠪⡊⡆⣕⣕⢧⣓⣧⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⢪⢞⣾⡽⣷⣮⡄⠐⠄⡂⠌⢌⠢⢑⢐⢄⢅⢇⢇⣗⣕⢗⡵⣽⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⡾⣽⣯⣷⣿⡿⣮⣰⢱⡱⣜⢔⡑⡜⣜⢮⣣⡳⣪⢷⣽⣿⣿⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⡷⣿⣽⣿⣿⣿⣿⣿⣾⣮⣗⣽⢵⢕⣕⢮⡺⢝⣵⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⣯⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣏⣾⣿⣿⣿⣿⣿⣿⣇⠄⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠻⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠉⠄⠄⠄⠉⠻⢿⣿⣿⣿⣿⡀⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢻⣿⣿⣿⣿⣿⣿⣿⡟⠁⠄⠄⠁⠠⠄⠄⠄⠈⠽⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⢿⣿⣿⣿⣿⣿⡵⣄⠄⠄⠄⠄⠁⠈⠄⠄⢸⣹⡪⣿⣿⣿⡂⠄⠄⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⢿⣿⣿⣻⣿⣿⣯⣿⣢⣄⠄⠄⠄⠑⠠⢸⣿⣿⣮⢞⣿⣧⠄⠄⠄⠄⠄⠄⠄",
    },
    ["Eye"] = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠋⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⡘⣧⠀⠀⠀⠈⠀⠐⢿⣮⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣆⠀⢹⡹⡆⠀⠀⠀⠀⠀⠀⠹⣿⣧⡀⠀⠀⢀⣀⣀⣀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣶⡆⡀⠀⠀⢦⠀⢸⡀⠀⣧⣇⠀⠀⠀⠀⠀⠀⠀⠘⢿⣟⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⣸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢷⣿⣇⣄⠀⢸⡆⠀⣷⠀⢻⢹⠀⣀⠀⠀⠀⠙⢳⢤⡈⠿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢰⠃⠀⢸⢼⣿⣿⣿⡀⢸⣿⡆⣿⡀⢸⢹⠀⠘⠲⠄⠀⠀⠈⠛⢿⣦⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄",
        "⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣟⠀⠀⣾⠘⣿⠏⢷⣧⣸⣿⣧⢹⡇⠸⣾⠀⠦⠤⣤⣀⠀⢐⡲⣤⡙⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠌",
        "⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⢀⣰⠃⠀⠀⠀⠀⢠⣿⣿⣿⣹⣿⢠⣾⠇⠀⣿⣄⣨⣿⣿⡏⣿⣾⡇⠀⣿⠀⠀⠀⢙⣺⠿⢭⠙⢶⡙⣾⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⢀⣷⢏⠀⠀⠀⠀⢠⣿⡟⣾⣿⡿⣹⣾⣿⣶⠾⣿⠉⠁⠈⢿⠇⢸⣿⣷⠀⣿⣙⣷⣦⡀⢸⡿⠶⢶⣦⣙⢮⢿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢸⢠⡇⠀⠀⠀⢀⣾⡞⣾⠀⠀⣤⣟⣿⡿⢠⣟⣿⢱⣿⡿⠋⠁⢀⣿⣶⣿⣟⣿⣿⣼⡿⢻⢰⣿⢿⢿⣿⣷⡾⠐⢦⣄⠹⣿⢮⣻⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢸⣼⢻⠀⠀⣴⣼⢧⣧⡇⣠⣸⣿⢿⣿⠇⣾⡿⠁⣾⡿⠁⠀⢀⣾⣯⣾⣿⣿⣿⣿⣅⡀⣸⠼⡇⢸⠀⢻⣿⡇⢰⣏⠈⢢⠻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢸⣿⢸⡇⢠⢧⣿⣼⢸⢻⢹⢹⣿⣼⣿⣴⡿⠁⣼⡟⠁⠀⠀⠸⣷⣿⠁⢻⣾⣿⣿⣿⡿⢹⠂⡇⢸⠀⢸⡇⠹⣼⣮⡷⠘⠀⣿⢻⣿⠀⠀⠀⠀⠀⠀⠀⠀⠐",
        "⠀⠀⠀⠀⠀⠀⠀⢸⣿⢸⡇⢸⣾⡏⣿⣿⣸⢸⡟⢿⣿⡷⢖⣶⣤⡀⠀⠀⠀⠀⠀⠚⠋⣀⣀⣹⢿⠛⠁⠀⢸⡆⡇⢸⠀⢸⡇⠀⠈⢻⠆⣰⠂⡿⢷⡟⠀⠀⠀⠀⠀⠀⠀⠀⢎",
        "⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⡿⣟⣿⣿⣿⣿⢿⣇⣼⡿⣿⣿⡶⠽⠗⠀⠀⠀⠀⠀⠀⠀⠛⠉⠀⠀⠀⠀⠀⢸⡇⠆⢸⠀⣿⠃⠀⠀⣸⣼⠃⣴⣷⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐",
        "⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣷⣿⠏⣿⣿⣿⡟⣿⣟⣿⡾⣿⣿⣿⣿⠷⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡂⢹⢸⡇⠀⠀⠀⠀⠈⠁⣰⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢀⣸⣿⣿⣿⠀⢸⣿⣿⣇⣼⠟⠋⠀⢿⣻⡿⣿⣁⣤⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⢸⣸⡇⠀⠀⠀⠀⢠⡴⣿⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⣤⡴⠖⠋⠩⣿⣿⣿⠀⢸⣏⣿⢿⣅⠐⣦⣤⣄⣽⡿⠛⠉⣼⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠠⣿⡇⠀⠀⠀⠀⢸⣿⣿⣿⣶⣶⡶⣶⣶⣠⣉⠉⠀⠀⠀⡀",
        "⡄⠀⠀⠀⢻⡀⡇⠀⠀⢸⣟⣿⣇⢸⣿⣸⠀⠹⣆⠈⠉⠉⠀⠀⠀⠀⢧⡀⠀⠀⠒⠂⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⠐⣿⡇⠀⠀⠀⠀⠈⣿⣿⠿⠦⠼⠿⠿⠚⠛⠛⠂⠀⠉⠉⡉",
        "⠙⠷⣄⠀⠀⠻⣇⠀⠀⠀⢿⣿⠙⣾⣿⡇⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀⠈⠻⠷⣶⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡀⠀⣧⡇⠀⠀⠀⠀⠀⢻⡃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠇",
        "⠀⠀⠈⠛⠦⣀⡹⣦⠀⠀⠀⢻⠀⣿⣿⡇⠀⠀⠀⠈⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣼⣿⡇⣠⠃⠀⠀⠀⠘⣧⣤⠤⡤⠤⠶⢒⣚⠛⠛⠋⠉⠁⠀",
        "⠀⠀⠀⠀⠀⢨⠙⠛⠳⠀⠀⢸⠀⣿⣿⠁⠀⠀⢀⠀⠈⠳⣄⡀⠀⠀⠀⠀⠀⠀⢠⣤⢴⣶⡶⠀⠀⠀⠀⠀⢸⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⣿⠮⠿⣷⡒⠒⠈⠉⠁⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⢸⠀⣻⣿⢰⡄⠀⣾⢠⠀⠀⣮⠻⢶⣄⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⢻⡇⠀⠀⠀⠀⠀⠀⢷⠀⡧⠀⠹⣆⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡇⢹⡟⢸⡇⠀⠘⢸⡇⠀⢻⠀⠀⣈⠓⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠼⡇⠀⠀⠀⠀⠀⠀⢸⡾⠁⠀⠀⠘⣆⣄⣀⣠⣀⣀⡀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⢸⡇⢸⡃⠀⠀⢸⡇⠀⠸⣦⡴⠃⠀⢠⠈⣻⢦⣄⡀⠀⠀⠀⠀⠀⠀⣠⢿⡿⣿⠀⡇⠀⠀⠀⠀⠀⣀⠞⠁⠀⠀⠀⠀⠘⢧⡀⠉⠛⠶⢶⣺",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⠈⡇⢸⠇⠀⠀⢸⠇⠀⠀⢸⠀⠀⠀⢸⣤⡟⣷⣉⢛⣷⣶⡤⠤⠴⠚⠁⢸⣽⡟⢸⠇⠀⠀⠀⣠⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠛⢶⣦⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⡇⠈⠀⠀⠀⢸⠀⠀⣤⣬⡦⢤⠀⠘⣿⣿⣿⣿⣾⠃⠘⣆⠀⠀⠀⠀⢸⣿⡇⣸⠀⣀⡴⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡏⠳⣤⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⣿⠀⠀⠀⠀⢘⠀⠀⠀⠘⢃⣶⡀⠀⢯⣿⣿⣾⠏⠘⡒⢸⡆⠀⠀⠀⣾⣷⠃⣿⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣻⡀⠀⠀⠉",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡀⢹⠀⠀⠀⠀⢨⠀⠀⠐⠄⠀⠀⠃⢀⣾⠛⢻⡿⠀⠀⠙⢦⣻⠀⠀⠀⣿⣿⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠏⠘⡟⠒⠒⠒",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⠘⡆⠀⠀⠀⢸⡂⠀⠀⠀⠀⠀⠀⢸⣷⢿⣼⠇⠀⠀⠀⠈⠛⠷⣄⢀⣿⣧⣼⠛⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢿⠏⠀⢀⡇⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠀⡇⠀⠀⠀⠘⡇⢀⣤⠀⠀⠀⠀⣸⠿⢫⡟⠀⠀⠀⠀⠀⣠⣤⣬⣿⣏⣿⣧⣤⣾⣷⣄⠀⠀⠀⠀⠀⠀⠀⢀⡞⢡⠇⠀⠀⢸⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⢿⢸⢻⠀⠀⠀⠀⠀⠃⠘⠀⣠⡴⠋⠁⢀⣾⠀⠀⠀⠀⠀⣼⣿⣾⣿⣿⣽⣿⣿⣿⣿⣿⣿⢷⡀⠀⠀⠀⠀⡴⠋⢠⠏⠀⠀⠀⠈⠀⠀⠀⠄",
        "⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⢸⡸⣾⡆⠀⠀⠀⠀⣠⡴⠛⠁⣠⠄⢀⢿⣧⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠈⢳⡄⠀⢀⠞⠁⣴⡏⠀⠀⠠⠄⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⣧⣏⣇⠀⢀⡴⠟⠁⠀⢀⣾⠁⢀⡞⢸⣿⠀⠀⢀⡟⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⢀⣀⠤⠿⠴⠫⣬⡭⠥⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠘⢛⠒⡒⠒⠀⣾⣿⣽⣿⡴⠋⠀⠀⠀⣠⣿⠇⠀⢸⠃⠀⢹⠀⣠⣏⡴⣚⣩⣿⢻⣿⣿⣿⣿⣿⣿⡧⠖⠋⣠⠞⡃⠀⣀⣀⡀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁",
    },
    ["Eye2"] = {
        "⠤⣤⣤⣤⣄⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⣤⠤⠤⠴⠶⠶⠶⠶",
        "⢠⣤⣤⡄⣤⣤⣤⠄⣀⠉⣉⣙⠒⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⠘⣉⢡⣤⡤⠐⣶⡆⢶⠀⣶⣶⡦",
        "⣄⢻⣿⣧⠻⠇⠋⠀⠋⠀⢘⣿⢳⣦⣌⠳⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠞⣡⣴⣧⠻⣄⢸⣿⣿⡟⢁⡻⣸⣿⡿⠁",
        "⠈⠃⠙⢿⣧⣙⠶⣿⣿⡷⢘⣡⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣷⣝⡳⠶⠶⠾⣛⣵⡿⠋⠀⠀",
        "⠀⠀⠀⠀⠉⠻⣿⣶⠂⠘⠛⠛⠛⢛⡛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠛⠀⠉⠒⠛⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⢻⡁⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    },
    ["home work"] = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⡇⢀⣀⣠⠤⠴⠶⢶⣶⠤⡤⣄⡀⣸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⠊⠉⠁⠀⠀⠒⢶⡉⠻⠕⠇⢈⣩⣿⣿⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⣾⣿⣿⠈⠻⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⡰⠋⢸⡿⠛⢋⣉⣩⠉⣀⢤⣭⡉⠉⠐⠤⣀⠀⢸⣿⣿⣿⢣⠀⠀⠙⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⢠⠞⢀⡔⠃⠀⠚⣭⡴⠂⠀⠀⢻⣬⣝⠳⣤⠀⠀⢳⣟⢿⣿⣿⠈⢣⠀⠀⠈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⢠⠏⡰⠋⠀⠀⢀⡼⠋⠀⠀⡞⠀⠀⠹⣎⠱⣌⠳⣄⠀⢷⠱⡹⣿⠀⠘⠃⠀⠀⠈⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢀⢏⡎⢠⡾⠀⢀⣾⠁⠀⠀⠀⡇⠀⠀⠀⢻⡄⢻⠳⡈⠃⢸⡇⠸⣽⡀⠀⢠⠀⠀⠀⠸⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⡜⡸⠀⡾⠁⠀⢨⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⡆⠈⡌⢏⢆⠈⣿⠀⢰⣣⠀⢸⠀⠀⠀⠀⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢧⠇⢸⠇⠀⡰⣿⠀⠀⠀⠀⠀⣇⠀⢀⠀⠀⠘⠀⢣⠈⢎⢣⡏⡇⠀⠏⡇⠘⣇⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⡾⠀⡾⢀⡜⠁⢻⢰⠀⠀⠀⠀⣿⠀⢸⣆⠀⠀⠀⠘⠀⠈⡆⡇⡇⠀⠸⢰⠀⣿⠀⠀⠀⢸⢸⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⢠⡇⢠⢇⣎⠀⠢⣸⠏⡆⠀⠀⠀⢸⡆⢸⠻⣦⠀⠀⢀⡇⠀⠸⡇⢻⡆⠀⠘⣆⣻⠀⠀⠀⢸⠀⡆⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⢸⠁⠈⣼⠾⠗⣶⣿⡼⣴⠀⠀⠀⠈⣧⢸⠀⠈⢷⠀⠈⢷⠀⠀⠁⠀⢻⡄⠀⣧⢿⠀⠀⠀⢸⠀⣷⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⢸⠀⢸⢻⣇⠸⣿⣺⣧⢹⣣⠀⠀⠀⢻⢸⠀⣀⣀⢑⣄⡘⣷⡀⠀⠰⡄⢳⡄⢈⢿⠀⠀⠀⡟⡇⢸⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⢸⠀⠸⡎⠸⠳⠼⠿⠉⢇⢻⢦⠀⠀⠘⣽⣰⡶⣶⣶⣤⣙⣯⣻⡇⢀⠈⠘⣿⣾⣝⠇⠀⠀⠇⢳⡜⡀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⢸⠀⠀⡇⠀⠀⠀⠀⠀⡼⢆⢫⠁⠀⠀⠹⠁⠀⣇⣏⣓⣿⠿⣿⣿⠘⢻⣿⡎⢸⢿⢸⠀⢰⢀⠘⢷⡅⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠈⠀⠀⢁⠀⠀⠀⠀⡼⠁⠈⢣⣣⠀⠀⠀⡇⠛⢦⣍⣭⡥⠢⠀⢸⠚⠋⡭⢋⡬⢊⠎⠀⡘⡏⠀⣟⡇⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⡄⠀⢸⣆⠀⠀⠠⠄⣀⠀⠀⠹⣷⠀⠀⢻⠀⠀⠈⠀⠀⠀⠀⣸⠀⠀⢒⣠⣶⣿⠀⠀⡟⠇⠀⢹⣷⠀⠀⠀⠀⠀⠀",
        "⠀⢀⡴⡇⠀⠈⠙⢆⠀⢠⣄⣀⠀⠀⠀⢹⡆⠀⣸⠀⠀⠀⠀⠀⢀⣴⣿⠰⣶⣿⣿⣿⣿⠀⢠⢿⠀⠀⠈⣿⡆⠀⠀⠀⠀⠀",
        "⢠⠋⠀⠃⠀⢰⠀⠘⣆⠘⡏⠉⠙⢲⣶⡤⣿⢸⡏⠀⠀⢀⣠⣶⣿⣷⣿⢀⣟⢿⣿⣿⡏⠀⢸⣾⡄⠀⠀⢿⣧⠀⠀⠀⠀⠀",
        "⢿⠀⠀⢸⠀⢸⠀⠀⣿⣆⣇⠀⡤⠚⠋⠁⡿⢋⣡⣴⣾⣿⣿⣿⣿⣿⣿⢸⠋⣽⡿⣿⡇⠀⢸⣿⣿⡀⠀⠘⣿⠀⠀⠀⠀⠀",
        "⠘⣆⠀⢸⠀⢸⠀⠀⢻⡏⠻⣍⣀⣤⣤⣶⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⢰⠺⣿⣿⣿⡇⠀⡟⠙⠿⣷⠀⠀⣿⡃⠀⠀⠀⠀",
        "⠀⠹⣆⠘⡆⣼⠀⠀⠈⢃⠀⠀⣰⣿⣇⠙⡟⣻⠿⣿⣿⣿⣿⢿⣿⣿⣿⠰⣟⣿⣿⣿⠃⢠⠇⠀⠀⠈⢧⡀⢸⣇⠀⠀⠀⠀",
        "⠀⠀⠹⡄⡇⣿⠀⠀⠀⢸⣀⣼⣿⣿⣿⣄⡟⣽⣧⠀⠉⠛⠻⠿⠿⡿⢿⠸⠛⠉⠁⠸⠀⡜⠀⢀⠖⠀⠀⠙⢦⣿⠀⠀⠀⠀",
        "⠀⠀⢀⣵⡇⡇⡇⠀⠀⢀⡋⠉⠉⣿⣷⣶⣾⢿⣿⣷⣀⠀⠀⢀⡜⠀⢸⠀⠀⠀⠀⡄⡸⠁⠀⣡⠆⠀⢀⣤⠀⠻⣧⠀⠀⠀",
        "⠀⣰⣿⣿⡇⡇⡇⢀⣴⠿⠒⠈⠁⢻⣿⣿⡏⠀⠈⠙⠻⢦⢀⠞⠀⠀⢸⡄⠀⠀⢠⢷⠃⢀⠞⠁⠀⣴⣿⠞⠀⠀⠈⢧⠀⠀",
        "⠀⢿⣿⣿⣧⡇⢣⠸⠁⠀⠀⠀⠀⣾⣿⣿⡇⠀⠀⠀⠀⠀⠋⠀⠀⠀⢸⡇⠀⠀⡘⡌⠰⠇⠀⠀⠘⡱⠁⠀⠀⠀⠀⠈⣦⠀",
        "⠀⠈⢻⣿⣿⡇⢀⡇⠀⠀⠀⠀⢀⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⠀⢀⣿⢁⠆⠀⠀⠀⠀⠁⠀⣠⠀⡾⠁⢤⠘⡆",
        "⠀⠀⠀⣿⣿⡇⢸⠀⠀⠀⠀⠀⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠇⠀⢸⡇⡌⠀⠀⠀⠀⣠⠖⢉⠞⢀⠃⠀⡞⠀⡇",
        "⠀⠀⠀⢹⣿⣧⢸⠀⠀⠀⠀⠀⣸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⠀⠀⡘⡘⠀⠀⢀⡴⣪⠏⣠⠃⢀⡼⠀⢀⠃⠀⠇",
    },
}

local function random_header()
    local header_names = {}
    for header_name, _ in pairs(headers) do
        table.insert(header_names, header_name)
    end
    return headers[header_names[math.random(#header_names)]]
end

return {
    {
        "goolord/alpha-nvim",
        opts = function(_, opts)
            opts.section.header.val = random_header()
            return opts
        end,
    },
}
