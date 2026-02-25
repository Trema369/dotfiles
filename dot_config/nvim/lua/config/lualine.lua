require("lualine").setup({
  options = {
    enabled = false,
    icons_enabled = true,
    theme = "auto",
    component_separators = "", -- no inner separators
    section_separators = "",   -- no fancy edges
    globalstatus = true,
  },

  sections = {
    -- LEFT: branch + diagnostics
    lualine_a = { "branch", "diagnostics" },

    -- CENTER: filename
    lualine_b = { { "filename", path = 1 } },

    -- RIGHT: line/column
    lualine_c = { "location" },

    -- unused sections
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },

  inactive_sections = {
    lualine_a = { "branch", "diagnostics" },
    lualine_b = { "filename" },
    lualine_c = { "location" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
