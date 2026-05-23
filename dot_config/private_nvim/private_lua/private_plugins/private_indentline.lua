return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      -- indent guides
      indent = {
        enable = true,
        chars = { "│" },
        style = {
          vim.api.nvim_get_hl(0, { name = "Whitespace" }),
        },
      },

      -- highlights the current block (THIS is the LazyVim-like part)
      chunk = {
        enable = true,
        style = {
          { fg = "#7aa2f7" }, -- subtle blue (change if needed)
        },
      },

      -- shows a line at the start/end of blocks
      line_num = {
        enable = false, -- turn on if you want scope markers
      },

      -- blank line handling
      blank = {
        enable = false,
      },
    })
  end,
}
