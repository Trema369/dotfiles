local M = {}
local Terminal = require("toggleterm.terminal").Terminal

-- ---------- Helpers ----------

local function find_project_root(pattern)
  -- 1️⃣ Try git root (best, IDE-like)
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" then
    if vim.fn.glob(git_root .. "/" .. pattern) ~= "" then
      return git_root
    end
  end

  -- 2️⃣ Fallback: walk up from current file
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" do
    if vim.fn.glob(dir .. "/" .. pattern) ~= "" then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return nil
end

-- 🔽 MODIFIED: dynamic float size
local function open_term(cmd, cwd)
  local term = Terminal:new({
    cmd = cmd,
    cwd = cwd,
    hidden = true,
    direction = "float",
    close_on_exit = false,
    float_opts = {
      border = "rounded",
      width = function()
        return math.floor(vim.o.columns * 0.7)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.3)
      end,
    },
  })
  term:toggle()
end

-- ---------- Runners ----------

local runners = {
  python = function()
    return "python " .. vim.fn.expand("%"), vim.fn.expand("%:p:h")
  end,

  lua = function()
    return "lua " .. vim.fn.expand("%"), vim.fn.expand("%:p:h")
  end,
  html = function()
    local port = 8000
    local dir = vim.fn.expand("%:p:h")
    local cmd = string.format("cd %s && python3 -m http.server %d &", dir, port, port)
    return cmd
  end,

  cs = function()
    local root = find_project_root("*.csproj")
    if not root then
      return nil
    end
    return "dotnet run", root
  end,

  xml = function()
    local root = find_project_root("*.csproj")
    if not root then
      return nil
    end
    return "dotnet run", root
  end,
}

-- ---------- Builders ----------

local builders = {
  cs = function()
    local root = find_project_root("*.csproj")
    if not root then
      return nil
    end
    return "dotnet build", root
  end,

  xml = function()
    local root = find_project_root("*.csproj")
    if not root then
      return nil
    end
    return "dotnet build", root
  end,

  python = function()
    return "python -m py_compile " .. vim.fn.expand("%"), vim.fn.expand("%:p:h")
  end,

  lua = function()
    return "luac -p " .. vim.fn.expand("%"), vim.fn.expand("%:p:h")
  end,
}

-- ---------- Actions ----------

function M.run_project()
  vim.cmd("write")
  local ft = vim.bo.filetype
  local runner = runners[ft]

  if not runner then
    vim.notify("No run command for " .. ft, vim.log.levels.WARN)
    return
  end

  local cmd, cwd = runner()
  if not cmd then
    vim.notify("Project root not found", vim.log.levels.ERROR)
    return
  end

  open_term(cmd, cwd)
end

function M.build_project()
  vim.cmd("write")
  local ft = vim.bo.filetype
  local builder = builders[ft]

  if not builder then
    vim.notify("No build command for " .. ft, vim.log.levels.WARN)
    return
  end

  local cmd, cwd = builder()
  if not cmd then
    vim.notify("Project root not found", vim.log.levels.ERROR)
    return
  end

  open_term(cmd, cwd)
end

-- ---------- Keymaps ----------

vim.keymap.set("n", "<F5>", function()
  require("config.toggleterm").run_project()
end, { silent = true })

vim.keymap.set("n", "<S-F10>", function()
  require("config.toggleterm").build_project()
end, { silent = true })

-- 🔽 NEW: resize terminal while it's open
vim.keymap.set("t", "<C-Up>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("t", "<C-Down>", "<cmd>resize -2<CR>", { silent = true })

return M
