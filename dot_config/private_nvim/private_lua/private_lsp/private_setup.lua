local M = {}

function M.setup()
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  local function merge(base, extra)
    return vim.tbl_deep_extend("force", base, extra or {})
  end

  -- TS
  local ts = merge(require "lsp.ts", {
    capabilities = capabilities,
    settings = {
      typescript = {
        referencesCodeLens = { enabled = true },
        implementationsCodeLens = { enabled = true },
      },
      javascript = {
        referencesCodeLens = { enabled = true },
        implementationsCodeLens = { enabled = true },
      },
    },
  })
  local original_on_attach = ts.on_attach
  ts.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    if original_on_attach then
      original_on_attach(client, bufnr)
    end
  end
  vim.lsp.config("ts_ls", ts)

  -- clangd
  vim.lsp.config(
    "clangd",
    merge(require "lsp.clangd", {
      capabilities = capabilities,
    })
  )
  vim.lsp.enable "clangd"
  vim.lsp.config("c3_lsp", {
    cmd = {
      "c3lsp",
      "--compiler-path",
      "/data/data/com.termux/files/home/c3/c3c",
      "--stdlib-path",
      "/data/data/com.termux/files/home/c3/lib/std",
      "--diagnostics-delay",
      "1000",
    },
    filetypes = { "c3", "c3i" },
    root_markers = { "project.json", ".git" },
    single_file_support = true,
    capabilities = capabilities,
  })
  vim.lsp.enable "c3_lsp"

  -- qmlls
  vim.lsp.config("qmlls", {
    cmd = { "qmlls6" },
    filetypes = { "qml" },
    root_markers = { ".", ".git" },
    capabilities = capabilities,
  })
  vim.lsp.enable "qmlls"

  -- gopls
  vim.lsp.config("gopls", {
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
        gofumpt = true,
        memoryMode = "DegradeClosed",
        expandWorkspaceToModule = false,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = false,
          run_govulncheck = false,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = false,
        },
      },
    },
  })
  vim.lsp.enable "gopls"

  vim.lsp.config("roslyn", {
    settings = {
      ["csharp|background_analysis"] = {
        dotnet_analyzer_diagnostics_scope = "openFiles",
        dotnet_compiler_diagnostics_scope = "openFiles",
      },
    },
  })

  -- html
  vim.lsp.config("html", {
    capabilities = capabilities,
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
    end,
  })

  -- lua_ls
  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        telemetry = { enable = false },
      },
    },
  })

  -- avalonia
  vim.lsp.config("avalonia_ls", {
    cmd = { "avalonia-ls" },
    filetypes = { "xml", "axaml" },
    root_dir = vim.fs.dirname,
    single_file_support = true,
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    end,
  })

  -- LSP attach autocmd
  local group = vim.api.nvim_create_augroup("my.lsp", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end

      -- codelens
      if client:supports_method "textDocument/codeLens" then
        vim.lsp.codelens.enable(true, { bufnr = args.buf })
      end

      -- format on save
      if
        not client:supports_method "textDocument/willSaveWaitUntil"
        and client:supports_method "textDocument/formatting"
      then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format {
              bufnr = args.buf,
              id = client.id,
              timeout_ms = 1000,
            }
          end,
        })
      end
    end,
  })
end

return M
