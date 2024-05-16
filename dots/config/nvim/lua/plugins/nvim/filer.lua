return {
  {
    "nvim-neo-tree/neo-tree.nvim", --{{{
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {
        "<C-t>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            -- position = "left",
          })
        end,
        desc = "Buffers (root dir)",
      },
      config = function()
        require("neo-tree").setup({
          default_component_configs = {
            container = {
              enable_character_fade = true,
            },
            indent = {
              indent_size = 2,
              padding = 1, -- extra padding on left hand side
              -- indent guides
              with_markers = true,
              indent_marker = "│",
              last_indent_marker = "└",
              highlight = "NeoTreeIndentMarker",
              -- expander config, needed for nesting files
              with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
              expander_collapsed = "",
              expander_expanded = "",
              expander_highlight = "NeoTreeExpander",
            },
            icon = {
              folder_closed = "",
              folder_open = "",
              folder_empty = "󰜌",
              -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
              -- then these will never be used.
              default = "*",
              highlight = "NeoTreeFileIcon",
            },
            modified = {
              symbol = "[+]",
              highlight = "NeoTreeModified",
            },
            name = {
              trailing_slash = false,
              use_git_status_colors = true,
              highlight = "NeoTreeFileName",
            },
            git_status = {
              symbols = {
                -- Change type
                added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted = "✖", -- this can only be used in the git_status source
                renamed = "󰁕", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored = "",
                unstaged = "󰄱",
                staged = "",
                conflict = "",
              },
            },
            -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
            file_size = {
              enabled = true,
              required_width = 64, -- min width of window required to show this column
            },
            type = {
              enabled = true,
              required_width = 122, -- min width of window required to show this column
            },
            last_modified = {
              enabled = true,
              required_width = 88, -- min width of window required to show this column
            },
            created = {
              enabled = true,
              required_width = 110, -- min width of window required to show this column
            },
            symlink_target = {
              enabled = false,
            },
          },
          window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
            -- possible options. These can also be functions that return these options.
            position = "left", -- left, right, top, bottom, float, current
            width = 40, -- applies to left and right positions
            height = 15, -- applies to top and bottom positions
            auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
            popup = { -- settings that apply to float position only
              size = {
                height = "80%",
                width = "50%",
              },
              position = "50%", -- 50% means center it
              -- you can also specify border here, if you want a different setting from
              -- the global popup_border_style.
            },
            same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
            insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
            -- "child":   Insert nodes as children of the directory under cursor.
            -- "sibling": Insert nodes  as siblings of the directory under cursor.
            -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
            -- You can also create your own commands by providing a function instead of a string.
            mapping_options = {
              noremap = true,
              nowait = true,
            },
            mappings = {
              ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
              },
              ["<2-LeftMouse>"] = "open",
              ["<cr>"] = "open_tabnew",

              -- ["<cr>"] = { "open", config = { expand_nested_files = true } }, -- expand nested file takes precedence
              ["<esc>"] = "cancel", -- close preview or floating neo-tree window
              ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
              ["l"] = "focus_preview",
              ["S"] = "open_split",
              -- ["S"] = "split_with_window_picker",
              ["s"] = "open_vsplit",
              -- ["s"] = "vsplit_with_window_picker",
              ["t"] = "open_tabnew",
              -- ["<cr>"] = "open_drop",
              -- ["t"] = "open_tab_drop",
              ["w"] = "open_with_window_picker",
              ["C"] = "close_node",
              ["z"] = "close_all_nodes",
              --["Z"] = "expand_all_nodes",
              ["R"] = "refresh",
              ["a"] = {
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                  show_path = "none", -- "none", "relative", "absolute"
                },
              },
              ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
              ["d"] = "delete",
              ["r"] = "rename",
              ["y"] = "copy_to_clipboard",
              ["x"] = "cut_to_clipboard",
              ["p"] = "paste_from_clipboard",
              ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
              ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
              -- ["e"] = "toggle_auto_expand_width",
              ["e"] = "move_cursor_up",
              ["q"] = "close_window",
              ["?"] = "show_help",
              ["<"] = "prev_source",
              [">"] = "next_source",
            },
          },
          filesystem = {
            window = {
              mappings = {
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                --["/"] = "filter_as_you_type", -- this was the default until v1.28
                ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                -- ["D"] = "fuzzy_sorter_directory",
                ["g"] = "",

                ["f"] = "filter_on_submit",
                ["<C-x>"] = "clear_filter",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
                ["i"] = "show_file_details",
                ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["og"] = { "order_by_git_status", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
                ["e"] = "move_cursor_up",
              },
              fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                ["<down>"] = "move_cursor_down",
                ["<C-n>"] = "move_cursor_down",
                ["<up>"] = "move_cursor_up",
                ["<C-p>"] = "move_cursor_up",
              },
            },
            async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
            -- "always" means directory scans are always async.
            -- "never"  means directory scans are never async.
            scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
            -- "deep": Scan into directories to detect empty or grouped empty directories a priori.
            bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
            cwd_target = {
              sidebar = "tab", -- sidebar is when position = left or right
              current = "window", -- current is when position = current
            },
            check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
            -- setting this to false will speed up searches, but gitignored
            -- items won't be marked if they are visible.
            -- The renderer section provides the renderers that will be used to render the tree.
            --   The first level is the node type.
            --   For each node type, you can specify a list of components to render.
            --       Components are rendered in the order they are specified.
            --         The first field in each component is the name of the function to call.
            --         The rest of the fields are passed to the function as the "config" argument.
            filtered_items = {
              visible = false, -- when true, they will just be displayed differently than normal items
              force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
              show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
              hide_dotfiles = true,
              hide_gitignored = true,
              hide_hidden = true, -- only works on Windows for hidden files/directories
              hide_by_name = {
                ".DS_Store",
                "thumbs.db",
                --"node_modules",
              },
              hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json"
              },
              always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
              },
              never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
              },
              never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
              },
            },
            find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
            -- `true` will change the filter into a full path
            -- search with space as an implicit ".*", so
            -- `fi init`
            -- will match: `./sources/filesystem/init.lua
            --find_command = "fd", -- this is determined automatically, you probably don't need to set it
            --find_args = {  -- you can specify extra args to pass to the find command.
            --  fd = {
            --  "--exclude", ".git",
            --  "--exclude",  "node_modules"
            --  }
            --},
            ---- or use a function instead of list of strings
            --find_args = function(cmd, path, search_term, args)
            --  if cmd ~= "fd" then
            --    return args
            --  end
            --  --maybe you want to force the filter to always include hidden files:
            --  table.insert(args, "--hidden")
            --  -- but no one ever wants to see .git files
            --  table.insert(args, "--exclude")
            --  table.insert(args, ".git")
            --  -- or node_modules
            --  table.insert(args, "--exclude")
            --  table.insert(args, "node_modules")
            --  --here is where it pays to use the function, you can exclude more for
            --  --short search terms, or vary based on the directory
            --  if string.len(search_term) < 4 and path == "/home/cseickel" then
            --    table.insert(args, "--exclude")
            --    table.insert(args, "Library")
            --  end
            --  return args
            --end,
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            search_limit = 50, -- max number of search results when using filters
            follow_current_file = {
              enabled = false, -- This will find and focus the file in the active buffer every time
              --               -- the current file is changed while the tree is open.
              leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
            -- in whatever position is specified in window.position
            -- "open_current",-- netrw disabled, opening a directory opens within the
            -- window like netrw would, regardless of window.position
            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
          },
          buffers = {
            bind_to_cwd = true,
            follow_current_file = {
              enabled = true, -- This will find and focus the file in the active buffer every time
              --              -- the current file is changed while the tree is open.
              leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            group_empty_dirs = true, -- when true, empty directories will be grouped together
            show_unloaded = false, -- When working with sessions, for example, restored but unfocused buffers
            -- are mark as "unloaded". Turn this on to view these unloaded buffer.
            terminals_first = false, -- when true, terminals will be listed before file buffers
            window = {
              mappings = {
                ["<bs>"] = "navigate_up",
                ["e"] = "move_cursor_up",
                ["."] = "set_root",
                ["bd"] = "buffer_delete",
                ["i"] = "show_file_details",
                ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
              },
            },
          },
          git_status = {
            window = {
              mappings = {
                ["e"] = "move_cursor_up",
                ["A"] = "git_add_all",
                ["u"] = "git_unstage_file",
                ["a"] = "git_add_file",
                ["r"] = "git_revert_file",
                ["c"] = "git_commit",
                ["p"] = "git_push",
                ["g"] = "git_commit_and_push",
                ["i"] = "show_file_details",
                ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
              },
            },
          },
        })
      end,
    },
    -- keys = {
    --   { "<C-t>", ":Neotree document_symbols toggle<CR>", desc = "Enable or disable NeoTree", mode = { "n" } },
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    config = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

      require("neo-tree").setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil, -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "✖", -- this can only be used in the git_status source
              renamed = "󰁕", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = false,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open_tabnew",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["B"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            -- Read `# Preview Mode` for more information
            ["l"] = "focus_preview",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            -- ["B"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["m"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["M"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["c"] = "copy_to_clipboard",
            ["C"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["x"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            -- ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["b"] = "show_file_details",
            ["G"] = function()
              vim.api.nvim_exec("Neotree focus filesystem left", true)
            end,
            ["f"] = function()
              vim.api.nvim_exec("Neotree focus buffers left", true)
            end,
            ["g"] = function()
              vim.api.nvim_exec("Neotree focus git_status left", true)
            end,
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              ".DS_Store",
              "thumbs.db",
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ["e"] = "move_cursor_up",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["og"] = { "order_by_git_status", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-e>"] = "move_cursor_up",
            },
          },

          commands = {}, -- Add a custom command or override a global one using the same function name
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["e"] = "move_cursor_up",
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["e"] = "move_cursor_up",
              ["A"] = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
          },
        },
      })

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end,
  }, --}}}
}