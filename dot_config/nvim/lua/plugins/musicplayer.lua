return {
  {
    "tamton-aquib/mpv.nvim",
    config = function()
      require("mpv").setup({
        width = 50,
        height = 5,
        border = "single",
        setup_widgets = true, -- enables statusline/tabline components
        timer = {
          after = 1000,
          throttle = 250,
        },
      })
    end,
  },
}
