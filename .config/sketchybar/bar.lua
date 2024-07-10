local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 40,
  y_offset = 10,
  color = colors.with_alpha(colors.bar.bg, 0.85),
  shadow = "on",
  padding_right = 2,
  padding_left = 2,
  margin = 10,
  corner_radius = 9,
  blur_radius = 20,
})
