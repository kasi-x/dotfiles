local options = {
  guifont = "JetBrainsMono Nerd Font Propo:h12",
  guifontwide = "IBM Plex Sans JP:h12",
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  -- {{{ Visual
  termguicolors = true, -- truecolours for better experience
  -- neovide_hide_mouse_when_typing = true,
  -- neovide_cursor_animation_length = 0,
  number = false, -- Always show line number
  swapfile = false,
  -- relativenumber = true, -- Always show relative numbers
  -- cursorline = true, -- Change current line background
  showtabline = 1, -- Show tabline when more than 1 tab
  -- Visual }}}

  -- {{{ Files & Buffers
  hidden = true, -- Do not close the buffers, hide them
  history = 1000, -- Remember more commands and search history
  undolevels = 1000, -- Remember more levels of undo
  formatoptions = "mMj",
  undodir = vim.fn.expand("~/.cache/undo"),
  undofile = true,
  backup = false,
  -- undodir = os.getenv("HOME") .. "/.vim/undodir",
  --
  -- novisualbell = true,        -- No 'visual buzz' on error
  -- autoread = true,            -- Reload the file if changed from the outside
  -- switchbuf = "uselast", -- If opening a file from :ls, :buffers, :files, etc. jump to open version
  -- buftype = "",

  -- of the file, if one exists
  clipboard = "unnamed", -- Use * and + registers to access system clipboard(i.e. tmux)
  -- clipboard = "unnamedplus",
  -- clipboard = ,

  -- confirm = true,       -- Dialog for unsaved changes
  splitright = true, -- Go to right pane by default (Needed for quickmenu)
  shortmess = "csa", -- Disable some hit-enter messages
  -- Files & Buffers }}}

  -- {{{ Terminal setup
  lazyredraw = false, -- lazyredraw to make macro faster
  showcmd = true, -- Show keys in status
  -- Terminal setup }}}

  -- {{{ Folding
  foldmethod = "marker", -- foldmethod using marker
  foldlevel = 10, -- limit foldings
  -- Folding }}}

  -- {{ Trailings / tabs
  list = true, -- display listchars
  fillchars = { vert = "│", eob = " " }, -- make vertical split sign better
  listchars = { eol = "↲", tab = "» " }, -- set listchars
  matchpairs = "(:),{:},[:],<:>,「:」,（:）",
  -- foldfix = true,

  -- Trailings / tabs }}}
  --
  -- -- Better vimdiff{{{
  diffopt = "internal,algorithm:patience,indent-heuristic", --}}}
  --
  -- Completion{{{
  pumheight = 10, -- limit completion items
  timeoutlen = 400, -- faster timeout wait time
  updatetime = 100, -- set faster update time ]]}}}
  -- wildmode = "list:longest,full",
  scrolloff = 5,
  cmdheight = 0,
  cmdwinheight = 1,
  -- conceallevel=3,
  -- concealcursor='nvc'
}
-- vim.g.node_host_prog = "/home/akizora/.nvm/versions/node/v18.16.0/bin/node"
for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd('setlocal ignorecase')
vim.cmd('setlocal conceallevel=0')
-- local alpha = function()
-- return string.format("%x", math.floor(255 * vim.g.transparency or 0.9))
-- end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
-- vim.g.neovide_transparency = 1
--
-- vim.g.transparency = 1
-- vim.g.neovide_background_color = "#0f1117" .. alpha()

-- if os.getenv("VIRTUAL_ENV") ~= nil then
--     vim.g.python3_host_prog = string.gsub(io.popen("whicsages -a python3 | head -n2 | tail -n1"):read("*all"), "\n", "")
-- else
--     vim.g.python3_host_prog = string.gsub(io.popen("which python3"):read("*all"), "\n", "")
-- end