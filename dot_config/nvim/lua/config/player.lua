-- Setup mpv.nvim first
require("mpv").setup({
  width = 50,
  height = 5,
  border = "single",
  setup_widgets = true,
  timer = { after = 1000, throttle = 250 },
})

-- Keymaps for controlling MPV
local mpv = require("mpv")

-- Open MPV player
vim.keymap.set("n", "<leader>mp", mpv.toggle_player, { desc = "Toggle MPV Player" })

-- Play / Pause
vim.keymap.set("n", "<leader>pp", function()
  mpv.cmd("cycle", "pause")
end, { desc = "Play/Pause MPV" })

-- Stop / Quit
vim.keymap.set("n", "<leader>pq", function()
  mpv.cmd("quit")
end, { desc = "Quit MPV" })

-- Seek forward/backward
vim.keymap.set("n", "<leader>pf", function()
  mpv.cmd("seek", 10)
end, { desc = "Seek +10s" })
vim.keymap.set("n", "<leader>pb", function()
  mpv.cmd("seek", -10)
end, { desc = "Seek -10s" })

-- Volume control
vim.keymap.set("n", "<leader>pv+", function()
  mpv.cmd("add", "volume", 5)
end, { desc = "Volume +5" })
vim.keymap.set("n", "<leader>pv-", function()
  mpv.cmd("add", "volume", -5)
end, { desc = "Volume -5" })

-- Mute toggle
vim.keymap.set("n", "<leader>pm", function()
  mpv.cmd("cycle", "mute")
end, { desc = "Mute/Unmute MPV" })

-- Auto-hide the MPV popup when leaving its buffer
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "mpv_*",
  callback = function()
    if mpv.is_running() then
      mpv.hide_ui() -- hides the popup without stopping playback
    end
  end,
})
