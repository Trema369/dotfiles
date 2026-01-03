local ls = require("luasnip")

-- Load Friendly Snippets (VSCode style)
require("luasnip.loaders.from_vscode").lazy_load()

-- Load your custom Lua snippets
require("luasnip.loaders.from_lua").lazy_load({
  paths = vim.fn.stdpath("config") .. "/lua/snippets",
})
