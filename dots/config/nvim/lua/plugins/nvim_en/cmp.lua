return {
  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    config = function()
      require("plugins.configs.cmp")
    end,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-calc" },
      { "f3fora/cmp-spell" },
      { "yutkat/cmp-mocword" },
      { "ray-x/cmp-treesitter" },
      { "lukas-reineke/cmp-rg" },
      { "lukas-reineke/cmp-under-comparator" },
      { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind-nvim" },
      { "hrsh7th/cmp-cmdline" },
      { "tzachar/cmp-tabnine", build = "./install.sh" },
      {
        "Exafunction/codeium.nvim",
        build = ":Codeium Auth",
        cmd = "Codeium",
        config = function()
          require("codeium").setup({})
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
        dependencies = {
          "rafamadriz/friendly-snippets",
          "benfowler/telescope-luasnip.nvim",
        },
        config = function(_, opts)
          if opts then
            require("luasnip").config.setup(opts)
          end
          vim.tbl_map(function(type)
            require("luasnip.loaders.from_" .. type).lazy_load()
          end, { "vscode", "snipmate", "lua" })
          require("luasnip").filetype_extend("typescript", { "tsdoc" })
          require("luasnip").filetype_extend("javascript", { "jsdoc" })
          require("luasnip").filetype_extend("lua", { "luadoc" })
          require("luasnip").filetype_extend("python", { "pydoc" })
          require("luasnip").filetype_extend("rust", { "rustdoc" })
          require("luasnip").filetype_extend("cs", { "csharpdoc" })
          require("luasnip").filetype_extend("java", { "javadoc" })
          require("luasnip").filetype_extend("c", { "cdoc" })
          require("luasnip").filetype_extend("cpp", { "cppdoc" })
          require("luasnip").filetype_extend("php", { "phpdoc" })
          require("luasnip").filetype_extend("kotlin", { "kdoc" })
          require("luasnip").filetype_extend("ruby", { "rdoc" })
          require("luasnip").filetype_extend("sh", { "shelldoc" })
        end,
      },
      -- {
      --   "vim-skk/skkeleton",
      --   -- event = "InsertEnter", --,"CursorHold"],
      --   dependencies = {
      --     {
      --       "vim-denops/denops.vim",
      --       lazy = false,
      --       -- init = function()
      --       -- vim.fn["denops#plugin#load"]("skkeleton")
      --       -- end,
      --     },
      --
      --     "delphinus/skkeleton_indicator.nvim",
      --   },
      --   config = function()
      --     require("skkeleton_indicator").setup({})
      --     -- vim.cmd([[ call skkeleton#config({
      --     --   \ 'eggLikeNewline': v:true,
      --     --   \ 'immediatelyCancel' : v:true,
      --     --   \ 'keepMode' : v:true,
      --     --   \ 'keepState' : v:true,
      --     --   \ 'registerConvertResult' : v:true,
      --     --   \ 'selectCandidateKeys' :"hneirstdwfpluyj",
      --     --   \ 'showCandidatesCount' : 4,
      --     --   \ 'useSkkServer': v:true,
      --     --   \ })]])
      --     --
      --     -- " \ 'userJisyo': "/home/user/.config/ibus-skk/user.dict",
      --     -- vim.fn["skkeleton#register_kanatable"]("rom", {
      --     --   ["("] = { "（", "" },
      --     --   [")"] = { "）", "" },
      --     --   ["z "] = { "　", "" },
      --     --   ["z1"] = { "①", "" },
      --     --   ["z2"] = { "②", "" },
      --     --   ["z3"] = { "③", "" },
      --     --   ["z4"] = { "④", "" },
      --     --   ["z5"] = { "⑤", "" },
      --     --   ["z6"] = { "⑥", "" },
      --     --   ["z7"] = { "⑦", "" },
      --     --   ["z8"] = { "⑧", "" },
      --     --   ["z9"] = { "⑨", "" },
      --     --   ["<s-q>"] = "henkanPoint",
      --     -- })
      --
      --     vim.fn["skkeleton#config"]({
      --       -- globalDictionaries = {
      --       --   "/home/user/.skk/SKK-JISYO.L",
      --       -- },
      --       eggLikeNewline = true,
      --       -- globalJisyo = "/home/user/.skk/SKK-JISYO.L",
      --       immediatelyCancel = true,
      --       keepMode = true,
      --       keepState = true,
      --       sources = { "skk_server" },
      --       registerConvertResult = true,
      --       selectCandidateKeys = "hneirstdwfpluyj",
      --       showCandidatesCount = 4,
      --       -- useSkkServer = true,
      --       -- sources = ["skk_server", "skk_dicsitory"]
      --       userDictionary = "/home/user/.config/ibus-skk/user.dict",
      --     })
      --   end,
      --   keys = {
      --     {
      --       "<C-j>",
      --       "<Plug>(skkeleton-toggle)",
      --       desc = "skkeleton-toggle",
      --       mode = { "i", "c", "t" },
      --     },
      --   },
      -- },
      -- {
      --   "delphinus/skkeleton_indicator.nvim",
      --   opts = { alwaysShown = false, fadeOutMs = 0 },
      -- },
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   after = { "copilot.lua" },
      --   config = function()
      --     require("copilot_cmp").setup()
      --   end,
      -- },
      -- {
      --   "zbirenbaum/copilot.lua",
      --   cmd = "Copilot",
      --   keys = {
      --     {
      --       "<C-o>",
      --       function()
      --         require("cmp").mapping.abort()
      --         require("copilot.suggestion").accept()
      --       end,
      --       desc = "[copilot] accept suggestion",
      --       silent = true,
      --       mode = { "n", "i" },
      --     },
      --     {
      --       "<C-'>",
      --       function()
      --         require("cmp").mapping.abort()
      --         require("copilot.panel").open()
      --       end,
      --       desc = "[copilot] open panel",
      --       silent = true,
      --       mode = { "n", "i" },
      --     },
      --   },
      --   config = function()
      --     require("copilot").setup({
      --       suggestion = {
      --         auto_trigger = true,
      --         keymap = {
      --           -- accept = "<C-o>", defined above
      --           accept_word = false,
      --           accept_line = false,
      --           next = "<C-u>",
      --           prev = "<C-y>",
      --           dismiss = "<C-h>",
      --         },
      --       },
      --       panel = {
      --         enabled = true,
      --         auto_refresh = true,
      --         keymap = {
      --           jump_prev = "<C-u>",
      --           jump_next = "<C-y>",
      --           accept = "<CR>",
      --           refresh = "<C-h>",
      --           -- open = "<C-'>", defined above
      --         },
      --         layout = {
      --           position = "bottom",
      --           ratio = 0.5,
      --         },
      --       },
      --     })
      --   end,
      -- },
    },
  },
}
