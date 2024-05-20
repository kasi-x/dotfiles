-- map func {{{
local function map(mode, lhs, rhs, opts)
local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = vim.tbl_extend("force", { expr = false, silent = true, nowait = true, noremap = true },
      opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
local is_vscode = vim.g.vscode ~= nil
--}}}
--- Marks {{{
-- Space {{{
map({ "n", "x", "o" }, "<Space>", "<Nop>", { desc = "Disable Space" })
map({ "i", "c" }, "<Space>", "<Space>", { desc = "Disable Space" })
map({ "n", "x", "o" }, "<Del>", "<Nop>", { desc = "Disable Del" })
map({ "n", "x", "o" }, "<BS>", "<Nop>", { desc = "Disable bs" })

if is_vscode then
  map("n", "<leader><leader>", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>",
    { desc = "Save File" })
else
  map({ "n", "x" }, "<leader><leader>", '<CMD>w!<CR><CMD>lua vim.cmd("nohlsearch")<CR>',
    { desc = "Save File" })
end
-- Space }}}
-- TAB {{{
map({ "n", "x", "o", "c" }, "<Tab>", "<Nop>", { desc = "Disable Tab" })
map({ "n", "x", "o", "c" }, "<S-Tab>", "<Nop>", { desc = "Disable Shift-Tab" })
map({ "n", "x", "o", "c" }, "<C-Tab>", "<Nop>", { desc = "Disable Ctrl-Tab" })
map({ "n", "x", "o", "c" }, "<C-S-Tab>", "<Nop>", { desc = "Disable Ctrl-Shift-Tab" })
-- TAB }}}
-- BLOCK {{{
map({ "n", "x" }, "[", "[z", { desc = "move to next marker" })
map({ "n", "x" }, "]", "]z", { desc = "move to prev marker" })
-- BLOCK }}}
-- COLON {{{
map({ "n", "x", "o" }, ";", ":", { desc = "enter cmdline" })
map({ "n", "x", "o" }, ":", ";", { desc = "Plugin Leader" })
-- COLON }}}
-- SIDE {{{
map({ "n", "o" }, "<", "<<", { desc = "Shift rightwards" })
map({ "n", "o" }, ">", ">>", { desc = "Shift leftwards" })
map("x", "<", "<gv", { desc = "Shift rightwards" })
map("x", ">", ">gv", { desc = "Shift leftwards" })
-- SIDE }}}
-- CONMA {{{
map({ "n", "x" }, ",", "/", { desc = "Search forward" })
map({ "n", "x" }, "g,", "?", { desc = "Search backward" })
-- map({ "n", "x" }, ",,", "<ESC>:nohlsearch<CR>", { desc = "Search forward" })

if is_vscode then
  map({ "n", "x" }, "<C-,>", "<Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>",
    { desc = "move" })
  map({ "n", "x" }, "<C-.>", "<Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>",
    { desc = "move" })
else
  map({ "n", "x" }, "<C-,>", "<C-o>", { desc = "Older cursor position in jump list" })
  map({ "n", "x" }, "<C-.>", "<C-i>", { desc = "Newer cursor position in jump list" })
end
map({ "n", "x" }, "<Leader>,", "g;", { desc = "Older cursor position in change list" })
map({ "n", "x" }, "<Leader>.", "g.", { desc = "Newer cursor position in change list" })
map({ "n", "x" }, "`", "<Nop>", { desc = "" })
map({ "n", "x" }, "'", "<Nop>", { desc = "" })

map({ "i", "c" }, "<C-,>", "<C-i>", { desc = "Insert Indent" })
map({ "i", "c" }, "<C-.>", "<C-o>ciw", { desc = "Remove forward chank" })
-- map({"n"}, "<C--9>", ":exec 'set guifont=*:h' . (str2nr(matchstr(&guifont", { desc = "decrement size" })
-- map({"n"}, "<C-+6>", ":exec 'set guifont=*:h' . (str2nr(matchstr(&guifont", { desc = "increment size" })

-- CONMA}}}
-- }}}

--[[ TODO KEYS -{{{
---- g
-- map('n', 'mq', vim.diagnostic.open_float)
-- map('n', '<Leader>f', vim.diagnostic.goto_prev)
-- map('n', '<Leader>p', vim.diagnostic.goto_next)
-- map('n', '<space>q', vim.diagnostic.setloclist)
--[[
  --
  -- map('n', 'B', vim.lsp.buf.hover, { desc = "Hover" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true })
imap <C-y> <C-e> " it is cursole insert of above and below."
-- c  <C-R>       * <Cmd>lua require("which-key").show("\18", {mode = "c", auto = true})<CR>
n  d           * <Cmd>lua require("which-key").show("d", {mode = "n", auto = true})<CR>
n  g           * <Cmd>lua require("which-key").show("g", {mode = "n", auto = true})<CR>
x  g           * <Cmd>lua require("which-key").show("g", {mode = "v", auto = true})<CR>
n  ya          * <Cmd>lua require("which-key").show("ya", {mode = "n", auto = true})<CR>
n  yi          * <Cmd>lua require("which-key").show("yi", {mode = "n", auto = true})<CR>

]]
--}}}

-- {{{  <Some> Template
-- {{{ Single / Shift
-- {{{ Normal / saisual / Operator
-- Make cursor position center after move for after jump move.
-- Reason: :Jump should not change screen position. But <small move> means you start editind at the point.
-- map({ "n", "x", "o" }, "n", "v:count == 0 ? 'gjzz' : 'jzz'", { expr = true, silent = true })
-- map({ "n", "x", "o" }, "e", "v:count == 0 ? 'gkzz' : 'kzz'", { expr = true, silent = true })
-- map({ "n", "x", "o" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x", "o" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--
--[[ N/E is used by "haya14busa/vim-edgemotion" for edge-jump, ]]
-- }}} Normal / Visual / Operator
-- }}} Single / Shift
-- {{{ <Ctrl>
-- {{{ Normal / Visual / Operator
--[[ <C-n>, <C-e> is used by hop.nvim ]]
-- }}} Normal / Visual / Operator
-- {{{ Insert
--[[ Insert Mode Action in nvim is defined at cmp.lua. ]]
-- Maybe this latter setting should be done in vscode.json.
-- if is_vscode() then  -- for vscode.
--   map({"i", "c"}, "<C-n>", "<Cmd>call VSCodeNotify('selectNextSuggestion')<CR>", { desc = "" })
-- end
-- }}} Insert
-- {{{ Command}
-- {{{ <Ctrl>
-- TODO: Add Command Action for search history.
--
-- FIX: Add Command Action for search history.

-- }}} <Ctrl>
-- }}} Command
-- }}} <Ctrl>
-- {{{ <Leader>
-- {{{ Normal / Visual / Operator
map({ "n", "x", "o" }, "<leader>n", '"}"', { expr = true, desc = "Navigate to the next paragraph" })
map({ "n", "x", "o" }, "<leader>e", '"{"',
  { expr = true, desc = "Navigate to the previous paragraph" })
map({ "n", "x", "o" }, "<leader>N", '"]"', { expr = false, desc = "Navigate to the next sentence" })
map({ "n", "x", "o" }, "<leader>E", '"["',
  { expr = false, desc = "Navigate to the previous sentence" })
map('t', '<esc>', "<C-\\><C-n>", {desc="exit from term" })
-- map('t', '<C-w>', [[<C-\><C-n><C-w>]], {desc="move from term"})
-- }}} Normal / Visual / Operator
-- }}} <Leader>
-- {{{ <g>
-- {{{ Normal
map("n", "gn", "<C-w>j", { desc = "Go to lower window", remap = false })
map("n", "ge", "<C-w>k", { desc = "Go to upper window", remap = false })
map("n", "gN", "<C-w>J", { desc = "Move window Up", remap = false })
map("n", "gE", "<C-w>K", { desc = "Move window Down", remap = false })
-- }}} Normal
-- {{{ Visual / Operator
-- TODO: Add gn/ge/gN/gE in visual mode. Treesitter move may good.
-- map({"v", "o"}, "gn", "G", { desc = "Go to Bottom", remap = false })
-- map({"v", "o"}, "ge, "G", { desc = "Go to Bottom", remap = false })
-- map({"v", "o"}, "gN", "G", { desc = "Go to Bottom", remap = false })
-- map({"v", "o"}, "gE, "G", { desc = "Go to Bottom", remap = false })
-- }}}  Visual / Operator
-- }}} <g>
-- {{{ <m/M>
-- {{{ Normal
--[[
  mn/me is for junmp next/previous fold.
  mN/mE is jump to top/bottom of current fold.
  These are defined at <M>
  Mn/Me is jump to next/previous mark by marks.nvim.
  FIX: this map may error.
 ]]
-- }}} Normal
-- }}} <m/M>
-- }}} <N/E> Up/Down

-- {{{ <H/I> WordMotion:W/B (-12, g(8), m/M(4))
-- {{{ Single / Shift (12/12)
-- {{{ Normal / Visual / Operator
--[[ h/i and H/I is used by "chrisgrieser/nvim-spider" ]]
-- }}} Normal / Visual / Operator
-- }}} Single / Shift
-- {{{ <Ctrl> (10/10)
-- {{{ Normal / Visual / Operator (6/6)
map({ "n", "x", "o" }, "<C-i>", '"W"', { expr = true, desc = "WORD Forward" })
map({ "n", "x", "o" }, "<C-h>", '"B"', { expr = true, desc = "WORD Backward" })
-- }}} Normal / Visual / Operator
-- {{{ Insert / Command (4/4)
map("c", "<C-i>", "<C-y>", { desc = "Move Tail" })
map("c", "<C-h>", "<C-e>", { desc = "Move Head" })
map("i", "<C-i>", "<Right>", {})
map("i", "<C-h>", "<Left>", {})
--[[ in cmp mode <C-h> is cancel. ]]
-- }}} Insert
-- }}} <Ctrl>
-- {{{ <Leader> (12/12)
-- {{{ Normal / Visual / Operator (12/12)
map({ "n", "x", "o" }, "<leader>h", '"^"', { expr = true, desc = "To the end of the line" })
map({ "n", "x", "o" }, "<leader>i", '"$"',
  { expr = true, desc = "To the first non-blank character of the line" })
map({ "n", "x", "o" }, "<leader>H", '"0"',
  { expr = true, desc = "To the first character of the line" })
map({ "n", "x", "o" }, "<leader>I", '"+"',
  { expr = true, desc = "Lines downward, on the first non-blank character" })
-- }}} Normal / Visual / Operator
-- }}} <Leader>
-- {{{ <g> (4/12)
-- {{{ Normal (4/4)
map("n", "gh", "<C-w>h", { desc = "Go to left window", remap = false })
map("n", "gi", "<C-w>l", { desc = "Go to right window", remap = false })
map("n", "gH", "<C-w>H", { desc = "Move window Left", remap = false })
map("n", "gI", "<C-w>L", { desc = "Move window Right", remap = false })
-- }}} Normal
-- {{{ Visual / Operator (0/8)
-- TODO: Add gh/gi/gH/gI in visual mode. Treesitter move may good.
-- map({"v", "o"}, "gh", "", { desc = "", remap = false })
-- map({"v", "o"}, "gi, "", { desc = "", remap = false })
-- map({"v", "o"}, "gH", "", { desc = "", remap = false })
-- map({"v", "o"}, "gI, "", { desc = "", remap = false })
-- }}}  Visual / Operator
-- }}} <g>
-- {{{ <m/M> (4/8)
-- {{{ Normal (4/8)
--[[
 mi/mh is for junmp next/previous fold.
 mH/mI is jump to top/bottom of current fold.
 These are defined at <M>
 Mi/Mh/MI/MH is not defined.
]]
-- }}} Normal
-- }}} <m/M>
-- }}}

-- {{{ <N/E> Up/Down (-12, g(8), m/M(4))
-- {{{ Single / Shift (6/6)
-- {{{ Normal / Visual / Operator
--[[ Make cursor position center after up/down move.
     Reason: Jump should not change screen position. But <small move> like up/down means you start editing at the point. ]]
-- n/e is used by accelerate.nvim
-- map({ "x", "o" }, "n", "gj", { expr = true, noremap = true })
-- map({ "x", "o" }, "e", "gk", { expr = true, noremap = true })

map({ "n", "x", "o" }, "n", "v:count == 0 ? 'gjzz' : 'jzz'",
  { expr = true, desc = "Move cursor to next line" })
map({ "n", "x", "o" }, "e", "v:count == 0 ? 'gkzz' : 'kzz'",
  { expr = true, desc = "Move cursor to previous line" })
-- map({ "n", "x", "o" }, "n", "gjzz", { expr = true, desc = "Move cursor to next line" })
-- map({ "n", "x", "o" }, "e", "gkzz", { expr = true, desc = "Move cursor to previous line" })

map({ "n", "x", "o" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x", "o" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })
--[[
 N/E is used by "haya14busa/vim-edgemotion" for edge-jump,
]]
-- }}} Normal / Visual / Operator
-- }}} Single / Shift
-- {{{ <Ctrl> (10/10)
-- {{{ Normal / Visual / Operator (6/6)
--[[ <C-n>, <C-e> is used by hop.nvim ]]
-- }}} Normal / Visual / Operator
-- {{{ Insert (2/2)
--[[ Insert Mode Action in nvim is defined at cmp.lua. ]]
-- Maybe this latter setting should be done in vscode.json.
-- if is_vscode() then
--   map({"i", "c"}, "<C-n>", "<Cmd>call VSCodeNotify('selectNextSuggestion')<CR>", { desc = "" })
-- end
-- }}} Insert
-- {{{ Command (2/2)
-- {{{ <Ctrl>
--[[ used by cmp.lua ]]
-- }}} <Ctrl>
-- }}} Command
-- }}} <Ctrl>
-- {{{ <Leader> (12/12)
-- {{{ Normal / Visual / Operator
map({ "n", "x", "o" }, "<leader>n", '"}"', { expr = true, desc = "Navigate to the next paragraph" })
map({ "n", "x", "o" }, "<leader>e", '"{"',
  { expr = true, desc = "Navigate to the previous paragraph" })
map({ "n", "x", "o" }, "<leader>N", '"]"', { expr = false, desc = "Navigate to the next sentence" })
map({ "n", "x", "o" }, "<leader>E", '"["',
  { expr = false, desc = "Navigate to the previous sentence" })
-- }}} Normal / Visual / Operator
-- }}} <Leader>
-- {{{ <g> (4/12)
-- {{{ Normal (4/4)
map("n", "gn", "<C-w>j", { desc = "Go to lower window", remap = false })
map("n", "ge", "<C-w>k", { desc = "Go to upper window", remap = false })
map("n", "gN", "<C-w>J", { desc = "Move window Up", remap = false })
map("n", "gE", "<C-w>K", { desc = "Move window Down", remap = false })
-- }}} Normal
-- {{{ Visual / Operator (0/8)
-- TODO: Add gn/ge/gN/gE in visual mode. Treesitter move may good.
-- map({"v", "o"}, "gn", "G", { desc = "Go to Bottom", remap = false })
-- map({"v", "o"}, "ge, "G", { desc = "Go to Bottom", remap = false })
-- map({"v", "o"}, "gN", "G", { desc = "Go to Bottom", remap = false })
-- map({"v", "o"}, "gE, "G", { desc = "Go to Bottom", remap = false })
-- }}}  Visual / Operator
-- }}} <g>
-- {{{ <m/M> (4/8)
-- {{{ Normal
--[[
 mn/me is for junmp next/previous fold.
 mN/mE is jump to top/bottom of current fold.
 These are defined at <M>
 Mn/Me is jump to next/previous mark by marks.nvim.
 FIX: this map may error.
]]
-- }}} Normal
-- }}} <m/M>
-- }}} <N/E> Up/Down

-- {{{ <U/Y> Right/Left (-19, S(6), L(9), g(4))
-- {{{ Single / Shift (6/12)
-- {{{ Normal / Visual / Operator (6/12)
map({ "n", "x" }, "u", "<left>", {})
map({ "n", "x" }, "y", "<right>", {})
map({ "n", "x" }, "U", "<Nop>", {})
map({ "n", "x" }, "Y", "<Nop>", {})
map("o", "<Nop>", "<left>", { noremap = true })
map("o", "<Nop>", "<right>", { noremap = true })

-- TODO:U,Y should used by some plugin.
-- }}} Normal / Visual / Operator
-- }}} Single / Shift
-- {{{ <Ctrl> (10/10)
-- {{{ Normal / Visual / Operator (6/6)
--[[ used by hop ]]
-- }}} Normal / Visual / Operator
-- {{{ Insert / Command (4/4)
--[[ <C-u>, <C-y> is used by Copilot.lua
--   command mode action is side move in cmp.lua]]
-- map("c", "<C-u>", "<C-p>", {})
-- map("c", "<C-y>", "<C-n>", {})
-- }}} Insert / Command
-- }}} <Ctrl>
-- {{{ <Leader> (3/12)
-- {{{ Normal / Visual / Operator
-- map('n', '<leader>u', '<Cmd>tabprev<CR>', { noremap = true, desc = 'tab previous' })
-- map('n', '<leader>y', '<cmd>tabnext<cr>', { noremap = true, desc = 'tab next' })
--
--
-- map('n', '<leader>u', "<cmd>lua if vim.api.nvim_list_tabpages() == 1 then vim.cmd('tabnew') else vim.cmd('tabprev') end<CR>", opts)
-- map('n', '<leader>y', "<cmd>lua if vim.api.nvim_list_tabpages() == 1 then vim.cmd('tabnew') else vim.cmd('tabnext') end<CR>", opts)
map("n", "<leader>u", function()
  if vim.api.nvim_list_tabpages() == 1 then
    vim.cmd("tabnew")
  else
    vim.cmd("tabprev")
  end
end, {})

map("n", "<leader>y", function()
  if #vim.api.nvim_list_tabpages() == 1 then
    vim.cmd("tabnew")
  else
    vim.cmd("tabnext")
  end
end, {})
-- map('n', '<leader>u', "len(nvim_list_tabpages()) == 1 ? 'tabnew' : 'tabprev'", { expr = true, desc = 'tab next' })
-- map('n', '<leader>y', "len(nvim_list_tabpages()) == 1 ? 'tabnew' : 'tabnext'", { expr = true, desc = 'tab next' })
map("n", "<leader>U", "<C-w>T", { expr = true, desc = "Move window to tab" })
-- TODO:x,o map.
-- map({ "n", "x", "o" }, "<leader>Y", '"+"', { expr = true, desc ="Lines downward, on the first non-blank character" })
-- }}} Normal / Visual / Operator
-- }}} <Leader>
-- {{{ <g> (4/8)
-- {{{ Normal (2/4)
-- TODO: gu/gy in normal mode.
-- if vim.g.is_vscode then
--   map("n", "<leader>u", "<Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>",
--     { desc = "Go to Previous Problem (Error, Warning, Info)" })
--   map("n", "<leader>y", "<Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>",
--     { desc = "Go to Next Problem (Error, Warning, Info)" })
-- else
-- map("n", "gu", "<Cmd>sp<CR>", { desc = "side split" })
-- map("n", "gy", "<CMD>vs<CR>", { desc = "vertical split" })
map("n", "gu", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>")
map("n", "gy", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>")

map("n", "gU", "<Cmd>sp<CR>", { desc = "side split" })
map("n", "gY", "<CMD>vs<CR>", { desc = "vertical split" })

-- end
-- TODO: gU/gY
-- map("n", "gU", "", { desc = "", remap = false })
-- map("n", "gY", "", { desc = "", remap = false })
-- }}} Normal
-- {{{ Visual (2/4)
--[[ Visual mode gu/gU is used as default(CAP/cap). ]]
-- TODO:Add gy/gY in visual mode.(No idea)
-- map("v", "gy", "", { desc = "", noremap = true })
-- map("v", "gY, "", { desc = "", noremap = true })
-- }}}  Visual / Operator
-- }}} <g>
-- {{{ <m/M> (0/0)
-- {{{ Normal
--[[ Nothing ]]
-- }}} Normal
-- }}} <m/M>
-- }}} <U/Y> Right/Left

-- {{{ <S/T> Insert/Append (-16, C(8), L(8))
-- {{{ Single / Shift (10/10 + not used(2))
-- {{{ Normal / Visual / Operator (10/10 + not used(2))
map({ "n", "x" }, "s", '"i"', { expr = true, desc = "insert" })
map({ "n", "x" }, "t", "'a'", { expr = true, desc = "append" })
map({ "n", "x" }, "S", '"I"', { expr = true, desc = "insert" })
map({ "n", "x" }, "T", "'A'", { expr = true, desc = "append" })
map("o", "s", '"i"', { expr = true, desc = "in" })
map("o", "t", "'a'", { expr = true, desc = "around" })
-- MEMO: S,T operator is empty now. ]]
-- }}} Normal / Visual / Operator
-- }}} Single / Shift
-- {{{ <Ctrl> (2/10)
-- {{{ Normal / Visual / Operator (2/2)
--[[ <C-t>, <C-s> is used by filetr and outliner ]]
-- }}} Normal / Visual / Operator
-- {{{ Visual / Operator (0/4)
--TODO:<C-s>, <C-t> in visual mode.
-- }}} Visual / Operator
-- {{{ Insert (0/2)
--FIX: Maybe keyacode trouble happinng.
-- map("i", "<C-s>", "<C-o>I", { noremap = true, desc = "Move to the start of the line (non-blank)" })
-- map("i", "<C-t>", "<C-o>A", { noremap = true, desc = "Move to the end of the line" })
-- Default <C-t> is intert tab.
-- }}} Insert
-- {{{ Command (0/2)
-- {{{ <Ctrl>
-- Cmap idea is nothing. Maybe not working.
-- }}} <Ctrl>
-- }}} Command
-- }}} <Ctrl>
-- {{{ <Leader> (4/8)
-- {{{ Normal / Visual / Operator
--TODO:customize plugins.
-- <leader>s is sniprun. But more customize is required.
-- <leader>t is toggle terminal in futere.
-- <leader>S, <leader>T is no idea.
-- if is_vscode then
--   map("n", "<leader>r", "<Cmd>call VSCodeNotify('code-runner.run')<CR>", { desc = "run code" })
-- end
-- }}} Normal / Visual
-- }}} <Leader>
-- {{{ <g> (8/8)
-- {{{ Normal / Visual (8/8)
map("n", "gs", ":%s/\\v/g<Left><Left>", { silent = false })
-- map("n", "gs", ":<C-u>%s/\\v/g<Left><Left>", { expr = false, silent = false })
map("x", "gs", ":s/\\v/g<Left><Left>", { silent = false })
--[[ gt/gT/gS in 'n' is treesitter definition jump ]]
-- }}} Normal / Visual
-- }}} <g>
-- {{{ <m/M> (0/0)
-- {{{ Normal
--[[ Nothing ]]
-- }}} Normal
-- }}} <m/M>
-- }}} <N/E> Up/Down

-- {{{ <A> Visual (4, S(2, operator), c(2,error))
-- {{{ Single / Shift (4/6)
-- {{{ Normal / Visual (4/4)
map("n", "a", "'v'", { expr = true, desc = "visual" })
map("x", "a", "'o'", { expr = true, desc = "jump other side" })
map({ "n", "x" }, "A", "'V'", { expr = true, desc = "Visual Line" })
-- }}} Normal / Visual
-- {{{ Operator  (0/2)
--[[ No idea ]]
-- }}} Operator
-- }}} Single / Shift
-- {{{ <Ctrl> (3/5)
-- {{{ Normal / Visual / Operator (2/3)
map("n", "<C-a>", "<C-v>", { desc = "Block Selection" })
map("v", "<C-a>", "<C-v>", { desc = "Block Selection" })
--[[ Operator is no idea ]]
-- }}} Normal / Visual / Operator
-- {{{ Insert (1/1)
map("i", "<C-a>", "<C-o>^", { desc = "Head of line" })
-- }}} Insert
-- {{{ Command (0/1)
-- {{{ <Ctrl>
-- TODO:Fix
-- map("i", "<C-a>", "<C-o>^", { desc = "Head of line" })
-- map("c", "<C-y>", "<C-n>", { desc = "history down" })
-- }}} <Ctrl>
-- }}} Command
-- }}} <Ctrl>
-- {{{ <Leader> (4/4)
-- {{{ Normal / Visual
map({ "n" }, "<leader>a", "gv", { desc = "select last selected area" })
map({ "n" }, "<leader>A", "gV", { desc = "select last selected Area" })
map({ "x", "o" }, "<leader>a", "ggV", { desc = "select to top" })
map({ "x", "o" }, "<leader>A", "ggVG", { desc = "select all area" })

-- }}} Normal / Visual
-- }}} <Leader>
-- {{{ <g> (4/4)
-- {{{ Normal / Visual (2/4)
-- Align
-- }}} Norma / Visual
-- }}} <g>
-- {{{ <m/M> (0/0)
--[[ Nothing ]]
-- }}} <m/M>
-- }}} <A> Visual

-- {{{ <R> Replace (-12, S(2), c(2), L(6), g(2))
-- {{{ Single / Shift (6/6)
-- {{{ Normal / Visual / Operator(6/6)
--[[ Default
R is for Replace paste.
  ]]
-- }}} Normal / Visual / Operator
-- }}} Single / Shift
-- {{{ <Ctrl> (3/5)
-- {{{ Normal / Visual (2/2)
-- if is_vscode then
--   map(
--     "n",
--     "<C-r>",
--     "<Cmd>call VSCodeNotify('editor.action.rename', { 'query': expand('<cword>')})<CR>",
--     { desc = "remap below word" }
--   )
-- end
-- smart rename of treesitter.
map("x", "<C-r>", "c", { desc = "change key" })
-- }}} Normal / Visual
-- {{{ Insert / Command (2/2)
-- Default is paset select. But it is <C-v>
map("i", "<C-r>", "<ESC>R", { desc = "enter Replace mode" })
map('n', '<C-r>r', "<Cmd>lua vim.lsp.buf.rename()<CR>", {desc = "Renamer"})
map('n', '<C-r>a', "<Cmd>lua vim.lsp.buf.code_action()<CR>", {desc = "Action"})
map('n', '<C-r>q', "<Cmd>lua vim.lsp.buf.uf.format({async = true})<cr>", {desc = "Formater"})


--MEMO:  <C-r> is paste. ( i thonk <C-v> is better but which-key force to use <C-r>)
-- }}} Insert / Command
-- }}} <Ctrl>
-- {{{ <Leader> (0/6)
-- {{{ Normal / Visual / Operator
--[[ <leader>r is refactoring. ]]
-- map({ "n", "x", "o" }, "<leader>A", '"{"', { expr = true, desc = "" })
-- }}} Normal / Visual / Operator
-- }}} <Leader>
-- {{{ <g> (2/4)
-- {{{ Normal / Visual (2/4)
-- if is_vscode then
--   map(
--     "n",
--     "gr",
--     "<Cmd>call VSCodeNotify('workbench.action.replaceInFiles', { 'query': expand('<cword>')})<CR>",
--     { desc = "remap below word" }
--   )
-- else
  -- smart rename of treesitter.
-- end -- }}} Norma / Visual
-- }}} <g>
-- {{{ <m/M> (0/0)
--[[ Nothing ]]
-- }}} <m/M>
-- }}} <A> Visual

-- {{{ <F/P> Forward/Previous (-14, S(6), L(8), g(4))
-- {{{ Single / Shift (6/12)
-- {{{ Normal / Visual / Operator / Leader()
--[[ All is used by hop.nvim ]]
-- }}} Normal / Visual / Operator
-- }}} Single / Shift
-- {{{ <Ctrl> (10/10)
-- {{{ Normal / Visual / Operator (6/6)
--[[ used by hop ]]
-- }}} Normal / Visual / Operator
-- {{{ Insert / Command (4/4)
--[[ <C-u>, <C-y> is used by Copilot.lua ]]
-- map("c", "<C-u>", "<C-p>", { desc = "history up" })
-- map("c", "<C-y>", "<C-n>", { desc = "history down" })
-- }}} Insert / Command
-- }}} <Ctrl>
-- {{{ <Leader> (4/12)
-- {{{ Normal / Visual / Operator
map("n", "<Leader>f", vim.diagnostic.goto_prev)
map("n", "<Leader>p", vim.diagnostic.goto_next)
-- map("n", "<Leader>F", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>")
-- map("n", "<Leader>P", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>")
-- }}} Normal / Visual / Operator
-- }}} <Leader>
-- {{{ <g> (4/8)
-- {{{ Normal (0/4)
map("n", "gf", "<Nop>", { desc = "unused" })
map("n", "gp", "<Nop>", { desc = "unused" })
-- map("n", "gF", "", { desc = "", remap = false })
-- map("n", "gP", "", { desc = "", remap = false })
-- }}} Normal
-- {{{ Visual (0/4)
-- map("v", "gf", "", { desc = "", noremap = true })
-- map("v", "gp, "", { desc = "", noremap = true })
-- }}}  Visual / Operator
-- }}} ww<g>ww
-- {{{ <m/M> (0/0)
--[[ Nothing ]]
-- }}} <m/M>
-- }}} <U/Y> Right/Left

-- {{{ <D> Delete (-3, c(2), g(1))
-- {{{ Normal / Shift (0/0)
-- [[ -- Default  ]]
-- }}} Normal / Shift
-- {{{ Ctrl (2/4)
-- {{{ Normal(2/2)
--[[ Trouble ]]
-- }}} Normal
--{{{ Visual (0/2)
--TODO: no idea.
--}}} Visual
--}}} Ctrl
-- {{{ Leader (6/6)
-- map({ "n", "x", "o" }, "<leader>d", "'\"+d'", { desc = "Delete to clip" })
-- map({ "n", "x", "o" }, "<leader>D", "'\"+d$'", { expr = true, desc = "Delete to clip" })
-- }}} Leader
--{{{ g (1/2)
if is_vscode then
  map("n", "gD", "<Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>",
    { desc = "move" })
  map("n", "gd", "<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>", { desc = "move" })
  -- map("n", "gf", "<Cmd>call VSCodeNotify('editor.action.peekDeclaration')<CR>", { desc = "move" })
  -- map("n", "gf", "<Cmd>call VSCodeNotify('editor.action.revealDeclaration')<CR>", { desc = "move" })
  -- else map
else
  -- gd is for {"KostkaBrukowa/definition-or-references.nvim"}
  -- gD is telescope
end
--}}} g
--}}}

-- {{{ <C/V> Copy/Paste (-4, C(2), g(2))
-- {{{ Normal / Shift (12/12)
map({ "n", "x", "o" }, "c", "'y'", { expr = true, desc = "copy" })
map({ "n", "x", "o" }, "v", "']p'", { expr = true, desc = "paste" })
map({ "n", "o" }, "C", "'y$'", { expr = true, desc = "copy to end of line" })
map({ "n", "o" }, "V", "']P'", { expr = true, desc = "paste before cursor" })
map("x", "v", "'\"_dp'", { expr = true, desc = "delete and paste" })
map("x", "V", "'\"_dP'", { expr = true, desc = "delete and paste before cursor" })
-- }}} Normal / Shift
-- {{{ Ctrl (2/4)
-- {{{ Normal(2/2)
--[[ ynakycyle.vim ]]
-- }}} Normal
-- {{{ Visual (0/2)
-- }}} Visual
-- }}} Ctrl
-- {{{ Leader (4/4)
map({ "n", "x", "o" }, "<leader>c", "'\"+y'", { expr = true, desc = "copy to clipboard" })
map({ "n", "x", "o" }, "<leader>v", "'\"+p'", { expr = true, desc = "paste from clipboard" })
map({ "n", "x", "o" }, "<leader>C", "'\"+Y'", { expr = true, desc = "copy to clipboard" })
map({ "n", "x", "o" }, "<leader>V", "'\"+P'", { expr = true, desc = "paste from clipboard" })
-- }}} Leader
-- {{{ g (2/4)
-- gv/gV is used by yanky.
--TODO:gc/gC
-- map({ "n", "x", "o" }, "gc", "gp", { expr = true, desc = "paste and reselect visual" })
-- map({ "n", "x", "o" }, "gC", "gP", { expr = true, desc = "paste before and reselect visual" })
-- }}} g
-- {{{ alt (terminal)
-- gv/gV is used by yanky.
  map('c', '<A-v>', '<C-R>+', { noremap = true, silent = true })
  map('t', '<A-v>', '<C-R>+', { noremap = true, silent = true })
-- }}}
-- }}} g
--
-- {{{ <Z> Undo (-6 c(2), l(3))
-- {{{ Normal / Shift (12/12)
if is_vscode then
  map("n", "z", "<Cmd>call VSCodeNotify('undo')<CR>", { desc = "undo" })
  map("n", "Z", "<Cmd>call VSCodeNotify('redo')<CR>", { desc = "redo" })
else
  map("n", "z", "'u'", { expr = true, desc = "undo" })
  map("n", "Z", "'<C-r>'", { expr = true, desc = "redo" })
end
-- -- }}} Normal / Shift
-- -- {{{ Ctrl (2/4)
-- -- {{{ Normal(2/2)
--[[ increment ]]
-- -- }}} Normal
-- -- {{{ Visual (0/2)
--[[ Selective Undo?/ Undo tree? ]]
-- -- }}} Visual
-- -- }}} Ctrl
-- -- {{{ Leader (1/4)
-- "<leader>z" is used by telescope.
--TODO: "<leader>V" is for undo-tree.
--TODO: visual mode <leader>z is for move last selected range.
-- -- }}} Leader
-- -- {{{ g (2/2)
-- map({ "n", "x", "o" }, "gz", "`.", { desc = "last edited" })
-- map({ "n", "x", "o" }, "gZ", "`,", { desc = "next edited" })
-- -- }}} g
-- }}}

-- {{{ <X> remove (-3, c(2), g(1))
-- {{{ Normal / Shift (0/0)
--[[ -- Default  ]]
-- -- }}} Normal / Shift
-- -- {{{ Ctrl (2/4)
-- -- {{{ Normal(2/2)
-- [[ decrement ]]
-- -- }}} Normal
-- -- {{{ Visual (0/2)
-- TODO:Treesitter?
-- -- }}} Visual
-- -- }}} Ctrl
-- -- {{{ Leader (6/6)
-- map({ "n", "x", "o" }, "<leader>x", "'\"+d'", { desc = "Delete to clip" })
-- map({ "n", "x", "o" }, "<leader>X", "'\"+d$'", { expr = true, desc = "Delete to clip" })
-- -- }}} Leader
-- -- {{{ g (1/2)
-- gx is open path or url.
-- gX is for ... no idea.
-- -- }}} g
-- }}}

-- {{{ <K/B> Search Move/Help ()
-- {{{ Normal / Shift (4/4)
map({ "n", "x" }, "k", "'n'", { expr = true, noremap = true, desc = "Repeat the latest search" })
map({ "n", "x" }, "K", "'N'", { expr = true, noremap = true, desc = "Search opposite direction" })
if is_vscode then
  map("n", "b", "<Cmd>call VSCodeNotify('editor.action.showHover')<CR>", { desc = "Hover" })
  -- map("n", "B", "<Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>", { desc = "move" })
  -- map("n", "<C-b>", "<Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>",
    -- { desc = "move" })
else
  -- vim.lsp.buf.references()Lists all the references to the
  -- map("n", "b", "K", { desc = "keyworddrop" })
  map("n", "b", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = "type definition" })
  -- map("n", "<C-b>", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "type definition" })

  -- map("n", "b", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "type definition" })
  -- map("n", "B", "<Cmd>lua vim.lsp.buf.references()<CR>", { desc = "Hover" })
  map("n", "B", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Hover" })

-- vim.lsp.buf.signature_help().
        -- d = { vim.lsp.buf.definition, "Go to definition" },
        -- r = { require("telescope.builtin").lsp_references,
          -- "Open a telescope window with references" },
        -- r = { require("telescope.builtin").lsp_references,
  -- map("n", "<leader>k", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "move" })
  -- "B", "<CMD>lua require('goto-preview').goto_preview_declaration()<CR>", desc = "Goto Preview Declaration",
  -- <C-b> is treesitter
  -- map("n", "<C-b>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Show signature help" })
  -- { "<C-k>", "<CMD>lua require('goto-preview').goto_.preview_references()<CR>", desc = "Goto Preview References",
end
-- }}} Normal / Shift
-- {{{ Leader/ g (6/6)
-- [[ it is for "rmagatti/goto-preview" ]]
-- }}} Leader / g
-- }}}

-- {{{ <O> newline/copilot ()
-- {{{ Normal / Shift (0/0)
--[[ -- Default  ]]
-- }}} Normal / Shift
-- {{{ Ctrl (2/4)
-- {{{ Normal(2/2)
if is_vscode then
  map(
    "n",
    "<C-o>",
    "<Cmd>call VSCodeNotify('workbench.actions.view.problems')<CR>",
    { desc = "Error Lens: Toggle (Enable/Disable) Everything" }
  )
else
  --[[ <C-o> is copilot ]]
end
-- }}} Normal
-- {{{ Visual (0/2)
-- }}} Visual
-- }}} Ctrl
-- {{{ Leader (6/6)
-- <leader>o is ...
-- }}} Leader
-- {{{ g (1/2)
-- go / gO  is for ... no idea.
-- }}} g
-- }}}

-- {{{ <W> Wrap ()
-- {{{ Normal / Shift (0/0)
--[[ sandwith.vim   ]]
-- ww is for hop.
-- -- }}} Normal / Shift
-- -- {{{ Ctrl (1/4)
-- -- {{{ Normal(1/2)
map("n", "<C-w>", "<cmd>wincmd w<CR>", { desc = "Move window" })
-- :wincmd w  -- 次のウィンドウに移動

-- -- }}} Normal
-- -- {{{ Visual (0/2)
-- TODO
-- -- }}} Visual
-- -- }}} Ctrl
-- -- {{{ Leader (6/6)
-- -- }}} Leader
-- -- {{{ g (1/2)
-- matchup
-- -- }}} g
-- }}}

-- {{{ <Q> Macro ()
-- {{{ Single / Shift / <Ctrl> (0/0)
-- {{{ Normal (2/4)
map("n", "q", "@", { expr = false, desc = "MacroPlay" })
map("n", "Q", "q", { expr = false, desc = "MacroRecord" })
-- if is_vscode then
--   map(
--     "n",
--     "<C-q>",
--     "<Cmd>call VSCodeNotify('github.copilot.collectDiagnostics')<CR>",
--     { desc = "Error Lens: Toggle (Enable/Disable) Everything" }
--   )
--   map("n", "qq", "<Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>",
--     { desc = "AutoFormat" })
  -- {
  --   "key": "shift+alt+f",
  --   "command": "editor.action.formatDocument",
  --   "when": "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor"
  -- }
-- else
  -- map("n", "<C-q>", "<Nop>", { expr = false, desc = "Nop" })
-- end
-- }}} Normal
-- {{{ Visual (0/2)
-- }}} Visual
-- }}} Single / Shift / <Ctrl>
-- {{{ Leader (0/2)
-- <leader>q is ...
-- }}} Leader
-- {{{ g (1/2)
-- gq / gQ  is for ... no idea.
-- gq is for close hover?
-- }}} g
-- }}}

-- {{{ <M> Fold/Mark ()
-- {{{ Single / Shift  (0/0)
map({ "n", "x" }, "m", '"`"', { expr = true, desc = "JumpToMark" })
map({ "n", "x" }, "M", "'m'", { expr = true, desc = "Mark" })
map({ "n", "x" }, "mX", "<CMD>delmarks!<CR>", { desc = "remove all marks" })
map(
  { "n", "x" },
  "mx",
  "<CMD>lua vim.api.nvim_command('delmarks ' .. vim.fn.nr2char(vim.fn.getchar()))<CR>",
  { desc = "remove mark" }
)
if is_vscode then
  -- map({"n", "x"}, "mn", "<Cmd>call VSCodeNotify('editor.foldNext')<CR>", { desc = "Move to next fold" })
  -- map({"n", "x"}, "me", "<Cmd>call VSCodeNotify('editor.foldPrev')<CR>", { desc = "Move to previous fold" })
  map("n", "mE", "<Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>",
    { desc = "Move to top of current fold" })
  map("n", "mN", "<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>",
    { desc = "Move to bottom of current fold" })
  map("n", "mh", "<Cmd>call VSCodeNotify('editor.fold')<CR>", { desc = "Close current fold" })
  map("n", "mH", "<Cmd>call VSCodeNotify('editor.foldAll')<CR>",
    { desc = "Close all folds recursively" })
  map("n", "mi", "<Cmd>call VSCodeNotify('editor.unfold')<CR>", { desc = "Open current fold" })
  map("n", "mI", "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>",
    { desc = "Open all folds recursively" })
  map("n", "mm", "<Cmd>call VSCodeNotify('editor.foldAll')<CR>", { desc = "Fold current level" })
  map("n", "mM", "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>",
    { desc = "Unfold all levels recursively" })
  map("n", "mx", "<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>",
    { desc = "Delete current fold" })
  map(
    "n",
    "mX",
    "<Cmd>call VSCodeNotify('editor.foldAllRecursively')<CR>",
    { desc = "Delete current fold recursively" }
  )
else
  map("n", "mn", '"zj"', { expr = true, desc = "Move to next fold" })
  map("n", "me", '"zk"', { expr = true, desc = "Move to previous fold" })
  map("n", "mE", '"[z"', { expr = true, desc = "Move to top of current fold" })
  map("n", "mN", '"]z"', { expr = true, desc = "Move to bottom of current fold" })
  map("n", "mh", '"zc"', { expr = true, desc = "Close current fold" })
  map("n", "mH", '"zC"', { expr = true, desc = "Close all folds recursively" })
  map("n", "mi", '"zo"', { expr = true, desc = "Open current fold" })
  map("n", "mI", '"zO"', { expr = true, desc = "Open all folds recursively" })
  map("n", "mm", '"zM"', { expr = true, desc = "Fold current level" })
  map("n", "mM", '"zR"', { expr = true, desc = "Unfold all levels recursively" })
  map("n", "Mx", '"zd"', { expr = true, desc = "Delete current fold" })
  map("n", "MX", '"zD"', { expr = true, desc = "Delete current fold recursively" })
  map("n", "Mm", '"zy"', { expr = true, desc = "Update folds" })
  map("n", "Mi", '"zr"', { expr = true, desc = "Reduce folding level by one" })
  map("n", "Mh", '"zm"', { expr = true, desc = "Increase folding level by one" })
end

-- map({ "n", "x" }, "gm", '"M"', { expr = true }) This is no need.
-- }}} Single / Shift
-- {{{ <Ctrl> (0/2)
--[[
{
      "key": "ctrl+m",
      "command": "editor.action.inlineSuggest.trigger",
      "when": "config.github.copilot.inlineSuggest.enable && editorTextFocus && !editorHasSelection && !inlineSuggestionsVisible"
    },
--]]
-- }}} <Ctrl>

-- {{{ Leader (0/2)
-- <leader>m is ...
-- }}} Leader
-- {{{ g (0/2)
-- }}} g
-- }}}

-- -- user object {{{
-- map("o", "(", "a(", { expr = true, desc = "select around parenthesis" })
-- map("o", "[", "a[", { expr = true, desc = "select around square bracket" })
-- map("o", ")", "a(", { expr = true, desc = "select inner parenthesis" })
-- map("o", "}", "a{", { expr = true, desc = "select inner curly bracet" })
-- map("o", "'", "a'", { expr = true, desc = "select inner single quote" })
-- map("o", '"', 'a"', { expr = true, desc = "select inner double quote" })
-- map("o", ",", "a'", { expr = true, desc = "select inner single quote" })
-- map("o", "s,", "a'", { expr = true, desc = "select inner single quote" })
-- map("o", "t,", "a'", { expr = true, desc = "select inner single quote" })
-- map("o", ".", 'a"', { expr = true, desc = "select inner double quote" })
-- map("o", "s.", 'a"', { expr = true, desc = "select inner double quote" })
-- map("o", "t.", 'a"', { expr = true, desc = "select inner double quote" })
-- map("o", "-", "a-", { expr = true, desc = "select inner dash" })
-- map("o", "M", "a-", { expr = true, desc = "select inner dash" })
-- map("o", "sM", "i-", { expr = true, desc = "select inner dash" })
-- map("o", "tM", "a-", { expr = true, desc = "select inner dash" })
-- map("o", "u", "a_", { expr = true, desc = "select inner underscore" })
-- map("o", "su", "i_", { expr = true, desc = "select inner underscore" })
-- map("o", "tu", "a_", { expr = true, desc = "select inner underscore" })
-- map("o", "U", "a__", { expr = true, desc = "select inner double underscore" })
-- map("o", "sU", "i__", { expr = true, desc = "select inner double underscore" })
-- map("o", "tU", "a__", { expr = true, desc = "select inner double underscore" })
-- map("o", "2_", "a__", { expr = true, desc = "select inner double underscore" })
-- map("o", "s_", "i__", { expr = true, desc = "select inner double underscore" })
-- map("o", "t2_", "a__", { expr = true, desc = "select around double underscore" })
-- map("o", "t_", "a_", { expr = true, desc = "select around underscore" })
-- map("o", "b", "a(", { expr = true, desc = "select inner parenthesis" })
-- map("o", "sb", "i(", { expr = true, desc = "select inner parenthesis" })
-- map("o", "tb", "a(", { expr = true, desc = "select around parenthesis" })
-- map("o", "B", "a[", { expr = true, desc = "select inner square bracket" })
-- map("o", "sB", "i[", { expr = true, desc = "select inner square bracket" })
-- map("o", "tB", "a[", { expr = true, desc = "select around square bracket" })
-- map("o", "k", "a{", { expr = true, desc = "select inner curly brace" })
-- map("o", "sk", "i{", { expr = true, desc = "select inner curly brace" })
-- map("o", "tk", "a{", { expr = true, desc = "select around curly brace" })
-- k is key in dict
-- map("o", "K", "a<", { expr = true, desc = "select inner angle bracket" })
-- map("o", "sK", "i<", { expr = true, desc = "select inner angle bracket" })
-- map("o", "tK", "a<", { expr = true, desc = "select around angle bracket" })

-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- }}}

-- {{{ <L> comment ()
-- {{{ Normal / Shift (0/0)
-- }}} Normal / Shift
-- -- {{{ Normal(1/2)
-- map("n", "l", "<Nop>", {expr=true})
-- map({ "n", "x", "o" }, "<Space>", "<Nop>", { desc = "Disable Space" })
--map("o", "<Nop>", "<left>", { noremap = true })


--map("n", "<C-q>", "<Nop>", { expr = false, desc = "Nop" })

-- -- }}} Normal
-- }}}


-- vim: ts=2 et sw=2 fdm=marker fmr={{{,}}}