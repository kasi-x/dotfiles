vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("better_backup", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  -- group = group_name,
  desc = "Add timestamp to backup extension",
  pattern = "*",
  callback = function()
    vim.opt.backupext = "-" .. os.date("%Y%m%d%H%M")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("QuickFixMappings", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<CR>:cclose<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":cclose<CR>", { noremap = true, silent = true })
  end,
})

-- vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
-- pattern = "git/config",
-- callback = function()
-- vim.api.nvim_exec("set filetype=ini", false)
-- end,
-- })

-- if client.server_capabilities.documentHighlightProvider then
-- vim.cmd([[
-- hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
-- hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
-- hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
-- ]])
-- vim.api.nvim_create_augroup("lsp_document_highlight", {
-- clear = false,
-- })
-- vim.api.nvim_clear_autocmds({
-- buffer = bufnr,
-- group = "lsp_document_highlight",
-- })
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- group = "lsp_document_highlight",
-- buffer = bufnr,
-- callback = vim.lsp.buf.document_highlight,
-- })
-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- group = "lsp_document_highlight",
-- buffer = bufnr,
-- callback = vim.lsp.buf.clear_references,
-- })
-- end

-- vim:ts=2:sts=2:et:cc=78:ft=lua
