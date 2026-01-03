return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      numbers = function()
        return ""
      end, -- no numbers
      close_command = nil,
      right_mouse_command = nil,
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = false,
      indicator = { icon = "", style = "none" },
      separator_style = { "", "" },
      enforce_regular_tabs = false,
      always_show_bufferline = false,
      max_name_length = 30,
      tab_size = 21,
      offsets = {
        {
          filetype = "NvimTree",
          text = "",
          text_align = "center",
          padding = 1,
          separator = false,
        },
      },
    },
    highlights = {
      fill = {
        fg = "none",
        bg = "none", -- Transparent background for the whole bar
      },
      background = {
        bg = "none", -- Transparent background for inactive tabs
      },
      -- Ensure other visible elements also use the transparent background
      buffer_visible = { bg = "none" },
      separator = { bg = "none", fg = "none" },
      separator_selected = { bg = "none", fg = "none" },
      separator_visible = { bg = "none", fg = "none" },
    },
  },
}
