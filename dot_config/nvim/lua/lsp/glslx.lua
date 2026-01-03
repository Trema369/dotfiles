-- Start glslx LSP on opening shader files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.glsl", "*.vert", "*.frag", "*.comp", "*.geom", "*.tesc", "*.tese", "*.glslx" },
  callback = function(event)
    vim.lsp.start({
      name = "glslx",
      cmd = { "glslx", "--stdio" }, -- make sure glslx is in your PATH
      root_dir = vim.fs.find(".git", { upward = true, path = event.file })[1] or vim.fn.getcwd(),
    })
  end,
})

-- Filetype detection for shader files
vim.filetype.add({
  extension = {
    vert = "glsl",
    frag = "glsl",
    comp = "glsl",
    geom = "glsl",
    tesc = "glsl",
    tese = "glsl",
    glslx = "glsl",
  },
})
