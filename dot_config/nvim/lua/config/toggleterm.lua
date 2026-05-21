local M = {}

local function find_project_root(pattern)
  return vim.fs.root(0, pattern) or vim.fs.root(0, ".git")
end

-- Highlight setup
local function setup_highlights()
  local C = {
    bg_dark = "#181825",
    bg = "#1e1e2e",
    bg_light = "#313244",
    surface = "#45475a",
    text = "#cdd6f4",
    subtext = "#a6adc8",
    green = "#a6e3a1",
    blue = "#89b4fa",
    mauve = "#cba6f7",
    peach = "#fab387",
    red = "#f38ba8",
    yellow = "#f9e2af",
    teal = "#94e2d5",
  }

  -- terminal window background
  vim.api.nvim_set_hl(0, "ToggletermNormal", { bg = C.bg_dark })
  vim.api.nvim_set_hl(0, "ToggletermFloat", { bg = C.bg_dark })
  vim.api.nvim_set_hl(0, "ToggletermBorder", { fg = C.bg_dark, bg = C.bg_dark })

  -- winbar acting as a title strip
  vim.api.nvim_set_hl(0, "ToggletermWinbar", { fg = C.subtext, bg = C.bg_light, bold = false })
  vim.api.nvim_set_hl(0, "ToggletermWinbarIcon", { fg = C.green, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermWinbarName", { fg = C.text, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermWinbarCwd", { fg = C.subtext, bg = C.bg_light, italic = true })
  vim.api.nvim_set_hl(0, "ToggletermWinbarSep", { fg = C.surface, bg = C.bg_light })

  -- runner type colors
  vim.api.nvim_set_hl(0, "ToggletermIconGo", { fg = C.teal, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermIconCs", { fg = C.mauve, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermIconPython", { fg = C.yellow, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermIconCpp", { fg = C.blue, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermIconLua", { fg = C.blue, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermIconHtml", { fg = C.peach, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermIconBuild", { fg = C.peach, bg = C.bg_light, bold = true })
  vim.api.nvim_set_hl(0, "ToggletermIconDefault", { fg = C.subtext, bg = C.bg_light, bold = true })
end

-- icon + highlight per filetype
local ft_meta = {
  go = { icon = " ", hl = "ToggletermIconGo" },
  cs = { icon = " ", hl = "ToggletermIconCs" },
  python = { icon = " ", hl = "ToggletermIconPython" },
  cpp = { icon = " ", hl = "ToggletermIconCpp" },
  lua = { icon = " ", hl = "ToggletermIconLua" },
  html = { icon = " ", hl = "ToggletermIconHtml" },
}

local function get_ft_meta(ft, is_build)
  if is_build then
    return { icon = " ", hl = "ToggletermIconBuild" }
  end
  return ft_meta[ft] or { icon = " ", hl = "ToggletermIconDefault" }
end

-- build a winbar string for the terminal
local function make_winbar(ft, cwd, is_build)
  local meta = get_ft_meta(ft, is_build)
  local action = is_build and "build" or "run"
  local dir = cwd and vim.fn.fnamemodify(cwd, ":~") or "~"

  return table.concat {
    "%#ToggletermWinbarIcon# " .. meta.icon .. " ",
    "%#ToggletermWinbarName#" .. ft .. " " .. action .. " ",
    "%#ToggletermWinbarSep#│ ",
    "%#ToggletermWinbarCwd# " .. dir .. " ",
    "%#ToggletermWinbar#%=",
    "%#ToggletermWinbarSep# ◖",
    "%#ToggletermWinbarIcon#terminal",
    "%#ToggletermWinbarSep#◗ ",
  }
end

local function open_term(cmd, cwd, ft, is_build)
  setup_highlights()
  local Terminal = require("toggleterm.terminal").Terminal

  local term = Terminal:new {
    cmd = cmd,
    cwd = cwd,
    hidden = true,
    close_on_exit = false,
    direction = "float",
    float_opts = {
      border = "none",
      width = function()
        return math.floor(vim.o.columns * 0.85)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.80)
      end,
      row = function()
        return math.floor((vim.o.lines - math.floor(vim.o.lines * 0.80)) / 2)
      end,
      col = function()
        return math.floor((vim.o.columns - math.floor(vim.o.columns * 0.85)) / 2)
      end,
      winblend = 0,
    },
    highlights = {
      Normal = { link = "ToggletermNormal" },
      NormalFloat = { link = "ToggletermFloat" },
      FloatBorder = { link = "ToggletermBorder" },
    },
    on_open = function(t)
      -- set winbar as title strip
      if t.window and vim.api.nvim_win_is_valid(t.window) then
        vim.wo[t.window].winbar = make_winbar(ft or vim.bo.filetype, cwd, is_build)
        vim.wo[t.window].number = false
        vim.wo[t.window].relativenumber = false
        vim.wo[t.window].signcolumn = "no"
        vim.wo[t.window].cursorline = false
      end
      -- easy close
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:close<CR>", { buffer = t.bufnr, silent = true })
      vim.keymap.set("t", "q", "<C-\\><C-n>:close<CR>", { buffer = t.bufnr, silent = true })
    end,
  }

  term:toggle()
end

-- runners
local runners = {
  go = function()
    local root = find_project_root "go.mod"
    if root then
      return "go run .", root
    end
    return "go run " .. vim.fn.expand "%", vim.fn.expand "%:p:h"
  end,
  python = function()
    return "python " .. vim.fn.expand "%", vim.fn.expand "%:p:h"
  end,
  lua = function()
    return "lua " .. vim.fn.expand "%", vim.fn.expand "%:p:h"
  end,
  html = function()
    local port = 8000
    local dir = vim.fn.expand "%:p:h"
    return string.format("cd %s && python3 -m http.server %d", dir, port), dir
  end,
  cs = function()
    local root = find_project_root "*.csproj"
    if not root then
      return nil
    end
    return "dotnet run", root
  end,
  xml = function()
    local root = find_project_root "*.csproj"
    if not root then
      return nil
    end
    return "dotnet run", root
  end,
  cpp = function()
    local root = find_project_root "CMakeLists.txt"
    if root then
      local project_name = vim.fn.fnamemodify(root, ":t")
      local binary = root .. "/build/" .. project_name
      if vim.fn.filereadable(binary) == 1 then
        return binary, root
      end
      vim.notify("Binary not found, build first with <S-F10>", vim.log.levels.WARN)
      return nil
    end
    local file = vim.fn.expand "%:p"
    local out = vim.fn.expand "%:p:r"
    return string.format("g++ -std=c++17 -g %s -o %s && %s", file, out, out), vim.fn.expand "%:p:h"
  end,
}

-- builders
local builders = {
  go = function()
    local root = find_project_root "go.mod"
    if not root then
      return nil
    end
    return "go build ./...", root
  end,
  cs = function()
    local root = find_project_root "*.csproj"
    if not root then
      return nil
    end
    return "dotnet build", root
  end,
  xml = function()
    local root = find_project_root "*.csproj"
    if not root then
      return nil
    end
    return "dotnet build", root
  end,
  python = function()
    return "python -m py_compile " .. vim.fn.expand "%", vim.fn.expand "%:p:h"
  end,
  lua = function()
    return "luac -p " .. vim.fn.expand "%", vim.fn.expand "%:p:h"
  end,
  cpp = function()
    local root = find_project_root "CMakeLists.txt"
    if not root then
      root = vim.fn.expand "%:p:h"
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
        local file = vim.fn.expand "%:p"
        local out = vim.fn.expand "%:p:r"
        return string.format("g++ -std=c++17 -g %s -o %s", file, out), root
      end
    end
    local build_dir = root .. "/build"
    return string.format(
      "mkdir -p %s && cd %s && cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && make -j$(nproc) && ln -sf %s/compile_commands.json %s/compile_commands.json",
      build_dir,
      build_dir,
      build_dir,
      root
    ),
      root
  end,
}

function M.run_project()
  vim.cmd "write"
  local ft = vim.bo.filetype
  local runner = runners[ft]
  if runner then
    local cmd, cwd = runner()
    if cmd then
      open_term(cmd, cwd, ft, false)
    end
  else
    vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
  end
end

function M.build_project()
  vim.cmd "write"
  local ft = vim.bo.filetype
  local builder = builders[ft]
  if builder then
    local cmd, cwd = builder()
    if cmd then
      open_term(cmd, cwd, ft, true)
    end
  else
    vim.notify("No builder for filetype: " .. ft, vim.log.levels.WARN)
  end
end

return M
