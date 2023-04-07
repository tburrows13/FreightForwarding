if not mods["aai-industry"] then return end

data.raw.item["processed-fuel"].stack_size = 50

if mods["Krastorio2"] then
  data.raw.item["electric-motor"].stack_size = 200
  data.raw.item["motor"].stack_size = 200
else
  data.raw.item["sand"].stack_size = 100
end