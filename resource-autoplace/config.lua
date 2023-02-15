local config = {}

---------------------------------------------------------------------------------------------------

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
    min_radius_expression = 32,
    minimum_richness = 0,
    order = "d",
    random_probability = 1,
    random_spot_size_maximum = 2.00,
    random_spot_size_minimum = 0.25,
    regular_patch_fade_in_distance = 1500,  -- 300
    regular_patch_fade_in_distance_start = 130,  -- Don't have any non-starting patches spawn until this, ramp up between this and regular_patch_fade_in_distance
    regular_rq_factor_coefficient = 1,
    regular_rq_factor_multiplier = 1,
    richness_post_multiplier = 1,
    seed = 100,
    size_multiplier_coefficient = 1,
    starting_amount = 40000,
    starting_resource_placement_radius = 90,  -- 120
    starting_rq_factor_coefficient = 1,
    starting_rq_factor_multiplier = 1,
  },
}

---------------------------------------------------------------------------------------------------

return config