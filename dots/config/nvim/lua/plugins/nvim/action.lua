return {
  {
    "cshuaimin/ssr.nvim", --{{{
    keys = {
      {
        "gr",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  }, --}}}
  {
    "michaelb/sniprun", --{{{
    build = "sh ./install.sh",
    cmd = { "SnipRun", "SnipRunOperator", "SnipLive", "SnipClose", "SnipInfo" },
    opts = {
      display = { "VirtualText" },
      live_display = { "VirtualTextOk", "TerminalOk" },
      selected_interpreters = { "Python3_fifo" },
      repl_enable = { "Python3_fifo" },
    },
    keys = {
      { "<Leader>s", "<Plug>SnipRunOperator", desc = "snip_run", mode = "o" },
      { "<Leader>s", "<esc><cmd>'<,'>SnipRun<cr>", desc = "snip_run", mode = "x" },
      { "<Leader>sd", "<Plug>SnipClose", desc = "snip_run", mode = "x" },
    },
  }, --}}}
  {
    "folke/zen-mode.nvim", --{{{
    cmd = { "ZenMode" },
    keys = {
      { "<A-,>", "<CMD>ZenMode<CR>", desc = "zen-mode", mode = "n" },
    },
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          options = {
            signcolumn = "no", -- disable signcolumn
            number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            cursorcolumn = false, -- disable cursor column
            foldcolumn = "0", -- disable fold column
            list = false, -- disable whitespace characters
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          twilight = {
            enabled = false,
          }, -- enable to start Twilight when zen mode opens
          gitsigns = {
            enabled = false,
          }, -- disables git signs
          tmux = {
            enabled = false,
          }, -- disables the tmux statusline
          kitty = {
            enabled = false,
            font = "+4", -- font size increment
          },
        },
        on_open = function()
          vim.diagnostic.config({
            virtual_text = false,
          })
          vim.lsp.handlers["textDocument/publishDiagnostics"] = nil
        end,
        on_close = function()
          vim.diagnostic.config({
            virtual_text = true,
          })
        end,
      })
    end,
    dependencies = {
      {
        "folke/twilight.nvim",
        config = function()
          require("twilight").setup({})
        end,
        -- keys = {
        --   { "<C-s>", "<CMD>Twilight<CR>", desc = "zen", mode = { "n" } },
        -- },
      },
    },
  }, --}}}
  {
    "folke/todo-comments.nvim", --{{{
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    cmd = { "TodoTrouble", "TodoTelesocpe" },
    keys = {
      { "<C-d>t", "<CMD>TodoTrouble<CR>", desc = "trouble list", mode = "n" },
      { "<C-d>T", "<CMD>TodoTelescope<CR>", desc = "trouble scope", mode = "n" },
    },
    opts = {
      keywords = {
        FIXME = { icon = "󱏛", color = "error", alt = { "BUG", "MISSING" } },
        DOCME = { icon = "󰈙", color = "info", alt = { "MEMO", "NOTION" } },
        TODO = { icon = " ", color = "info", alt = { "PLAN", "WIP", "STRATEGY", "FUTURE", "MVP" } },
        HACK = { icon = " ", color = "warning", alt = { "ISSUE", "WARN" } },
        PILOT = { icon = "", color = "info", alt = { "META", "INNOVATE", "OUTSIDE-BOX", "UNEXPLORED" } },
        WHYNOT = { icon = "󱄶", color = "info", alt = { "PURPOSE", "CONTEXT", "RATIONAL", "EXAMPLE", "FOLLOW" } },
        REVIEW = { icon = "", color = "hint", alt = { "DISCUSS", "QUESTION", "REQUEST", "BLOCKER" } },
        REFACTOR = {
          icon = "󰵛",
          color = "info",
          alt = { "DEPENDENT", "OVERTEST", "UNCOVERED", "INTEGRATION", "EDGE-CASE", "SLOW" },
        },
        BLUE = { icon = "", color = "test" },
        RED = { icon = "", color = "test" },
        GREEN = { icon = "", color = "test" },
        PERF = { icon = "", alt = { "BENCHMARK", "EVALUATION", "SCALE" } },
        LOGIC = { icon = "", alt = { "CLARITY", "UPGRADE", "CLEANUP", "DOC-ENHANCE" } },
        SECURE = { icon = "󰒃", alt = { "PRIVACY", "ILLEGAL", "ACCESSIBILITY", "LOCALIZE" } },
        LEGACY = { icon = "󱦟", alt = { "DEPRECATE", "MAINTAIN", "DEBT", "UNKNOWN", "PHASE-OUT" } },
      },
    },
    config = true,
  }, --}}}
  {
    "chikko80/error-lens.nvim",
    event = "BufRead",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {},
  },
  {
    "folke/trouble.nvim", --{{{
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    cmd = { "TroubleToggle" },
    keys = {
      {
        "<C-d>n",
        "<CMD>TroubleToggle workspace_diagnostics<CR>",
        desc = "workspace trouble_toggle",
        mode = { "n" },
      },
      {
        "<C-d>f",
        "<CMD>TroubleToggle quickfix<CR>",
        desc = "quickfix",
        mode = { "n" },
      },
      {
        "<C-d>e",
        "<cmd>TodoTrouble keywords=TODO,FIXME<CR>",
        desc = "todo list",
        mode = { "n" },
      },
      {
        "<C-d>y",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "document_diagnostics",
        mode = { "n" },
      },
      {
        "<C-d>i",
        "<cmd>TodoTrouble  snipfix<CR>",
        desc = "Show error by Lsp",
        mode = { "n" },
      },
      {
        "<C-d>h",
        "<cmd>TodoTrouble  loclist<CR>",
        desc = "loclist",
        mode = { "n" },
      },
      {
        "<C-d>r",
        "<cmd>TodoTrouble lsp_references<CR>",
        desc = "Show error by Lsp",
        mode = { "n" },
      }
    },
    config = function() -- {{{
      require("trouble").setup({
        action_keys = {
          close = { "<C-d>", "q" }, -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
          open_split = { "u" }, -- open buffer in new split
          open_vsplit = { "y" }, -- open buffer in new vsplit
          open_tab = { "<C-t>" }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = ",", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = ".", -- toggle auto_preview
          hover = "B", -- opens a small popup with the full multiline message
          preview = "b", -- preview the diagnostic location
          close_folds = { "mM" }, -- close all folds
          open_folds = { "mm" }, -- open all folds
          toggle_fold = { "mi", "mh" }, -- toggle fold of current file
          previous = "e", -- previous item
          next = "n", -- next item
        },
        auto_open = false,
        auto_close = false,
        use_diagnostic_signs = true,
      })
    end, -- }}}
  }, --}}}
  {
    "dstein64/vim-startuptime", --{{{
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  }, --}}}
  {
    "sindrets/diffview.nvim", --{{{
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
  }, --}}}
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   opts = {
  --     signs = {
  --       add = { text = "▎" },
  --       change = { text = "▎" },
  --       delete = { text = "" },
  --       topdelete = { text = "" },
  --       changedelete = { text = "▎" },
  --       untracked = { text = "▎" },
  --     },
  --     on_attach = function(buffer)
  --       local gs = package.loaded.gitsigns
  --
  --       local function map(mode, l, r, desc)
  --         vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
  --       end
  --
  --       -- stylua: ignore start
  --       map("n", "]h", gs.next_hunk, "Next Hunk")
  --       map("n", "[h", gs.prev_hunk, "Prev Hunk")
  --       map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
  --       map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
  --       map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
  --       map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
  --       map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
  --       map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
  --       map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
  --       map("n", "<leader>ghd", gs.diffthis, "Diff This")
  --       map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
  --       map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  --     end,
  --   },
  -- },
  {
    "lewis6991/gitsigns.nvim", --{{{
    event ="VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      signs = {
        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
      },
      current_line_blame_formatter_opts = {
        relative_time = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    },
  }, --}}}
  {
    "mrjones2014/smart-splits.nvim", --{{{
    event = "VeryLazy",
  }, --}}}
  {
    "echasnovski/mini.align", --{{{
    opts = {},
    keys = {
      { "ga", mode = { "v" } },
      { "gA", mode = { "v" } },
    },
  }, --}}}
  {
    "nvimtools/hydra.nvim", --{{{
    event = "VeryLazy",
    dependencies = { "mrjones2014/smart-splits.nvim", "lewis6991/gitsigns.nvim" },
    config = function()
      local success, hydra = pcall(require, "hydra")
      if not success then
        print("Unable to locate hydra!")
        return
      end
      local cmd = require("hydra.keymap-util").cmd
      hydra({
        name = "window",
        mode = "n",
        body = "<C-g>",
        heads = {
          -- Resize windows
          { "h", cmd("lua require('smart-splits').resize_left()"), { desc = "←s", silent = true } },
          { "n", cmd("lua require('smart-splits').resize_down()"), { desc = "↓s", silent = true } },
          { "e", cmd("lua require('smart-splits').resize_up()"), { desc = "↑s", silent = true } },
          { "i", cmd("lua require('smart-splits').resize_right()"), { desc = "→s", silent = true } },

          -- Move cursor between windows
          { "<M-h>", cmd(":lua require('smart-splits').move_cursor_left()"), { desc = "←m", silent = true } },
          { "<M-n>", cmd(":lua require('smart-splits').move_cursor_down()"), { desc = "↓m", silent = true } },
          { "<M-e>", cmd(":lua require('smart-splits').move_cursor_up()"), { desc = "↑m", silent = true } },
          { "<M-i>", cmd(":lua require('smart-splits').move_cursor_right()"), { desc = "→m", silent = true } },

          -- Swap buffers
          { "<C-h>", cmd(":lua require('smart-splits').swap_buf_left()"), { desc = "←w", silent = true } },
          { "<C-n>", cmd(":lua require('smart-splits').swap_buf_down()"), { desc = "↓w", silent = true } },
          { "<C-e>", cmd(":lua require('smart-splits').swap_buf_up()"), { desc = "↑w", silent = true } },
          { "<C-i>", cmd(":lua require('smart-splits').swap_buf_right()"), { desc = "→w", silent = true } },

          -- Change window layout
          { "H", "<C-W>H", { desc = "R←", silent = true } },
          { "N", "<C-W>K", { desc = "R↑", silent = true } },
          { "E", "<C-W>J", { desc = "R↓", silent = true } },
          { "I", "<C-W>L", { desc = "R→", silent = true } },
          { "z", "<Cmd>WindowsMaximize<CR>", { desc = "Max", silent = true } },
          { "S", "<Cmd>WindowsMaximizeVertically<CR>", { desc = "vMax", silent = true } },
          { "V", "<Cmd>WindowsMaximizeHorizontally<CR>", { desc = "hMax", silent = true } },
          { "=", "<cmd>WindowsEqualize<cr>", { desc = "=", silent = true } },

          -- Window management
          { "c", "<C-w>c", { desc = "Close", silent = true } },
          { "v", "<C-w>v", { desc = "VSplit", silent = true } },
          { "s", "<C-w>s", { desc = "HSplit", silent = true } },

          -- Tab management
          { "t", ":tabnew<CR>", { desc = "New Tab", silent = true } },
          { "T", ":tabclose<CR>", { desc = "Close Tab", silent = true } },
          { "]", ":tabnext<CR>", { desc = "Next Tab", silent = true } },
          { "[", ":tabprev<CR>", { desc = "Prev Tab", silent = true } },

          -- Exit Hydra
          { "q", nil, { desc = "Exit", exit = true, silent = true } },
        },
      }) -- }}}      -- gitsigns {{{
      local Hydra = require("hydra")
      local gitsigns = require('gitsigns')

      local hint = [[
 _N_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _E_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
      ]]
      Hydra({
      name = 'Git',
       hint = hint,
       config = {
          buffer = bufnr,
          color = 'red',
          invoke_on_body = true,
          hint = {
              type = "window",
              float_opts = {
                    -- row, col, height, width, relative, and anchor should not be
                    -- overridden
                    style = "minimal",
                    focusable = false,
                    noautocmd = true,
                },
          },
          on_key = function() vim.wait(50) end,
          on_enter = function()
             vim.cmd 'mkview'
             vim.cmd 'silent! %foldopen!'
             gitsigns.toggle_signs(true)
             gitsigns.toggle_linehl(true)
          end,
          on_exit = function()
             local cursor_pos = vim.api.nvim_win_get_cursor(0)
             vim.cmd 'loadview'
             vim.api.nvim_win_set_cursor(0, cursor_pos)
             vim.cmd 'normal zv'
             gitsigns.toggle_signs(false)
             gitsigns.toggle_linehl(false)
             gitsigns.toggle_deleted(false)
          end,
       },
       mode = {'n','x'},
       body = '<leader>g',
       heads = {
          { 'n',

             function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gitsigns.next_hunk() end)
                return '<Ignore>'
             end,
             { expr = true, desc = 'next hunk' } },
          { 'E',
             function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gitsigns.prev_hunk() end)
                return '<Ignore>'
             end,
             { expr = true, desc = 'prev hunk' } },
          { 's',
             function()
                local mode = vim.api.nvim_get_mode().mode:sub(1,1)
                if mode == 'V' then -- visual-line mode
                   local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
                   vim.api.nvim_feedkeys(esc, 'x', false) -- exit visual mode
                   vim.cmd("'<,'>Gitsigns stage_hunk")
                else
                   vim.cmd("Gitsigns stage_hunk")
                end
             end,
             { desc = 'stage hunk' } },
          { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
          { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
          { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
          { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
          { 'b', gitsigns.blame_line, { desc = 'blame' } },
          { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
          { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
          { '<Enter>', function() vim.cmd('Neogit') end, { exit = true, desc = 'Neogit' } },
          { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
       }
      }) --}}}
    end,
  }, --}}}
  {
    "nvim-telescope/telescope.nvim", --{{{
    cmd = "Telescope",
    keys = {
      {
        "<C-k>",
        "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find({ sorter = require('telescope.sorters').get_substr_matcher({})})<CR>",
        desc = "buffer_fuzzy_find",
        mode = { "n" },
      },
      {
        "gD",
        "<CMD>Telescope lsp_references<CR>",
        desc = "lsp_references",
        mode = { "n" },
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>z", "<cmd>Telescope undo<cr>", mode = "n", desc = "undo" } },
        config = function()
          require("telescope").load_extension("undo")
        end,
        desc = "telescope-undo",
      },
      "delphinus/telescope-memo.nvim",
      cmd = "Telescope memo",

      -- :Telescope memo live_grep
      -- telescope.builtin.live_grep on memo_dir.
      -- piersolenski/telescope-import.nvim,
      {
        "nvim-telescope/telescope-dap.nvim",
        -- mfussenegger / nvim-dap
        -- require'telescope'.extensions.dap.commands{}
        -- require'telescope'.extensions.dap.configurations{}
        -- require'telescope'.extensions.dap.list_breakpoints{}
        -- require'telescope'.extensions.dap.variables{}
        -- require'telescope'.extensions.dap.frames{}
      },
      {
        "nvim-telescope/telescope-github.nvim",
        -- lua require('telescope').extensions.gh.issues()<cr>
        -- lua require('telescope').extensions.gh.pull_request()<cr>
        -- lua require('telescope').extensions.gh.gist()<cr>
        -- lua require('telescope').extensions.gh.run()<cr>
        -- Telescope gh issues author=windwp label=bug
      },
      { "olimorris/persisted.nvim" },
    },
    config = function()
      local actions = require("telescope.actions")
      -- require("telescope").load_extension("persisted")
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.5,
            },
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
          },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            i = {
              ["<C-t>"] = actions.select_tab,
              ["<CR>"] = actions.select_default,
              ["<C-n>"] = actions.move_selection_next,
              ["<C-e>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<esc>"] = actions.close,
              -- ["<C-q>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-y>"] = actions.preview_scrolling_down,
              -- ["<C-l>"] = actions.preview_scrolling_left,
              ["<C-;>"] = actions.preview_scrolling_right,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["<C-f>"] = actions.results_scrolling_left,
              ["<C-p>"] = actions.results_scrolling_right,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-o>"] = actions.complete_tag,
              ["<C-b>"] = actions.which_key,
              ["<C-w>"] = { "<c-s-w>", type = "command" },

              -- disable c-j because we dont want to allow new lines #2123
              ["<C-j>"] = actions.nop,
            },
            n = {
              ["<C-t>"] = actions.select_tab,
              ["<CR>"] = actions.select_default,
              ["<esc>"] = actions.close,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["q"] = actions.close,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

              -- TODO: This would be weird if we switch the ordering.
              ["n"] = actions.move_selection_next,
              ["e"] = actions.move_selection_previous,
              ["E"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["N"] = actions.move_to_bottom,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-y>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["?"] = actions.which_key,
            },
          },
        },
        extensions = {
          undo = {
            use_delta = true,
            use_custom_command = nil,
            diff_context_lines = vim.o.scrolloff,
            entry_format = "state #$ID, $STAT, $TIME",
            time_format = "",
            saved_only = false,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
            mappings = {
              i = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-cr>"] = require("telescope-undo.actions").restore,
                ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-r>"] = require("telescope-undo.actions").restore,
              },
              n = {
                ["y"] = require("telescope-undo.actions").yank_additions,
                ["Y"] = require("telescope-undo.actions").yank_deletions,
                ["u"] = require("telescope-undo.actions").restore,
              },
            },
          },
        },
      })
      -- require("telescope").load_extension("ui-select")
      require("telescope").load_extension("undo")
    end,
  }, --}}}
  {
    "NeogitOrg/neogit", --{{{
    even = "VeryLazy",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    -- keys = {
    --   {
    --     "<leader>g",
    --     '<Cmd>Neogit<CR>',
    --     mode = "n",
    --     desc = "NeoGit",
    --   },
    -- },
    config = true,
  }, --}}}
  {
    "nvim-tree/nvim-web-devicons", --{{{
    event = "VeryLazy",
    config = function() --{{{
      require("nvim-web-devicons").setup({
        -- yes, this is all the icons w/ an extra space
        -- yes, this is all the icons w/ an extra space
        override = {
          ["default_icon"] = {
            icon = "󱔗 ",
          },
          [".babelrc"] = {
            icon = " ",
          },
          [".bash_profile"] = {
            icon = " ",
          },
          [".bashrc"] = {
            icon = " ",
          },
          [".ds_store"] = {
            icon = " ",
          },
          [".eslintrc"] = {
            icon = " ",
          },
          [".gitattributes"] = {
            icon = " ",
          },
          [".gitconfig"] = {
            icon = " ",
          },
          [".gitignore"] = {
            icon = " ",
          },
          [".gitlab-ci.yml"] = {
            icon = " ",
          },
          [".gitmodules"] = {
            icon = " ",
          },
          [".gvimrc"] = {
            icon = " ",
          },
          [".npmignore"] = {
            icon = " ",
          },
          [".npmrc"] = {
            icon = " ",
          },
          [".settings.json"] = {
            icon = " ",
          },
          [".vimrc"] = {
            icon = " ",
          },
          [".zprofile"] = {
            icon = " ",
          },
          [".zshenv"] = {
            icon = " ",
          },
          [".zshrc"] = {
            icon = " ",
          },
          ["brewfile"] = {
            icon = " ",
          },
          ["cmakelists.txt"] = {
            icon = " ",
          },
          ["commit_editmsg"] = {
            icon = " ",
          },
          ["containerfile"] = {
            icon = "󰡨 ",
          },
          ["copying"] = {
            icon = " ",
          },
          ["copying.lesser"] = {
            icon = " ",
          },
          ["docker-compose.yml"] = {
            icon = "󰡨 ",
          },
          ["docker-compose.yaml"] = {
            icon = "󰡨 ",
          },
          [".dockerignore"] = {
            icon = "󰡨 ",
          },
          ["gemfile$"] = {
            icon = " ",
          },
          ["vagrantfile$"] = {
            icon = " ",
          },
          ["_gvimrc"] = {
            icon = " ",
          },
          ["_vimrc"] = {
            icon = " ",
          },
          ["package.json"] = {
            icon = " ",
          },
          ["package-lock.json"] = {
            icon = " ",
          },
          ["node_modules"] = {
            icon = " ",
          },
          ["favicon.ico"] = {
            icon = " ",
          },
          ["mix.lock"] = {
            icon = " ",
          },
          [".env"] = {
            icon = " ",
          },
          ["gruntfile"] = {
            icon = " ",
          },
          ["gulpfile"] = {
            icon = " ",
          },
          ["rakefile"] = {
            icon = " ",
          },
          ["procfile"] = {
            icon = " ",
          },
          ["dockerfile"] = {
            icon = "󰡨 ",
          },
          ["build"] = {
            icon = " ",
          },
          ["workspace"] = {
            icon = " ",
          },
          ["unlicense"] = {
            icon = " ",
          },
          ["ai"] = {
            icon = " ",
          },
          ["awk"] = {
            icon = " ",
          },
          ["bash"] = {
            icon = " ",
          },
          ["bat"] = {
            icon = " ",
          },
          ["bazel"] = {
            icon = " ",
          },
          ["bzl"] = {
            icon = " ",
          },
          ["bmp"] = {
            icon = " ",
          },
          ["c"] = {
            icon = " ",
          },
          ["c++"] = {
            icon = " ",
          },
          ["cbl"] = {
            icon = "⚙ ",
          },
          ["cc"] = {
            icon = " ",
          },
          ["cfg"] = {
            icon = " ",
          },
          ["cjs"] = {
            icon = " ",
          },
          ["clj"] = {
            icon = " ",
          },
          ["cljc"] = {
            icon = " ",
          },
          ["cljs"] = {
            icon = " ",
          },
          ["cljd"] = {
            icon = " ",
          },
          ["cmake"] = {
            icon = " ",
          },
          ["cob"] = {
            icon = "⚙ ",
          },
          ["cobol"] = {
            icon = "⚙ ",
          },
          ["coffee"] = {
            icon = " ",
          },
          ["conf"] = {
            icon = " ",
          },
          ["config.ru"] = {
            icon = " ",
          },
          ["cp"] = {
            icon = " ",
          },
          ["cpp"] = {
            icon = " ",
          },
          ["cpy"] = {
            icon = "⚙ ",
          },
          ["cr"] = {
            icon = " ",
          },
          ["cs"] = {
            icon = "󰌛 ",
          },
          ["csh"] = {
            icon = " ",
          },
          ["cson"] = {
            icon = " ",
          },
          ["css"] = {
            icon = " ",
          },
          ["csv"] = {
            icon = "󰈙 ",
          },
          ["cxx"] = {
            icon = " ",
          },
          ["d"] = {
            icon = " ",
          },
          ["dart"] = {
            icon = " ",
          },
          ["db"] = {
            icon = " ",
          },
          ["desktop"] = {
            icon = " ",
          },
          ["diff"] = {
            icon = " ",
          },
          ["doc"] = {
            icon = "󰈬 ",
          },
          ["docx"] = {
            icon = "󰈬 ",
          },
          ["drl"] = {
            icon = " ",
          },
          ["dropbox"] = {
            icon = " ",
          },
          ["dump"] = {
            icon = " ",
          },
          ["end"] = {
            icon = " ",
          },
          ["eex"] = {
            icon = " ",
          },
          ["ejs"] = {
            icon = " ",
          },
          ["elm"] = {
            icon = " ",
          },
          ["epp"] = {
            icon = " ",
          },
          ["erb"] = {
            icon = " ",
          },
          ["erl"] = {
            icon = " ",
          },
          ["ex"] = {
            icon = " ",
          },
          ["exs"] = {
            icon = " ",
          },
          ["f#"] = {
            icon = " ",
          },
          ["f90"] = {
            icon = "󱈚 ",
          },
          ["fnl"] = {
            icon = "🌜 ",
          },
          ["fish"] = {
            icon = " ",
          },
          ["fs"] = {
            icon = " ",
          },
          ["fsi"] = {
            icon = " ",
          },
          ["fsscript"] = {
            icon = " ",
          },
          ["fsx"] = {
            icon = " ",
          },
          ["gd"] = {
            icon = " ",
          },
          ["gemspec"] = {
            icon = " ",
          },
          ["gif"] = {
            icon = " ",
          },
          ["git"] = {
            icon = " ",
          },
          ["glb"] = {
            icon = " ",
          },
          ["go"] = {
            icon = " ",
          },
          ["godot"] = {
            icon = " ",
          },
          ["graphql"] = {
            icon = " ",
          },
          ["gql"] = {
            icon = " ",
          },
          ["h"] = {
            icon = " ",
          },
          ["haml"] = {
            icon = " ",
          },
          ["hbs"] = {
            icon = " ",
          },
          ["heex"] = {
            icon = " ",
          },
          ["hh"] = {
            icon = " ",
          },
          ["hpp"] = {
            icon = " ",
          },
          ["hrl"] = {
            icon = " ",
          },
          ["hs"] = {
            icon = " ",
          },
          ["htm"] = {
            icon = " ",
          },
          ["html"] = {
            icon = " ",
          },
          ["hxx"] = {
            icon = " ",
          },
          ["ico"] = {
            icon = " ",
          },
          ["import"] = {
            icon = " ",
          },
          ["ini"] = {
            icon = " ",
          },
          ["java"] = {
            icon = " ",
          },
          ["jl"] = {
            icon = " ",
          },
          ["jpeg"] = {
            icon = " ",
          },
          ["jpg"] = {
            icon = " ",
          },
          ["js"] = {
            icon = " ",
          },
          ["test.js"] = {
            icon = " ",
          },
          ["spec.js"] = {
            icon = " ",
          },
          ["json"] = {
            icon = " ",
          },
          ["json5"] = {
            icon = " ",
          },
          ["jsx"] = {
            icon = " ",
          },
          ["test.jsx"] = {
            icon = " ",
          },
          ["spec.jsx"] = {
            icon = " ",
          },
          ["ksh"] = {
            icon = " ",
          },
          ["kt"] = {
            icon = " ",
          },
          ["kts"] = {
            icon = " ",
          },
          ["leex"] = {
            icon = " ",
          },
          ["less"] = {
            icon = " ",
          },
          ["lhs"] = {
            icon = " ",
          },
          ["license"] = {
            icon = " ",
          },
          ["lua"] = {
            icon = " ",
          },
          ["luau"] = {
            icon = " ",
          },
          ["gnumakefile"] = {
            icon = " ",
          },
          ["makefile"] = {
            icon = " ",
          },
          ["mk"] = {
            icon = " ",
          },
          ["markdown"] = {
            icon = " ",
          },
          ["material"] = {
            icon = "󰔉 ",
          },
          ["md"] = {
            icon = " ",
          },
          ["mdx"] = {
            icon = " ",
          },
          ["mint"] = {
            icon = "󰌪 ",
          },
          ["mjs"] = {
            icon = " ",
          },
          ["ml"] = {
            icon = "λ ",
          },
          ["mli"] = {
            icon = "λ ",
          },
          ["mo"] = {
            icon = "∞ ",
          },
          ["mustache"] = {
            icon = " ",
          },
          ["nim"] = {
            icon = " ",
          },
          ["nix"] = {
            icon = " ",
          },
          ["opus"] = {
            icon = "󰈣 ",
          },
          ["org"] = {
            icon = " ",
          },
          ["otf"] = {
            icon = " ",
          },
          ["pck"] = {
            icon = " ",
          },
          ["pdf"] = {
            icon = " ",
          },
          ["php"] = {
            icon = " ",
          },
          ["pl"] = {
            icon = " ",
          },
          ["pm"] = {
            icon = " ",
          },
          ["png"] = {
            icon = " ",
          },
          ["pp"] = {
            icon = " ",
          },
          ["ppt"] = {
            icon = "󰈧 ",
          },
          ["pro"] = {
            icon = " ",
          },
          ["ps1"] = {
            icon = "󰨊 ",
          },
          ["psd1"] = {
            icon = "󰨊 ",
          },
          ["psm1"] = {
            icon = "󰨊 ",
          },
          ["psb"] = {
            icon = " ",
          },
          ["psd"] = {
            icon = " ",
          },
          ["py"] = {
            icon = " ",
          },
          ["pyc"] = {
            icon = " ",
          },
          ["pyd"] = {
            icon = " ",
          },
          ["pyo"] = {
            icon = " ",
          },
          ["query"] = {
            icon = " ",
          },
          ["r"] = {
            icon = "󰟔 ",
          },
          ["rake"] = {
            icon = " ",
          },
          ["rb"] = {
            icon = " ",
          },
          ["README"] = {
            icon = "󰑇 ",
          },
          ["README.md"] = {
            icon = "󰑇 ",
          },
          ["res"] = {
            icon = " ",
          },
          ["resi"] = {
            icon = " ",
          },
          ["rlib"] = {
            icon = " ",
          },
          ["rmd"] = {
            icon = " ",
          },
          ["robots.txt"] = {
            icon = "󱚤 ",
          },
          ["rproj"] = {
            icon = "󰗆 ",
          },
          ["rs"] = {
            icon = " ",
          },
          ["rss"] = {
            icon = " ",
          },
          ["sass"] = {
            icon = " ",
          },
          ["sbt"] = {
            icon = " ",
          },
          ["scala"] = {
            icon = " ",
          },
          ["scm"] = {
            icon = "󰘧 ",
          },
          ["scss"] = {
            icon = " ",
          },
          ["sh"] = {
            icon = " ",
          },
          ["sig"] = {
            icon = "λ ",
          },
          ["slim"] = {
            icon = " ",
          },
          ["sln"] = {
            icon = " ",
          },
          ["sml"] = {
            icon = "λ ",
          },
          ["sql"] = {
            icon = " ",
          },
          ["sqlite"] = {
            icon = " ",
          },
          ["sqlite3"] = {
            icon = " ",
          },
          ["styl"] = {
            icon = " ",
          },
          ["sublime"] = {
            icon = " ",
          },
          ["suo"] = {
            icon = " ",
          },
          ["sv"] = {
            icon = "󰍛 ",
          },
          ["svelte"] = {
            icon = " ",
          },
          ["svh"] = {
            icon = "󰍛 ",
          },
          ["svg"] = {
            icon = "󰜡 ",
          },
          ["swift"] = {
            icon = " ",
          },
          ["t"] = {
            icon = " ",
          },
          ["tbc"] = {
            icon = "󰛓 ",
          },
          ["tcl"] = {
            icon = "󰛓 ",
          },
          ["terminal"] = {
            icon = " ",
          },
          ["tex"] = {
            icon = "󰙩 ",
          },
          ["tf"] = {
            icon = " ",
          },
          ["tfvars"] = {
            icon = " ",
          },
          ["toml"] = {
            icon = " ",
          },
          ["tres"] = {
            icon = " ",
          },
          ["ts"] = {
            icon = " ",
          },
          ["test.ts"] = {
            icon = " ",
          },
          ["spec.ts"] = {
            icon = " ",
          },
          ["tscn"] = {
            icon = "󰎁 ",
          },
          ["tsx"] = {
            icon = " ",
          },
          ["test.tsx"] = {
            icon = " ",
          },
          ["spec.tsx"] = {
            icon = " ",
          },
          ["twig"] = {
            icon = " ",
          },
          ["txt"] = {
            icon = "󰈙 ",
          },
          ["v"] = {
            icon = "󰍛 ",
          },
          ["vala"] = {
            icon = " ",
          },
          ["vh"] = {
            icon = "󰍛 ",
          },
          ["vhd"] = {
            icon = "󰍛 ",
          },
          ["vhdl"] = {
            icon = "󰍛 ",
          },
          ["vim"] = {
            icon = " ",
          },
          ["vue"] = {
            icon = " ",
          },
          ["webmanifest"] = {
            icon = " ",
          },
          ["webp"] = {
            icon = " ",
          },
          ["webpack"] = {
            icon = "󰜫 ",
          },
          ["xcplayground"] = {
            icon = " ",
          },
          ["xls"] = {
            icon = "󰈛 ",
          },
          ["xlsx"] = {
            icon = "󰈛 ",
          },
          ["xml"] = {
            icon = "󰗀 ",
          },
          ["xul"] = {
            icon = " ",
          },
          ["yaml"] = {
            icon = " ",
          },
          ["yml"] = {
            icon = " ",
          },
          ["zig"] = {
            icon = " ",
          },
          ["zsh"] = {
            icon = " ",
          },
          ["sol"] = {
            icon = "󰞻 ",
          },
          ["prisma"] = {
            icon = "󰔶 ",
          },
          ["lock"] = {
            icon = " ",
          },
          ["log"] = {
            icon = "󰌱 ",
          },
          ["wasm"] = {
            icon = " ",
          },
          ["liquid"] = {
            icon = " ",
          },
        },
      })
    end, --}}}
  }, --}}}
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<C-z>", "<cmd>UndotreeToggle<cr>", desc = "undotree", mode = "n" } },
  },
  {
    "aznhe21/actions-preview.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "MunifTanjim/nui.nvim" },
    keys = {
      {
        "<C-r>s",
        "<cmd>lua require('actions-preview').code_actions()<CR>",
        desc = "code_actions",
        mode = { "n", "v" },
      },
    },
  },
}