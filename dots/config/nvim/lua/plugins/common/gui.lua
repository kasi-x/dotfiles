return {
  {
    "chentoast/marks.nvim", --{{{
    -- event = "FileType",
    lazy = false,
    -- config = function()
    opts = {
      -- whether to map keybinds or not. default true
      default_mappings = false,
      -- which builtin marks to show. default {}
      builtin_marks = { ".", "a", "b", "c", "d" },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- whether the shada file is updated after modifying uppercase marks. default false
      force_write_shada = false,
      -- how often (in ms) to redraw signs/recompute mark positions.
      -- higher values will have better performance but may cause visual lag,
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      mappings = {},
    },
    -- keys = {
    --   {
    --     "dm",
    --     "<cmd>MarksListAll<CR>",
    --     desc = "Marks from all opened buffers",
    --     mode = "n",
    --   },
    --   {
    --     "MX",
    --     "<Plug>(Marks-delete)",
    --     desc = "marks-delete",
    --     mode = "n",
    --   },
    --   {
    --     "Mx",
    --     "<Plug>(Marks-deletebuf)",
    --     desc = "marks-deletebuf",
    --     mode = "n",
    --   },
    -- },
  }, --}}}
  {
    "shadmansaleh/IRC.nvim",
    rocks = "openssl",
    cmd = "IRCConnect",
    opts = {
      servers = {
        libera = {
          nick = "kashimiya",
          username = "kashimiya",
          server = "irc.libera.chat",
          port = 6667,
          use_ssl = true,
        },
      },
      statusline = true,
    },
  },
  {
    "windwp/nvim-autopairs", --{{{,
    event = "InsertEnter",
    opts = {
      fast_wrap = {
        map = "<C-;>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "o",
        before_key = "h",
        after_key = "i",
        cursor_pos_before = true,
        keys = "hneihoarstduyl;wfpgjbvckqzx",
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },
  }, --}}}
  {
    "Wansmer/symbol-usage.nvim", --{{{
    event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      local function h(name)
        return vim.api.nvim_get_hl(0, { name = name })
      end

      -- hl-groups can have any name
      vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

      local function text_format(symbol)
        local res = {}

        local round_start = { "", "SymbolUsageRounding" }
        local round_end = { "", "SymbolUsageRounding" }

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(res, round_start)
          table.insert(res, { "󰌹 ", "SymbolUsageRef" })
          table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.definition then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { "󰳽 ", "SymbolUsageDef" })
          table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
          table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        return res
      end

      require("symbol-usage").setup({
        text_format = text_format,
        ---@type 'above'|'end_of_line'|'textwidth' above by default
        vt_position = "end_of_line",
        ---@type 'start'|'end' At which position of `symbol.selectionRange` the request to the lsp server should start. Default is `end` (try changing it to `start` if the symbol counting is not correct).
        symbol_request_pos = "start", -- Recommended redefine only in `filetypes` override table
      })
    end,
  }, --}}}
  {
    "KostkaBrukowa/definition-or-references.nvim",
    keys = {
      {
        "gd",
        function()
          require("definition-or-references").definition_or_references()
        end,
        desc = "references",
        mode = "n",
      },
    },
  },
}
