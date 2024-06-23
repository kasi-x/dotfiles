return {
  {
    "jsborjesson/vim-uppercase-sql",
    ft = { "sql" },
  },
  {
    "itchyny/vim-highlighturl",
    event = { "BufRead", "BufNewFile" },
  },
  {
    "MTDL9/vim-log-highlighting",
    ft = "log",
  },
  {
    "vim-denops/denops.vim",
    dependencies = {
      {
        "yuki-yano/denops-lazy.nvim",
        opts = {
          wait_load = false,
        },
      },
    },
    event = { "VeryLazy" },
    priority = 1000,
  },
  -- {
  --   "vim-denops/denops.vim",
  --   lazy = false,
  -- },
  -- { "yuki-yano/denops-lazy.nvim" },
}
