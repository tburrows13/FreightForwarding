for _, surface in pairs(game.surfaces) do
  for _, entity in pairs(surface.find_entities_filtered{type = "assembling-machine", name = {"ff-lava-pool", "ff-lava-pool-small"}, force = "player"}) do
    entity.destructible = false
    if entity.name == "ff-lava-pool" then
      rendering.draw_animation{
        animation = "ff-lava-pool-animation",
        target = entity,
        surface = surface,
        render_layer = "lower-object-above-shadow",
        animation_offset = math.floor(math.random() * 10),
      }
    else
      rendering.draw_animation{
        animation = "ff-lava-pool-small-animation",
        target = entity,
        surface = surface,
        render_layer = "lower-object-above-shadow",
        animation_offset = math.floor(math.random() * 10),
      }
    end
    end
end
