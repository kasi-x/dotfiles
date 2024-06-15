return {
  {
    "SWiegandt/autoself.nvim",
    ft = "python",
    config = true,
  },
  {
    "tmhedberg/SimpylFold",
    ft = "python",
  },
  {
    "twanh/nvim-pydoc",
    ft = "python",
  },
  {
    "nmac427/guess-indent.nvim", --{{{
    event = { "BufRead", "BufNewFile" },
    opts = {
      auto_cmd = true,
      override_editorconfig = false,
      filetype_exclude = {
        "netrw",
        "tutor",
      },
      buftype_exclude = {
        "help",
        "nofile",
        "terminal",
        "prompt",
      },
    },
  }, --}}}
  {
    "chrisgrieser/nvim-puppeteer",
    ft = "python",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- select virtual environments
  -- - makes pyright and debugpy aware of the selected virtual environment
  -- - Select a virtual environment with `:VenvSelect`
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    opts = {
      dap_enabled = true, -- makes the debugger work with venv
    },
  },
  {
    "wookayin/semshi", -- maintained fork
    ft = "python",
    build = ":UpdateRemotePlugins", -- don't disable `rplugin` in lazy.nvim for this
    init = function()
      vim.g.python3_host_prog = vim.fn.exepath("python3")
      -- better done by LSP
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
      vim.g["semshi#update_delay_factor"] = 0.001

      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        callback = function()
          vim.cmd([[
						highlight! semshiGlobal gui=italic
						highlight! link semshiImported @lsp.type.namespace
						highlight! link semshiParameter @lsp.type.parameter
						highlight! link semshiParameterUnused DiagnosticUnnecessary
						highlight! link semshiBuiltin @function.builtin
						highlight! link semshiAttribute @field
						highlight! link semshiSelf @lsp.type.selfKeyword
						highlight! link semshiUnresolved @lsp.type.unresolvedReference
						highlight! link semshiFree @comment
					]])
        end,
      })
    end,
  },
  -- {
  --   "MaximilianLloyd/tw-values.nvim",
  --   ft = { "typescript", "typescriptreact", "vue", "html", "svelte", "astro", "css" },
  --   keys = {
  --     { "B", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
  --   },
  --   opts = {
  --     border = "rounded", -- Valid window border style,
  --     show_unknown_classes = true, -- Shows the unknown classes popup
  --     focus_preview = true, -- Sets the preview as the current window
  --   },
  -- },
}
