return {
  {
    "phaazon/hop.nvim", --{{{
    event = "VeryLazy",
    branch = "v2",
    config = function()
      require("hop").setup({
        keys = "heniarstd,./muyl;j[xcvzbkqwfpg",
        case_insensitive = false,
      })
    end,
    keys = {
      { --{{{
        "ww",
        "<cmd>HopWord<cr>",
        desc = "Hop to word",
        mode = "n",
      },
      {
        "<leader>w",
        "<cmd>HopLine<cr>",
        desc = "Hop to word (multi-window)",
        mode = "n",
      },
      {
        "<c-p>",
        "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>",
        desc = "Hop to start of line",
        mode = { "n", "x", "o" },
      },
      {
        "<c-f>",
        "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",
        desc = "Hop to start of line",
        mode = { "n", "x", "o" },
      },
      {
        "<C-u>",
        "<cmd>lua require'hop'.hint_words({ current_line_only = true })<cr>",
        desc = "Hop to word with offset at end",
        mode = { "n", "x", "o" },
      },
      {
        "<C-y>",
        "<cmd>lua require'hop'.hint_words({ current_line_only = true, hint_position = require'hop.hint'.HintPosition.END })<cr>",
        desc = "Hop to word with offset at end",
        mode = { "n", "x", "o" },
      },
      {
        "<c-n>",
        "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",
        desc = "Hop to start of line",
        mode = { "n", "x", "o" },
      },
      {
        "<c-e>",
        "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>",
        desc = "Hop to start of line",
        mode = { "n", "x", "o" },
      },
      {
        "w,",
        "<cmd>HopPattern<cr>",
        desc = "Hop to pattern",
        mode = "n",
      }, -- { 'wh', '<cmd>HopPatternMW<cr>', desc = 'Hop to pattern (multi-window)', mode = 'n' },
      {
        "wn",
        "<cmd>HopChar1<cr>",
        desc = "Hop to single character",
        mode = "n",
      },
      {
        "we",
        "<cmd>HopChar2<cr>",
        desc = "Hop to single character",
        mode = "n",
      }, -- { 'wn', '<cmd>HopChar1MW<cr>', desc = 'Hop to single character (multi-window)', mode = 'n' },
      {
        "f",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
        desc = "Hop to character after cursor on current line",
        mode = { "n", "x", "o" },
      },
      {
        "p",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true,  hint_offset = -1 })<cr>",
        desc = "Hop to character before cursor on current line",
        mode = { "n", "x", "o" },
      },
      {
        "P",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
        desc = "Hop to character before cursor on current line",
        mode = { "n", "x", "o" },
      },
      {
        "F",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
        desc = "Hop to character after cursor on current line",
        mode = { "n", "x", "o" },
      },
      {
        "g,",
        "<cmd>lua require'hop'.hint_patterns()<cr>",
        desc = "search last",
        mode = "n",
      },
    }, --}}}
  }, --}}}
  {
    "anuvyklack/pretty-fold.nvim", --{{{
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("pretty-fold").setup({
        global = { "{{{", "}}}" },
      })
    end,
  }, --}}}
  {
    "chrisgrieser/nvim-spider", --{{{
    event = { "BufRead", "BufNewFile" },
    keys = {
      { --{{{
        "i",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "x", "o" },
      },
      {
        "I",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "x", "o" },
      },
      {
        "h",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "x", "o" },
      },
      {
        "H",
        "<cmd>lua require('spider').motion('ge')<CR>",
        mode = { "n", "x", "o" },
      },
    }, --}}}
  }, --}}}
}
