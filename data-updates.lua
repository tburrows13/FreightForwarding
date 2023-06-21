require "__FreightForwarding__.prototypes.crating-machine"
require "__FreightForwarding__.prototypes.inventory-sizes"
require "__FreightForwarding__.prototypes.stack-sizes"
require "__FreightForwarding__.prototypes.recipe-updates"
require "__FreightForwarding__.prototypes.autoplace-updates"

for _, tile in pairs(data.raw.tile) do
  tile.check_collision_with_entities = true
end

-- Compatibility
require "__FreightForwarding__.compatibility.advanced-centrifuge.data-updates"
require "__FreightForwarding__.compatibility.aai-industry.data-updates"
require "__FreightForwarding__.compatibility.aai-vehicles-ironclad.data-updates"
require "__FreightForwarding__.compatibility.big-mining-drill.data-updates"
require "__FreightForwarding__.compatibility.bz.data-updates"
require "__FreightForwarding__.compatibility.compressed-fluids.data-updates"
require "__FreightForwarding__.compatibility.concentrated-solar.data-updates"
require "__FreightForwarding__.compatibility.krastorio2.data-updates"
require "__FreightForwarding__.compatibility.planetfall.data-updates"
require "__FreightForwarding__.compatibility.plutonium-energy.data-updates"
require "__FreightForwarding__.compatibility.rocket-silo-construction.data-updates"
require "__FreightForwarding__.compatibility.train-construction-site.data-updates"
require "__FreightForwarding__.compatibility.underwater-pipes.data-updates"
