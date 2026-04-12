---@type vim.lsp.Config
return {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", "CMakeLists.txt", ".git" },
  on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
  settings = {
    clangd = {
      InlayHints = {
        Enabled = true,
        DeducedTypes = true,
        ParameterNames = true,
        Designators = true,
      },
    },
  },
}
