local function update_description_stack_size(description, stack_size)
  if not description then return end
  if type(description) ~= "table" then return end
  if description[1] == "description.stack-size" or description[1] == "other.stack-size-description" then
    -- Extended Descriptions and Stack Size Tooltip
    description[2] = stack_size
  end
  for _, item in pairs(description) do
    update_description_stack_size(item, stack_size)
  end
end

for _, item in pairs(data.raw.item) do
  -- Update stack size descriptions added by other mods because we run in data-final-fixes
  update_description_stack_size(item.localised_description, tostring(item.stack_size))
end