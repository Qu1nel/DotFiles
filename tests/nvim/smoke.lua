-- Run after the isolated profile loads: nvim --headless -c "lua dofile('tests/nvim/smoke.lua')"
local function check(condition, message)
  if not condition then error(message, 2) end
end

local function keys(input)
  local encoded = vim.api.nvim_replace_termcodes(input, true, false, true)
  vim.api.nvim_feedkeys(encoded, "xt", false)
end

local function main()
  check(vim.fn.has("nvim-0.12.5") == 1, "Neovim 0.12.5 or newer required")
  check(vim.v.errmsg == "", "Startup error: " .. vim.v.errmsg)
  for _, module in ipairs({ "mini.pick", "mini.bufremove", "nvim-tree.api", "lint", "tokyonight" }) do
    check(pcall(require, module), "Plugin missing: " .. module)
  end
  local config = require("lazy.core.config")
  check(vim.fs.normalize(config.options.lockfile) == vim.fs.normalize(vim.fn.stdpath("config") .. "/lazy-lock.json"), "Lockfile depends on working directory")
  check(config.options.install.missing == false, "Normal startup must not install plugins")
  local state_root = vim.fs.normalize(vim.fn.stdpath("state") .. "/state/dotfiles-lazy/")
  for _, path in ipairs({ config.options.state, config.options.pkg.cache, config.options.readme.root }) do
    check(vim.fs.normalize(path):sub(1, #state_root) == state_root, "Lazy runtime files must stay outside the installed plugins")
  end

  for _, lhs in ipairs({ "<Tab>", "<S-Tab>", "<Leader>j", "<Leader>c", "<Leader>C", "<Leader>bc", "<Leader>bC", "<Leader>bD", "<Leader>bv", "<Leader>bh", "<Leader>bs", "<Leader>e", "<Leader>o", "<Leader>lf", "<F2>" }) do
    check(vim.fn.maparg(lhs, "n") ~= "", "Missing mapping: " .. lhs)
  end
  check(vim.fn.maparg(":", "n") == "", "Native command line must remain usable")
  check(not vim.fn.maparg("<C-s>", "n"):find("!", 1, true), "Ordinary saving must not force writes")
  check(not vim.fn.maparg("<Leader>q", "n"):find("!", 1, true), "Ordinary quit must not force writes")
  check(vim.o.langmap:find("фисвуап", 1, true), "Russian keyboard navigation is missing")

  local dir = vim.fn.tempname() .. " space кириллица"
  vim.fn.mkdir(dir, "p")
  local fixture = {
    { "sample.py", "python", "def sample():", "    return 1" },
    { "sample.go", "go", "package main", "func main() {}" },
    { "sample.md", "markdown", "# Heading", "Some text." },
    { "sample.yaml", "yaml", "key: value", "enabled: true" },
    { "sample.toml", "toml", "[section]", "enabled = true" },
  }
  for _, item in ipairs(fixture) do
    local path = dir .. "/" .. item[1]
    vim.fn.writefile({ item[3], item[4] }, path)
    vim.cmd.edit(vim.fn.fnameescape(path))
    check(vim.bo.filetype == item[2], "Wrong filetype for " .. item[1])
    check(vim.bo.syntax ~= "" or vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()], "No syntax highlighting for " .. item[1])
    if item[2] == "go" then check(not vim.bo.expandtab, "Go must use tabs") end
  end

  local original_format = vim.lsp.buf.format
  local format_calls = 0
  vim.lsp.buf.format = function() format_calls = format_calls + 1 end
  local unformatted = { "x=  1", "" }
  vim.cmd.edit(vim.fn.fnameescape(dir .. "/sample.py"))
  vim.api.nvim_buf_set_lines(0, 0, -1, false, unformatted)
  vim.cmd.write()
  check(format_calls == 0, "Saving called the formatter")
  check(vim.deep_equal(vim.fn.readfile(dir .. "/sample.py"), unformatted), "Saving altered file contents")
  vim.lsp.buf.format = original_format

  local buffers = require("dotfiles.buffers")
  check(buffers.close_all(false), "Could not reset clean buffers")
  vim.cmd.enew()
  local first = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(first, dir .. "/alpha.txt")
  local second = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(second, dir .. "/beta.txt")
  local third = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(third, dir .. "/gamma.txt")
  keys("2<Tab>")
  check(vim.api.nvim_get_current_buf() == third, "Counted Tab navigation failed")
  keys("<S-Tab>")
  check(vim.api.nvim_get_current_buf() == second, "Backward buffer navigation failed")

  vim.api.nvim_buf_set_lines(first, 0, -1, false, { "unsaved work" })
  check(not buffers.close(first), "Normal close discarded unsaved work")
  check(not buffers.close_all(false), "Bulk close discarded unsaved work")
  check(vim.api.nvim_buf_is_loaded(first) and vim.api.nvim_buf_is_loaded(second) and vim.api.nvim_buf_is_loaded(third), "Bulk close partially deleted buffers before checking modifications")
  check(not buffers.close_all(true), "Close others discarded unsaved work")
  vim.api.nvim_set_current_buf(first)
  check(buffers.close_all(true), "Modified current buffer must survive close others")
  check(vim.api.nvim_get_current_buf() == first and vim.bo.modified, "Close others changed current unsaved buffer")
  check(buffers.close(first, true), "Explicit force close failed")

  local test_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
  dofile(test_dir .. "/buffer-picker.lua")()

  local tree = require("nvim-tree.api")
  vim.cmd.edit(vim.fn.fnameescape(dir))
  check(vim.wait(3000, function() return tree.tree.is_visible() end, 20), "Opening a directory did not open the explorer")
  local tree_win = require("nvim-tree.view").get_winnr()
  check(tree_win and vim.api.nvim_win_is_valid(tree_win), "Explorer did not open")
  local tree_x = vim.api.nvim_win_get_position(tree_win)[2]
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= tree_win and vim.api.nvim_win_get_config(win).relative == "" then
      check(tree_x < vim.api.nvim_win_get_position(win)[2], "Explorer must be on the left")
    end
  end
  tree.tree.close()
  check(vim.v.errmsg == "", "Runtime error: " .. vim.v.errmsg)
  vim.fn.delete(dir, "rf")
  print("Neovim smoke checks passed")
end

vim.schedule(function()
  local ok, err = xpcall(main, debug.traceback)
  if not ok then
    vim.api.nvim_err_writeln(err)
    vim.cmd("cquit 1")
  else
    vim.cmd("qa!")
  end
end)
