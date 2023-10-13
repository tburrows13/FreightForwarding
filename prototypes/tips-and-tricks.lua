local vanilla_tip_names = {
  "introduction",
  "show-info",
  "e-confirm",
  "clear-cursor",
  "pipette",
  "stack-transfers",
  "entity-transfers",
  "z-dropping",
  "shoot-targeting",
  "bulk-crafting",
  "rotating-assemblers",
  "circuit-network",
  "inserters",
  "burner-inserter-refueling",
  "long-handed-inserters",
  "move-between-labs",
  "insertion-limits",
  "limit-chests",
  "transport-belts",
  "belt-lanes",
  "splitters",
  "splitter-filters",
  "underground-belts",
  "electric-network",
  "steam-power",
  "electric-pole-connections",
  "low-power",
  "connect-switch",
  "copy-entity-settings",
  "copy-paste-trains",
  "copy-paste-filters",
  "copy-paste-requester-chest",
  "copy-paste-spidertron",
  "drag-building",
  "drag-building-poles",
  "pole-dragging-coverage",
  "drag-building-underground-belts",
  "fast-belt-bending",
  "fast-obstacle-traversing",
  "trains",
  "rail-building",
  "train-stops",
  "rail-signals-basic",
  "rail-signals-advanced",
  "gate-over-rail",
  "pump-connection",
  "train-stop-same-name",
  "logistic-network",
  "personal-logistics",
  "construction-robots",
  "passive-provider-chest",
  "storage-chest",
  "requester-chest",
  "active-provider-chest",
  "buffer-chest",
  "ghost-building",
  "ghost-rail-planner",
  "copy-paste",
  "fast-replace",
  "fast-replace-direction",
  "fast-replace-belt-splitter",
  "fast-replace-belt-underground",
}

local vanilla_category_names = {
  "game-interaction",
  "inserters",
  "belts",
  "electric-network",
  "copy-paste",
  "drag-building",
  "trains",
  "logistic-network",
  "ghost-building",
  "fast-replace",
}

for _, tip_name in pairs(vanilla_tip_names) do
  local tip = data.raw["tips-and-tricks-item"][tip_name]
  local indent = tip.indent or 0
  indent = indent + 1
  local dependencies = tip.dependencies or {}
  table.insert(dependencies, "ff-vanilla")
  local order = tip.order or ""
  order = "zzz-[vanilla]-" .. order
  tip.indent = indent
  tip.dependencies = dependencies
  tip.order = order
  tip.starting_status = "unlocked"
end

for _, category_name in pairs(vanilla_category_names) do
  local category = data.raw["tips-and-tricks-item-category"][category_name]
  local order = category.order or ""
  order = "zzz-[vanilla]-" .. order
  category.order = order
end

data:extend({
  {
    type = "tips-and-tricks-item",
    name = "ff-vanilla",
    order = "zzz-[vanilla]",
    is_title = true,
    starting_status = "unlocked",
  }
})

data:extend{
  {
    type = "tips-and-tricks-item-category",
    name = "freight-forwarding",
    order = "a-[freight-forwarding]",
  },
  {
    type = "tips-and-tricks-item",
    name = "freight-forwarding",
    --tag = "[entity=spidertron]",
    category = "freight-forwarding",
    is_title = true,
    order = "a",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true}
  },
  {
    type = "tips-and-tricks-item",
    name = "ff-containerization",
    tag = "[entity=ic-containerization-machine-1]",
    category = "freight-forwarding",
    indent = 1,
    order = "b",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  {
    type = "tips-and-tricks-item",
    name = "ff-container-limits",
    tag = "[item=ic-container]",
    category = "freight-forwarding",
    indent = 1,
    order = "c",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  {
    type = "tips-and-tricks-item",
    name = "ff-water-types",
    tag = "[tile=water]",
    category = "freight-forwarding",
    indent = 1,
    order = "d",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  -- Cargo ships tip fits in here, see below
  {
    type = "tips-and-tricks-item",
    name = "ff-oil",
    tag = "[entity=oil_rig]",
    category = "freight-forwarding",
    indent = 1,
    order = "f",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  {
    type = "tips-and-tricks-item",
    name = "ff-power",
    tag = "[entity=ff-charging-station]",
    category = "freight-forwarding",
    indent = 1,
    order = "g",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  {
    type = "tips-and-tricks-item",
    name = "ff-dredging",
    tag = "[entity=ff-dredger]",
    category = "freight-forwarding",
    indent = 1,
    order = "h",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },
  --[[{
    type = "tips-and-tricks-item",
    name = "ff-cobalt",
    tag = "[item=ff-cobalt-ore]",
    category = "freight-forwarding",
    indent = 1,
    order = "i",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },]]
  --[[{
    type = "tips-and-tricks-item",
    name = "ff-titansteel",
    tag = "[item=ff-titansteel-plate]",
    category = "freight-forwarding",
    indent = 1,
    order = "h",
    --trigger = {type = "build-entity", entity = "spidertron", match_type_only = true},
  },]]
  {
    type = "tips-and-tricks-item",
    name = "ff-rocket-silo",
    tag = "[entity=rocket-silo]",
    category = "freight-forwarding",
    indent = 1,
    order = "i",
    image = "__FreightForwarding__/graphics/tips-and-tricks/rocket-silo.png"
  },
}

-- Convert cargo ships tip to fit in with the rest
local ships_tip = data.raw["tips-and-tricks-item"]["cargo-ships"]
ships_tip.category = "freight-forwarding"
ships_tip.tag = "[entity=cargo_ship]"
ships_tip.indent = 1
ships_tip.order = "e"
ships_tip.is_title = false