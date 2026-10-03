-- Integration checks against the installed servers and linters, without network access.
local function check(condition, message)
  if not condition then error(message, 2) end
end

local function diagnostic_summary(buf)
  local diagnostics = vim.tbl_map(function(diagnostic)
    return { source = diagnostic.source, severity = diagnostic.severity, code = diagnostic.code, message = diagnostic.message }
  end, vim.diagnostic.get(buf))
  local clients = vim.tbl_map(function(client)
    return { name = client.name, root = client.config.root_dir }
  end, vim.lsp.get_clients({ bufnr = buf }))
  return vim.json.encode({ diagnostics = diagnostics, clients = clients })
end

local function check_python_completion(buf)
  check(#vim.lsp.get_clients({ bufnr = buf, name = "pyright" }) == 1, "Pyright is not attached")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "" })
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  local failure
  vim.defer_fn(function()
    local ok, err = pcall(function()
      check(vim.wait(10000, function() return vim.fn.pumvisible() == 1 end, 20), "Typing a Python prefix did not open native completion")
      local print_index
      for index, item in ipairs(vim.fn.complete_info({ "items" }).items) do
        if item.word == "print" then print_index = index; break end
      end
      check(print_index ~= nil, "Pyright did not suggest print")
      local accept = string.rep("<C-n>", print_index) .. "<C-y><Esc>"
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(accept, true, false, true), "t", false)
    end)
    if not ok then
      failure = err
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-e><Esc>", true, false, true), "t", false)
    end
  end, 100)
  vim.api.nvim_feedkeys("ipri", "xt!", false)
  check(not failure, failure or "Python completion failed")
  check(vim.api.nvim_get_current_line() == "print", "Ctrl-Y did not accept the selected completion")
end

local function main()
  -- Keep fixtures outside the checkout so Git roots cannot mask standalone LSP failures.
  local dir = vim.fn.tempname() .. " languages space кириллица"
  vim.fn.mkdir(dir, "p")
  vim.fn.writefile({ 'module example.com/dotfiles-test', '', 'go 1.23' }, dir .. "/go.mod")
  vim.fn.writefile({ "[tool.ruff]" }, dir .. "/pyproject.toml")
  local fixtures = {
    { name = "main.py", tool = "ruff", bad = { "import os" }, good = { "value = 1" } },
    { name = "type-error.py", tool = "pyright", code = "reportOperatorIssue", bad = { 'print(3 + "34")' }, good = { "print(3 + 34)" } },
    { name = "main.go", tool = "gopls", message = "missing", bad = { "package main", "func main() { missing() }" }, good = { "package main", "func main() {}" } },
    { name = "main.yaml", tool = "yamlls", bad = { "name: [" }, good = { "name: value" } },
    { name = "main.toml", tool = "taplo", message = "conflicting keys", severity = vim.diagnostic.severity.ERROR, bad = { "name = 1", "name = 2" }, good = { "name = 1" } },
    { name = "main.md", tool = "markdownlint", bad = { "#Heading" }, good = { "# Heading" } },
  }
  for _, fixture in ipairs(fixtures) do
    local path = dir .. "/" .. fixture.name
    vim.fn.writefile(fixture.bad, path)
    vim.cmd.edit(vim.fn.fnameescape(path))
    local buf = vim.api.nvim_get_current_buf()
    check(vim.wait(45000, function()
      for _, diagnostic in ipairs(vim.diagnostic.get(buf)) do
        if (not fixture.code or diagnostic.code == fixture.code)
          and (not fixture.severity or diagnostic.severity == fixture.severity)
          and (not fixture.message or diagnostic.message:find(fixture.message, 1, true)) then return true end
      end
      return false
    end, 50), fixture.tool .. " did not report the intentional error: " .. diagnostic_summary(buf))
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, fixture.good)
    vim.cmd.write()
    check(vim.wait(15000, function() return #vim.diagnostic.get(buf) == 0 end, 50), fixture.tool .. " retained diagnostics after the error was fixed: " .. diagnostic_summary(buf))
    if fixture.tool == "ruff" then
      local unformatted = { "value=  1" }
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, unformatted)
      vim.cmd.write()
      check(vim.deep_equal(vim.api.nvim_buf_get_lines(buf, 0, -1, false), unformatted), "Python formatted automatically on save")
      vim.cmd.Format()
      check(vim.api.nvim_get_current_line() == "value = 1", "Explicit Python formatting failed")
      vim.cmd.write()
    elseif fixture.tool == "pyright" then
      check_python_completion(buf)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, fixture.good)
      vim.cmd.write()
      print("pyright: native prefix completion and Ctrl-Y acceptance passed")
    end
    print(fixture.tool .. ": error detected and cleared")
  end
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do client:stop() end
  check(vim.wait(3000, function()
    for _, client in ipairs(clients) do if not client:is_stopped() then return false end end
    return true
  end, 20), "Language servers did not shut down")
  vim.cmd("silent! %bdelete!")
  vim.fn.delete(dir, "rf")
  print("Neovim language checks passed")
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
