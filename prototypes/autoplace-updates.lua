--[[

Goes from 
  {
    source_location = {
      filename = "__base__/prototypes/entity/enemy-autoplace-utils.lua",
      line_number = 142
    },
    type = "variable",
    variable_name = "distance"
  },

  to

  {
    arguments = {
      {
        source_location = {
          filename = "__base__/prototypes/entity/enemy-autoplace-utils.lua",
          line_number = 142
        },
        type = "variable",
        variable_name = "distance"
      },
      {
        literal_value = 7,
        source_location = {
          filename = "__core__/lualib/noise.lua",
          line_number = 86
        },
        type = "literal-number"
      }
    },
    function_name = "divide",
    source_location = {
      filename = "__base__/prototypes/entity/enemy-autoplace-utils.lua",
      line_number = 142
    },
    type = "function-application"
  },
]]

local distance_scale = 2.5

local function update_expression(expression)
  for key, value in pairs(expression) do
    if type(value) == "table" then
      if value.type == "variable" and value.variable_name == "distance" then
        expression[key] = {
          arguments = {
            {
              type = "variable",
              variable_name = "distance"
            },
            {
              literal_value = distance_scale,
              type = "literal-number"
            }
          },
          function_name = "divide",
          type = "function-application"
        }
      elseif value.type == "variable" and value.variable_name == "starting_area_radius" then
        expression[key] = {
          arguments = {
            {
              type = "variable",
              variable_name = "starting_area_radius"
            },
            {
              literal_value = distance_scale,
              type = "literal-number"
            }
          },
          function_name = "divide",
          type = "function-application"
        }
      else
        update_expression(value)
      end
    end
  end
end

for _, unit_spawner in pairs(data.raw["unit-spawner"]) do
  if unit_spawner.autoplace and unit_spawner.autoplace.probability_expression then
    update_expression(unit_spawner.autoplace.probability_expression)
  end
end

for _, turret in pairs(data.raw["turret"]) do
  if turret.autoplace and turret.autoplace.probability_expression then
    update_expression(turret.autoplace.probability_expression)
  end
end

update_expression(data.raw["noise-expression"]["enemy_base_probability"].expression)
update_expression(data.raw["noise-expression"]["enemy-base-intensity"].expression)

--log(serpent.block(data.raw["unit-spawner"]["biter-spawner"].autoplace))
--log("-----------------------------------")
--log(serpent.block(data.raw["noise-expression"]["enemy-base-intensity"].expression))
