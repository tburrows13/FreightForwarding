if not mods["Krastorio2"] then return end

-- override K2 stack changes before they are applied in data-updates
settings["startup"]["kr-stack-size"] = "No changes"

local matter = require("__Krastorio2__/lib/public/data-stages/matter-util")

-- Matter technology
data:extend({
  {
    type = "technology",
    name = "kr-matter-cobalt-processing",
    localised_name = "Cobalt conversion",
    icons =
    {
      {
        icon = "__Krastorio2Assets__/technologies/matter-stone.png",
        icon_size = 256,
      },
      {
        icon = "__FreightForwarding__/graphics/item/cobalt-ore.png",
        icon_size = 64,
        icon_mipmaps = 1,
        scale = 1.25,
      }
    },
    prerequisites = {"kr-matter-processing"},
    unit =
      {
        count = 350,
        ingredients =
        {
          {"production-science-pack", 1},
          {"utility-science-pack", 1},
          {"matter-tech-card", 1}
        },
        time = 45
      }
  },
})

-- Cobalt ore
local cobalt_ore = {
  k2matter = {
    item_name = "ff-cobalt-ore",
    minimum_conversion_quantity = 10,
    matter_value = 5,
    energy_required = 1,
    only_deconversion = false,
    need_stabilizer = false,
    unlocked_by_technology = "kr-matter-cobalt-processing",
  },
  k2baseicon = "stone",
  icon = {
    icon = "__FreightForwarding__/graphics/item/cobalt-ore.png",
    icon_size = 64, 
    icon_mipmaps = 1,
    scale = 1.25,
  },
}
matter.createMatterRecipe(cobalt_ore.k2matter)

-- Cobalt ingot
local cobalt_ingot = {
  k2matter = {
    item_name = "ff-cobalt-ingot",
    minimum_conversion_quantity = 10,
    matter_value = 7.5,
    energy_required = 2,
    only_deconversion = true,
    need_stabilizer = true,
    unlocked_by_technology = "kr-matter-cobalt-processing",
  },
  k2baseicon = "stone",
  icon = {
    icon = "__FreightForwarding__/graphics/item/cobalt-ingot.png",
    icon_size = 64, 
    icon_mipmaps = 1,
    scale = 1.25,
  },
}
matter.createMatterRecipe(cobalt_ingot.k2matter)
