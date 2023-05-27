if not mods["advanced-centrifuge"] then return end

-- vanilla recipe
-- (1) Mk1 centrifuge              --> 10  ore = 1 u238 + 0.7% u235
-- (2) MK1 centrifuge + 2 T£ prods --> 8.4 ore = 1 u238 + 0.7% u235
-- Productivity should be about: (1) < ff-new-recipe < (2)

local function k2_byproducts(index)
  local byproducts = {
    [1] = { name = "iron-ore", probability = 0.25, amount = 5 },
    [2] = { name = "stone", probability = 0.5, amount = 5 }
  }
  if mods["Krastorio2"] then return byproducts[index] else return nil end
end

data:extend({
  {
    type = "recipe-category",
    name = "advanced-centrifuging"
  },
  {
    type = "recipe",
    name = "ff-advanced-uranium-processing",
    energy_required = 60, --was 12
    enabled = false,
    category = "advanced-centrifuging",
    ingredients = {{"uranium-ore", 46}}, -- was 10
    icons = {
      {
        icon = "__base__/graphics/icons/uranium-processing.png",
        icon_size = 64,
        icon_mipmaps = 4,
      },
      {
        icon = "__core__/graphics/icons/technology/constants/constant-mining-productivity.png",
        icon_size = 128,
        icon_mipmaps = 3,
        scale = 0.25,
        shift = {10, -8}
      }
    },
    subgroup = "raw-material",
    order = "k[uranium-processing]-2", -- k ordering so it shows up after explosives which is j ordering
    results =
    {
      {
        name = "uranium-235",
        probability = 0.007,
        amount_min = 4,
        amount_max = 8
      },
      {
        name = "uranium-238",
        probability = 0.993,
        amount_min = 1,
        amount_max = 9
      },
      k2_byproducts(1),
      k2_byproducts(2),
    }
  },
})
