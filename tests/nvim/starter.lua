local function check(condition, message)
  if not condition then error(message, 2) end
end

local function main()
  local case = vim.env.DOTFILES_NVIM_STARTER_CASE or "bare"
  check(vim.v.errmsg == "", "Startup error: " .. vim.v.errmsg)
  local starter = require("mini.starter")
  if case == "quit" then
    check(vim.bo.filetype == "ministarter", "Clean quit requires the welcome screen")
    print("Neovim welcome clean quit started")
    starter.set_query("q")
    error("Welcome quit did not exit Neovim")
  end
  if case ~= "bare" then
    check(vim.bo.filetype ~= "ministarter", "Welcome replaced " .. case .. " startup")
    if case == "file" then
      check(vim.fs.normalize(vim.api.nvim_buf_get_name(0)) == vim.fs.normalize(vim.env.DOTFILES_NVIM_STARTER_FILE), "File startup lost the requested file")
      check(vim.api.nvim_buf_get_lines(0, 0, 1, true)[1] == "file startup", "File startup lost its content")
    elseif case == "directory" then
      check(require("nvim-tree.api").tree.is_visible(), "Directory startup lost the explorer")
    elseif case == "stdin" then
      check(vim.api.nvim_buf_get_lines(0, 0, 1, true)[1] == "stdin startup", "Standard input was replaced")
    elseif case == "modified" then
      check(vim.bo.modified, "Empty modified buffer was reset")
    end
    print("Neovim welcome " .. case .. " checks passed")
    return
  end

  check(vim.bo.filetype == "ministarter", "Empty startup did not show the welcome screen")
  local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  check(content:find("⠤⣤⣤⣤⣄⣀⣀⣀⣀⣀", 1, true), "Legacy eyes are missing")
  for _, name in ipairs({ "New file", "Find files", "Find text", "Explorer", "Quit" }) do
    check(content:find(name, 1, true), "Missing welcome action: " .. name)
  end
  starter.set_query("n")
  check(vim.bo.filetype == "" and vim.api.nvim_buf_get_name(0) == "", "New file did not create an editable empty buffer")
  check(vim.bo.modifiable and vim.bo.buftype == "", "New file is not an ordinary editing buffer")
  local unsaved = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(unsaved, 0, -1, false, { "unsaved work" })
  check(not require("dotfiles.starter").open(), "Welcome replaced unsaved work")
  check(vim.api.nvim_get_current_buf() == unsaved and vim.bo.modified, "Welcome altered an unsaved buffer")
  vim.cmd.enew()
  vim.cmd.Welcome()
  local welcome = vim.api.nvim_get_current_buf()
  starter.set_query("q")
  check(vim.api.nvim_buf_is_valid(unsaved) and vim.bo[unsaved].modified, "Quit discarded another modified buffer")
  check(vim.api.nvim_get_current_buf() == welcome, "Quit exited despite unsaved work")
  vim.bo[unsaved].modified = false

  local dir = vim.fn.tempname() .. " welcome space кириллица"
  vim.fn.mkdir(dir, "p")
  local fixture = dir .. "/welcome.txt"
  vim.fn.writefile({ "welcome search needle" }, fixture)
  local original_cwd = vim.fn.getcwd()
  vim.cmd.cd(vim.fn.fnameescape(dir))
  local picker = require("mini.pick")
  local function choose(key, query)
    local found, ticks = false, 0
    local function poll()
      ticks = ticks + 1
      if picker.is_picker_active() then
        if query and ticks == 1 then picker.set_picker_query(vim.split(query, "")) end
        local items = picker.get_picker_matches()
        if items and items.all and #items.all > 0 then
          found = true
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "t", false)
          return
        end
      end
      if ticks >= 100 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "t", false)
        return
      end
      vim.defer_fn(poll, 30)
    end
    vim.defer_fn(poll, 30)
    starter.set_query(key)
    check(found, "Welcome picker found no results: " .. key)
    check(vim.fs.normalize(vim.api.nvim_buf_get_name(0)) == vim.fs.normalize(fixture), "Welcome picker did not open the selected file: " .. key)
  end
  choose("f")
  vim.cmd.Welcome()
  choose("g", "needle")
  vim.cmd.Welcome()
  starter.set_query("e")
  check(require("nvim-tree.api").tree.is_visible(), "Welcome explorer action failed")
  require("nvim-tree.api").tree.close()
  vim.cmd.cd(vim.fn.fnameescape(original_cwd))
  vim.fn.delete(dir, "rf")
  check(vim.v.errmsg == "", "Runtime error: " .. vim.v.errmsg)
  print("Neovim welcome checks passed")
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
