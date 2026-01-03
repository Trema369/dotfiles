local func = require("vim.func")
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      --cappabilities for autocompletion
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- lua/configs/lspconfig.lua

      -- ROSLYN (+razor support)
      local mason_root = require("mason.settings").current.install_root_dir
      vim.lsp.config("roslyn", {
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })
      vim.lsp.config("html", {
        capabilities = capabilities,
        on_attach = function(client)
          -- Disable LSP formatting, let Prettier handle HTML formatting
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      vim.lsp.config("glslx", {
        cmd = { "glslx", "--stdio" }, -- make sure glslx is in your PATH
        filetypes = { "glsl", "vert", "frag", "comp", "geom", "tesc", "tese", "glslx" },
        root_dir = function(fname)
          return vim.fs.find(".git", { upward = true, path = fname })[1] or vim.fn.getcwd()
        end,
        capabilities = capabilities, -- optional, from nvim-cmp
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })
      vim.lsp.config("avalonia_ls", {
        default_config = {
          cmd = { "avalonia-ls" },        -- path to Avalonia LSP executable
          filetypes = { "xml", "axaml" }, -- XML/XAML files
          root_dir = vim.fs.dirname,      -- uses the file's directory as root
          settings = {},                  -- Avalonia LSP usually needs no special settings
          single_file_support = true,
        },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Optional: disable formatting if you want to use Prettier or CSharpier
          client.server_capabilities.documentFormattingProvider = true

          -- Optional: keymaps for LSP actions
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        end,
      })

      --lua lsp configuration
      vim.lsp.config("lua_ls", {
        filetypes = { "lua" },
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.api.nvim_get_runtime_file("", true),
                vim.fn.stdpath("config"),
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      --diagnostics

      --Auto-formating on save
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          if
              not client:supports_method("textDocument/willSaveWaitUntil")
              and client:supports_method("textDocument/formatting")
          then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  },
}
