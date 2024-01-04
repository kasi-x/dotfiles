return {
  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    -- event = "InsertEnter",
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
      { "tzachar/cmp-tabnine",                 build = "./install.sh" },
      {
        "Exafunction/codeium.nvim",
        build = ":Codeium Auth",
        cmd = "Codeium",
        -- opts = true,
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
                -- accept = "<C-o>", defined above
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
                refresh = "<C-h>",
                -- open = "<C-'>", defined above
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
}