return {
  -- lua/plugins/init.lua

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "config.conform"
    end,
  }
}
