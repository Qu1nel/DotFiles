local M = {}

function M.list()
  return vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype == ""
  end, vim.api.nvim_list_bufs())
end

function M.navigate(count)
  local buffers = M.list()
  if #buffers == 0 then return end
  local current = vim.api.nvim_get_current_buf()
  local index = count > 0 and 0 or 1
  for i, buf in ipairs(buffers) do
    if buf == current then index = i; break end
  end
  vim.api.nvim_set_current_buf(buffers[(index - 1 + count) % #buffers + 1])
end

function M.close(buf, force)
  if not buf or buf == 0 then buf = vim.api.nvim_get_current_buf() end
  if vim.bo[buf].modified and not force then
    vim.notify("Buffer has unsaved changes. Save it first, or use <Space>C to discard them.", vim.log.levels.WARN)
    return false
  end
  local ok, remove = pcall(require, "mini.bufremove")
  if ok then
    return remove.delete(buf, force == true) == true
  else
    vim.api.nvim_buf_delete(buf, { force = force == true })
  end
  return true
end

function M.close_all(keep_current)
  local current = vim.api.nvim_get_current_buf()
  local targets = vim.tbl_filter(function(buf) return not keep_current or buf ~= current end, M.list())
  for _, buf in ipairs(targets) do
    if vim.bo[buf].modified then
      vim.notify("No buffers closed: save modified buffers first.", vim.log.levels.WARN)
      return false
    end
  end
  for _, buf in ipairs(targets) do M.close(buf) end
  return true
end

function M.pick(action)
  local ok, picker = pcall(require, "mini.pick")
  if not ok then vim.notify("Buffer picker requires installed plugins.", vim.log.levels.WARN); return end
  local items = vim.tbl_map(function(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    return { bufnr = buf, text = string.format("%d %s%s", buf, name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":~:."), vim.bo[buf].modified and " [+]" or "") }
  end, M.list())
  picker.start({ source = {
    name = action == "close" and "Close buffer" or "Buffers",
    items = items,
    choose = function(item)
      if action == "close" then M.close(item.bufnr); return end
      vim.api.nvim_win_call(picker.get_picker_state().windows.target, function()
        if action == "vertical" then vim.cmd.vsplit() end
        if action == "horizontal" then vim.cmd.split() end
        vim.api.nvim_win_set_buf(0, item.bufnr)
        picker.set_picker_target_window(vim.api.nvim_get_current_win())
      end)
    end,
  } })
end

return M
