local headers = {
    ["Q"] = {
        " ██████╗ ██╗   ██╗ ██╗███╗   ██╗███████╗██╗     ",
        "██╔═══██╗██║   ██║███║████╗  ██║██╔════╝██║     ",
        "██║   ██║██║   ██║╚██║██╔██╗ ██║█████╗  ██║     ",
        "██║▄▄ ██║██║   ██║ ██║██║╚██╗██║██╔══╝  ██║     ",
        "╚██████╔╝╚██████╔╝ ██║██║ ╚████║███████╗███████╗",
        " ╚══▀▀═╝  ╚═════╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝",
    },
    ["half-wit"] = {
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
    ["dog"] = {
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
    ["eye"] = {
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
    ["no gay"] = {
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
    ["Neubaufahrzeug"] = {
        "        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⢀⣄⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⣴⣤⡀⠀⢀⣀⣤⠤⠤⠶⠖⠒⠒⠒⠒⠒⠲⠶⠤⢤⣀⡀⣼⣛⣧⠀⢁⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣸⣏⢻⣍⠁⠀⢀⡀⠤⠄⠒⠒⠒⠒⠒⠒⠀⠤⠄⠀⠀⢸⡳⢾⢹⡀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⣠⠖⠋⠀⢯⡞⣎⡆⠁⠀⠀⠀⢀⡀⠀⠤⠤⠤⠤⠄⠀⡀⠀⠀⠻⣽⣻⡌⠹⣄⠀⠐⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⢀⢾⣹⢿⣸⠀⣰⠎⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠆⠹⡿⣏⢆⠈⢷⡀⠀⠆⠀⠀",
        "⠀⠀⠀⠀⣰⠏⠀⠀⢀⠔⠛⠄⠙⠫⠇⢀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢄⠠⠒⠒⠵⡈⢳⡀⠀⠀⠀",
        "⠀⠄⠀⡰⠁⠀⠀⢠⠊⠄⠂⠁⠈⠁⠒⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠄⢳⡀⠈⠀",
        "⠈⠀⣸⠃⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠐⠀⠀⠐⠀⢀⠀⠀⠀⠀⢷⠀⠀",
        "⠀⢠⠇⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠰⠀⠀⠀⠀⠀⠀⡄⠀⡀⠆⢰⠀⠀⠀⡄⠀⠀⠀⠸⡄⠀",
        "⠀⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠉⠀⡄⠀⢀⠀⠀⡄⠂⠆⠀⠀⠀⠀⢁⠀⢁⠀⢸⠀⢇⠀⡇⠀⠀⠀⠀⣧⠀",
        "⠀⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠰⡃⠄⠈⡄⠀⡇⢀⢰⠀⠀⠀⠀⡼⠀⠸⢰⠀⣤⣅⣁⣴⠀⠀⠀⠀⢻⠀",
        "⢠⡇⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠱⢀⣁⣤⣧⣴⣧⣄⡇⢸⣸⡄⠀⢀⣆⠀⣦⠊⢹⣿⣿⡛⠻⢿⠀⠀⠀⠀⢸⡇",
        "⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⣃⠀⠀⢴⣿⠟⠉⢈⣿⣿⣿⡟⠇⠀⠀⠀⠀⠀⠀⢸⣶⣿⣿⡿⣧⠀⢸⡇⠀⢃⠀⢸⡇",
        "⠈⡇⠀⠀⠀⠀⠀⠀⠀⡀⢉⡄⠀⢸⠁⠀⣷⣾⣿⣿⡟⣿⠀⠀⠀⠀⠀⠀⠀⠀⢧⠙⠋⢁⡟⢀⡦⢧⠀⠸⡇⢸⡇",
        "⠀⣿⠀⠀⠀⠀⠀⠀⢀⠔⠪⡄⠀⠸⣁⠀⠹⣉⠉⠉⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢲⠛⠆⢉⠀⢸⠀⢀⢇⢸⡇",
        "⠀⢿⠀⠀⠀⠀⠀⢀⠃⡐⠐⣴⠀⠀⠏⠉⠖⠉⠋⡙⠁⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⢀⡠⠀⠊⠄⠌⢘⠀⠀⠸⢸⠀",
        "⠀⢸⠀⠀⠀⠀⠀⠈⣆⢃⠘⠘⡀⠀⡸⡘⡐⡐⠠⠁⠀⡴⡖⣲⠒⠊⠉⠉⠉⠙⢿⣤⡇⠀⠀⠀⠈⢐⠀⠀⠁⣿⠀",
        "⠀⠘⡇⠀⠀⠀⠀⠀⠈⢶⠬⣁⡇⠀⠀⠑⠐⠤⠐⠀⠀⡇⠉⠀⠀⠀⠀⠀⠀⠀⠀⢙⠇⠀⠀⠀⠀⣼⢀⠀⠀⣿⠀",
        "⠀⠀⣇⠀⠀⠀⢰⠀⠀⠈⠀⠂⡇⠀⠃⢡⠀⠀⠀⠀⠀⠹⡄⠀⠀⠀⠀⠀⠀⠀⣠⠎⠀⠀⢀⡴⡞⡉⠈⠀⠀⣿⠀",
        "⠀⠀⣹⠀⠀⠀⠀⠀⠀⠀⠀⡀⡇⠀⢰⠈⡷⡀⠀⠀⠀⠀⠸⢶⣀⠀⠀⢀⣰⠎⠁⢀⡶⠏⠁⣈⠆⠁⡀⠰⢸⡇⠀",
        "⠀⠀⢸⡀⢸⠀⠀⠆⠀⠀⠀⠀⡇⠀⠀⠀⢡⡄⡏⢆⠒⠢⠤⠤⠤⢨⠥⡴⠒⠚⠉⠉⠀⠀⡠⠁⡘⢠⠁⢀⠆⡇⠀",
        "⠀⠀⢸⡇⠀⡀⠀⠀⠀⠀⢠⢠⠁⠀⠘⡀⠠⣷⠃⠀⠀⠀⠀⠉⢰⠈⢱⠄⡀⡄⠀⢸⠀⠐⠀⠰⠁⠀⠀⡞⠄⣷⠀",
        "⠀⠀⠀⣷⠀⡇⠀⠀⠀⠸⠀⡈⠀⠀⢂⠃⠀⡄⠇⠀⠀⠀⠀⠀⢔⠳⠀⠀⠣⠍⠒⠤⣰⠁⢠⠃⢠⠀⠀⠅⠀⢻⡀",
        "⠀⠀⠀⠉⠀⠁⠀⠀⠀⠀⠀⠁⠀⠀⠈⠀⠀⠁⠈⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠈⠁⠀⠈⠀⠁⠀⠈⠀⠀⠁⠀⠈⠁",
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
