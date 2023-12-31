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
    cmd = { "SnipRun", "SnipRunOperator" },
    opts = {
      display = { "Terminal" },
      live_display = { "VirtualTextOk", "TerminalOk" },
      selected_interpreters = { "Python3_fifo" },
      repl_enable = { "Python3_fifo" },
    },
    keys = {
      {
        "<Leader>s",
        "<Plug>SnipRunOperator",
        desc = "snip_run",
        mode = "o",
      },
      {
        "<Leader>s",
        "<esc><cmd>'<,'>SnipRun<cr>",
        desc = "snip_run",
        mode = "x",
      },
    },
  }, --}}}
  {
    "folke/zen-mode.nvim", --{{{
    cmd = { "ZenMode" },
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
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
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
          -- this will change the font size on kitty when in zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = false,
            font = "+4", -- font size increment
          },
          -- this will change the font size on alacritty when in zen mode
          -- requires  Alacritty Version 0.10.0 or higher
          -- uses `alacritty msg` subcommand to change font size
          alacritty = {
            enabled = false,
            font = "14", -- font size
          },
          -- this will change the font size on wezterm when in zen mode
          -- See aalso the Plugins/Wezterm section in this projects README
          wezterm = {
            enabled = false,
            -- can be either an absolute font size or the number of incremental steps
            font = "+4", -- (10% increase per step)
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
    "folke/trouble.nvim", --{{{
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      { "folke/todo-comments.nvim", opts = true, cmd = "TodoTrouble" },
    },
    cmd = { "TroubleToggle" },
    keys = {
      {
        "<C-d>",
        "<CMD>TroubleToggle workspace_diagnostics<CR>",
        desc = "trouble_toggle",
        mode = { "n" },
      },
      {
        "<leader>d",
        "<cmd>TodoTrouble  keywords=TODO,FIX,FIXME<CR>",
        desc = "todo",
        mode = { "n" },
      },
      -- 	["<C-o>o"] = { "<cmd>TroubleToggle snipfix <CR>", "Show Error by LSPs" },
      -- 	["<C-o>d"] = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "diagnostics" },
      -- 	["<C-o>r"] = { "<cmd>TroubleToggle loclist<CR>", "diagnostics" },
      -- 	["<C-o>a"] = { "<cmd>TroubleToggle snipfix<CR>", "diagnostics" },
      -- 	["<C-o>o"] = { "<cmd>TroubleToggle lsp_references<CR>", "diagnostics" },
    },
    config = function() -- {{{
      require("trouble").setup({
        action_keys = {
          -- key mappings for actions in the trouble list
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
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  }, --}}}
  {
    "lewis6991/gitsigns.nvim", --{{{
    event = { "BufReadPre", "BufNewFile" },
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
    dependencies = {
      "mrjones2014/smart-splits.nvim",
    },
    config = function()
      local Hydra = require("hydra")
      -- windows size {{{
      Hydra({
        name = "window",
        mode = "n",
        body = "<C-g>",
        heads = {
          -- ウィンドウのサイズ変更
          { "h", ":lua require('smart-splits').resize_left()<CR>", { desc = "←s" } },
          { "n", ":lua require('smart-splits').resize_down()<CR>", { desc = "↓s" } },
          { "e", ":lua require('smart-splits').resize_up()<CR>", { desc = "↑s" } },
          { "i", ":lua require('smart-splits').resize_right()<CR>", { desc = "→s" } },

          -- カーソルの移動
          { "<M-h>", ":lua require('smart-splits').move_cursor_left()<CR>", { desc = "←m" } },
          { "<M-n>", ":lua require('smart-splits').move_cursor_down()<CR>", { desc = "↓m" } },
          { "<M-e>", ":lua require('smart-splits').move_cursor_up()<CR>", { desc = "↑m" } },
          { "<M-i>", ":lua require('smart-splits').move_cursor_right()<CR>", { desc = "→m" } },

          -- バッファの交換
          { "<C-h>", ":lua require('smart-splits').swap_buf_left()<CR>", { desc = "←w" } },
          { "<C-n>", ":lua require('smart-splits').swap_buf_down()<CR>", { desc = "↓w" } },
          { "<C-e>", ":lua require('smart-splits').swap_buf_up()<CR>", { desc = "↑w" } },
          { "<C-i>", ":lua require('smart-splits').swap_buf_right()<CR>", { desc = "→w" } },

          -- ウィンドウの向きの変更
          { "H", "<C-W>H", { desc = "R←" } },
          { "N", "<C-W>K", { desc = "R↑" } },
          { "E", "<C-W>J", { desc = "R↓" } },
          { "I", "<C-W>L", { desc = "R→" } },

          { "z", "<Cmd>WindowsMaximize<CR>", { desc = "Max" } },
          { "S", "<Cmd>WindowsMaximizeVertically<CR>", { desc = "vMax" } },
          { "V", "<Cmd>WindowsMaximizeHorizontally<CR>", { desc = "hMax" } },
          { "=", "<cmd>WindowsEqualize<cr>", { desc = "=" } },

          -- -- ウィンドウ間の移動
          -- { '<C-h>', '<C-W>h', { desc = 'Move ←' } },
          -- { '<C-n>', '<C-W>k', { desc = 'Move ↑' } },
          -- { '<C-e>', '<C-W>j', { desc = 'Move ↓' } },
          -- { '<C-i>', '<C-W>l', { desc = 'Move →' } },
          --
          -- ウィンドウ操作
          { "c", "<C-w>c", { desc = "Close" } },
          { "v", "<C-w>v", { desc = "VSplit" } },
          { "s", "<C-w>s", { desc = "HSplit" } },

          -- 新規タブの操作
          { "t", ":tabnew<CR>", { desc = "New Tab" } },
          { "T", ":tabclose<CR>", { desc = "Close Tab" } },
          { "]", ":tabnext<CR>", { desc = "Next Tab" } },
          { "[", ":tabprev<CR>", { desc = "Prev Tab" } },

          -- ハイドラの終了
          { "q", nil, { desc = "Exit", exit = true } },
        },
      }) -- }}}
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
      { "debugloop/telescope-undo.nvim" },
      -- { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>z", "<cmd>Telescope undo<cr>", mode = "n", desc = "undo" } },
        config = function()
          require("telescope").load_extension("undo")
        end,
        desc = "telescope-undo",
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
  -- {
  --   "aznhe21/actions-preview.nvim",
  --   keys = {
  --     {
  --       "<Leader>ra",
  --       "<cmd>lua require('actions-preview').code_actions)<CR>",
  --       desc = "code_actions",
  --       mode = { "n", "v" },
  --     },
  --   },
  -- },
  {
    "nvimdev/lspsaga.nvim",
    lazy = false,
    cmd = "Lspsaga",
    config = function()
      require("lspsaga").setup({
        ui = {
          code_action = "󰌶",
          diagnostic = "",
        },
        lightbulb = {
          sigh = false,
          enable = false,
          virtual_text = true,
          enable_in_insert = true,
        },
        finder = {
          scroll_down = "<C-u>",
          scroll_up = "<C-y>",
          quit = { "q", "<ESC>" },
        },
        symbol_in_winbar = {
          enable = false,
          show_file = false,
        },
        definition = {
          keys = {
            edit = "<C-o>",
            vsplit = "gu",
            split = "gy",
            tabe = "<C-g>",
            quit = "q",
            close = "<C-q>",
          },
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
    keys = {
      {
        "gR",
        "<cmd>Lspsaga rename ++project<cr>",
        desc = "rename",
        mode = "n",
      },
      {
        "b",
        "<cmd>Lspsaga hover_doc<cr>",
        desc = "hover_doc",
        mode = "n",
      },
      {
        "gD",
        "<cmd>Lspsaga finder<CR>",
        desc = "implementation of interface",
        mode = { "n" },
      },
      {
        "<C-b>",
        "<cmd>Lspsaga peek_type_definition<CR>",
        desc = "preview_type_definition",
        mode = { "n" },
      },

      {
        "<Leader>R",
        "<cmd>Lspsaga code_action<cr>",
        desc = "CodeAction",
        mode = { "n" },
      },
      {
        "<Leader>R",
        "<cmd>Lspsaga range_code_action<cr>",
        desc = "CodeAction",
        mode = { "x" },
      },
      {
        "<Leader>f",
        "<cmd>Lspsaga diagnostic_jump_next<cr>",
        desc = "diagnostic_jump_next",
        mode = { "n" },
      },
      {
        "<Leader>p",
        "<cmd>Lspsaga diagnostic_jump_prev<cr>",
        desc = "diagnostic_jump_prev",
        mode = { "n" },
      },
      {
        "<Leader>b",
        "<cmd>Lspsaga show_line_diagnostics<CR>",
        desc = "show_diagnostic",
        mode = { "n" },
      },
    },
  },

  -- vim.keymap.set("n", "[_Lsp]r", "<cmd>Lspsaga rename ++project<cr>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "M", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
  -- vim.keymap.set("x", "M", ":<c-u>Lspsaga range_code_action<cr>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "?", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]j", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]k", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]f", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]s", "<Cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]d", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
  -- vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true, noremap = true })
  -- -- vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
  -- vim.keymap.set("n", "[_Lsp]l", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]c", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]b", "<cmd>Lspsaga show_buf_diagnostics<CR>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[E", function()
  -- 	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  -- end, { silent = true, noremap = true })
  -- vim.keymap.set("n", "]E", function()
  -- 	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  -- end, { silent = true, noremap = true })
  -- vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]I", "<cmd>Lspsaga incoming_calls<CR>", { silent = true, noremap = true })
  -- vim.keymap.set("n", "[_Lsp]O", "<cmd>Lspsaga outgoing_calls<CR>", { silent = true, noremap = true })
}