return {
  "nvim-lua/plenary.nvim",
  {
    "monaqa/dial.nvim", --{{{
    dependencies = "plenary.nvim",
    event = { "BufRead", "BufNewFile" },
    keys = {
      {
        "<C-z>",
        "<Plug>(dial-increment)",
        desc = "increment",
        mode = { "n", "x" },
      },
      {
        "<C-x>",
        "<Plug>(dial-decrement)",
        desc = "decrement",
        mode = { "n", "x" },
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.constant.alias.bool,
          augend.constant.alias.ja_weekday,
          augend.constant.alias.ja_weekday_full,
          augend.date.alias["%H:%M"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y年%-m月%-d日"],
          augend.date.alias["%Y年%-m月%-d日(%ja)"],
          augend.date.alias["%m/%d"],
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.semver.alias.semver,
        },
      })
    end,
  }, --}}}
  {
    "gbprod/substitute.nvim", --{{{
    keys = {
      {
        "R",
        "<cmd>lua require('substitute').operator()<cr>",
        desc = "substitute",
        mode = { "n", "o", "x" },
      },
      {
        "mr",
        "<cmd>lua require('substitute').line()<cr>",
        desc = "substitute",
        mode = "n",
      },
    },
    config = function()
      require("substitute").setup()
    end,
  }, --}}}
  {
    "numToStr/Comment.nvim", --{{{
    config = function()
      require("Comment").setup({
        {
          padding = true,
          sticky = true,
          opleader = {
            line = "l",
            block = "<C-l>",
          },
          extra = {
            above = "le",
            below = "ln",
            eol = "li",
          },
          mappings = {
            basic = true,
            extra = false,
          },
          pre_hook = nil,
          post_hook = nil,
          ignore = "^$",
          toggler = {
            line = "ll",
            block = "lL",
          },
        },
      })
    end,
    keys = {
      {
        "ll",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc = "toggle comment",
        mode = "n",
      },
      {
        "lb",
        function()
          require("Comment.api").toggle.blockwise.current()
        end,
        desc = "toggle comment",
        mode = "n",
      },
      {
        "li", --
        function()
          require("Comment.api").insert.linewise.eol()
        end,
        desc = "toggle comment",
        mode = "n",
      },
      {
        "ln",
        function()
          require("Comment.api").insert.linewise.below()
        end,
        desc = "toggle comment",
        mode = "n",
      },
      {
        "le",
        function()
          require("Comment.api").insert.linewise.above()
        end,
        desc = "toggle comment",
        mode = "n",
      },
      {
        "lB",
        function()
          require("Comment.api").insert.blockwise.eol()
        end,
        desc = "toggle comment",
        mode = "n",
      },
      {
        "lN",
        function()
          require("Comment.api").insert.blockwise.below()
        end,
        desc = "toggle comment",
        mode = "n",
      },
      {
        "lE",
        function()
          require("Comment.api").insert.blockwise.above()
        end,
        desc = "toggle comment",
        mode = "n",
      },
      {
        "l",
        "<Plug>(comment_toggle_linewise_visual)",
        desc = "commet_toggle",
        mode = "x",
      },
      {
        "L",
        "<Plug>(comment_toggle_blockwise_visual)",
        desc = "commet_toggle",
        mode = "x",
      },
    },
  }, --}}}
  {
    "LudoPinelli/comment-box.nvim", --{{{
    keys = {
      {
        "<leader>l",
        "<Cmd>lua require('comment-box').lbox()<CR>",
        desc = "left aligned fixed size box with left aligned text",
        mode = { "n", "v" },
      },
      {
        "<leader>L",
        "<Cmd>lua require('comment-box').cbox()<CR>",
        desc = "centered adapted box with centered text",
        mode = { "n", "v" },
      },
    },
  }, --}}}
}
