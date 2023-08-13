local settings = { opt = {}, g = {} }

settings.opt = {
    relativenumber = true,
    number = true,
    spell = false,
    signcolumn = "auto",
    wrap = false,
    shiftwidth = 4,
    tabstop = 4,
    langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz",
}

settings.g = {
    mapleader = " ",
    autoformat_enabled = true,
    cmp_enabled = true,
    autopairs_enabled = true,
    diagnostics_mode = 3,
    icons_enabled = true,
    ui_notifications_enabled = true,
    resession_enabled = false,
}

return settings
