if not mods["big-mining-drill"] then return end

x_util.replace_ingredient("big-mining-drill", "steel-plate", "titanium-plate")
x_util.add_prerequisite("big-mining-drill", "titanium-processing")