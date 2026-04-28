local mason = vim.fn.stdpath("data") .. "/mason"
local rzls = mason .. "/packages/roslyn/libexec/.razorExtension"

return {
  cmd = (function()
    return {
      "roslyn",
      "--stdio",
      "--logLevel=Information",
      "--extensionLogDirectory=" .. vim.fn.stdpath("log"),
      "--razorSourceGenerator=" .. rzls .. "/Microsoft.CodeAnalysis.Razor.Compiler.dll",
      "--razorDesignTimePath=" .. rzls .. "/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets",
      "--extension=" .. rzls .. "/Microsoft.VisualStudioCode.RazorExtension.dll",
    }
  end)(),

  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_parameters = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },

  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
}
