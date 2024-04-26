return {
  {
    "SWiegandt/autoself.nvim",
    ft = "python",
    config = true,
  },
  {
    "chrisgrieser/nvim-puppeteer",
    ft = "python",
  },
  {
    "tmhedberg/SimpylFold",
    ft = "python",
  },
  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
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
