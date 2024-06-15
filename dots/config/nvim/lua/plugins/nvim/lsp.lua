return {
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "williamboman/mason.nvim", --{{{
    event = "VeryLazy",
    build = ":MasonUpdate",
    opts = {
      max_concurrent_installers = 10,
      log_level = vim.log.levels.DEBUG,
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    },
    config = true,
  }, --}}}
  {
    "williamboman/mason-lspconfig.nvim", --{{{
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  }, --}}}
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- ensure_installed = { "python" },
      automatic_installation = true,
      automatic_setup = true,
    },
    -- config = function()
    --   require("mason").setup()
    --   require("mason-nvim-dap").setup({
    --     ensure_installed = { "python" },
    --     automatic_installation = true,
    --     automatic_setup = true,
    --   })
    -- end,
  },
  -- {"mfussenegger/nvim-dap"},
  -- mfussenegger / nvim-dap-python
  --
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "williamboman/mason.nvim", opts = true },
      { "williamboman/mason-lspconfig.nvim", opts = true },
    },
    opts = {
      ensure_installed = {
        "pyright", -- LSP for python
        "debugpy", -- debugger
      },
    },
  },
  {
    "mfussenegger/nvim-lint", --{{{
    dependencies = { "rshkarin/mason-nvim-lint" },
    event = { "VeryLazy" },
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck", "zsh" },
        ini = { "shellcheck", "shfmt" },
        dotenv = { "dotenv_lint" },
        dockerfile = { "hadolint" },
        ghaction = { "actionlint" },
        git = { "gitlint", "cspell" },
        go = { "golangci_lint" },
        gitcommit = { "gitlint", "commitlint", "cspell" },
        java = {},
        -- javascript = { "eslint_d" },
        lua = { "luacheck" },
        markdown = { "markdownlint" },
        powershell = {},
        python = { "ruff" }, -- mypy
        rst = { "vale" },
        c = { "clang_format", "cpplint" },
        cpp = { "clang_format", "cpplint" },
        arduino = { "clang_format", "cpplint" },
        rust = { "clippy" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        yaml = { "yamllint" },
        ["*"] = { "codespell", "typos" },
        ["_"] = { "trim_whitespace" },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  }, --}}}
  {
    "rshkarin/mason-nvim-lint", --{{{
    event = { "VeryLazy" },
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-lint" },
    opts = { automatic_installation = true },
    config = function()
      require("mason-nvim-lint").setup({
        automatic_installation = true,
      })
    end,
  }, --}}}
  {
    "zapling/mason-conform.nvim", --{{{
    event = { "VeryLazy" },
    dependencies = { "williamboman/mason.nvim", "kasi-x/conform.nvim" },
    opts = { automatic_installation = true },
  }, --}}}
  {
    "kasi-x/conform.nvim", --{{{
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<C-q>",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "n",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        typescript = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier", "textlint" },
        graphql = { "prettier" },
        lua = { "stylua", "selene" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        zsh = { "shfmt", "beautysh", "shellcheck" },
        arduino = { "clang_format", "astyle", "uncrustify" },
        c = { "clang_format", "astyle", "uncrustify" },
        cpp = { "clang_format", "astyle", "uncrustify" },
        nim = { "nph" },
        cmake = { "cmake_format" },
        go = { "goimports", "gofmt", "gofumpt", "golines" },
        rust = { "rustfmt" },
        shell = { "shfmt", "beautysh", "shellcheck" },
        ini = { "shfmt", "beautysh", "shellcheck" },
        ["*"] = { "codespell", "typos" },
        ["_"] = {
          "trim_whitespace", --[[ "injected" ]]
        },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- format_after_save = { lsp_fallback = true, timeout_ms = 500 },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  }, --}}}
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  --   keys = {
  --     {
  --       "b",
  --       function()
  --         -- require("lsp_signature").toggle_signature()
  --         require('lsp_signature').toggle_float_win()
  --       end,
  --       mode = "n",
  --       desc = "Toggle signature",
  --     },
  --     {
  --       "<C-b>",
  --       function()
  --         require("lsp_signature").toggle_signature()
  --       end,
  --       mode = "i",
  --       desc = "Toggle signature",
  --     },
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      inlay_hints = { enabled = true },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    },
    config = function()
      -- this snippet enables auto-completion
      local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
      lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
      local lspconfig = require("lspconfig")
      local servers = {
        -- "arduino-language-server",
        "bashls",
        "bufls",
        "clangd",
        "cssls",
        "denols",
        "diagnosticls",
        "dockerls",
        "gopls",
        "jsonls",
        "marksman",
        "nimls",
        "pyright",
        -- "ruff_lsp",
        "powershell_es",
        "rust_analyzer",
        "lua_ls",
        "taplo",
        -- "terraformls",
        "tsserver",
        "yamlls",
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
      lspconfig.ruff_lsp.setup({
        on_attach = on_attach,
      })
      lspconfig.pyright.setup({
        settings = {
          pyright = {
            disableOrganizeImports = true,
            disableTaggedHints = true,
          },
          python = {
            analysis = {
              ignore = { "*" },
              diagnosticSeverityOverrides = {
                reportUndefinedVariable = "none",
              },
            },
          },
        },
      })
    end,
  },
}
