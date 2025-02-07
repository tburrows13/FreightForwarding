-- Hide light gunship
data.raw.technology["lex-flying-gunship-ships"].hidden = true
data.raw.recipe["lex-flying-gunship"].hidden = true
data.raw["item-with-entity-data"]["lex-flying-gunship"].hidden = true
data.raw["spider-vehicle"]["lex-flying-gunship"].hidden = true
x_util.remove_prerequisite("lex-flying-heavyship-ships", "lex-flying-gunship-ships")

-- Doesn't have any effect anyway because automatic_weapon_cycling = false, so remove from tooltip
data.raw["spider-vehicle"]["lex-flying-heavyship"].chain_shooting_cooldown_modifier = 1

-- Adjust locale
data.raw["spider-vehicle"]["lex-flying-cargo"].localised_description = {""}
data.raw["spider-vehicle"]["lex-flying-heavyship"].localised_description = {""}

-- Move lex aicraft to lategame
x_util.add_prerequisite("lex-jet-engine", "hovercraft")
x_util.add_prerequisite("lex-jet-engine", "utility-science-pack")
x_util.add_prerequisite("lex-jet-engine", "production-science-pack")
x_util.remove_prerequisite("lex-jet-engine", "automobilism")
x_util.remove_prerequisite("lex-jet-engine", "robotics")

x_util.add_research_ingredient("lex-jet-engine", "utility-science-pack")
x_util.add_research_ingredient("lex-jet-engine", "production-science-pack")
data.raw.technology["lex-jet-engine"].unit.count = 500  -- 350

--x_util.add_research_ingredient("lex-flying-gunship-ships", "utility-science-pack")
--data.raw.technology["lex-flying-gunship-ships"].unit.count = 1000  -- 500
--x_util.add_prerequisite("lex-flying-gunship-ships", "missile-hovercraft")

x_util.add_research_ingredient("lex-flying-cargo-ships", "utility-science-pack")
x_util.add_research_ingredient("lex-flying-cargo-ships", "production-science-pack")
data.raw.technology["lex-flying-cargo-ships"].unit.count = 1500  -- 500
x_util.add_prerequisite("lex-flying-cargo-ships", "sp-spidertron-automation")

x_util.add_prerequisite("lex-flying-heavyship-ships", "missile-hovercraft")
x_util.add_prerequisite("lex-flying-heavyship-ships", "lex-jet-engine")
x_util.remove_prerequisite("lex-flying-heavyship-ships", "lex-flying-cargo-ships")
x_util.remove_recipe_effect("lex-flying-heavyship-ships", "spidertron-remote")

-- Make spidertron slightly earlier since it is weaker than lex heavy ship
x_util.remove_prerequisite("efficiency-module-3", "production-science-pack")
x_util.remove_research_ingredient("efficiency-module-3", "production-science-pack")
x_util.remove_research_ingredient("spidertron", "production-science-pack")