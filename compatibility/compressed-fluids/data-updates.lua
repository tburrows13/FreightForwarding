-- explicit compatibility just because original mod is not responsive
-- https://mods.factorio.com/mod/CompressedFluids
-- to be removed after/if it gets updated
if not mods["CompressedFluids"] then return end

data.raw.technology["fluid-compressor"] = table.deepcopy(data.raw.technology["fluid-compressor"])