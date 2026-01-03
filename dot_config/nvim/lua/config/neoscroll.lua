local neoscroll = require("neoscroll")

neoscroll.setup({
  hide_cursor = true,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
  easing_function = "quadratic",
})

local keymap = vim.keymap.set
local opts = { silent = true }

-- Ctrl-based scrolling
keymap("n", "<C-u>", function()
  neoscroll.ctrl_u({ duration = 250 })
end, opts)

keymap("n", "<C-d>", function()
  neoscroll.ctrl_d({ duration = 250 })
end, opts)

keymap("n", "<C-b>", function()
  neoscroll.ctrl_b({ duration = 450 })
end, opts)

keymap("n", "<C-f>", function()
  neoscroll.ctrl_f({ duration = 450 })
end, opts)

-- Fine scrolling
keymap("n", "<C-y>", function()
  neoscroll.scroll(-0.10, { move_cursor = false, duration = 100 })
end, opts)

keymap("n", "<C-e>", function()
  neoscroll.scroll(0.10, { move_cursor = false, duration = 100 })
end, opts)

-- Centering motions
keymap("n", "zt", function()
  neoscroll.zt({ half_win_duration = 250 })
end, opts)

keymap("n", "zz", function()
  neoscroll.zz({ half_win_duration = 250 })
end, opts)

keymap("n", "zb", function()
  neoscroll.zb({ half_win_duration = 250 })
end, opts)
