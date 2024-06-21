return {
  {
    "haya14busa/vim-edgemotion", --{{{
    keys = {
      {
        "N",
        "<Plug>(edgemotion-j)",
        desc = "edgemotion",
        mode = { "n", "x", "o" },
      },
      {
        "E",
        "<Plug>(edgemotion-k)",
        desc = "edgemotion",
        mode = { "n", "x", "o" },
      },
    },
  }, --}}}
  {
    "dstein64/nvim-scrollview", --{{{
    event = "VeryLazy",
    config = function()
      require("scrollview").setup({
        excluded_filetypes = { "nerdtree" },
        current_only = true,
        base = "buffer",
        -- column = 135,
        -- column = 'colorcolumn',
        scrollview_base = "right",
        scrollview_mode = "auto",
        signs_on_startup = { "all" },
        diagnostics_severities = { vim.diagnostic.severity.ERROR },
      })
    end,
  }, --}}}
  {
    "karb94/neoscroll.nvim", --{{{
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({
        mappings = {},
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
      })
      local t = {}
      t["<Leader><CR>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
      t["<S-CR>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
      t["<CR>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
      t["<C-CR>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
      -- t["mu"] = { "scroll", { "-0.50", "false", "100" } }
      -- t["my"] = { "scroll", { "0.50", "false", "100" } }
      require("neoscroll.config").set_mappings(t)
    end,
  }, --}}}
  -- { # I use Alt for window move key.
  --   "fedepujol/move.nvim", --{{{
  --   event = { "BufRead", "BufNewFile" },
  --   keys = {
  --     {
  --       "<A-n>",
  --       "<CMD>MoveLine(1)<CR>",
  --       desc = "Aove",
  --       mode = "n",
  --     },
  --     {
  --       "<A-e>",
  --       "<CMD>MoveLine(-1)<CR>",
  --       desc = "Aove",
  --       mode = "n",
  --     },
  --     {
  --       "<A-i>",
  --       "<CMD>MoveChar(1)<CR>",
  --       desc = "Aove",
  --       mode = "n",
  --     },
  --     {
  --       "<A-h>",
  --       "<CMD>MoveChar(-1)<CR>",
  --       desc = "Aove",
  --       mode = "n",
  --     },
  --     {
  --       "<A-n>",
  --       "<CMD>MoveBlock(1)<CR>",
  --       desc = "Aove",
  --       mode = "v",
  --     },
  --     {
  --       "<A-e>",
  --       "<CMD>MoveBlock(-1)<CR>",
  --       desc = "Aove",
  --       mode = "v",
  --     },
  --     {
  --       "<A-i>",
  --       "<CMD>MoveHBlock(1)<CR>",
  --       desc = "Aove",
  --       mode = "v",
  --     },
  --     {
  --       "<A-h>",
  --       "<CMD>MoveHBlock(-1)<CR>",
  --       desc = "Aove",
  --       mode = "v",
  --     },
  --   },
  -- }, --}}}
}
