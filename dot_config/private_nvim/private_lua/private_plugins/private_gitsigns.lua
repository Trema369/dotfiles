return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "━" },
    topdelete    = { text = "━" },
    changedelete = { text = "┃" },
    untracked    = { text = "┃" },
  },
  signs_staged = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "━" },
    topdelete    = { text = "━" },
    changedelete = { text = "┃" },
  },
})

    vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
  end,
}
