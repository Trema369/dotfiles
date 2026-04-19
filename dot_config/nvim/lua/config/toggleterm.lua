local M = {}
local Terminal = require("toggleterm.terminal").Terminal

local function find_project_root(pattern)
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" then
    if vim.fn.glob(git_root .. "/" .. pattern) ~= "" then
      return git_root
    end
  end
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" do
    if vim.fn.glob(dir .. "/" .. pattern) ~= "" then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

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
        return math.floor(vim.o.columns * 0.8)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
    },
  })
  term:toggle()
end

-- ---------- Runners ----------
local runners = {
  go = function()
    local root = find_project_root("go.mod")
    if root then
      return "go run .", root
    end
    -- Single file fallback
    return "go run " .. vim.fn.expand("%"), vim.fn.expand("%:p:h")
  end,
  python = function()
    return "python " .. vim.fn.expand("%"), vim.fn.expand("%:p:h")
  end,
  lua = function()
    return "lua " .. vim.fn.expand("%"), vim.fn.expand("%:p:h")
  end,
  html = function()
    local port = 8000
    local dir = vim.fn.expand("%:p:h")
    local cmd = string.format("cd %s && python3 -m http.server %d &", dir, port)
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
  cpp = function()
    local root = find_project_root("CMakeLists.txt")
    if root then
      local project_name = vim.fn.fnamemodify(root, ":t")
      local binary = root .. "/build/" .. project_name
      if vim.fn.filereadable(binary) == 1 then
        return binary, root
      end
      vim.notify("Binary not found, build first with <S-F10>", vim.log.levels.WARN)
      return nil
    end
    -- Single file fallback: compile + run in one shot
    local file = vim.fn.expand("%:p")
    local out = vim.fn.expand("%:p:r")
    local cmd = string.format("g++ -std=c++17 -g %s -o %s && %s", file, out, out)
    return cmd, vim.fn.expand("%:p:h")
  end,
}

-- ---------- Builders ----------
local builders = {
  go = function()
    local root = find_project_root("go.mod")
    if not root then
      return nil
    end
    return "go build ./...", root
  end,
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
  cpp = function()
    local root = find_project_root("CMakeLists.txt")

    if not root then
      -- Auto-generate CMakeLists.txt in the current file's directory
      root = vim.fn.expand("%:p:h")
      local project_name = vim.fn.fnamemodify(root, ":t")
      local cmake_path = root .. "/CMakeLists.txt"

      local cmake_content = string.format(
        [[
cmake_minimum_required(VERSION 3.10)
project(%s)
set(CMAKE_CXX_STANDARD 17)
file(GLOB_RECURSE SOURCES "*.cpp")
add_executable(%s ${SOURCES})
]],
        project_name,
        project_name
      )

      local f = io.open(cmake_path, "w")
      if f then
        f:write(cmake_content)
        f:close()
        vim.notify("Generated CMakeLists.txt in " .. root, vim.log.levels.INFO)
      else
        -- Fallback to raw g++ if file write fails
        local file = vim.fn.expand("%:p")
        local out = vim.fn.expand("%:p:r")
        return string.format("g++ -std=c++17 -g %s -o %s", file, out), root
      end
    end

    local build_dir = root .. "/build"
    local cmd = string.format(
      "mkdir -p %s && cd %s && cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && make -j$(nproc) && ln -sf %s/compile_commands.json %s/compile_commands.json",
      build_dir,
      build_dir,
      build_dir,
      root
    )
    return cmd, root
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

vim.keymap.set("t", "<C-Up>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("t", "<C-Down>", "<cmd>resize -2<CR>", { silent = true })

return M
