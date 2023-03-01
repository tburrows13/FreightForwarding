-- Fix oil rigs
table.insert(data.raw["generator"]["or_power"].flags, "placeable-off-grid")
table.insert(data.raw["electric-pole"]["or_pole"].flags, "placeable-off-grid")
table.insert(data.raw["radar"]["or_radar"].flags, "placeable-off-grid")

-- Much bigger supply area to make up for lack of floating pole
data.raw["electric-pole"]["or_pole"].supply_area_distance = 7.5  -- 4.5

-- Hide floating pole
table.insert(data.raw["electric-pole"]["floating-electric-pole"].flags, "hidden")
table.insert(data.raw["item"]["floating-electric-pole"].flags, "hidden")
data.raw["recipe"]["floating-electric-pole"].hidden = true
data.raw["technology"]["oversea-energy-distribution"].hidden = true

-- Speed up small boat
data.raw["car"]["indep-boat"].friction = data.raw["car"]["indep-boat"].friction * 0.75