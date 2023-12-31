return {
  {
    "hrsh7th/nvim-cmp",
    -- event = "VimEnter",
    event = "InsertEnter",
    config = function()
      require("plugins.configs.cmp_jp")
    end,
    dependencies = {
      {
        "uga-rosa/cmp-skkeleton",
        dependencies = { "vim-skk/skkeleton", "hrsh7th/nvim-cmp" },
      },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      -- { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-emoji" },
      -- { "hrsh7th/cmp-calc" },
      -- { "f3fora/cmp-spell" },
      -- { "yutkat/cmp-mocword" },
      -- { "ray-x/cmp-treesitter" },
      -- { "lukas-reineke/cmp-rg" },
      -- { "lukas-reineke/cmp-under-comparator" },
      -- { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind-nvim" },
      -- { "hrsh7th/cmp-cmdline" },
      -- { "tzachar/cmp-tabnine", build = "./install.sh" },
      -- {
      --   "Exafunction/codeium.nvim",
      --   build = ":Codeium Auth",
      --   cmd = "Codeium",
      --   -- opts = true,
      --   config = function()
      --     require("codeium").setup({})
      --   end,
      -- },
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
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
      {
        "zbirenbaum/copilot.lua",
        -- event = "InsertEnter",
        cmd = "Copilot",
        keys = {
          {
            "<C-o>",
            function()
              require("cmp").mapping.abort()
              require("copilot.suggestion").accept()
            end,
            desc = "[copilot] accept suggestion",
            silent = true,
            mode = { "n", "i" },
          },
          {
            "<C-'>",
            function()
              require("cmp").mapping.abort()
              require("copilot.panel").open()
            end,
            desc = "[copilot] open panel",
            silent = true,
            mode = { "n", "i" },
          },
        },
        config = function()
          require("copilot").setup({
            suggestion = {
              auto_trigger = true,
              keymap = {
                accept = "<C-o>",
                accept_word = false,
                accept_line = false,
                next = "<C-u>",
                prev = "<C-y>",
                dismiss = "<C-h>",
              },
            },
            panel = {
              enabled = true,
              auto_refresh = true,
              keymap = {
                jump_prev = "<C-u>",
                jump_next = "<C-y>",
                accept = "<CR>",
                refresh = "<C-o>",
                open = "go",
              },

              layout = {
                position = "bottom",
                ratio = 0.5,
              },
            },
          })
        end,
      },
    },
  },
  {
    "vim-skk/skkeleton",
    -- lazy = false,
    -- event = "Insert",
    -- event = "VimEnter",
    dependencies = {
      "vim-denops/denops.vim",
      "delphinus/skkeleton_indicator.nvim",
    },
    init = function()
      require("skkeleton_indicator").setup({})
      vim.fn["denops#plugin#register"]("skkeleton")
      vim.fn["skkeleton#config"]({
        globalDictionaries = {
          "/home/user/.skk/SKK-JISYO.L",
        },
        eggLikeNewline = true,
        -- globalJisyo = "/home/user/.skk/SKK-JISYO.L",
        immediatelyCancel = true,
        keepMode = true,
        keepState = true,
        registerConvertResult = true,
        selectCandidateKeys = "hneirstdwfpluyj",
        showCandidatesCount = 4,
        -- TODO: cannot use this with cmp-skkeleton?
        useSkkServer = true,
        userJisyo = "/home/user/.config/ibus-skk/user.dict",
      })
      vim.fn["skkeleton#register_kanatable"]("rom", {
        ["("] = { "（", "" },
        [")"] = { "）", "" },
        ["z "] = { "　", "" },
        ["z1"] = { "①", "" },
        ["z2"] = { "②", "" },
        ["z3"] = { "③", "" },
        ["z4"] = { "④", "" },
        ["z5"] = { "⑤", "" },
        ["z6"] = { "⑥", "" },
        ["z7"] = { "⑦", "" },
        ["z8"] = { "⑧", "" },
        ["z9"] = { "⑨", "" },
        ["<s-q>"] = "henkanPoint",
      })
    end,
    keys = {
      {
        "<C-j>",
        "<Plug>(skkeleton-toggle)",
        desc = "skkeleton-toggle",
        mode = { "i", "c", "t" },
      },
    },
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    opts = { alwaysShown = false, fadeOutMs = 0 },
  },
  {
    "vim-denops/denops.vim",
    -- lazy = false,
    -- event = "VimEnter",
  },
}
