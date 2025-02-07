-- Much bigger supply area to make up for lack of floating pole
data.raw["electric-pole"]["or_pole"].supply_area_distance = 12.5  -- 4.5

-- Hide floating pole
data.raw["electric-pole"]["floating-electric-pole"].hidden = true
data.raw["item"]["floating-electric-pole"].hidden = true
data.raw["recipe"]["floating-electric-pole"].hidden = true
data.raw["technology"]["oversea-energy-distribution"].hidden = true

-- Speed up small boat
data.raw["car"]["indep-boat"].friction = data.raw["car"]["indep-boat"].friction * 0.75