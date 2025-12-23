require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = "", -- IMPORTANT: remove inner separators
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },

  sections = {
    -- LEFT ROUND EDGE
    lualine_a = {
      { "", separator = { left = "" }, right_padding = 2 },
      "mode",

    },

    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },

    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },

    -- RIGHT ROUND EDGE
    lualine_z = {
      "location",
      { "", separator = { right = "" } },
    },
  },

  inactive_sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" },
  },
})
