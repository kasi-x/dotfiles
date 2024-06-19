return {
  {
    "hrsh7th/nvim-cmp", --{{{
    -- event = "VimEnter",
    lazy = false,
    -- event = "InsertEnter",
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
      { "hrsh7th/cmp-emoji" },
      { "f3fora/cmp-spell" },
      { "onsails/lspkind-nvim" },
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
  }, --}}}
  {
    "vim-denops/denops.vim", --{{{
    event = "VeryLazy",
    dependencies = {
      "vim-denops/denops-shared-server.vim",
    },
    -- init = function()
    -- vim.g.denops_server_addr = "127.0.0.1:32123"
    -- vim.g["denops#debug"] = 1
    -- setting DenopsInstallSharedServer command
    -- vim.api.nvim_create_user_command("DenopsInstallSharedServer", "call denops_shared_server#install()", {})
    -- end,
  }, --}}}
  {
    "vim-skk/skkeleton", --{{{
    event = { "VeryLazy", "InsertEnter", "CmdlineEnter", "CmdwinEnter" },
    commit = "60866fe",
    dependencies = {
      "vim-denops/denops.vim",
      "yuki-yano/denops-lazy.nvim",
      "delphinus/skkeleton_indicator.nvim",
    },
    keys = {
      {
        "<C-j>",
        "<Plug>(skkeleton-toggle)",
        desc = "skkeleton-toggle",
        mode = { "i", "c" },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = { "skkeleton-initialize-pre" },
        callback = function()
          vim.fn["skkeleton#config"]({
            eggLikeNewline = true,
            immediatelyCancel = true,
            keepMode = true,
            keepState = true,
            sources = { "skk_server" },
            showCandidatesCount = 3,
            registerConvertResult = true,
            selectCandidateKeys = "hneirst",
            userDictionary = "/home/user/.config/ibus-skk/user.dict",
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
            -- ["ne"] = { "escape" },
            ["z,"] = { "，" },
            ["z."] = { "．" },
            -- 。
            ["<s-q>"] = "henkanPoint",
          })
        end,
      })
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = { "DenopsPluginPost:skkeleton" },
        callback = function()
          vim.fn["skkeleton#initialize"]()
        end,
      })
    end,
    config = function()
      require("denops-lazy").load("skkeleton", { wait_load = false })
      -- require("skkeleton_indicator").setup({
      -- fadeOutMs = 5,
      -- })
      -- require("skkeleton").setup({
      --   eggLikeNewline = true,
      --   immediatelyCancel = true,
      --   keepMode = true,
      --   keepState = true,
      --   sources = { "skk_server" },
      --   showCandidatesCount = 3,
      --   registerConvertResult = true,
      --   selectCandidateKeys = "hneirst",
      --   userDictionary = "/home/user/.config/ibus-skk/user.dict",
      -- })
      -- require("skkeleton#register_kanatable")("rom", {
      --   ["("] = { "（", "" },
      --   [")"] = { "）", "" },
      --   ["z "] = { "　", "" },
      --   ["z1"] = { "①", "" },
      --   ["z2"] = { "②", "" },
      --   ["z3"] = { "③", "" },
      --   border = "rounded",
      --   eijiHlName = "LineNr",
      --   hiraHlName = "String",
      --   kataHlName = "Todo",
      --   hankataHlName = "Special",
      --   zenkakuHlName = "LineNr",
      -- })
    end,
  }, --}}}
}
