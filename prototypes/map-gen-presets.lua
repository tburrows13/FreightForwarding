local presets = data.raw["map-gen-presets"]["default"]

local ore_default = { frequency = 0.5, size = 1, richness = 2 }

presets["x-default"] = {
  order = ".",
  basic_settings = {
    autoplace_controls = {
      --[[["iron-ore"] = ore_default,
      ["copper-ore"] = ore_default,
      ["stone"] = ore_default,
      ["coal"] = ore_default,
      ["uranium-ore"] = ore_default,
      ["crude-oil"] = ore_default,]]
    },
    terrain_segmentation = 1,  -- Inverse of Water Scale
    water = 1,  -- Water Coverage
    property_expression_names = {  -- From IslandStart mod
      elevation = "x-continents",
    },
  },
  advanced_settings = {
    difficulty_settings = {
      research_queue_setting = "always"
    }
  }
}

for _, control in pairs(data.raw["autoplace-control"]) do
  local name = control.name
  if name ~= "trees" and name ~= "enemy-base" then
    presets["x-default"].basic_settings.autoplace_controls[control.name] = ore_default
  end
end
