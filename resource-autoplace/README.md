# Resource-Autoplace Documentation

Here's a quick guide on how to use the *Resource-Autoplace* module.

---

### 1. Getting started

Import the module wherever you need it, you must call the `resource-autoplace.lua` file inside the homonym directory `resource-autoplace`, just like this:

```lua
local resource_autoplace = require("resource-autoplace/resource-autoplace")
```

**Note**: Do not simply require `resource-autoplace` because it will use the base module instead of the featured one.

The `resource-autoplace` directory is organized as follows:
- `config.lua`: this is the entry point to tweak the parameters of ResourceAutoplace and customize the placement of your resources. More details in the section below.
- `expression-to-ascii-math.lua`: helper functions for *RA*, do not touch.
- `noise.lua`: helper functions for *RA*, do not touch.
- `resource-autoplace.lua`: the core functions of *RA*, theoretically there's no need to touch this file, but edge-cases and specific behaviors of resource placement may require some tweaking (hopefully not!).
- `README.md`: documentation.

---

### 2. Use Resource-Autoplace

Calling the method `resource_autoplace_settings` of Resource Autoplace will generate, based on your parameters, the information required to autoplace resources on the map. Here's an example:

```lua
data.raw.resource["iron-ore"].autoplace = resource_autoplace.resource_autoplace_settings
  {
    name = "iron-ore",
    order = "b",
    base_density = 10,
    has_starting_area_placement = true,
    starting_rq_factor_multiplier = 1.5,
    regular_rq_factor_multiplier = 1.1,
    candidate_spot_count = 22
  }
```

**Note**: *Resource Autoplace* supports the exact same behaviors and syntax of vanilla's `resource-autoplace`, plus new parameters. So it's always possible to migrate the call to vanilla's `resource-autoplace` to the featured one without changing anything, but it's not always possible to do the opposite, due to the extended customization and parameters.

---


3. Config file

In the `config.lua` file it is possible to create presets of parameters that your mod will use to place resources. Presets are only used to reduce the amount of code needed to tweak resources' placement, as they're meant to collect the common parameters among your resources, but it is always possible to override each of the preset's parameters for any resource.

The `default` preset is always available and will be used if no other presets are specified or available, it contains all the default values originally hardcoded in the base module.

Here's the default preset:

```lua
config.presets = {
  ["default"] = {
    -- -- PRESET NAME
    preset_name = "default",
    -- -- PARAMETERS (alphabetically)
    additional_richness = 0,
    base_density = 8,
    base_quantity = 1 * 10^6,
    base_spots_per_km2 = 2.5,
    blob_amplitude_multiplier = 1,
    candidate_spot_count = 21,
    double_density_distance = 1300,
    freq_multiplier_coefficient = 1,
    has_starting_area_placement = nil,
    min_radius_expression = 32,
    minimum_richness = 0,
    order = "d",
    random_probability = 1,
    random_spot_size_maximum = 2.00,
    random_spot_size_minimum = 0.25,
    regular_patch_fade_in_distance = 300,
    regular_rq_factor_coefficient = 1,
    regular_rq_factor_multiplier = 1,
    richness_post_multiplier = 1,
    seed = 100,
    size_multiplier_coefficient = 1,
    starting_amount = 40000,
    starting_resource_placement_radius = 120,
    starting_rq_factor_coefficient = 1,
    starting_rq_factor_multiplier = 1,
  },
  ["other-preset"] = ...
 }
```

A preset **MUST** have at least the default parameters declared and not nil. Each parameter will described in detail in the following section.

---

### 4. Parameters

Here there's a brief explanation of each parameter. The parameters can be specified bot in a preset, or when calling `resource_autoplace_settings`. If the second case, if a parameter is specified, it will override the value of the preset.

- `additional_richness` :: Number, (**_optional_**), (default: 0), will be added to richness before `regular_rq_factor_multiplier` and distance multiplier. It does not affect probability of anything being placed at all. This is not automatically compensated for, the caller will need to compensate for any `additional_richness` by adjusting `base_density`.
- `autoplace_control_name` :: String, (**_optional_**), (default: 8), name of the corresponding autoplace control. Default: uses `name` property. Should not be specified in presets.
- `base_density` :: Number, (**_optional_**), (default: 8), how much of this resource (probability * richness) should occur per tile on average. It is the main indicator of patches' dimension and how rich they will be. 
- `base_quantity` :: Number, (**_optional_**), (default: 1'000'000), the base value of resources outside the starting area.
- `base_spots_per_km2` :: Number, (**_optional_**), (default: 2.5), number of patches per square kilometer near the starting area.
- `blob_amplitude_multiplier` :: Number, (**_optional_**), (default: 1), Amplitude of spot "blob noise" relative to typical spot amplitude. Higher values = irregular shapes, lower values = perfect circles.
- `candidate_spot_count` :: Number, (**_optional_**), (default: 21), number of spots for that resource.
- `double_density_distance` :: Number, (**_optional_**), (default: 1300), distance at which patches have twice as much stuff in them. In-between starting area and `double_density_distance`, the values will be clamped in that range, while outside `double_density_distance`, the richness will use a multiplier "generally" based on `double_density_distance` as unit.
- `freq_multiplier_coefficient` :: Number, (**_optional_**), (default: 1), multiplies the net frequency of resources by specified value.
- `has_starting_area_placement` :: Bool, (**_optional_**), (default: nil), values: **true** - place in starting area and outside starting area independently, **false** - place outside starting area but not inside, **nil** - place everywhere as if there is no starting area.
- `min_radius_expression` :: Number, (**_optional_**), (default: 32),
- `minimum_richness` :: Number, (**_optional_**), (default: 0),
- `name` :: String, (**_required_**), (default: nil), the internal name of that ResourcePrototype to be placed, used as the default autoplace control name and patch set name. Must be specified at resource level, should not be specified in presets.
- `order` :: String, (**_optional_**), (default: "d"), order of appearance, similar to other Prototypes's order behaviour.
- `patch_set_name` :: String, (**_optional_**), (default: `name`), name of the patch set; patches sets of the same name and `seed` will overlap. Default: uses `name` property. Should not be specified in presets.
- `preset_name` :: String, (**_required_**), (default: "default"), must be specified in a preset, but can be omitted at resources. Specifies which preset of parameters is used if a parameter is not declared.
- `random_probability` :: Number, (**_optional_**), (default: 1), probability of placement at any given tile within a patch when probability is otherwise positive. This is automatically compensated for by richness, so you don't need to adjust `base_density`.
- `random_spot_size_maximum` :: Number, (**_optional_**), (default: 2.00), multiplies the `base_quantity` by specified value to evaluate the range (min quantity, max quantity) from which patch's quantity is drawn at random.
- `random_spot_size_minimum` :: Number, (**_optional_**), (default: 0.25), multiplies the `base_quantity` by specified value to evaluate the range (min quantity, max quantity) from which patch's quantity is drawn at random.
- `regular_patch_fade_in_distance` :: Number, (**_optional_**), (default: 300), used to compute the `size_effectiveness_at_distance(distance)` and clamp noise in its range, i.e. works as outer radius of the starting area, from which the regular patches are being placed.
- `regular_rq_factor_coefficient` :: Number, (**_optional_**), (default: 1), if specified, multiplies the net `rq_factor` of regular patches by this value. Higher = larger diameter but less density, lower = smaller diameter, higher density.
- `regular_rq_factor_multiplier` :: Number, (**_optional_**), (default: 1), refers to the ratio of the radius of a regular patch to the cube root of its quantity. Gets also multiplied by 1/10 before being applied.
- `richness_post_multiplier` :: Number, (**_optional_**), (default: 1), if specified, multiplies the net richness of patches by its value, similar (and in combination) to the slider in map generation. i.e. 200% richness + 2.00 `richness_post_multiplier` = 400% richness.
- `seed` :: Number, (**_optional_**), (default: 100), random seed to use when generating patch positions.
- `size_multiplier_coefficient` :: Number, (**_optional_**), (default: 1), if specified, multiplies the net size of patches by its value, similar (and in combination) to the slider in map generation. i.e. 200% size + 2.00 `size_multiplier_coefficient` = 400% size.
- `starting_amount` :: Number, (**_optional_**), (default: 40'000), base amount for starting area richness, the final total amount is computed as `starting_amount * base_density * starting_frequency_multiplier * size_multiplier`.
- `starting_resource_placement_radius` :: Number, (**_optional_**), (default: 120),
- `starting_rq_factor_coefficient` :: Number, (**_optional_**), (default: 1),if specified, multiplies the net `rq_factor` of patches in starting area by this value. Higher = larger diameter but less density, lower = smaller diameter, higher density.
- `starting_rq_factor_multiplier` :: Number, (**_optional_**), (default: 1), refers to the ratio of the radius of a patch in the starting area to the cube root of its quantity. Gets also multiplied by 1/7 before being applied.


General notions:

- `rq_factor` is the ratio of the radius of a patch to the cube root of its quantity, i.e. radius of a quantity=1 patch; higher values = fatter, shallower patches.
- `_coefficient` parameters usually happen last, at the end of the computations, after multipliers are taken in consideration and modified. Therefore have a direct impact on the results (whereas this behaviour is not guaranteed for `_multiplier`, since they may undergo multiple steps before the final value is computed).
