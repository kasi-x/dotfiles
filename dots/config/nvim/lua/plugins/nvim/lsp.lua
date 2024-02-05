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
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "williamboman/mason.nvim" },
  --   -- opts = {
  --   --   ensure_installed = { "python" },
  --   --   automatic_installation = true,
  --   --   automatic_setup = true,
  --   -- },
  -- config =function()
  --   require("mason").setup()
  --   require("mason-nvim-dap").setup({
  --   ensure_installed = { "python" },
  --     automatic_installation = true,
  --     automatic_setup = true,
  --   })
  -- end,
  -- },
  -- {"mfussenegger/nvim-dap"},
  -- mfussenegger / nvim-dap-python
  {
    "mfussenegger/nvim-lint", --{{{
    dependencies = { "rshkarin/mason-nvim-lint" },
    -- events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck", "zsh" },
        ini = { "shellcheck", "shfmt" },
        -- ["yaml.ansible"] = { "ansible_lint" },
        -- dotenv = { "dotenv_lint" },
        dockerfile = { "hadolint" },
        ghaction = { "actionlint" },
        git = { "gitlint", "cspell" },
        go = { "golangci_lint" },
        gitcommit = { "gitlint", "commitlint", "cspell" },
        -- java = {},
        javascript = { "eslint_d" },
        lua = { "luacheck" },
        markdown = { "markdownlint" },
        powershell = {},
        python = { "ruff", "mypy" },
        -- rst = { "vale" },
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
      -- vim.cmd [[
      --   augroup lint
      --     autocmd!
      --     autocmd BufWritePost,BufEnter * lua require('lint').try_lint()
      --   augroup END
      -- ]]
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
    -- event = "VeryLazy",
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-lint" },
    -- opts = { automatic_installation = true },
    config = function()
      require("mason").setup()
      require("mason-nvim-lint").setup({
        automatic_installation = true,
      })
      require("nvim-lint").setup()
    end,
  }, --}}}
  {
    "stevearc/conform.nvim", --{{{
    -- event = { "VeryLazy" },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "qq",
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
        python = { "ruff_fix", "ruff_format" },
        zsh = { "shfmt", "beautysh", "shellcheck" },
        arduino = { "clang_format", "astyle", "uncrustify" },
        c = { "clang_format", "astyle", "uncrustify" },
        cpp = { "clang_format", "astyle", "uncrustify" },
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
      format_on_save = { timeout_ms = 500, lsp_fallback = false },
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
  --     -- {
  --     --   "B",
  --     --   function()
  --     --     require("lsp_signature").toggle_signature()
  --     --   end,
  --     --   mode = "n",
  --     --   desc = "Toggle signature",
  --     -- },
  --   --   {
  --   --     "B",
  --   --     function()
  --   --       require("lsp_signature").toggle_signature()
  --   --     end,
  --   --     mode = "i",
  --   --     desc = "Toggle signature",
  --   --   },
  --   -- },
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
        "html",
        "jsonls",
        "marksman",
        "nimls",
        -- "ruby_ls",
        "pyright",
        "jedi_language_server",
        "powershell_es",
        "rust_analyzer",
        "lua_ls",
        "taplo",
        "terraformls",
        "tsserver",
        "yamlls",
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
      --[[ {{{ pyright capabilities
      analyzerServiceExecutor
      autoImporter
      callHierarchyProvider
      codeActionProvider
      completionProvider
      completionProviderUtils
      definitionProvider
      documentHighlightProvider
      documentSymbolCollector
      documentSymbolProvider
      hoverProvider
      importSorter
      navigationUtils
      quickActions
      referencesProvider
      renameProvider
      signatureHelpProvider
      symbolIndexer
      tooltipUtils
      workspaceSymbolProvider
      -- }}} ]]
      --[[ {{{ jedi capabilities
      completionItem/resolve
      textDocument/codeAction (refactor.inline, refactor.extract)
      textDocument/completion
      textDocument/definition
      textDocument/documentHighlight
      textDocument/documentSymbol
      textDocument/typeDefinition
      textDocument/hover
      textDocument/publishDiagnostics
      textDocument/references
      textDocument/rename
      textDocument/signatureHelp
      workspace/symbol
      Text Synchronization (for diagnostics)
      textDocument/didChange
      textDocument/didOpen
      textDocument/didSave
      -- }}} ]]
      --[[ Compare {{{
      Pyright Exclusive Features: {{{
      analyzerServiceExecutor
      importSorter
      navigationUtils
      ?quickActions
      symbolIndexer
      tooltipUtils }}}
      Jedi Language Server Exclusive Features: {{{
      completionItem/resolve
      ?textDocument/codeAction (refactor.inline, refactor.extract)
      textDocument/typeDefinition
      textDocument/publishDiagnostics
      Text Synchronization (for diagnostics)
      textDocument/didChange
      textDocument/didOpen
      textDocument/didSave
      }}}
      -- }}}]]
      local on_attach = function(client)
        if client.name == "pyright" then
          client.server_capabilities.definitionProvider = true
          client.server_capabilities.referencesProvider = true
          client.server_capabilities.hoverProvider = true
        end

        if client.name == "jedi_language_server" then
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.referencesProvider = false
          client.server_capabilities.hoverProvider = false
        end
      end
      lspconfig.pyright.setup({
        on_attach = on_attach,
        settings = {
          disableLanguageServices = false,
          disableOrganizeImports = true,
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              autoImportCompletions = false,
            },
          },
        },
      })
      lspconfig.jedi_language_server.setup({
        on_attach = on_attach,
        settings = {
          diagnostics = {
            enable = false,
            didOpen = false,
            didChange = false,
            didSave = false,
          },
        },
      })
    end,
  },
}
