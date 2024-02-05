vim.g.completeopt = "menu,menuone,noselect"
local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local has_words_before = function()
  local unpack = unpack or table.unpack ---@diagnostic disable-line: deprecated
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  formatting = {
    -- fields = {'abbr', 'kind', 'menu'},
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        skkeleton = "[SKK]",
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        cmp_tabnine = "[TabNine]",
        copilot = "[Copilot]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[NeovimLua]",
        latex_symbols = "[LaTeX]",
        path = "[Path]",
        omni = "[Omni]",
        spell = "[Spell]",
        emoji = "[Emoji]",
        calc = "[Calc]",
        rg = "[Rg]",
        treesitter = "[TS]",
        dictionary = "[Dictionary]",
        mocword = "[mocword]",
        cmdline = "[Cmd]",
        cmdline_history = "[History]",
        Codeium = "[Codium]",
      },
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require("cmp-under-comparator").under,
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
        local kind2 = entry2:get_kind()
        kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
        if kind1 ~= kind2 then
          if kind1 == types.lsp.CompletionItemKind.Snippet then
            return false
          end
          if kind2 == types.lsp.CompletionItemKind.Snippet then
            return true
          end
          local diff = kind1 - kind2
          if diff < 0 then
            return true
          elseif diff > 0 then
            return false
          end
        end
      end,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  mapping = {
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-p>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ---@diagnostic disable-next-line: unused-local
    ["<C-e>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({
          behavior = cmp.SelectBehavior.Select,
        })
      else
        vim.api.nvim_feedkeys(t("<Up>"), "n", true)
      end
    end, { "i", "s" }),
    -- selene: allow(unused_variable)
    ---@diagnostic disable-next-line: unused-local
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({
          behavior = cmp.SelectBehavior.Select,
        })
      else
        vim.api.nvim_feedkeys(t("<Down>"), "n", true)
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        cmp.complete()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-i>"] = cmp.mapping(function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.mapping(cmp.mapping.complete(), { "i", "c" })
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", true)
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.mapping(cmp.mapping.close(), { "i", "c" })
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", true)
      end
    end, { "i", "s" }),
    ["<C-cr>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-q>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      select = false,
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  cmdline = {
    [":"] = {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    },
  },
  sources = cmp.config.sources({
    { name = "skkeleton", priority = 200 },
    -- { name = "jupynium", priority = 1000 },
    { name = "copilot", priority = 90 },
    { name = "codeium", priority = 84 },
    {
      name = "luasnip",
      option = { use_show_condition = false, show_autosnippets = true },
      priority = 85,
    },
    { name = "nvim_lsp", priority = 100 },
    { name = "cmp_tabnine", priority = 30 },
    { name = "path", priority = 100 },
    {
      name = "emoji",
      insert = true,
      priority = 60,
    },
    { name = "nvim_lua", priority = 50 },
    { name = "nvim_lsp_signature_help", priority = 80 },
    { name = "buffer", priority = 50 },
    -- slow
    -- { name = "omni", priority = 40 },
    { name = "spell", priority = 40 },
    { name = "calc", priority = 50 },
    { name = "treesitter", priority = 30 },
    {
      name = "dictionary",
      keyword_length = 2,
      priority = 10,
    },
  }),
})

cmp.setup.filetype({ "gitcommit", "markdown" }, {
  sources = cmp.config.sources({
    {
      name = "copilot",
      priority = 90,
    },
    {
      name = "nvim_lsp",
      priority = 100,
    },
    {
      name = "cmp_tabnine",
      priority = 30,
    },
    {
      name = "luasnip",
      priority = 80,
    },
    {
      name = "rg",
      priority = 70,
    },
    {
      name = "path",
      priority = 100,
    },
    {
      name = "emoji",
      insert = true,
      priority = 60,
    },
  }, {
    {
      name = "buffer",
      priority = 50,
    }, -- { name = "omni", priority = 40 },
    {
      name = "spell",
      priority = 40,
    },
    {
      name = "calc",
      priority = 50,
    },
    {
      name = "treesitter",
      priority = 30,
    },
    {
      name = "mocword",
      priority = 60,
    },
    {
      name = "dictionary",
      keyword_length = 2,
      priority = 10,
    },
  }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    {
      name = "nvim_lsp_document_symbol",
    },
    {
      name = "cmdline_history",
    },
    {
      name = "buffer",
    },
  }, {}),
})

cmp.setup.cmdline(":", {
  mapping = {
    ["<C-n>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, true, true), "n", false)
      end
    end, { "c" }),
    ["<C-e>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", false)
      end
    end, { "c" }),
    ["<C-u>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, true, true), "n", false)
      end
    end, { "c" }),
    ["<C-y>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n", false)
      end
    end, { "c" }),
    ["<C-h>"] = cmp.mapping(function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Home>", true, true, true), "n")
    end, { "c" }),
    ["<C-i>"] = cmp.mapping(function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<End>", true, true, true), "n")
    end, { "c" }),
    -- ["<C-y>"] = {
    --   c = cmp.mapping.confirm({
    --       select = false
    --   })
    -- },
    ["<C-q>"] = {
      c = cmp.mapping.abort(),
    },
  },
  sources = cmp.config.sources(
    { {
      name = "path",
    } },
    { {
      name = "cmdline",
    }, { {
      name = "cmdline_history",
    } } }
  ),
})
