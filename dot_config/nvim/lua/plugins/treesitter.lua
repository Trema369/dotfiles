-- treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,
    },
  },
  config = function()
    local ts = require("nvim-treesitter")
    local parsers = {
      "bash",
      "comment",
      "css",
      "c_sharp",
      "diff",
      "dockerfile",
      "elixir",
      "git_config",
      "gitcommit",
      "gitignore",
      "groovy",
      "go",
      "heex",
      "hcl",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "lua",
      "make",
      "razor",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rst",
      "rust",
      "scss",
      "ssh_config",
      "sql",
      "terraform",
      "typst",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }

    for _, parser in ipairs(parsers) do
      ts.install(parser)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
