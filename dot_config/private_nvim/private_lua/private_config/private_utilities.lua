local M = {}

function M.find_csproj_root()
  local dir = vim.fn.expand("%:p:h")

  while dir ~= "/" do
    local csproj = vim.fn.glob(dir .. "/*.csproj")
    if csproj ~= "" then
      return dir, vim.fn.fnamemodify(csproj, ":t:r")
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return nil, nil
end

function M.compute_namespace()
  local root, project = M.find_csproj_root()
  if not root or not project then
    return project or "MyApp"
  end

  local file_dir = vim.fn.expand("%:p:h")

  -- remove project root from file path
  local relative = file_dir:sub(#root + 2)

  if relative == "" then
    return project
  end

  -- convert folders to namespace
  return project .. "." .. relative:gsub("/", ".")
end

function M.class_name()
  return vim.fn.expand("%:t:r")
end

return M
