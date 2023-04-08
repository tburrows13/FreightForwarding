local presets = data.raw["map-gen-presets"]["default"]

local ff_default = { frequency = 0.5, size = 1.0, richness = 1 }
local ff_ribbon  = { frequency = 2.0, size = 1.0, richness = 2 }
--local _ribbon  = { frequency = 3.0, size = 0.5, richness = 2 }

-- FreightForwarding::Default
presets["x-default"] = {
  order = ".1",
  basic_settings = {
    autoplace_controls = {
      --[[["iron-ore"] = ff_default,
      ["copper-ore"] = ff_default,
      ["stone"] = ff_default,
      ["coal"] = ff_default,
      ["uranium-ore"] = ff_default,
      ["crude-oil"] = ff_default,]]
      ["enemy-base"] = { frequency = 0.5, size = 0.5 },
    },
    terrain_segmentation = 1,  -- Inverse of Water Scale
    water = 1,  -- Water Coverage
    property_expression_names = {
      elevation = "x-continents",
    },
  },
  advanced_settings = {
    enemy_evolution = {
      time_factor = 0.000001  -- Default is 0.000004
    },
    difficulty_settings = {
      research_queue_setting = "always"
    }
  }
}

-- FreightForwarding::Ribbon Word
presets["ff-ribbon-world"] = {
  order = ".2",
  basic_settings = 
  {
    autoplace_controls = {
      ["trees"] = { frequency = 1.5, size = 1.0 },
      ["enemy-base"] = { frequency = 0.5, size = 0.5 },
    },
    terrain_segmentation = 2,
    water = 0.80,
    starting_area = 2.5,
    height = 32 * 5, -- 5 chunks
    property_expression_names = { elevation = "x-continents" },
  },
  advanced_settings = 
  {
    enemy_evolution = { time_factor = 0.000001 },
    difficulty_settings = { research_queue_setting = "always" }
  }
}

for _, control in pairs(data.raw["autoplace-control"]) do
  local name = control.name
  if name ~= "trees" and name ~= "enemy-base" and name ~= "ff-seamount" then
    presets["x-default"].basic_settings.autoplace_controls[control.name] = ff_default
    presets["ff-ribbon-world"].basic_settings.autoplace_controls[control.name] = ff_ribbon
  end
end