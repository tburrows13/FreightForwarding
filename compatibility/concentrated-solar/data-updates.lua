if not mods["ch-concentrated-solar"] then return end

x_util.add_ingredient("chcs-heliostat-mirror", "ff-cobalt-ingot", 1)
x_util.add_ingredient("chcs-solar-power-tower", "ff-cobalt-ingot", 50)
x_util.add_ingredient("chcs-solar-laser-tower", "ff-cobalt-ingot", 50)
x_util.add_prerequisite("chcs-concentrated-solar-energy", "ff-cobalt-processing")
x_util.add_research_ingredient("chcs-concentrated-solar-energy", "utility-science-pack")
x_util.add_research_ingredient("chcs-weaponized-solar-energy", "utility-science-pack")
