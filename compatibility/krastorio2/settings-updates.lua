if not mods["Krastorio2"] then return end

-- Prevent K2 to change stack sizes
data.raw["string-setting"]["kr-stack-size"].forced_value = "No changes"
data.raw["string-setting"]["kr-stack-size"].hidden = true