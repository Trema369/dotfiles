---------------------
---- KEYBINDINGS ----
---------------------

local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "rofi -show drun"

local mainMod = "SUPER"

----------------------
---- MAIN BINDINGS ----
----------------------
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("kitty"))

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(
  mainMod .. " + M",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
)

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd('hyprctl --batch "dispatch togglefloating ; dispatch centerwindow 1"'))

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.config/rofi/launchers/type-2/launcher.sh"))

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

hl.bind("CTRL + Return", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("quickshell -c hyprquickpaper"))

--------------------
---- SWAP WINDOWS ----
--------------------

hl.bind("CTRL + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))

hl.bind("CTRL + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))

hl.bind("CTRL + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))

hl.bind("CTRL + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))

-------------------------
---- MOVE WORKSPACES ----
-------------------------

hl.bind("CTRL + SHIFT + left", hl.dsp.window.move({ workspace = "e-1" }))

hl.bind("CTRL + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))

-----------------------
---- WINDOW FOCUS ----
-----------------------

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-----------------------
---- WORKSPACES ----
-----------------------

for i = 1, 10 do
  local key = i % 10

  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

--------------------------
---- SPECIAL WORKSPACE ----
--------------------------

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(
  mainMod .. " + SHIFT + S",
  hl.dsp.window.move({
    workspace = "special:magic",
  })
)

------------------
---- SCROLLING ----
------------------

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

----------------------
---- MOUSE ACTIONS ----
----------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-----------------------------
---- MEDIA KEYS ----
-----------------------------

hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true }
)

hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)

hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true }
)

hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true }
)

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-----------------------------
---- PLAYER CONTROL ----
-----------------------------

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
