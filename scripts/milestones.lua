remote.add_interface("FreightForwardingMilestones", {
  milestones_presets = function()
    return {
      ["Freight Forwarding"] = {
        required_mods = {"FreightForwarding"},
        milestones = {
          {type="group",      name="Science"},
          {type="item",       name="automation-science-pack", quantity=1},
          {type="item",       name="logistic-science-pack",   quantity=1},
          {type="item",       name="x-transport-science-pack",quantity=1},
          {type="item",       name="military-science-pack",   quantity=1},
          {type="item",       name="chemical-science-pack",   quantity=1},
          {type="item",       name="production-science-pack", quantity=1},
          {type="item",       name="utility-science-pack",    quantity=1},
          {type="item",       name="space-science-pack",      quantity=1},
          {type="item",       name="automation-science-pack", quantity=1000, next="x10"},
          {type="item",       name="x-transport-science-pack",quantity=1000, next="x10"},
          {type="item",       name="logistic-science-pack",   quantity=1000, next="x10"},
          {type="item",       name="military-science-pack",   quantity=1000, next="x10"},
          {type="item",       name="chemical-science-pack",   quantity=1000, next="x10"},
          {type="item",       name="production-science-pack", quantity=1000, next="x10"},
          {type="item",       name="utility-science-pack",    quantity=1000, next="x10"},
          {type="item",       name="space-science-pack",      quantity=10000, next="x10"},

          {type="group",      name="Resources"},
          --{type="item",       name="lead-plate",              quantity=1},
          {type="fluid",      name="petroleum-gas",           quantity=1},
          --{type="item",       name="titanium-plate",          quantity=1},
          {type="item",       name="uranium-235",             quantity=1},
          {type="item",       name="ff-titansteel-plate",     quantity=1},

          {type="group",      name="Progress"},
          {type="item",       name="locomotive",              quantity=1},
          {type="item",       name="construction-robot",      quantity=1},
          {type="item",       name="hcraft-entity",           quantity=1},
          {type="item",       name="spidertron",              quantity=1},
          {type="item",       name="lex-flying-cargo",        quantity=1},
          {type="technology", name="rocket-silo",             quantity=1},
          {type="item",       name="rocket-part",             quantity=100},

          {type="group",      name="Power"},
          {type="item",       name="solar-panel",             quantity=1},
          {type="item",       name="solar-panel",             quantity=1000, next="x10"},
          {type="item",       name="nuclear-reactor",         quantity=1},

          {type="group",      name="Kills"},
          {type="kill",       name="medium-biter",            quantity=1},
          {type="kill",       name="big-biter",               quantity=1},
          {type="kill",       name="behemoth-biter",          quantity=1},
          {type="kill",       name="behemoth-biter",          quantity=1000, next="x10"},
          {type="kill",       name="character",               quantity=1, next="x5"},
        }
      },
    }
  end
})
