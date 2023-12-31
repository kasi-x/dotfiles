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
  }, --}}}
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  },
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
        "pyright",
        "rust_analyzer",
        "taplo",
        "terraformls",
        "tsserver",
        "yamlls",
        -- "ruby_ls",
      },
      -- The default handler will try to find a matching lspconfig server and
      -- call the setup function with an empty table.
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
    config = function()
      require("mason-nvim-lint").setup({
        ensure_installed = {
          "beautysh",
          "clang_format",
          "astyle",
          "uncrustify",
          "codespell",
          "cpp_format",
          "cpplint",
          "gitlint",
          "luacheck",
          "ruff",
          "selene",
          "shellcheck",
          "shfmt",
          "vale",
          "hadolint",
          "commitlint",
          "cspell",
          "mypy",
          "goimports",
          "gofmt",
          "gofumpt",
          "golines",
          "write-good",
          "dotenv_lint",
        },
        automatic_installation = true,
      })
    end,
  }, --}}}
  {
    "mfussenegger/nvim-lint", --{{{
    -- events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    -- event = { "VimEnter" },
    event = { "BufReadPre", "BufNewFile" },
    -- event = "InsertEnter",
    -- config = true,
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        sh = { "shellcheck", "codespell" },
        bash = { "shellcheck", "codespell" },
        zsh = { "shellcheck", "zsh", "codespell" },
        ini = { "shellcheck", "shfmt", "codespell" },
        ["yaml.ansible"] = { "ansible_lint" },
        dotenv = { "dotenv_lint" },
        dockerfile = { "hadolint", "codespell" },
        ghaction = { "actionlint" },
        git = { "gitlint", "cspell", "codespell" },
        gitcommit = { "gitlint", "commitlint", "codespell", "cspell" },
        htmldjango = { "curlylint" },
        java = { "codespell" },
        javascript = { "eslint_d" },
        lua = { "luacheck", "codespell" },
        markdown = { "markdownlint", "value", "write-good", "codespell" },
        powershell = { "codespell" },
        python = { "ruff", "mypy", "codespell" },
        rst = { "vale" },
        c = { "clang_format", "cpplint", "codespell" },
        cpp = { "clang_format", "cpplint", "codespell" },
        arduino = { "clang_format", "cpplint", "codespell" },
        rust = { "clippy", "codespell" },
        typescript = { "eslint_d", "codespell" },
        typescriptreact = { "eslint_d", "codespell" },
        yaml = { "yamllint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
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
        python = { "ruff_format", "ruff_fix" },
        zsh = { "shfmt", "beautysh", "shellcheck" },
        arduino = { "clang_format", "astyle", "uncrustify" },
        c = { "clang_format", "astyle", "uncrustify" },
        cpp = { "clang_format", "astyle", "uncrustify" },
        cmake = { "cmake_format" },
        go = { "goimports", "gofmt", "gofumpt", "golines" },
        rust = { "rustfmt" },
        ruby = { "rufo" },
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
    event = "VimEnter",
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
        "powershell_es",
        "pyright",
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
    end,
  },
}
