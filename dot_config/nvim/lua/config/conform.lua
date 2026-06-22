local conform = require "conform"

conform.setup {
  async = true,

  formatters_by_ft = {
    cs = { "csharpier_trema" },
    csproj = { "csharpier_trema" },
    xml = { "avalonia_lsp" },
    c3 = { "c3fmt" },
  },

  formatters = {
    csharpier_trema = {
      command = "csharpier",
      args = { "format", "--write-stdout" },
      to_stdin = true,
    },

    c3fmt = {
      format = function(_, ctx)
        local file = ctx.filename

        vim.fn.system {
          "c3fmt",
          "--in-place",
          file,
        }

        return {
          bufnr = ctx.buf,
          timeout_ms = 2000,
        }
      end,
    },

    -- xstyler as Lua function
    xstyler = {
      format = function(bufnr)
        local file = vim.api.nvim_buf_get_name(bufnr)
        vim.fn.system { "xstyler", "-f", file }
        vim.cmd "edit" -- reload buffer
      end,
    },

    -- Avalonia LSP via Lua function
    avalonia_lsp = {
      format = function(opts)
        local bufnr = opts.bufnr
        vim.lsp.buf.format { bufnr = bufnr, async = true }
      end,
    },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = false,
  },
}
