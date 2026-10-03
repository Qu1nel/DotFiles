local ok, err = xpcall(function()
  local function check_path(kind, expected)
    assert(expected and expected ~= "", "Missing expected " .. kind .. " path")
    assert(vim.fs.normalize(vim.fn.stdpath(kind)) == vim.fs.normalize(expected), kind .. " isolation failed")
  end
  check_path("config", vim.env.DOTFILES_NVIM_EXPECT_CONFIG)
  check_path("data", vim.env.DOTFILES_NVIM_EXPECT_DATA)
  assert(vim.env.DOTFILES_NVIM_TEST, "Missing test script")
  dofile(vim.env.DOTFILES_NVIM_TEST)
end, debug.traceback)

if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd("cquit 1")
end
