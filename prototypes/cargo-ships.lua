-- Much bigger supply area to make up for lack of floating pole
data.raw["electric-pole"]["or_pole"].supply_area_distance = 12.5  -- 4.5

-- Hide floating pole
table.insert(data.raw["electric-pole"]["floating-electric-pole"].flags, "hidden")
table.insert(data.raw["item"]["floating-electric-pole"].flags, "hidden")
data.raw["recipe"]["floating-electric-pole"].hidden = true
data.raw["technology"]["oversea-energy-distribution"].hidden = true

-- Speed up small boat
data.raw["car"]["indep-boat"].friction = data.raw["car"]["indep-boat"].friction * 0.75