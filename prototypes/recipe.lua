local bzutil = require("__bzlead__.data-util");

-- Rails are now used in transport science, so swap them out for uranium
bzutil.remove_ingredient("production-science-pack", "rail")
bzutil.add_ingredient("production-science-pack", "uranium-238", 2)

-- Make rails more expensive
local recipe = data.raw.recipe["rail"]
recipe.result_count = 1
