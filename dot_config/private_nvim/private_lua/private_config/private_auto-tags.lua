require("nvim-ts-autotag").setup({
  opts = {
    aliases = {
      ["axaml"] = "xml",
      ["xaml"] = "xml",
    },
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
})
