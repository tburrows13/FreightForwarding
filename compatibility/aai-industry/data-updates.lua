if not mods["aai-industry"] then return end

local restack = require "__FreightForwarding__.prototypes.data-util".set_stack_size

restack("processed-fuel", 50)

if mods["Krastorio2"] then
  restack("electric-motor", 200)
  restack("motor", 200)
else
  restack("sand", 100)
end