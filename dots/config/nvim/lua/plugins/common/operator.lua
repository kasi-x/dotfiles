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
    event="VeryLazy",
  -- lazy = false,
    config = function()
      require("Comment").setup({
        {
          padding = false,
          sticky = false,
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
            basic = false,
            extra = false,
          },
          pre_hook = nil,
          post_hook = nil,
          ignore = "^$",
          toggler = {
            line = false,
            block = false,
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
        "lL",
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
        "lI",
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
    lazy = false,
    keys = {
      {
        "Lff",
        "<Cmd>CBllbox<CR>",
        desc = "Left box with Left text",
        mode = { "n" },
      },
      {
        "Lfw",
        "<Cmd>CBlcbox<CR>",
        desc = "Left box with Centered text",
        mode = { "n" },
      },
      {
        "Lpf",
        "<Cmd>CBlrbox<CR>",
        desc = "Left box with Right text",
        mode = { "n" },
      },
      {
        "Lwp",
        "<Cmd>CBclbox<CR>",
        desc = "Center box with Left text",
        mode = { "n" },
      },
      {
        "Lww",
        "<Cmd>CBlcbox<CR>",
        desc = "Center box with Centered text",
        mode = { "n" },
      },
      {
        "Lwf",
        "<Cmd>CBlrbox<CR>",
        desc = "Center box with Right text",
        mode = { "n" },
      },
      {
        "Lfp",
        "<Cmd>CBclbox<CR>",
        desc = "Right box with Left text",
        mode = { "n" },
      },
      {
        "Lfw",
        "<Cmd>CBlcbox<CR>",
        desc = "Right box with Centered text",
        mode = { "n" },
      },
      {
        "Lff",
        "<Cmd>CBlrbox<CR>",
        desc = "Right box with Right text",
        mode = { "n" },
      },
      {
        "Lap",
        "<Cmd>CBlabox<CR>",
        desc = "Left aligned adapted box",
        mode = { "n" },
      },
      {
        "Laf",
        "<Cmd>CBcabox<CR>",
        desc = "Center aligned adapted box",
        mode = { "n" },
      },
      {
        "Lap",
        "<Cmd>CBrabox<CR>",
        desc = "Right aligned adapted box",
        mode = { "n" },
      },
      {
        "Lrff",
        "<Cmd>CBllline<CR>",
        desc = "Left titled line with Left text",
        mode = { "n"},
      },
      {
        "Lrfw",
        "<Cmd>CBlcline<CR>",
        desc = "Left titled line with Centerd text",
        mode = { "n"},
      },
      {
        "Lrfp",
        "<Cmd>CBlrline<CR>",
        desc = "Left titled line with Right text",
        mode = { "n"},
      },
      {
        "Lrwf",
        "<Cmd>CBclline<CR>",
        desc = "Center titled line with Left text",
        mode = { "n"},
      },
      {
        "Lrww",
        "<Cmd>CBccline<CR>",
        desc = "Center titled line with Centerd text",
        mode = { "n"},
      },
      {
        "Lrwp",
        "<Cmd>CBcrline<CR>",
        desc = "Center titled line with Right text",
        mode = { "n"},
      },
      {
        "Lrpf",
        "<Cmd>CBrlline<CR>",
        desc = "Right titled line with Left text",
        mode = { "n"},
      },
      {
        "Lrpw",
        "<Cmd>CBrcline<CR>",
        desc = "Right titled line with Centerd text",
        mode = { "n"},
      },
      {
        "Lrpp",
        "<Cmd>CBrrline<CR>",
        desc = "Right titled line with Right text",
        mode = { "n" },
      },
      {
        "Ld",
        "<Cmd>CBd<CR>",
        desc = "Remove context",
        mode = { "n" },
      },
      {
        "<C-l>d",
        "<Cmd>CBd<CR>",
        desc = "Remove context",
        mode = { "v" },
      },
      {
        "<C-l>ff",
        "<Cmd>CBllbox<CR>",
        desc = "Left box with Left text",
        mode = { "v" },
      },
      {
        "<C-l>fw",
        "<Cmd>CBlcbox<CR>",
        desc = "Left box with Centered text",
        mode = { "v" },
      },
      {
        "<C-l>pf",
        "<Cmd>CBlrbox<CR>",
        desc = "Left box with Right text",
        mode = { "v" },
      },
      {
        "<C-l>wp",
        "<Cmd>CBclbox<CR>",
        desc = "Center box with Left text",
        mode = { "v" },
      },
      {
        "<C-l>ww",
        "<Cmd>CBlcbox<CR>",
        desc = "Center box with Centered text",
        mode = { "v" },
      },
      {
        "<C-l>wf",
        "<Cmd>CBlrbox<CR>",
        desc = "Center box with Right text",
        mode = { "v" },
      },
      {
        "<C-l>fp",
        "<Cmd>CBclbox<CR>",
        desc = "Right box with Left text",
        mode = { "v" },
      },
      {
        "<C-l>fw",
        "<Cmd>CBlcbox<CR>",
        desc = "Right box with Centered text",
        mode = { "v" },
      },
      {
        "<C-l>ff",
        "<Cmd>CBlrbox<CR>",
        desc = "Right box with Right text",
        mode = { "v" },
      },
      {
        "<C-l>ap",
        "<Cmd>CBlabox<CR>",
        desc = "Left aligned adapted box",
        mode = { "v" },
      },
      {
        "<C-l>af",
        "<Cmd>CBcabox<CR>",
        desc = "Center aligned adapted box",
        mode = { "v" },
      },
      {
        "<C-l>ap",
        "<Cmd>CBrabox<CR>",
        desc = "Right aligned adapted box",
        mode = { "v" },
      },
      {
        "<C-l>rff",
        "<Cmd>CBllline<CR>",
        desc = "Left titled line with Left text",
        mode = { "v"},
      },
      {
        "<C-l>rfw",
        "<Cmd>CBlcline<CR>",
        desc = "Left titled line with Centerd text",
        mode = { "v"},
      },
      {
        "<C-l>rfp",
        "<Cmd>CBlrline<CR>",
        desc = "Left titled line with Right text",
        mode = { "v"},
      },
      {
        "<C-l>rwf",
        "<Cmd>CBclline<CR>",
        desc = "Center titled line with Left text",
        mode = { "v"},
      },
      {
        "<C-l>rww",
        "<Cmd>CBccline<CR>",
        desc = "Center titled line with Centerd text",
        mode = { "v"},
      },
      {
        "<C-l>rwp",
        "<Cmd>CBcrline<CR>",
        desc = "Center titled line with Right text",
        mode = { "v"},
      },
      {
        "<C-l>rpf",
        "<Cmd>CBrlline<CR>",
        desc = "Right titled line with Left text",
        mode = { "v"},
      },
      {
        "<C-l>rpw",
        "<Cmd>CBrcline<CR>",
        desc = "Right titled line with Centerd text",
        mode = { "v"},
      },
      {
        "<C-l>rpp",
        "<Cmd>CBrrline<CR>",
        desc = "Right titled line with Right text",
        mode = { "v" },
      },
    },
  }, --}}}
}