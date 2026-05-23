return {
  {
    "L3MON4D3/LuaSnip",
    -- Load only when typing starts
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      -- Load snippets only when the plugin wakes up
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
