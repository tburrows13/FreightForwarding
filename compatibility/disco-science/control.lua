local function init()
  if not script.active_mods["DiscoScience"] then return end
  if not remote.interfaces["DiscoScience"] then return end
  if not remote.interfaces["DiscoScience"]["setIngredientColor"] then return end
  -- Set Transport Science color
  remote.call(
    "DiscoScience",
    "setIngredientColor",
    "ff-transport-science-pack",
    { r = 253/255, g = 83/255, b = 0 } -- Orange #FD5300
  )
end

return
{
  init = init
}