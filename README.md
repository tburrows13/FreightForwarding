X-Logistics is an attempt to add greater variety to long-distance logistics.

The central changes revolve around the transportation of intermediate resources, which have all had their stack sizes reduced by 90%. In addition, trains and ships also have lost 90% of their inventory space. Instead, resources must be put into crates using a crating machine: each crate can hold 100 regular stacks of that item.

Train -> cargo ship -> train logistics is strongly encouraged by a variety of balance changes:

Regular landfill can only be used on shallow water and deep landfill (that can fill any water) is extremely expensive. Rails are 10x more expensive, and bridges even more so.
Since items are being transported so compactly, transfer from trains to ships is much more straightforward.
Map generation features large islands/continents, with plenty of opportunity for cargo ships in between or around them.

When starting a game, please use the 'X-Logistics Default' map preset for the intended experience (a notification will appear in-game if you forget).

---

## Included Mods

- [Deadlock's Crating Machine](https://mods.factorio.com/mod/DeadlockCrating)
- Water mods
    - [Cargo Ships](https://mods.factorio.com/mod/cargo-ships): large inventories for transport across water; oil rigs for drilling oil in the ocean
    - [Canal Builder Simplified](https://mods.factorio.com/mod/CanalBuilderMAV): allows placing shallow water adjacent to existing water
    - [Beautiful Bridge Railway for Cargoships](https://mods.factorio.com/mod/beautiful_bridge_railway_Cargoships): (optional)
    - [Underwater Pipes](https://mods.factorio.com/mod/underwater-pipes) (optional)
- [Spidertron Patrols](https://mods.factorio.com/mod/SpidertronPatrols): another logistics alternative
- [Just Another Greenhouse Mod](https://mods.factorio.com/mod/just-another-greenhouse): automatically grow wood for crates, rails (and consequently production science)
- [Island Start](https://mods.factorio.com/mod/IslandStart): provides island/continent generation to X-Mod map preset

---

## Information

### Other mods
X-Logistics is not currently balanced to work with any overhaul mods (such as Bob's+Angel's, Krastorio2 and Space Exploration).

Other small-to-medium mods will probably work, although may break the intended balance.

### Bugs
X-Logistics adds, removes, and changes many things in the above mods, so if you find a bug in them, please confirm that it still occurs without X-Logistics present before reporting it to that mod's owner, or report it to me and I can let you know whether it's my bug or not.

### Feedback
I'd love to hear any feedback you have, such as suggestions of additions, changes, or removals that you think would improve the mod.

---

## Full list of changes

### Item transport
- All intermediate resource stack sizes divided by 10
- Cargo wagon (including cargo ships) inventory sizes divided by 10
- Car and spidertron inventory sizes divided by 5
- Container inventory sizes divided by 2
- Burner input inventory sizes multiplied by 3 (to somewhat offset the significant decrease in fuel stack sizes)

### Crating machine
- Added crating recipes for seeds, explosives, engines and electric engines
- All crate sizes increased from 0.2 stacks to 100 stacks
- Size increased from 3x3 to 4x4
- Recipe names changed from 'Iron ore: pack crate' to 'Pack Iron ore crate'

### Landfill
- Enabled shallow water around the edges of lakes/oceans that can be walked on
- Normal landfill can only be placed on shallow water (cost 20 stone)
- Added deep landfill for non-shallow water (cost 400 stone)

### Map generation
- Added 'X-Mod Default preset' which uses island/continent generation from IslandStart
- Oil only spawns in water (relevant mod settings have been hidden)

### Recipe changes
- Added wood to rail cost and multiplied cost by 10 (cost x5, rails per craft x0.5)
- Production science costs 3 rails instead of 30 to compensate
- Bridges extra material multiplied by 40 (if installed)

### Greenhouse
- Locked greenhouse and wood recipes behind a new technology (only requires red science)
- Removed starting seed (trees have a 1/50 chance of containing a seed)
