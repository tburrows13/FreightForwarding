local crating_util = require "__FreightForwarding__/prototypes/crating-util"

-- FF_items_data has been populated during data stage
-- changes can still be added during data-updates

-- acttually create DC items & recipe
for key, _ in pairs(FF_items_data) do
  crating_util.crate_item(key)
end