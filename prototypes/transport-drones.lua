-- Remove all crate request recipes so that crates cannot be transported by transport drones

for name, recipe in pairs(data.raw.recipe) do
  if recipe.category == "transport-drone-request" and recipe.subgroup == "deadlock-crates-pack" then
    data.raw.recipe[name] = nil
  end
end