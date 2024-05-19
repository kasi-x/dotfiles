local set = vim.api.nvim_set_option
local M = {}

M.python = function()
  set('tabstop', 4)
  set('expandtab', true)
end


return M