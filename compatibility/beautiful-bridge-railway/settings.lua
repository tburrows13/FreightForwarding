-- Set the special item cost for each bridge to 20
if data.raw["int-setting"]["bbr-fix-cost"] then
  data.raw["int-setting"]["bbr-fix-cost"].allowed_values = {2}  -- gets multiplied by 2 in data-final-fixes
  data.raw["int-setting"]["bbr-fix-cost"].default_value = 2
  data.raw["int-setting"]["bbr-fix-cost"].hidden = true

  data.raw["bool-setting"]["rail-signal-on-water"].forced_value = false
  data.raw["bool-setting"]["rail-signal-on-water"].hidden = true
  data.raw["bool-setting"]["big-power-poles-on-water"].forced_value = false
  data.raw["bool-setting"]["big-power-poles-on-water"].hidden = true
end