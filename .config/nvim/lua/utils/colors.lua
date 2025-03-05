local M = {}

-- https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua
-- https://github.com/craftzdog/solarized-osaka.nvim/blob/e96ec4bb1a622d969d77bb0b4ffd525ccc44b73a/lua/solarized-osaka/hsl.lua#L65

--- Converts an HSL color value to RGB. Conversion formula
--- adapted from http://en.wikipedia.org/wiki/HSL_color_space.
--- Assumes h, s, and l are contained in the set [0, 1] and
--- returns r, g, and b in the set [0, 255].
---
--- @param h number      The hue
--- @param s number      The saturation
--- @param l number      The lightness
--- @return number, number, number     # The RGB representation
M.hslToRgb = function(h, s, l)
  --- @type number, number, number
  local r, g, b

  if s == 0 then
    r, g, b = l, l, l -- achromatic
  else
    --- @param p number
    --- @param q number
    --- @param t number
    local function hue2rgb(p, q, t)
      if t < 0 then
        t = t + 1
      end
      if t > 1 then
        t = t - 1
      end
      if t < 1 / 6 then
        return p + (q - p) * 6 * t
      end
      if t < 1 / 2 then
        return q
      end
      if t < 2 / 3 then
        return p + (q - p) * (2 / 3 - t) * 6
      end
      return p
    end

    --- @type number
    local q
    if l < 0.5 then
      q = l * (1 + s)
    else
      q = l + s - l * s
    end
    local p = 2 * l - q

    r = hue2rgb(p, q, h + 1 / 3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1 / 3)
  end

  return r * 255, g * 255, b * 255
end

--- Converts an HSL color value to RGB in Hex representation.
--- @param  h number?   The hue
--- @param  s number?   The saturation
--- @param  l number?   The lightness
--- @return   string   # The hex representation
M.hslToHex = function(h, s, l)
  local r, g, b = M.hslToRgb(h / 360, s / 100, l / 100)

  return string.format("#%02x%02x%02x", r, g, b)
end

M.hsl_color = function(_, match)
  --- @type string, string, string
  local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
  --- @type number?, number?, number?
  local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
  --- @type string
  local hex_color = M.hslToHex(h, s, l)
  return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
end

--- https://github.com/echasnovski/mini.nvim/discussions/1024#discussion-6905706

--- Returns hex color group for matching short hex color.
---
---@param match string
---@return string
M.hex_color_short = function(_, match)
  local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
  local hex_color = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
  return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
end

-- Returns hex color group for matching rgb() color.
--
---@param match string
---@return string
M.rgb_color = function(_, match)
  local red, green, blue = match:match("rgb%((%d+), ?(%d+), ?(%d+)%)")
  local hex_color = string.format("#%02x%02x%02x", red, green, blue)
  return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
end

-- Returns hex color group for matching rgba() color
-- or false if alpha is nil or out of range.
-- The use of the alpha value refers to a black background.
--
---@param match string
---@return string|false
M.rgba_color = function(_, match)
  local red, green, blue, alpha = match:match("rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)")
  alpha = tonumber(alpha)
  if alpha == nil or alpha < 0 or alpha > 1 then
    return false
  end
  local hex_color = string.format("#%02x%02x%02x", red * alpha, green * alpha, blue * alpha)
  return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
end

return M
