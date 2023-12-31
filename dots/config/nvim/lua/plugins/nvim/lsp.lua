return {
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "williamboman/mason.nvim", --{{{
    event = "VeryLazy",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },                                     --}}}
  {
    "williamboman/mason-lspconfig.nvim", --{{{
    event = "VeryLazy",
    opts = {
      automatic_installation = true,
      ensure_installed = {
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
        "lua_ls",
        "marksman",
        "nimls",
        "powershell_es",
        -- "pyright"
        "jedi_language_server",
        "rust_analyzer",
        "taplo",
        "terraformls",
        "tsserver",
        "yamlls",
        -- "ruby_ls",
      },
      default_handler = function(server_name)
        local lspconfig = require("lspconfig")
        lspconfig[server_name].setup({})
      end,
    },
  }, --}}}
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "python" },
      automatic_installation = true,
      automatic_setup = true,
    },
  },
  {
    "rshkarin/mason-nvim-lint", --{{{
    event = "VeryLazy",
    opts = {
      DEFAULT_SETTINGS = {
        ---@type string[]
        ensure_installed = {
          "golint",
          "beautysh",
          "clang_format",
          "astyle",
          "uncrustify",
          "codespell",
          "cspell",
          "cpp_format",
          "cpplint",
          "gitlint",
          "luacheck",
          "ruff",
          "selene",
          "shellcheck",
          "shfmt",
          -- "vale",
          "hadolint",
          "commitlint",
          "cspell",
          "mypy",
          "goimports",
          "gofmt",
          "gofumpt",
          "golines",
          "markdownlint",
          "typos",
          "actionlint"
        },
      }
    },
  },                          --}}}
  {
    "mfussenegger/nvim-lint", --{{{
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
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
        go = { "golangci_lint", "golint" },
        gitcommit = { "gitlint", "commitlint", "cspell" },
        -- java = {},
        javascript = { "eslint_d" },
        lua = { "luacheck" },
        markdown = { "markdownlint" },
        powershell = {},
        python = { "ruff" },
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
          require('lint').try_lint()
        end,
      })
    end,
  },                         --}}}
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
        python = { "ruff_format", "ruff_fix" },
        zsh = { "shfmt", "beautysh", "shellcheck" },
        arduino = { "clang_format", "astyle", "uncrustify" },
        c = { "clang_format", "astyle", "uncrustify" },
        cpp = { "clang_format", "astyle", "uncrustify" },
        cmake = { "cmake_format" },
        go = { "goimports", "gofmt", "gofumpt", "golines" },
        rust = { "rustfmt" },
        -- ruby = { "rufo" },
        shell = { "shfmt", "beautysh", "shellcheck" },
        ini = { "shfmt", "beautysh", "shellcheck" },
        ["_"] = { "trim_whitespace", "injected" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
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
            dynamicRegistration = false,
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local servers = {
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
      local on_attach = function(client, buffer)
        if client.name == 'pyright' then
          client.server_capabilities.definitionProvider = true
          client.server_capabilities.referencesProvider = true
          client.server_capabilities.hoverProvider = true

          -- for k, _ in pairs(client.server_capabilities) do
          --   client.server_capabilities[k] = false
          -- end
          -- client.server_capabilities.definitionProvider = false
          -- client.server_capabilities.analyzerServiceExecutor = true
          -- client.server_capabilities.referencesProvider = true
          -- client.server_capabilities.hoverProvider = true
          -- client.server_capabilities.analyzerServiceExecutor = true
          -- client.server_capabilities.callHierarchyProvider = true
          -- client.server_capabilities.signatureHelpProvider = true
          -- client.server_capabilities.documentSymbolCollector = true
          -- client.server_capabilities.documentSymbolProvider = true
          -- client.server_capabilities.navigationUtils = true
          -- navigationUtils
          -- renameProvider
          -- signatureHelpProvider
          -- symbolIndexer
          -- tooltipUtils
          -- workspaceSymbolProvider
        end

        if client.name == 'jedi_language_server' then
          -- for k, _ in pairs(client.server_capabilities) do
          --   client.server_capabilities[k] = true
          -- end

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
        }
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
  }
}