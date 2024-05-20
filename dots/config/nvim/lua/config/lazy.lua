local in_vscode = vim.g.vscode ~= nil
local is_jp_file = vim.fn.expand("%:t"):match("_jp%.md$")
local is_en_file = not is_jp_file
-- local file_size_threshold = 5000 * 1024 -- 50KB in bytes
-- local file_stat = vim.loop.fs_stat(vim.fn.expand("%:p"))
-- local is_large_file = file_stat and file_stat.size > file_size_threshold
local is_large_file = false

local base_path = vim.fn.stdpath("data")
local lazy_path = base_path .. "/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazy_path })
  vim.fn.system({ "git", "-C", lazy_path, "checkout", "tags/stable" })
end

vim.opt.rtp:prepend(lazy_path)
local lazy_suffix = is_large_file and "large"
  or (in_vscode and (is_jp_file and "vscode_jp" or "vscode_en") or (is_jp_file and "nvim_jp" or "nvim_en"))
local plugin_path = base_path .. "/lazy_" .. lazy_suffix

vim.g.mapleader = " "

local opts = {
  root = plugin_path, -- 環境に応じたプラグインの保存先を設定
  defaults = {
    lazy = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

local plugins = {
  { import = "plugins.common" },
  -- { import = is_large_file and "plugins.large" or (in_vscode and "plugins.vscode" or "plugins.nvim") },
  { import = in_vscode and "plugins.vscode" or "plugins.nvim" },
  { import = is_jp_file and "plugins.jp" or "plugins.en" },
  { import = (in_vscode and is_jp_file) and "plugins.vscode_jp" or nil },
  { import = (in_vscode and is_en_file) and "plugins.vscode_en" or nil },
  { import = (not in_vscode and is_jp_file) and "plugins.nvim_jp" or nil },
  { import = (not in_vscode and is_en_file) and "plugins.nvim_en" or nil },
}
-- end

require("lazy").setup(plugins, opts)