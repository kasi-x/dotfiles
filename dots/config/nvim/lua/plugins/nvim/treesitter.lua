return {
  {
    -- "numiras/semshi",
    "wookayin/semshi", -- use a maintained fork
    ft = "python",
    build = ":UpdateRemotePlugins",
    init = function()
      -- Disabled these features better provided by LSP or other more general plugins
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
      vim.g["semshi#update_delay_factor"] = 0.001

      -- This autocmd must be defined in init to take effect
      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
        callback = function()
          -- Only add style, inherit or link to the LSP's colors
          vim.cmd([[
            highlight! semshiGlobal gui=italic
            highlight! link semshiImported @none
            highlight! link semshiParameter @lsp.type.parameter
            highlight! link semshiParameterUnused DiagnosticUnnecessary
            highlight! link semshiBuiltin @function.builtin
            highlight! link semshiAttribute @field
            highlight! link semshiSelf @lsp.type.selfKeyword
            highlight! link semshiUnresolved @lsp.type.unresolvedReference
            highlight! link semshiFree @none
            ]])
        end,
      })
    end,
  },
  { "m-demare/hlargs.nvim", opts = true },
  {
    "nvim-treesitter/nvim-treesitter", --{{{
    event = { "BufReadPost" },
    build = ":TSUpdateSync",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
        sync_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          use_languagetree = false,
          disable = function(lang, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 4000
          end,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "'",
            node_incremental = "'",
            scope_incremental = '"',
            node_decremental = "<BS>",
          },
        },
        indent = {
          enable = true,
          disable = { "python" },
        },
        -- refactor = {
        --   highlight_definitions = {
        --     enable = false, -- very very slow
        --   },
        --   highlight_current_scope = {
        --     enable = false,
        --   },
        --   -- smart_rename = {
        --   --   enable = false,
        --   --   keymaps = {
        --   --     smart_rename = "<C-r>", -- mapping to rename reference under cursor
        --   --   },
        --   -- },
        --   navigation = {
        --     enable = true,
        --     keymaps = {
        --       goto_definition = "gt",
        --       list_definitions = "gT",
        --       list_definitions_toc = "gS",
        --       goto_next_usage = "wu",
        --       goto_previous_usage = "wy",
        --     },
        --   },
        -- },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["tf"] = "@function.outer",
              ["sf"] = "@function.inner",
              ["tc"] = "@class.outer",
              ["sc"] = "@class.inner",
              ["sB"] = "@block.inner",
              ["tB"] = "@block.outer",
              ["si"] = "@conditional.inner",
              ["ti"] = "@conditional.outer",
              ["sl"] = "@loop.inner",
              ["tl"] = "@loop.outer",
              ["sp"] = "@parameter.inner",
              ["tp"] = "@parameter.outer",
              ["sS"] = "@scopename.inner",
              ["tS"] = "@statement.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },
        matchup = {
          enable = true,
        },
        -- autotag = {
        --   enable = false,
        --   disable = function(lang, bufnr)
        --     return vim.api.nvim_buf_line_count(bufnr) > 1000
        --   end,
        -- },
      })
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", config = true },
      { "HiPhish/rainbow-delimiters.nvim" },
      -- { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/nvim-tree-docs" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
  }, --}}}
  {
    "chrisgrieser/nvim-various-textobjs", --{{{
    event = "VeryLazy",
    opts = { useDefaultKeymaps = false },
    keys = { --{{{
      {
        "st",
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
        desc = "Inner Indentation",
        mode = { "o", "x" },
      },
      {
        "tt",
        "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>",
        desc = "Outer Indentation",
        mode = { "o", "x" },
      },
      {
        "tT",
        "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>",
        desc = "Outer Indentation",
        mode = { "o", "x" },
      },
      {
        "sT",
        "<cmd>lua require('various-textobjs').indentation('inner', 'outer')<CR>",
        desc = "Outer Indentation",
        mode = { "o", "x" },
      },
      -- { "R", "<cmd>lua require('various-textobjs').restOfIndentation('inner')<CR>", desc = "Rest Of Indent", mode = {"o"} },
      -- { "r", "<cmd>lua require('various-textobjs').restOfParagraph()<CR>", desc = "Rest of Paragraph", mode = {"o", "x"} },
      -- { "sS", "<cmd>lua require('various-textobjs').subword('inner')<CR>",              desc = "Inner Subword",            mode = { "o", "x" } },
      -- { "tS", "<cmd>lua require('various-textobjs').subword('outer')<CR>",              desc = "Outer Subword",            mode = { "o", "x" } },
      -- { "C", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>", desc = "To Next Closing Bracket", mode = {"o"} },
      {
        "Q",
        "<cmd>lua require('various-textobjs').toNextQuotationMark()<CR>",
        desc = "To Next Quotation Mark",
        mode = { "o" },
      },
      {
        "L",
        "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>",
        desc = "Multi Commented Lines",
        mode = { "o" },
      },
      {
        "<C-l>",
        "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>",
        desc = "Multi Commented Lines",
        mode = { "x", "o" },
      },
      {
        "gG",
        "<cmd>lua require('various-textobjs').entireBuffer()<CR>",
        desc = "Entire Buffer",
        mode = { "x" },
      },
      {
        "G",
        "<cmd>lua require('various-textobjs').entireBuffer()<CR>",
        desc = "Entire Buffer",
        mode = { "o" },
      },
      -- {
      --   "gW",
      --   "<cmd>lua require('various-textobjs').restOfWindow()<CR>",
      --   desc = "Rest of Window",
      --   mode = { "o", "x" },
      -- },
      -- {
      --   "gw",
      --   "<cmd>lua require('various-textobjs').visibleInWindow()<CR>",
      --   desc = "Visible of Window",
      --   mode = { "o", "x" },
      -- },

      -- { "s_", "<cmd>lua require('various-textobjs').lineCharacterwise('inner')<CR>",    desc = "Inner Line Characterwise", mode = { "o", "x" } },
      -- { "t_", "<cmd>lua require('various-textobjs').lineCharacterwise('outer')<CR>",    desc = "Outer Line Characterwise", mode = { "o", "x" } },

      {
        "|",
        "<cmd>lua require('various-textobjs').column()<CR>",
        desc = "Column",
        mode = { "o", "x" },
      },
      {
        "sv",
        "<cmd>lua require('various-textobjs').value('inner')<CR>",
        desc = "Inner Value",
        mode = { "o", "x" },
      },
      {
        "tv",
        "<cmd>lua require('various-textobjs').value('outer')<CR>",
        desc = "Outer Value",
        mode = { "o", "x" },
      },
      {
        "sk",
        "<cmd>lua require('various-textobjs').key('inner')<CR>",
        desc = "Inner Key",
        mode = { "o", "x" },
      },
      {
        "tk",
        "<cmd>lua require('various-textobjs').key('outer')<CR>",
        desc = "Outer Key",
        mode = { "o", "x" },
      },
      {
        "r",
        "<cmd>lua require('various-textobjs').url()<CR>",
        desc = "Inner URL",
        mode = { "o" },
      },
      {
        "R",
        "<cmd>lua require('various-textobjs').mdlink('outer)<CR>",
        desc = "Inner URL",
        mode = { "o" },
      },
      {
        "sC",
        "<cmd>lua require('various-textobjs').mdFencedCodeBlock('inner')<CR>",
        desc = "Inner link",
        mode = { "o", "x" },
      },
      {
        "tC",
        "<cmd>lua require('various-textobjs').mdFencedCodeBlock('outer')<CR>",
        desc = "Inner link",
        mode = { "o", "x" },
      },
      {
        "sn",
        "<cmd>lua require('various-textobjs').number('inner')<CR>",
        desc = "Inner Number",
        mode = { "o", "x" },
      },
      {
        "tn",
        "<cmd>lua require('various-textobjs').number('outer')<CR>",
        desc = "Outer Number",
        mode = { "o", "x" },
      },
      {
        "!",
        "<cmd>lua require('various-textobjs').diagnostic()<CR>",
        desc = "LSP Diagnostic",
        mode = { "o", "x" },
      },
      {
        "sm",
        "<cmd>lua require('various-textobjs').closedFold('inner')<CR>",
        desc = "Inner Fold",
        mode = { "o", "x" },
      },
      {
        "tm",
        "<cmd>lua require('various-textobjs').closedFold('outer')<CR>",
        desc = "Outer Fold",
        mode = { "o", "x" },
      },
      {
        "tq",
        "<cmd>lua require('various-textobjs').anyQuote('outer')<CR>",
        desc = "Outer Quote",
        mode = { "o", "x" },
      },
      {
        "sq",
        "<cmd>lua require('various-textobjs').anyQuote('inner')<CR>",
        desc = "Inner Quote",
        mode = { "o", "x" },
      },
      {
        "tq",
        "<cmd>lua require('various-textobjs').pyTripleQuotes('outer')<CR>",
        desc = "Outer Quote",
        mode = { "o", "x" },
      },
      {
        "sq",
        "<cmd>lua require('various-textobjs').pyTripleQuotes('inner')<CR>",
        desc = "Inner Quote",
        mode = { "o", "x" },
      },
    }, --}}}
  }, -- }}}
  {
    "mfussenegger/nvim-treehopper", --{{{
    event = "BufReadPost",
    keys = {
      { '"', "<cmd>lua require('tsht').nodes()<CR>", desc = "node", mode = { "n", "x" } },
      { '"', ":<C-u>lua require('tsht').nodes()<CR>", desc = "node", mode = { "o" } },
    },
  }, --}}}
  -- {
  --   "haringsrob/nvim_context_vt", --{{{
  --   event = "BufReadPost",
  --   -- config = function()
  --   -- 	require("rc/pluginconfig/nvim_context_vt")
  --   -- end,
  -- }, --}}}
  {
    "m-demare/hlargs.nvim", --{{{
    event = "BufReadPost",
  }, --}}}
  -- {
  --   "olimorris/persisted.nvim", --{{{
  --   event = "BufReadPre",
  --   opts = {
  --     -- save_dir = Sessiondir .. "/",
  --     use_git_branch = true,
  --     silent = true,
  --     should_autosave = true,
  --   },
  --   config = function(_, opts)
  --     require("persisted").setup(opts)
  --     require("telescope").load_extension("persisted")
  --   end,
  -- }, --}}}
  {
    "BartSte/nvim-project-marks", --{{{
    lazy = false,
    config = function()
      require("projectmarks").setup({
        mappings = false,
      })
    end,
  }, --}}}
}
