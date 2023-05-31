-- Adapted from https://mods.factorio.com/mod/exotic-industries-tanks

local ei_tank_1 = {
  north = util.empty_sprite(),
  south = {
    layers = {
      {
        filename =  "__FreightForwarding__/graphics/pipe-covers/data_south_covers.png",
        width = 512,
        height = 512,
        -- shift = {0,-2.15},
        scale = 0.35,
        shift = util.by_pixel(0, -96), 
      },
      {
        filename = "__FreightForwarding__/graphics/pipe-covers/south_basic_covers.png",
        priority = "high",
        width = 55,
        height = 50,
        shift = {0.01, -0.58},
        scale = 0.5
      }
    }
  },
  west = {
    filename = "__FreightForwarding__/graphics/pipe-covers/big_west_covers.png",
    priority = "high",
    width = 512,
    height = 512,
    scale = 0.35,
    shift = util.by_pixel(96, 0),        
  },
  east = {
    filename = "__FreightForwarding__/graphics/pipe-covers/big_east_covers.png",
    priority = "high",
    width = 512,
    height = 512,
    scale = 0.35,
    shift = util.by_pixel(-96, 0),
  }
}

data:extend{
  {
    name = "ff-offshore-storage-tank",
    type = "item",
    icon = "__FreightForwarding__/graphics/item/offshore-tank.png",
    icon_size = 64,
    subgroup = "storage",
    order = "b[fluid]-d",
    place_result = "ff-offshore-storage-tank",
    stack_size = 50
  },
  {
    name = "ff-offshore-storage-tank",
    type = "recipe",
    category = "crafting",
    energy_required = 2,
    ingredients =
    {
      {"iron-plate", 25},
      {"steel-plate", 40},
      {"storage-tank", 2},
    },
    result = "ff-offshore-storage-tank",
    --result_count = 1,
    enabled = false,
    --always_show_made_in = true,
    --main_product = "ff-offshore-storage-tank",
  },
  {
    name = "ff-offshore-storage-tank",
    type = "storage-tank",
    icon = "__FreightForwarding__/graphics/item/offshore-tank.png",
    icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "ff-offshore-storage-tank"},
    max_health = 500,
    corpse = "big-remnants",
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    --collision_mask = table.deepcopy(data.raw["pipe"]["storage-tank"].collision_mask),
    collision_mask = {"ground-tile", "object-layer"},  -- Fixed in data-final-fixes
    circuit_wire_connection_points = circuit_connector_definitions["storage-tank"].points,
    circuit_connector_sprites = circuit_connector_definitions["storage-tank"].sprites,
    circuit_wire_max_distance = 20,
    flow_length_in_ticks = 1,
    map_color = data.raw["storage-tank"]["storage-tank"].map_color,
    window_bounding_box = {{0,0},{1,1}},
    fluid_box = {
      base_area = 1000,
      pipe_covers = pipecoverspictures(),
      pipe_picture = ei_tank_1,
      base_level = 0,
      height = 1,
      pipe_connections =
      {
        { type = "input-output", position = {0, -3} },
        { type = "input-output", position = {0, 3} },
        { type = "input-output", position = {-3, 0} },
        { type = "input-output", position = {3, 0} },
      },
      production_type = "input-output",
    },
    pictures = {
      picture = {
        filename = "__FreightForwarding__/graphics/offshore-tank.png",
        size = {512, 512},
        shift = {0, 0},
        scale = 0.35*2,
      },
      window_background = util.empty_sprite(),
      fluid_background = util.empty_sprite(),
      flow_sprite = util.empty_sprite(),
      gas_flow = util.empty_sprite(),
    }
  }
}


table.insert(data.raw["technology"]["tank_ship"].effects, 3,
  {
    type = "unlock-recipe",
    recipe = "ff-offshore-storage-tank"
  }
)