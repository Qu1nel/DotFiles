local function escape(str)
    local escape_chars = [[;,."|\]]
    return vim.fn.escape(str, escape_chars)
end

local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

local settings = { opt = {}, g = {} }

settings.opt = {
    relativenumber = true,
    number = true,
    spell = false,
    signcolumn = "auto",
    wrap = false,
    shiftwidth = 4,
    tabstop = 4,
    langmap = vim.fn.join({
        escape(ru_shift) .. ";" .. escape(en_shift),
        escape(ru) .. ";" .. escape(en),
    }, ","),
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
