local conform = require("conform")

conform.setup({
  async = true,

  formatters_by_ft = {
    cs     = { "csharpier_trema" },
    csproj = { "csharpier_trema" },
    xml    = { "avalonia_lsp" },
  },

  formatters = {
    csharpier_trema = {
      command = "csharpier",
      args = { "format", "--write-stdout" },
      to_stdin = true,
    },

    -- xstyler as Lua function
    xstyler = {
      format = function(bufnr)
        local file = vim.api.nvim_buf_get_name(bufnr)
        vim.fn.system({ "xstyler", "-f", file })
        vim.cmd("edit") -- reload buffer
      end,
    },

    -- Avalonia LSP via Lua function
    avalonia_lsp = {
      format = function(opts)
        local bufnr = opts.bufnr
        vim.lsp.buf.format({ bufnr = bufnr, async = true })
      end,
    },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = false,
  },
})
