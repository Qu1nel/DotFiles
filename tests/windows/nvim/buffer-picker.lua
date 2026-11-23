local buffers = require("dotfiles.buffers")
local picker = require("mini.pick")
local function check(condition, message)
  if not condition then error(message, 2) end
end

local function select(action, buf)
  local selected = false
  vim.defer_fn(function()
    if not picker.is_picker_active() then return end
    local items = picker.get_picker_items()
    for i, item in ipairs(items or {}) do
      if item.bufnr == buf then
        picker.set_picker_match_inds({ i })
        selected = true
        break
      end
    end
    local input = selected and "<CR>" or "<Esc>"
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(input, true, false, true), "t", false)
  end, 30)
  buffers.pick(action)
  check(selected, "Picker did not include the expected buffer")
end

return function()
  buffers.close_all(false)
  vim.cmd.enew()
  local first = vim.api.nvim_get_current_buf()
  local second = vim.api.nvim_create_buf(true, false)
  local third = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(first, "picker-alpha.txt")
  vim.api.nvim_buf_set_name(second, "picker-beta.txt")
  vim.api.nvim_buf_set_name(third, "picker-gamma.txt")
  select(nil, second)
  check(vim.api.nvim_get_current_buf() == second, "Picker did not jump in the target window")
  local original = vim.api.nvim_get_current_win()
  select("vertical", third)
  local vertical = vim.api.nvim_get_current_win()
  check(vertical ~= original and vim.api.nvim_get_current_buf() == third, "Vertical picker did not open a split")
  check(vim.api.nvim_win_get_position(vertical)[2] > vim.api.nvim_win_get_position(original)[2], "Vertical picker split has wrong orientation")
  vim.cmd.close()
  select("horizontal", first)
  local horizontal = vim.api.nvim_get_current_win()
  check(horizontal ~= original and vim.api.nvim_get_current_buf() == first, "Horizontal picker did not open a split")
  check(vim.api.nvim_win_get_position(horizontal)[1] > vim.api.nvim_win_get_position(original)[1], "Horizontal picker split has wrong orientation")
  vim.cmd.close()
  select("close", third)
  check(not vim.bo[third].buflisted, "Picker did not close selected buffer")
  buffers.close_all(false)
end
