local M = {}

local header = {
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
}

function M.open()
  if vim.bo.modified then
    vim.notify("Save the current buffer before opening the welcome screen.", vim.log.levels.WARN)
    return false
  end
  require("mini.starter").open()
  return true
end

function M.setup()
  local starter = require("mini.starter")
  starter.setup({
    autoopen = false,
    evaluate_single = true,
    header = table.concat(header, "\n"),
    items = {
      { name = "n  New file", action = "enew", section = "Actions" },
      { name = "f  Find files", action = function() require("mini.pick").builtin.files() end, section = "Actions" },
      { name = "g  Find text", action = function()
        if vim.fn.executable("rg") ~= 1 then
          vim.notify("Text search requires ripgrep (rg).", vim.log.levels.WARN)
          return
        end
        require("mini.pick").builtin.grep_live({ tool = "rg" })
      end, section = "Actions" },
      { name = "e  Explorer", action = function() require("nvim-tree.api").tree.open() end, section = "Actions" },
      { name = "q  Quit", action = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].modified then
            vim.notify("Save modified buffers before quitting.", vim.log.levels.WARN)
            return
          end
        end
        vim.cmd.quitall()
      end, section = "Actions" },
    },
    footer = "n / f / g / e / q    or select with arrows and Enter\n:Welcome opens this screen again",
    content_hooks = { starter.gen_hook.aligning("center", "center") },
    query_updaters = "nfgeq",
    silent = true,
  })
  vim.api.nvim_create_user_command("Welcome", M.open, { desc = "Open the welcome screen" })
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("DotFilesWelcome", { clear = true }),
    once = true,
    callback = function()
      local listed = vim.tbl_filter(function(buf) return vim.bo[buf].buflisted end, vim.api.nvim_list_bufs())
      if vim.fn.argc() ~= 0 or #listed ~= 1 or vim.bo.modified or vim.bo.filetype ~= ""
        or vim.api.nvim_buf_get_name(0) ~= "" or vim.api.nvim_buf_line_count(0) ~= 1
        or vim.api.nvim_buf_get_lines(0, 0, 1, true)[1] ~= "" then return end
      starter.open(vim.api.nvim_get_current_buf())
    end,
    desc = "Show the welcome screen on empty startup",
  })
end

return M
