return {
  -- Tiny Inline Diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Stays VeryLazy to keep startup snappy
    enabled = true,
    priority = 1000,
    config = function()
      -- Disable default virtual text so tiny-inline can take over
      vim.diagnostic.config { virtual_text = false }
      require("tiny-inline-diagnostic").setup {}
    end,
  },

  -- Tiny Code Actions
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    -- Load only when an LSP attaches to a buffer
    event = "LspAttach",
    opts = {
      backend = "vim",
      picker = "telescope",
      resolve_timeout = 100,
      notify = {
        enabled = true,
        on_empty = true,
      },
      signs = {
        quickfix = { "", { link = "DiagnosticWarning" } },
        others = { "", { link = "DiagnosticWarning" } },
        refactor = { "", { link = "DiagnosticInfo" } },
        ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
        ["refactor.extract"] = { "", { link = "DiagnosticError" } },
        ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
        ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
        ["source"] = { "", { link = "DiagnosticError" } },
        ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
        ["codeAction"] = { "", { link = "DiagnosticWarning" } },
      },
      -- Keeping your backend_opts for Delta/Difftastic
      backend_opts = {
        delta = {
          header_lines_to_remove = 4,
          args = { "--line-numbers" },
        },
        difftastic = {
          header_lines_to_remove = 1,
          args = { "--color=always", "--display=inline", "--syntax-highlight=on" },
        },
        diffsofancy = {
          header_lines_to_remove = 4,
        },
      },
    },
  },
}
