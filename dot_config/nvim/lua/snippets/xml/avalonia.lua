-- ~/.config/nvim/lua/snippets/xml/test.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local utils = require("config.utilities")

-- =========================
-- Avalonia UserControl XAML
-- =========================
ls.add_snippets("xml", {
  s("avalonia-usercontrol", {
    t({
      '<UserControl xmlns="https://github.com/avaloniaui"',
      '             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"',
      '             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"',
      '             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"',
      '             mc:Ignorable="d"',
    }),
    f(function()
      local ns = utils.compute_namespace()
      local cls = utils.class_name()
      return '             x:Class="' .. ns .. "." .. cls .. '">'
    end),
    t({
      "",
      "",
      "</UserControl>",
    }),
  }),
})

-- =========================
-- Avalonia Code-behind
-- =========================
ls.add_snippets("cs", {
  s("avalonia-codebehind", {
    f(function()
      return "namespace " .. utils.compute_namespace() .. ";"
    end),
    t({
      "",
      "",
      "using Avalonia.Controls;",
      "",
      "public partial class ",
    }),
    f(function()
      return utils.class_name()
    end),
    t({
      " : UserControl",
      "{",
      "    public ",
    }),
    f(function()
      return utils.class_name()
    end),
    t({
      "()",
      "    {",
      "        InitializeComponent();",
      "    }",
      "}",
    }),
  }),
})
