--------------------
---- AUTOSTART ----
--------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("swaync")
  hl.exec_cmd("qs -c navbar")
  hl.exec_cmd("systemctl --user start sunshine")
  hl.exec_cmd("awww-daemon")
end)
