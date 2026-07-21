----------------------
---- LOOK AND FEEL ----
----------------------

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 15,

    border_size = 1,

    col = {
      active_border = "rgba(ffffff33)",
      inactive_border = "rgba(ffffff11)",
    },

    resize_on_border = false,
    allow_tearing = false,

    layout = "dwindle",
  },

  decoration = {
    rounding = 15,
    rounding_power = 15,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = false,
      range = 1,
      render_power = 1,
      color = "rgba(00000088)",
    },

    blur = {
      enabled = true,
      size = 5,
      passes = 2,

      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
})

-------------------
---- ANIMATIONS ----
-------------------

hl.curve("easeOutQuint", {
  type = "bezier",
  points = {
    { 0.23, 1 },
    { 0.32, 1 },
  },
})

hl.curve("easeInOutCubic", {
  type = "bezier",
  points = {
    { 0.65, 0.05 },
    { 0.36, 1 },
  },
})

hl.curve("linear", {
  type = "bezier",
  points = {
    { 0, 0 },
    { 1, 1 },
  },
})

hl.curve("almostLinear", {
  type = "bezier",
  points = {
    { 0.5,  0.5 },
    { 0.75, 1 },
  },
})

hl.curve("quick", {
  type = "bezier",
  points = {
    { 0.15, 0 },
    { 0.1,  1 },
  },
})

hl.animation({
  leaf = "global",
  enabled = true,
  speed = 10,
  bezier = "default",
})

hl.animation({
  leaf = "border",
  enabled = true,
  speed = 5.39,
  bezier = "easeOutQuint",
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 4.79,
  bezier = "easeOutQuint",
})

hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 4.1,
  bezier = "easeOutQuint",
  style = "popin 87%",
})

hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 1.49,
  bezier = "linear",
  style = "popin 87%",
})

hl.animation({
  leaf = "fadeIn",
  enabled = true,
  speed = 1.73,
  bezier = "almostLinear",
})

hl.animation({
  leaf = "fadeOut",
  enabled = true,
  speed = 1.46,
  bezier = "almostLinear",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 3.03,
  bezier = "quick",
})

hl.animation({
  leaf = "layers",
  enabled = true,
  speed = 3.81,
  bezier = "easeOutQuint",
})

hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 4,
  bezier = "easeOutQuint",
  style = "fade",
})

hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 1.5,
  bezier = "linear",
  style = "fade",
})

hl.animation({
  leaf = "fadeLayersIn",
  enabled = true,
  speed = 1.79,
  bezier = "almostLinear",
})

hl.animation({
  leaf = "fadeLayersOut",
  enabled = true,
  speed = 1.39,
  bezier = "almostLinear",
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 8,
  curve = "default",
  bezier = "almostLinear",
  style = "slidefade 20%",
})

hl.animation({
  leaf = "workspacesIn",
  enabled = true,
  speed = 10,
  curve = "default",
  bezier = "almostLinear",
  style = "slide",
})

hl.animation({
  leaf = "workspacesOut",
  enabled = true,
  speed = 10,
  curve = "default",
  bezier = "almostLinear",
  style = "slide",
})

hl.animation({
  leaf = "zoomFactor",
  enabled = true,
  speed = 7,
  bezier = "quick",
})

--------------------
---- LAYOUTS ----
--------------------

hl.config({
  dwindle = {
    preserve_split = true,
  },
})

hl.config({
  master = {
    new_status = "master",
  },
})

----------------
---- MISC ----
----------------

hl.config({
  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },
})
