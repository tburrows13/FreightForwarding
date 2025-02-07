local x_util = {}

function x_util.set_stack_size(item, stack_size)
  local item = data.raw.item[item] or data.raw.tool[item] or data.raw.ammo[item]
  if not item then return end
  item.stack_size = stack_size or 50
end

function x_util.add_prerequisite(tech_name, prerequisite)
  local technology = data.raw.technology[tech_name]
  for _, name in pairs(technology.prerequisites) do
    if name == prerequisite then
      return
    end
  end
  table.insert(technology.prerequisites, prerequisite)
end

function x_util.remove_prerequisite(tech_name, prerequisite)
  local technology = data.raw.technology[tech_name]
  for i, name in pairs(technology.prerequisites) do
    if name == prerequisite then
      table.remove(technology.prerequisites, i)
    end
  end
end

function x_util.add_research_ingredient(tech_name, ingredient)
  local technology = data.raw.technology[tech_name]
  for _, name in pairs(technology.unit.ingredients) do
    if name[1] == ingredient then
      return
    end
  end
  table.insert(technology.unit.ingredients, {ingredient, 1})
end

function x_util.remove_research_ingredient(tech_name, ingredient)
  local technology = data.raw.technology[tech_name]
  for i, name in pairs(technology.unit.ingredients) do
    if name[1] == ingredient then
      table.remove(technology.unit.ingredients, i)
    end
  end
end

function x_util.contains_research_ingredient(tech_name, ingredient)
  local technology = data.raw.technology[tech_name]
  for _, name in pairs(technology.unit.ingredients) do
    if name[1] == ingredient then
      return true
    end
  end
  return false
end

-- From bzutil
-- Add an effect to a given technology
function x_util.add_effect(technology_name, effect)
  local technology = data.raw.technology[technology_name]
  if technology then
    if not technology.effects then technology.effects = {} end
    if effect and effect.type == "unlock-recipe" then
      if not data.raw.recipe[effect.recipe] then
        return
      end
      table.insert(technology.effects, effect)
    end
  end
end

-- Add an effect to a given technology to unlock recipe
function x_util.add_unlock(technology_name, recipe)
  x_util.add_effect(technology_name, {type="unlock-recipe", recipe=recipe})
end

-- From bzutil
-- remove recipe unlock effect from a given technology, multiple times if necessary
function x_util.remove_recipe_effect(technology_name, recipe_name)
  local technology = data.raw.technology[technology_name]
  local index = -1
  local cnt = 0
  if technology and technology.effects then
      for i, effect in pairs(technology.effects) do
          if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
              index = i
              cnt = cnt + 1
          end
      end
      if index > -1 then
          table.remove(technology.effects, index)
          if cnt > 1 then -- not over yet, do it again
            x_util.remove_recipe_effect(technology_name, recipe_name)
          end
      end
  end
end

function x_util.is_descendant_of(tech_name, ancestor)
  --if tech_name == ancestor then return true end
  --log(ancestor .. "  -->  "..tech_name)
  local technology = data.raw.technology[tech_name]
  if not technology then return false end
  if technology.prerequisites == nil then
    return false
  end
  for _, name in pairs(technology.prerequisites) do
    if name == ancestor then
      return true
    end
    if x_util.is_descendant_of(name, ancestor) then
      return true
    end
  end
  return false
end

-- From bzutil
-- check if a table contains a sought value
function x_util.contains(table, sought)
  for i, value in pairs(table) do
    if value == sought then
      return true
    end
  end
  return false
end

-- From bzutil
local function add_ingredient(recipe, ingredient, quantity, is_fluid)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == ingredient then
        return
      end
    end
    if is_fluid then
      table.insert(recipe.ingredients, {type="fluid", name=ingredient, amount=quantity})
    else
      table.insert(recipe.ingredients, {type="item", name=ingredient, amount=quantity})
    end
  end
end

-- From bzutil
-- Add a given quantity of ingredient to a given recipe
function x_util.add_ingredient(recipe_name, ingredient, quantity, options)
  local is_fluid = not not data.raw.fluid[ingredient]
  if data.raw.recipe[recipe_name] and (data.raw.item[ingredient] or is_fluid) then
    add_ingredient(data.raw.recipe[recipe_name], ingredient, quantity, is_fluid)
  end
end

-- From bzutil
local function replace_ingredient(recipe, old, new, amount, multiply)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == new then
        return
      end
    end
    for i, ingredient in pairs(recipe.ingredients) do
      if ingredient.name == old then
        ingredient.name = new
        if amount then
          if multiply then
            ingredient.amount = amount * ingredient.amount
          else
            ingredient.amount = amount
          end
        end
      end
    end
  end
end

-- From bzutil
-- Replace one ingredient with another in a recipe
--    Use amount to set an amount. If that amount is a multiplier instead of an exact amount, set multiply true.
function x_util.replace_ingredient(recipe_name, old, new, amount, multiply, options)
  if data.raw.recipe[recipe_name] and (data.raw.item[new] or data.raw.fluid[new]) then
    replace_ingredient(data.raw.recipe[recipe_name], old, new, amount, multiply)
  end
end

-- From bzutil
local function set_ingredient(recipe, ingredient, quantity)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == ingredient then
        existing.amount = quantity
        return
      end
    end
    table.insert(recipe.ingredients, {type="item", name=ingredient, amount=quantity})
  end
end

-- From bzutil
-- Set an ingredient to a given quantity
function x_util.set_ingredient(recipe_name, ingredient, quantity)
  if data.raw.recipe[recipe_name] and data.raw.item[ingredient] then
    set_ingredient(data.raw.recipe[recipe_name], ingredient, quantity)
  end
end

-- From bzutil
local function remove_ingredient(recipe, old)
  index = -1
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do
      if ingredient.name == old  then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(recipe.ingredients, index)
    end
  end
end

-- From bzutil
-- Remove an ingredient from a recipe
function x_util.remove_ingredient(recipe_name, old)
  if data.raw.recipe[recipe_name] then
    remove_ingredient(data.raw.recipe[recipe_name], old)
  end
end

function x_util.debug_technology(tech_name)
  local tech = data.raw.technology[tech_name]
  if not tech then log("Unable to find "..tech_name) return end
  log(serpent.block({
    A_name    = tech.name,
    B_prereq  = tech.prerequisites,
    C_effects = tech.effects
  }))
end

function x_util.set_item_subgroup_order(subgroup_name, order)
  local item_subgroup = data.raw["item-subgroup"][subgroup_name]
  if not item_subgroup then return end
  item_subgroup.order = order
end


function x_util.scale_sprite(sprite, scale)
  sprite.scale = (sprite.scale or 0.5) * scale
  sprite.shift = {sprite.shift[1] * scale, sprite.shift[2] * scale}
end

function x_util.scale_offset(offset, scale)
  offset[1] = offset[1] * scale
  offset[2] = offset[2] * scale
end

return x_util