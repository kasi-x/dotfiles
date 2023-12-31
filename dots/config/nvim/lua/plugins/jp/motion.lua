return {
  {
    "deton/jasegment.vim", -- {{{
    event = { "BufRead", "BufNewFile" },
    init = function()
      vim.g["jasegment#model"] = "cabocha"
      vim.g["jasegment_no_default_key_mappings"] = 1
    end,
    keys = {
      {
        "i",
        "<Plug>JaSegmentMoveNW",
        mode = "n",
      },
      {
        "I",
        "<Plug>JaSegmentMoveNE",
        mode = "n",
      },
      {
        "h",
        "<Plug>JaSegmentMoveNB",
        mode = "n",
      },
      {
        "H",
        "ge",
        mode = { "n", "x", "o" },
      },
      {
        "i",
        "<Plug>JaSegmentMoveOW",
        mode = "o",
      },
      {
        "I",
        "<Plug>JaSegmentMoveOE",
        mode = "o",
      },
      {
        "h",
        "<Plug>JaSegmentMoveOB",
        mode = "o",
      },
      {
        "i",
        "<Plug>JaSegmentMoveXW",
        mode = "x",
      },
      {
        "I",
        "<Plug>JaSegmentMoveXE",
        mode = "x",
      },
      {
        "h",
        "<Plug>JaSegmentMoveXB",
        mode = "x",
      },
      {
        "si",
        "<Plug>JaSegmentTextObjVI",
        mode = "x",
      },
      {
        "ti",
        "<Plug>JaSegmentTextObjVA",
        mode = "x",
      },
      {
        "si",
        "<Plug>JaSegmentTextObjI",
        mode = "o",
      },
      {
        "ti",
        "<Plug>JaSegmentTextObjA",
        mode = "o",
      },
    },
    -- }}}
  },
  {
    "lambdalisue/kensaku.vim",
    lazy = false,
    dependences = {
      "denops.vim",
    },
  },
  {
    "lambdalisue/kensaku-search.vim",
    event = "CmdlineEnter",
    keys = {
      { "<CR>", "<Plug>(kensaku-search-replace)<CR>", desc = "kensaku", mode = "c" },
    },
  },
  {
    "lambdalisue/kensaku-search.vim",
    event = "CmdlineEnter",
    keys = {
      {
        "<CR>",
        "<Plug>(kensaku-search-replace)<CR>",
        desc = "kensaku",
        mode = "c",
      },
    },
    dependencies = { "kensaku.vim" },
  },
  -- {
  --   "easymotion/vim-easymotion",
  --   event = { "BufRead", "BufNewFile" },
  --   init = function()
  --     vim.g.EasyMotion_keys = "NEIHOARSTDLUYFWP;,."
  --     vim.g.EasyMotion_use_smartsign_us = 1
  --     vim.g.EasyMotion_do_mapping = 0
  --     -- Do not shade
  --     vim.g.EasyMotion_do_shade = 1
  --     -- Use upper case
  --     vim.g.EasyMotion_use_upper = 1
  --     -- Smartcase
  --     vim.g.EasyMotion_smartcase = 1
  --     -- Smartsign
  --     vim.g.EasyMotion_use_smartsign_us = 1
  --     vim.g.EasyMotion_startofline = 0
  --     -- Don't skip folded line
  --     vim.g.EasyMotion_skipfoldedline = 0
  --     -- pseudo-migemo
  --     vim.g.EasyMotion_use_migemo = 1
  --     -- Jump to first with enter & space
  --     vim.g.EasyMotion_space_jump_first = 1
  --     -- Prompt
  --     vim.g.EasyMotion_prompt = "{n}> "
  --   end,
  --   keys = {
  --     {
  --       "Y",
  --       "<Plug>(easymotion-lineforward)",
  --       desc = "To the occurrence of {char} to the left",
  --       mode = { "n", "x", "o" },
  --     },
  --     {
  --       "U",
  --       "<Plug>(easymotion-linebackward)",
  --       desc = "To the occurrence of {char} to the right",
  --       mode = { "n", "x", "o" },
  --     },
  --     {
  --       "<C-n>",
  --       "<Plug>(easymotion-j)",
  --       desc = "JK motion up option",
  --       mode = { "n", "x", "o" },
  --     },
  --     {
  --       "<C-e>",
  --       "<Plug>(easymotion-k)",
  --       desc = "JK motion down option",
  --       mode = { "n", "x", "o" },
  --     },
  --     {
  --       "F",
  --       "<Plug>(easymotion-bd-Fl)",
  --       desc = "Till before the occurrence of {char} to the left with vscode",
  --       mode = { "n", "x", "o" },
  --     },
  --     {
  --       "p",
  --       "<Plug>(easymotion-bd-tl)",
  --       desc = "To the occurrence of {char} to the right",
  --       mode = { "n", "x", "o" },
  --     },
  --     {
  --       "P",
  --       "<Plug>(easymotion-bd-Tl)",
  --       desc = "Till before the occurrence of {char} to the right with vscode",
  --       mode = { "n", "x", "o" },
  --     },
  --   },
  --   -- dependencies = {
  --   --   "haya14busa/vim-easyoperator-line",
  --   --   after = "easymotion/vim-easymotion",
  --   --   lazy = false,
  --   --   -- event = {"BufRead", "BufNewFile"},
  --   --   keys = {
  --   --     {
  --   --       "dL",
  --   --       "<Plug>(easyoperator-line-delete)",
  --   --       desc = "operator-line",
  --   --       mode = "n",
  --   --     },
  --   --     {
  --   --       "cL",
  --   --       "<Plug>(easyoperator-line-yank)",
  --   --       desc = "operator-line",
  --   --       mode = "n",
  --   --     },
  --   --     {
  --   --       "L",
  --   --       "<Plug>(easyoperator-select)",
  --   --       desc = "select-lines",
  --   --       mode = { "o", "n" },
  --   --     },
  --   --   },
  --   --   init = function()
  --   --     vim.g.EasyOperator_line_do_mapping = 0
  --   --   end,
  --   -- },
  -- },
  -- {
  --   "uga-rosa/cmp-skkeleton",
  --   dependencies = { "vim-skk/skkeleton", "hrsh7th/nvim-cmp" },
  --   lazy = false,
  --   config = function()
  --     require("cmp").setup({
  --       sources = {
  --         { name = "skkeleton", priority = 100 },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "vim-jp/vimdoc-ja",
  --   event = "CmdLineEnter",
  -- },
}
