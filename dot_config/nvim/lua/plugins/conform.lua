-- ~/.config/nvim/lua/plugins/conform.lua
return {
  {
    "stevearc/conform.nvim",
    opts = {
      quiet = true,

      -- Map filetypes to formatters
      formatters_by_ft = {
        -- Web
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        axaml = { "avalonials" },
        xml = { "avalonials" },
        go = { "gofumpt" },

        -- C# & XML
        cs = { "csharpier_trema" },
        csproj = { "csharpier_trema" },

        -- XAML via AvaloniaLS (LSP handles formatting)

        markdown = { "prettier" },
        yaml = { "prettier" },
        ["_"] = { "trim_whitespace" },
      },

      -- Define formatters
      formatters = {
        -- CSharpier
        csharpier_trema = {
          command = "csharpier",
          args = { "format", "--write-stdout" },
          to_stdin = true,
        },
        avalonials = {
          command = "xaml-styler", -- the CLI that AvaloniaLS uses internally
          args = { "--write-to-stdout", "--take-pipe" },
          to_stdin = true,         -- sends buffer contents to CLI
        },

        -- Prettier
        prettier = {
          command = "prettier",
          args = function()
            return {
              "--stdin-filepath",
              "$FILENAME",
              "--no-semi",
              "--single-quote",
              "--no-bracket-spacing",
              "--print-width",
              "80",
              "--html-whitespace-sensitivity",
              "ignore",
              "--config-precedence",
              "prefer-file",
            }
          end,
          to_stdin = true,
        },
      },

      -- Format on save logic
      format_on_save = function(bufnr)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = false } -- Prettier/CSharpier handles formatting
      end,
    },
  },
}
