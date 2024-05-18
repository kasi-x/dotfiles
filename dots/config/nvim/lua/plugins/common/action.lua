return {
  {
    "andymass/vim-matchup", --{{{
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.matchup_surround_enabled = 1
      vim.g.matchup_matchparen_enabled = 1
      vim.g.matchup_motion_enabled = 1
      vim.g.matchup_text_obj_enabled = 1
      vim.g.matchup_matchparen_offscreen = {
        method = "popup",
      }
    end,
    keys = {
      {
        "W",
        "<plug>(matchup-%)",
        desc = "matchup",
        mode = { "n", "v", "o" },
      },
      {
        "sw",
        "<plug>(matchup-i%)",
        desc = "matchup_inside",
        mode = { "v" },
      },
      {
        "tw",
        "<plug>(matchuwp-a%)",
        desc = "matchup_around",
        mode = { "v" },
      },
      {
        "gw",
        "<plug>(matchup-g%)",
        desc = "matchup",
        mode = { "n", "v", "o" },
      },
    },
  }, --}}}
  {
    "mizlan/iswap.nvim", --{{{
    cmd = {"ISwap", "ISwapNode"},
    keys = {
      {
        "<leader>k",
        "<cmd>ISwap<cr>",
        desc = "iswap",
        mode = { "n" },
      },
      {
        "<leader>m",
        "<cmd>ISwapNode<cr>",
        desc = "iswapNode",
        mode = { "n" },
      },
    },
  },
  { --}}}
    "gbprod/yanky.nvim", --{{{
    event = "VeryLazy",
    config = function()
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        system_clipboard = {
          sync_with_ring = true,
        },
      })
    end,
    keys = {
      {
        "v",
        "<Plug>(YankyPutAfter)",
        desc = "yankyAfter",
        mode = { "n", "v" },
      },
      {
        "V",
        "<Plug>(YankyPutBefore)",
        desc = "yankyBefore",
        mode = { "n", "v" },
      },
      {
        "<C-v>",
        "<Plug>(YankyCycleForward)",
        desc = "yankyCycleForward",
        mode = { "n", "v" },
      },
      {
        "<C-c>",
        "<Plug>(YankyCycleBackward)",
        desc = "yankyCycleBackward",
        mode = { "n", "v" },
      },
      {
        "gv",
        "<Plug>(YankyGPutAfter)",
        desc = "GyankyAfter",
        mode = { "n", "v" },
      },
      {
        "gV",
        "<Plug>(YankyGPutBefore)",
        desc = "GyankyBefore",
        mode = { "n", "v" },
      },
      {
        "<A-v>",
        "<Plug>(YankyPutAfterBlockwiseJoined)",
        desc = "BlockwiseJoined",
        mode = { "n", "v" },
      },
      {
        "<A-c>",
        "<Plug>(YankyPutAfterBlockwise)",
        desc = "GyankyAfter",
        mode = { "n", "v" },
      },
    },
  },
  -- { --}}}
  --   "ThePrimeagen/refactoring.nvim", --{{{
  --   lazy = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("refactoring").setup()
  --     require("telescope").load_extension("refactoring")
  --   end,
  --   keys = { --{{{
  --     {
  --       "<leader>rr",
  --       "<CMD>lua require'telescope'.extensions.refactoring.refactors()<CR>",
  --       desc = "refactoring",
  --       mode = { "n", "x" },
  --     },
  --     {
  --       "<leader>rF",
  --       function()
  --         require("refactoring").refactor("Extract Function")
  --       end,
  --       desc = "Extract Function",
  --       mode = { "x" },
  --     },
  --     {
  --       "<leader>rt",
  --       function()
  --         require("refactoring").refactor("Extract Function To File")
  --       end,
  --       desc = "Extract Function To File",
  --       mode = { "x" },
  --     },
  --     {
  --       "<leader>rV",
  --       function()
  --         require("refactoring").refactor("Extract Variable")
  --       end,
  --       desc = "Extract Variable",
  --       mode = { "x" },
  --     },
  --     {
  --       "<leader>rf",
  --       function()
  --         require("refactoring").refactor("Inline Function")
  --       end,
  --       desc = "Inline Function",
  --       mode = { "n" },
  --     },
  --     {
  --       "<leader>rv",
  --       function()
  --         require("refactoring").refactor("Inline Variable")
  --       end,
  --       desc = "Inline Variable",
  --       mode = { "n", "x" },
  --     },
  --     {
  --       "<leader>rb",
  --       function()
  --         require("refactoring").refactor("Extract Block")
  --       end,
  --       desc = "Extract Block",
  --       mode = { "n" },
  --     },
  --     {
  --       "<leader>rB",
  --       function()
  --         require("refactoring").refactor("Extract Block To File")
  --       end,
  --       desc = "Extract Block To File",
  --       mode = { "n" },
  --     },
  --     {
  --       "<leader>rp",
  --       function()
  --         require("refactoring").debug.printf({ below = false })
  --       end,
  --       desc = "Print Function",
  --       mode = { "n" }, -- This remap must be made in normal mode
  --     },
  --     {
  --       "<leader>rP",
  --       function()
  --         require("refactoring").debug.print_var()
  --       end,
  --       desc = "Print Variable",
  --       mode = { "n", "x" }, -- Supports both visual and normal mode
  --     },
  --     {
  --       "<leader>rc",
  --       function()
  --         require("refactoring").debug.cleanup({})
  --       end,
  --       desc = "Cleanup Refactoring",
  --       mode = { "n" }, -- Supports only normal mode
  --     },
  --   }, --}}},
  -- },
  { --}}}
    "Wansmer/treesj", --{{{
    keys = {
      {
        "<leader>j",
        "<cmd>TSJToggle<cr>",
        mode = "n",
        desc = "Join Toggle",
      },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  { --}}}
    "danymat/neogen", --{{{
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings",
            },
          },
        },
      })
    end,
    keys = {
      {
        "lg",
        function()
          require("neogen").generate()
        end,
        mode = "n",
        desc = "Neogen Comment",
      },
      {
        "lG",
        function() require("neogen").generate({ type = "class" }) end,
        mode = "n",
        desc = "Neogen Class Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
  { --}}}
    "rmagatti/auto-session", --{{{
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/.cache/session", "~/Projects", "~/Downloads", "/" },
        sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
        auto_session_enable_last_session = true,
      })
    end,
  }, --}}}
}