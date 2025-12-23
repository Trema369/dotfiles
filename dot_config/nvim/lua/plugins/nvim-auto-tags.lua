return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "handlebars",
    "html",
    "vue",
    "xml"
  },
  ---@module "nvim-ts-autotag"
  ---@class nvim-ts-autotag.PluginSetup
  opts = {
    aliases = {
      axaml = "xml",
      xaml = "xml",
    },
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
    filetypes = { -- modern replacement for per_filetype
      html = { enable_close = false },
    },
  },
}
