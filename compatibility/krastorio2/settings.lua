if data.raw["string-setting"]["kr-stack-size"] then
  data.raw["string-setting"]["kr-stack-size"].allowed_values = {"No changes"}
  data.raw["string-setting"]["kr-stack-size"].default_value = "No changes"
  data.raw["string-setting"]["kr-stack-size"].hidden = true
end


data:extend{
  {
    type = "bool-setting",
    name = "ff-k2-no-lead-ammo",
    order = "c",
    setting_type = "startup",
    default_value = true
  },
}