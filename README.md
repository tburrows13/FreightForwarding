X-Logistics adds much greater variety to long-distance logistics.

The central changes revolve around the transportation of intermediate resources, which have all had their stack sizes reduced by 90%. In addition, trains and ships have lost 90% of their inventory space. Instead, resources must be put into crates using a crating machine: each crate can hold 100 regular stacks of that item.

Train -> cargo ship -> train logistics is strongly encouraged by the following balance changes:

- Regular landfill can only be used on shallow water and deep landfill (that can fill any water) is extremely expensive. Rails are 10x more expensive, and bridges even more so.
- Since items are being transported so compactly, transfer from trains to ships is much more straightforward.
- Map generation features large islands/continents, with plenty of opportunity for cargo ships in between or around them.

When starting a game, please use the 'X-Logistics Default' map preset for the intended experience (a notification will appear in-game if you forget).

---

## Included Mods

- [Deadlock's Crating Machine](https://mods.factorio.com/mod/DeadlockCrating)
- Water mods
    - [Cargo Ships](https://mods.factorio.com/mod/cargo-ships): large inventories for transport across water; oil rigs for drilling oil in the ocean
    - [Canal Builder Simplified](https://mods.factorio.com/mod/CanalBuilderMAV): allows placing shallow water adjacent to existing water _(optional)_
    - [Beautiful Bridge Railway for Cargoships](https://mods.factorio.com/mod/beautiful_bridge_railway_Cargoships) _(optional)_
    - [Underwater Pipes](https://mods.factorio.com/mod/underwater-pipes): construct offshore oil rig infrastructure with less landfill _(optional)_
    - [Hovercrafts](https://mods.factorio.com/mod/Hovercrafts): easier navigation across both water and land _(optional)_
    - [AAI Vehicles: Ironclad](https://mods.factorio.com/mod/https://mods.factorio.com/mod/aai-vehicles-ironclad): useful boat for transport or combat _(optional)_
- [Spidertron Patrols](https://mods.factorio.com/mod/SpidertronPatrols): another logistics alternative
- [Just Another Greenhouse Mod](https://mods.factorio.com/mod/just-another-greenhouse): automatically grow wood for crates and rails (and consequently production science)
- [Island Start](https://mods.factorio.com/mod/IslandStart): provides island/continent generation to X-Logistics map preset
- [Robot Attrition](https://mods.factorio.com/mod/robot_attrition): discourages transportation of crates by logistic bots, which is otherwise impossible to balance _(optional)_

---

## Information

### Other mods
I'd recommend playing with my modpack [X-Mod](https://mods.factorio.com/mod/X-Mod), which provides a few extra challenges to vanilla gameplay and makes for a great 'Vanilla Plus' experience.

X-Logistics is not currently balanced to work with any overhaul mods (such as Bob's+Angel's, Krastorio2 and Space Exploration).

Other small-to-medium mods will probably work, although may break the intended balance.

### Bugs
X-Logistics adds, removes, and changes many things in the above mods, so if you find a bug in them, please confirm that it still occurs without X-Logistics present before reporting it to that mod's owner, or report it to me and I can let you know whether it's my bug or not.

### Feedback
I'd love to hear any feedback you have, such as suggestions of additions, changes, or removals that you think would improve the mod.

### Attributions
Thank you to everyone who's contributed to the mods used in X-Logistics. In particular: Deadlock989, schnurrebutz, robot256, Yehn, and Jakzie.
Thank you to ElephantInTheRoom for feedback and suggestions.

---

## Full list of changes

### Item transport
- All intermediate resource stack sizes divided by 10
- Cargo wagon (including cargo ships) inventory sizes divided by 10
- Car and spidertron inventory sizes divided by 5
- Wooden/Iron/Steel chest sizes decreased from 16/32/48 to 12/18/24
- All other container inventory sizes divided by 2
- Burner input inventory sizes multiplied by 3 (to somewhat offset the significant decrease in fuel stack sizes)

### Crating machine
- Added crating recipes for seeds, explosives, engines and electric engines
- All crate sizes increased from 0.2 stacks to 100 stacks
- Size increased from 3x3 to 4x4
- Crating machine recipes changed and technology prerequisites fixed so that the first crating machine can be unlocked with green science
- Crating recipe names changed from 'Iron ore: pack crate' to 'Pack Iron ore crate'

### Landfill
- Enabled shallow water around the edges of lakes/oceans that can be walked on
- Normal landfill can only be placed on shallow water (costs 20 stone and 2 wood) _(optional change)_
- Added deep landfill for non-shallow water (costs 15 shallow landfill, 15 concrete and 15 iron sticks) _(optional change)_

### Map generation
- Added 'X-Mod Default preset' which uses island/continent generation from IslandStart
- Oil only spawns in water (relevant mod settings have been hidden)

### Recipe changes
- Added wood to rail cost and multiplied cost by 10 (cost x5, rails per craft x0.5)
- Production science costs 3 rails instead of 30 to compensate
- Bridges' extra material multiplied by 40 (if installed)

### Greenhouse
- Locked greenhouse and wood recipes behind a new technology (only requires red science)
- Removed starting seed (trees have a 1/50 chance of containing a seed)
- Tree growth now has a chance of not returning any seeds (but still gains seeds on average) 
- Renamed recipes and improved recipe icons
- Increased default chance of trees dropping seeds from 2% to 4% (can still be configured in mod settings)
