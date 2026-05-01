return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy", -- Delay the disk-heavy scanning
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      -- Optional: Run your ensure_installed logic here if you
      -- prefer it handled by a custom function
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "pyright",
        "rust_analyzer",
        "eslint",
        "ts_ls",
        "jsonls",
        "gopls",
        "roslyn",
      },
    },
  },
}
