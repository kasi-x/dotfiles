return {
  {
  "machakann/vim-sandwich",
  event = {"BufRead", "BufNewFile"},
  init = function()
      vim.g.operator_sandwich_no_default_key_mappings = 1
      vim.g.textobj_sandwich_no_default_key_mappings = 1
      vim.g.sandwich_no_default_key_mappings = 1
  end,
  config = function()
      vim.g["sandwich#recipes"] = vim.list_extend(vim.deepcopy(vim.g["sandwich#default_recipes"]), {{
          buns = {"（", "）"},
          input = {"b"}
      }, {
          buns = {"（", "）"},
          input = {"("}
      }, {
          buns = {"（", "）"},
          input = {"8"}
      }, {
          buns = {"（", "）"},
          input = {"9"}
      }, {
          buns = {"［", "］"},
          input = {"["}
      }, {
          buns = {"［", "］"},
          input = {"B"}
      }, {
          buns = {"｛", "｝"},
          input = {"{"}
      }, {
          buns = {"＜", "＞"},
          input = {"<"}
      }, {
          buns = {"＜", "＞"},
          input = {">"}
      }, {
          buns = {"＜", "＞"},
          input = {"a"}
      }, {
          buns = {"≪", "≫"},
          input = {"A"}
      }, {
          buns = {"「", "」"},
          input = {"k"}
      }, {
          buns = {"『", "』"},
          input = {"K"}
      }, {
          buns = {"〈", "〉"},
          input = {"y"}
      }, {
          buns = {"《", "》"},
          input = {"Y"}
      }, {
          buns = {"【", "】"},
          input = {"r"}
      }, {
          buns = {"【", "】"},
          input = {"s"}
      }, {
          buns = {"〔", "〕"},
          input = {"t"}
      }, {
          buns = {"{", "}"},
          input = {"B"}
      }, {
          buns = {"(", ")"},
          input = {"b"}
      }, {
          buns = {"{{", "}}"},
          input = {"BB"}
      }, {
          buns = {"((", "))"},
          input = {"bb"}
      }, {
          buns = {"'", "'"},
          input = {","}
      }, {
          buns = {'"', '"'},
          input = {"."}
      }, {
          buns = {"[", "]"},
          input = {">"}
      }, {
          buns = {"<", ">"},
          input = {"<"}
      }})
  end,
  keys = {{
      "w",
      "<Plug>(operator-sandwich-add)",
      desc = "substitue",
      mode = {"n", "x"}
  }, {
      "W",
      "<Plug>(operator-sandwich-add)<Plug>(operator-sandwich-synchro-count)",
      desc = "substitue",
      mode = {"n", "x"}
  }, {
      "wd",
      "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
      desc = "substitue",
      mode = "n"
  }, {
      "Wd",
      "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
      desc = "substitue",
      mode = "n"
  }, {
      "wr",
      "<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-auto-a)",
      desc = "substitue",
      mode = "n"
  }, {
      "Wr",
      "<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)",
      desc = "substitue",
      mode = "n"
  }, {
      "w",
      "<Plug>(textobj-sandwich-auto-i)",
      desc = "substitue",
      mode = "o"
  }, {
      "W",
      "<Plug>(textobj-sandwich-query-i)",
      desc = "substitue",
      mode = "o"
  }, {
      "sw",
      "<Plug>(textobj-sandwich-auto-i)",
      desc = "substitue",
      mode = "o"
  }, {
      "sW",
      "<Plug>(textobj-sandwich-query-i)",
      desc = "substitue",
      mode = "o"
  }, {
      "tw",
      "<Plug>(textobj-sandwich-auto-a)",
      desc = "substitue",
      mode = "o"
  }, {
      "tW",
      "<Plug>(textobj-sandwich-query-a)",
      desc = "substitue",
      mode = "o"
  }}
  }
}
