return {
  {
    "machakann/vim-sandwich", --{{{
    event = { "VeryLazy" },
    init = function()
      vim.g.operator_sandwich_no_default_key_mappings = 1
      vim.g.textobj_sandwich_no_default_key_mappings = 1
      vim.g.sandwich_no_default_key_mappings = 1
    end,
    config = function() --{{{
      vim.g["sandwich#recipes"] = vim.list_extend(vim.deepcopy(vim.g["sandwich#default_recipes"]), {
        {
          buns = { "{", "}" },
          input = { "B" },
        },
        {
          buns = { "(", ")" },
          input = { "b" },
        },
        {
          buns = { "{{", "}}" },
          input = { "BB" },
        },
        {
          buns = { "--{{{", "--}}}" },
          input = { "m" },
          filetype = { "lua" },
        },
        {
          buns = { "((", "))" },
          input = { "bb" },
        },
        {
          buns = { "'", "'" },
          input = { "," },
        },
        {
          buns = { '"', '"' },
          input = { "." },
        },
        {
          buns = { "[", "]" },
          input = { ">" },
        },
        {
          buns = { "<", ">" },
          input = { "<" },
        },
        {
          buns = { "# fmt: off", "# fmt: on" },
          input = { "z" },
          filetype = { "python" },
          nesting = 0,
          linewise = 1,
        },
        {
          buns = { "# --{{{", "#--}}}" },
          input = { "m" },
          filetype = { "python" },
        },
      })
    end, --}}}
    keys = {
      { --{{{
        "w",
        "<Plug>(operator-sandwich-add)",
        desc = "substitute",
        mode = { "n", "x" },
      },
      {
        "W",
        "<Plug>(operator-sandwich-add)<Plug>(operator-sandwich-synchro-count)",
        desc = "substitute",
        mode = { "n" },
      },
      {
        "wd",
        "<Plug>operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
        desc = "substitute",
        mode = "n",
      },
      {
        "Wd",
        "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
        desc = "substitute",
        mode = "n",
      },
      {
        "wr",
        "<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-auto-a)",
        desc = "substitute",
        mode = "n",
      },
      {
        "Wr",
        "<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)",
        desc = "substitute",
        mode = "n",
      },
      {
        "w",
        "<Plug>(textobj-sandwich-auto-i)",
        desc = "substitute",
        mode = "o",
      },
      {
        "W",
        "<Plug>(textobj-sandwich-query-i)",
        desc = "substitute",
        mode = "o",
      },
      {
        "sw",
        "<Plug>(textobj-sandwich-auto-i)",
        desc = "substitute",
        mode = "o",
      },
      {
        "sW",
        "<Plug>(textobj-sandwich-query-i)",
        desc = "substitute",
        mode = "o",
      },
      {
        "tw",
        "<Plug>(textobj-sandwich-auto-a)",
        desc = "substitute",
        mode = "o",
      },
      {
        "tW",
        "<Plug>(textobj-sandwich-query-a)",
        desc = "substitute",
        mode = "o",
      },
    }, --}}}
  }, --}}}
}