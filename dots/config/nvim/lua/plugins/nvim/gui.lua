return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    event="VeryLazy",
    keys = {
       {
         "<leader>rm",
         "<cmd>ToggleTermSendCurrentLine<CR>",
         mode = { "n" },
         desc = "Toggle outline",
       },
       {
         "<leader>rm",
         function() require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count }) end,
        mode = {  "v" },
         desc="line2term",
       },
       {
         "<leader>rM",
         "<cmd>ToggleTermSendVisualSelection<CR>",
         mode = { "v" },
         desc = "Toggle outline",
       }
    },
  },
  {"calebsmith/ vim-lambdify"},
  {
    "hedyhli/outline.nvim", --{{{
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {{ "<C-s>", "<cmd>Outline<CR>",  mode = { "n" , "v" }, desc = "Toggle outline" }},
    opts = {
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "b",
        toggle_preview = "B",
        rename_symbol = "r",
        code_actions = "a",
        fold = "mh",
        unfold = "mi",
        fold_all = "M",
        unfold_all = "mm",
        fold_reset = "R",
      },
      symbols = {
        filter = {
            default = { 'String', exclude=true },
            python = { 'Function', 'Class' },
          },
      },
    }
  }, --}}}
  -- {
  --   "ecthelionvi/NeoComposer.nvim",
  --   dependencies = { "kkharji/sqlite.lua" },
  --   opts = {
  --     keymaps = {
  --       play_macro = "q",
  --       yank_macro = "yq",
  --       stop_macro = "xq",
  --       toggle_record = "Q",
  --       cycle_next = "<c-n>",
  --       cycle_prev = "<c-p>",
  --       toggle_macro_menu = "<m-q>",
  --     },
  --   }
  -- },
  {
    "nvim-lualine/lualine.nvim", --{{{
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- "chrisgrieser/nvim-dr-lsp",
    },
    config = function()
      require("plugins.configs.statusline")
    end,
  },                    --}}}
  {
    "folke/noice.nvim", --{{{
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        render = "simple",
        stages = "fade_in_slide_out",
        level = 2,
        time_out = 2,
        top_down = false,
        background_colour = "#121212",
        max_width = 50,
      })
      require("noice").setup({
        notify = {
          enabled = true,
          view = "mini",
        },
        messages = {
          view_search = "mini",
        },
        lsp = {
          progress = {
            enabled = false,
            format = "lsp_progress",
            format_done = "lsp_progress_done",
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = "mini",
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true,            -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  },                           --}}}
  {
    "anuvyklack/windows.nvim", --{{{
    requires = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    cmd = {
      "WindowsMaximize",
      "WindowsMaximize",
      "WindowsMinimize",
      "WindowsEqualize",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },                         --}}}
  -- {
  --   "jackMort/ChatGPT.nvim", --{{{
  --   event = "VeryLazy",
  --   config = function()
  --     local home = vim.fn.expand("$HOME")
  --     require("chatgpt").setup({
  --       api_key_cmd = "gpg --decrypt " .. home .. "/open_ai.gpg",
  --       yank_register = "+",
  --       edit_with_instructions = {
  --         diff = true,
  --         keymaps = {
  --           close = "<C-q>",
  --           accept = "<CR>",
  --           toggle_diff = "<C-d>",
  --           toggle_settings = "<C-m>",
  --           toggle_help = "<C-h>",
  --           cycle_windows = "<C-g>",
  --           use_output_as_input = "<C-o>",
  --         },
  --       },
  --       chat = {
  --         welcome_message = "WELCOME_MESSAGE",
  --         loading_text = "Loading, please wait ...",
  --         question_sign = "", -- 🙂
  --         answer_sign = "ﮧ", -- 🤖
  --         border_left_sign = "",
  --         border_right_sign = "",
  --         max_line_length = 120,
  --         sessions_window = {
  --           active_sign = "  ",
  --           inactive_sign = "  ",
  --           current_line_sign = "",
  --           border = {
  --             style = "rounded",
  --             text = {
  --               top = " Sessions ",
  --             },
  --           },
  --           win_options = {
  --             winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  --           },
  --         },
  --         keymaps = {
  --           close = "<C-q>",
  --           yank_last = "<C-v>",
  --           yank_last_code = "<C-c>",
  --           scroll_up = "<C-u>",
  --           scroll_down = "<C-y>",
  --           new_session = "<C-t>",
  --           cycle_windows = "<Tab>",
  --           cycle_modes = "<C-f>",
  --           next_message = "<C-n>",
  --           prev_message = "<C-e>",
  --           select_session = "<Space>",
  --           rename_session = "r",
  --           delete_session = "d",
  --           draft_message = "<C-r>",
  --           edit_message = "e",
  --           delete_message = "d",
  --           toggle_settings = "<C-m>",
  --           toggle_sessions = "<C-s>",
  --           toggle_help = "<C-h>",
  --           toggle_message_role = "<C-r>",
  --           toggle_system_role_open = "<C-a>",
  --           stop_generating = "<C-x>",
  --         },
  --       },
  --       popup_layout = {
  --         default = "center",
  --         center = {
  --           width = "80%",
  --           height = "80%",
  --         },
  --         right = {
  --           width = "30%",
  --           width_settings_open = "50%",
  --         },
  --       },
  --       popup_window = {
  --         border = {
  --           highlight = "FloatBorder",
  --           style = "rounded",
  --           text = {
  --             top = " ChatGPT ",
  --           },
  --         },
  --         win_options = {
  --           wrap = true,
  --           linebreak = true,
  --           foldcolumn = "1",
  --           winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  --         },
  --         buf_options = {
  --           filetype = "markdown",
  --         },
  --       },
  --       system_window = {
  --         border = {
  --           highlight = "FloatBorder",
  --           style = "rounded",
  --           text = {
  --             top = " SYSTEM ",
  --           },
  --         },
  --         win_options = {
  --           wrap = true,
  --           linebreak = true,
  --           foldcolumn = "2",
  --           winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  --         },
  --       },
  --       popup_input = {
  --         prompt = "  ",
  --         border = {
  --           highlight = "FloatBorder",
  --           style = "rounded",
  --           text = {
  --             top_align = "center",
  --             top = " Prompt ",
  --           },
  --         },
  --         win_options = {
  --           winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  --         },
  --         submit = "<C-Enter>",
  --         submit_n = "<Enter>",
  --         max_visible_lines = 20,
  --       },
  --       settings_window = {
  --         setting_sign = "  ",
  --         border = {
  --           style = "rounded",
  --           text = {
  --             top = " Settings ",
  --           },
  --         },
  --         win_options = {
  --           winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  --         },
  --       },
  --       help_window = {
  --         setting_sign = "  ",
  --         border = {
  --           style = "rounded",
  --           text = {
  --             top = " Help ",
  --           },
  --         },
  --         win_options = {
  --           winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  --         },
  --       },
  --       openai_params = {
  --         model = "gpt-3.5-turbo",
  --         frequency_penalty = 0,
  --         presence_penalty = 0,
  --         max_tokens = 300,
  --         temperature = 0,
  --         top_p = 1,
  --         n = 1,
  --       },
  --       openai_edit_params = {
  --         model = "gpt-3.5-turbo",
  --         frequency_penalty = 0,
  --         presence_penalty = 0,
  --         temperature = 0,
  --         top_p = 1,
  --         n = 1,
  --       },
  --       use_openai_functions_for_edits = false,
  --       actions_paths = {},
  --       show_quickfixes_cmd = "Trouble quickfix",
  --       predefined_chat_gpt_prompts =
  --       "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
  --       highlights = {
  --         help_key = "@symbol",
  --         help_description = "@comment",
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- }, --}}}
  {
    "stevanmilic/nvim-lspimport", --{{{
    ft = "python",
    -- lazy = false,
    -- opts = true,
    keys = {
      {
        "<Leader>ri",
        function()
          require("lspimport").import()
        end,
        desc = "Import using LSP",
        mode = { "n" }, -- Normal mode only
      },
    },
  },                     --}}}
  {
    "j-hui/fidget.nvim", --{{{
    -- branch = "legacy",
    ft = { "lua", "go", "python" },
    config = true,
  },                        --}}}
  {
    "folke/which-key.nvim", --{{{
    event = "VeryLazy",
    keys = {
      {
        "m",
        "<CMD>WhichKey `<CR>",
        desc = "marks",
        mode = { "n", "x" },
      },
    },
    config = function()
      local wk = require("which-key")
      vim.o.timeout = true
      vim.o.timeoutlen = 300

      require("which-key").setup({
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        window = {
          border = "rounded",
          padding = { 1, 1, 1, 1 },
        },
        plugins = {
          marks = true,      -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          presets = {
            operators = true,    -- adds help for operators like d, y, ...
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = false,     -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = false,           -- bindings for folds, spelling and others prefixed with z
            g = false,           -- bindings for prefixed with g
          },
        },
        -- triggers_blacklist = {
        --   i = { "<C-r>" },
        --   c = { "<C-r>" },
        -- },
        -- popup_mappings = {
        --   scroll_down = "<M-n>", -- binding to scroll down inside the popup
        --   scroll_up = "<M-e>r, -- binding to scroll up inside the popup
        -- },
        operators = {
          d = "delete",
          c = "copy",
          a = "visual",
          -- l = "Comments",
        },
        triggers_nowait = {
          -- marks
          "`",
          "'",
          -- registers
          -- '"',
          "<c-r>",
          "d",
          "c",
          -- spelling
        },
        layout = {
          height = { min = 2, max = 5 },  -- min and max height of the columns
          width = { min = 20, max = 60 }, -- min and max width of the columns
          spacing = 3,                    -- spacing between columns
          align = "center",               -- align columns left, center or right
        },
      })
      --{{{ presets fix

      local presets = require("which-key.plugins.presets")
      presets.operators["v"] = nil
      presets.operators["V"] = nil
      presets.operators["y"] = nil
      -- presets.operators["'"] = nil
      -- presets.operators['"'] = nil
      presets.operators["`"] = nil
      presets.operators["d"] = nil
      presets.operators["V"] = nil
      presets.operators["zf"] = nil
      presets.operators[">"] = nil
      presets.operators["gu"] = nil
      presets.operators["gU"] = nil
      --}}}
      --{{{ Mappings
      --{{{ TODO
      -- {{{ Git
      -- wk.register({
      --   ["<leader>g"] = {
      --     name = "Git",
      --     g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
      --     n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      --     e = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      --     l = { "<cmd>GitBlameToggle<cr>", "Blame" },
      --     N = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      --     E = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      --     R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      --     s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      --     u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
      --     o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      --     b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      --     c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      --     d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
      --     G = {
      --       name = "Gist",
      --       a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
      --       d = { "<cmd>Gist -d<cr>", "Delete" },
      --       f = { "<cmd>Gist -f<cr>", "Fork" },
      --       g = { "<cmd>Gist -b<cr>", "Create" },
      --       l = { "<cmd>Gist -l<cr>", "List" },
      --       p = { "<cmd>Gist -b -p<cr>", "Create Private" },
      --     },
      --   },
      -- }, { mode = { "n" } }) --}}}
      wk.register({
        ["l"] = {
          name = "comment",
        },
      }, { mode = { "n" } }) --}}}
      wk.register({
        ["L"] = {
          name = "comment_with_dialog",
        },
      }, { mode = { "n" } }) --}}}
      wk.register({
        ["<C-l>"] = {
          name = "comment",
        },
      }, { mode = { "x", "o" } }) --}}}
      wk.register({
        ["<leader>s"] = {
          name = "code_runnner",
        },
      }, { mode = { "n", "x", "o" } }) --}}}
      wk.register({
        ["<leader>r"] = {
          name = "refactoring",
        },
      }, { mode = { "n", "x", "o" } }) --}}}
      wk.register({
        ["<C-r>"] = {
          name = "code_actions",
        },
      }, { mode = { "n", "x", "o" } }) --}}}
      -- wk.register({
      --   ["b"] = {
      --     name = "help",
      --   },
      -- }, { mode = { "n", "x", "o" } }) --}}}
      -- wk.register({
      --   ["B"] = {
      --     name = "help",
      --   },
      -- }, { mode = { "n", "x", "o" } }) --}}}
      -- wk.register({
      --   ["<C-b>"] = {
      --     name = "help",
      --   },
      -- }, { mode = { "n", "x", "o" } }) --}}}
      -- {{{ Telescope
      wk.register({
        ["j"] = {
          name = "Find",
          B = { "<cmd>Telescope git_commits<cr>", "Checkout branch" },
          ["<C-b>"] = { "<cmd>Telescope git_commits<cr>", "Checkout branch" },
          b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
          c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
          f = { "<cmd>Telescope find_files<cr>", "Find File" },
          j = { "<cmd>Telescope live_grep theme=ivy<cr>", "Finder " },
          g = { "<cmd>Telescope live_grep<CR>", "Find Text" },
          s = { "<cmd>Telescope grep_string theme=ivy<cr>", "Find String" },
          [","] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "search in file" },
          ["."] = { "<cmd>Telescope search_history theme=dropdown<CR>", "search history" },
          h = { "<cmd>Telescope help_tags<cr>", "Help" },
          H = { '<cmd>lua require("plugins.telescope").command_history()<CR>', "Command His" },
          v = { "<cmd>Telescope yank_history<CR>", "Yank His" },
          i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
          l = { "<cmd>Telescope resume<cr>", "Last Search" },
          M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
          r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
          R = { "<cmd>Telescope registers<cr>", "Registers" },
          k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
          C = { "<cmd>Telescope commands<cr>", "Commands" },
        },
      }, { mode = { "n" } }) --}}}
      -- {{{ Terminal
      wk.register({
        ["<leader>t"] = {
          name = "Terminal",
          ["1"] = { ":1ToggleTerm<cr>", "1" },
          ["2"] = { ":2ToggleTerm<cr>", "2" },
          ["3"] = { ":3ToggleTerm<cr>", "3" },
          ["4"] = { ":4ToggleTerm<cr>", "4" },
          n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
          u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
          t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
          p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
          f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
          h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
          v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
        },
      }, { mode = { "n" } }) --}}}
      --{{{ Fold (not yet)
      -- wk.register({
      --     ["m"] = {
      --       name = "fold", -- group name for the popup
      --       o = "Open fold under cursor",
      --       O = "Open all folds under cursor",
      --       c = "Close fold under cursor",
      --       C = "Close all folds under cursor",
      --       a = "Toggle fold under cursor",
      --       A = "Toggle all folds under cursor",
      --       v = "Show cursor line",
      --       M = "Close all folds",
      --       R = "Open all folds",
      --       m = "Fold more",
      --       r = "Fold less",
      --       x = "Update folds",
      --       z = "Center this line",
      --       t = "Top this line",
      --       ["<CR>"] = "Top this line, 1st non-blank col",
      --       b = "Bottom this line",
      --       g = "Add word to spell list",
      --       w = "Mark word as bad/misspelling",
      --       e = "Right this line",
      --       s = "Left this line",
      --       H = "Half screen to the left",
      --       L = "Half screen to the right",
      --       i = "Toggle folding",
      --       ["="] = "Spelling suggestions",
      --     },
      --   }
      -- ) --}}}
      -- {{{ Refactor
      -- wk.register({
      --   ["<leader>r"] = {
      --     name = "refactoring",
      --     F = "ex_Func",
      --     t = "ex_Func_to_File",
      --     V = "ex_Var",
      --     v = "inline_Var",
      --     p = "Print_Function",
      --     -- a = "Code_Actions",
      --     r = "Telescope",
      --   },
      -- }, { mode = "x" })
      -- wk.register({
      --   ["<leader>r"] = {
      --     name = "refactoring",
      --     f = "inline_Func",
      --     v = "inline_Var",
      --     b = "ex_Block",
      --     B = "ex_Block_to_File",
      --     p = "Print Function",
      --     P = "Print Variable",
      --     c = "Cleanup Refactoring",
      --     i = "Auto_Import",
      --     -- a = "Code_Actions",
      --     r = "Telescope",
      --   },
      -- }, { mode = "n" }) --}}}
      -- {{{ Align
      wk.register({
        ["gA"] = {
          name = "Align Trial",
          s = "Enter Split Pattern",
          j = "Choose Justify Side",
          m = "Enter Merge Delimiter",
          f = "Filter Parts (Lua Expression)",
          i = "Ignore Split Matches",
          p = "Pair Parts",
          t = "Trim Parts",
          ["<BS>"] = "Delete Last Pre-step",
          ["="] = "Enhanced Setup for '='",
          [","] = "Enhanced Setup for ','",
          [" "] = "Enhanced Setup for Space",
        },
      }, { mode = { "v" }, nowait = true, noremap = true })
      wk.register({
        ["ga"] = {
          name = "Align",
          s = "Enter Split Pattern",
          j = "Choose Justify Side",
          m = "Enter Merge Delimiter",
          f = "Filter Parts (Lua Expression)",
          i = "Ignore Split Matches",
          p = "Pair Parts",
          t = "Trim Parts",
          ["<BS>"] = "Delete Last Pre-step",
          ["="] = "Enhanced Setup for '='",
          [","] = "Enhanced Setup for ','",
          [" "] = "Enhanced Setup for Space",
        },
        ["gA"] = {
          name = "Align Trial",
          s = "Enter Split Pattern",
          j = "Choose Justify Side",
          m = "Enter Merge Delimiter",
          f = "Filter Parts (Lua Expression)",
          i = "Ignore Split Matches",
          p = "Pair Parts",
          t = "Trim Parts",
          ["<BS>"] = "Delete Last Pre-step",
          ["="] = "Enhanced Setup for '='",
          [","] = "Enhanced Setup for ','",
          [" "] = "Enhanced Setup for Space",
        },
      }, { mode = { "v" }, nowait = true, noremap = true }) --}}}
      --{{{  ChatGPT
      wk.register({
        ["<BS>"] = {
          name = "ChatGPT",
          c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
          e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
          g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
          t = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
          k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
          d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
          a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
          o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
          s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
          f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
          x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
          r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
          l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
        },
      }, { mode = { "n", "x" } }) --}}}
      --{{{  Future
      -- wk.register({
      --  x = {
      --    name = "Completion",
      --    "<C-l>"  = 'Whole lines',
      --    "<C-n>"  = 'keywords in the current file',
      --    "<C-k>"  = 'keywords in dictionary',
      --    "<C-t>"  = 'keywords in thesaurus',
      --    "<C-i>"  = 'keywords in the current and included files',
      --    "<C-]>"  = 'tags',
      --    "<C-f>"  = 'file names',
      --    "<C-d>"  = 'definitions or macros',
      --    "<C-v>"  = 'Vim command-line',
      --    "<C-u>"  = 'User defined completion',
      --    "<C-o>"  = 'omni completion',
      --    "<C-s>"  = 'Spelling suggestions',
      --    "<C-z>"  = 'stop completion',
      --  }}, { mode = "i", prefix = "<C-x>" })--}}}
      ----}}}
    end,
  },                                 --}}}
  {
    "yuki-yano/highlight-undo.nvim", --{{{
    dependencies = { "vim-denops/denops.vim" },
    config = function()
      require("highlight-undo").setup({
        mappings = {
          undo = "z",
          redo = "Z",
        },
        enabled = {
          added = true,
          removed = true,
        },
        highlight = {
          added = "DiffAdd",
          removed = "DiffDelete",
        },
        threshold = {
          line = 50,
          char = 1500,
        },
        duration = 200,
      })
    end,
  },                             --}}}
  {
    "shellRaining/hlchunk.nvim", --{{{
    event = { "UIEnter" },
    config = function()
      require("hlchunk").setup({
        -- right_arraw = "",
      })
    end,
  }, --}}}
}