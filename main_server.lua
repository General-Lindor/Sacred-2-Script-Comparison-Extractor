do extractFile(
    "server",
    "balance",
    "txt",
    {
        {name = "balanceValues", getterName = "setBalanceValues", getter = getSimpleGetter("balanceValues")},
        {name = "beValues", getterName = "setBalanceBase", getter = getSimpleGetter("beValues")},
        {name = "basetables", getterName = "setBaseTables", getter = getSimpleGetter("basetables")},
        {name = "subfamSlots", getterName = "loadSubfamSlots", getter = getSimpleGetter("subfamSlots")},
        {name = "subfamDroplists", getterName = "loadSubfamDroplists", getter = getSimpleGetter("subfamDroplists")},
        {name = "shrinkheadMinionMap", getterName = "loadShrinkheadMinionMap", getter = getSimpleGetter("shrinkheadMinionMap")}
    }
) end

do extractFile(
    "server",
    "blueprint",
    "txt",
    {
        {name = "blueprint", getterName = "createBlueprint", getter = identityGetter},
        {name = "bonus", getterName = "createBonus", getter = identityGetter},
        {name = "bonusgroup", getterName = "createBonusgroup", getter = identityGetter},
        {name = "blueprintset", getterName = "createBlueprintset", getter = identityGetter}
    }
) end

do extractFile(
    "server",
    "creatures",
    "txt",
    {
        {name = "creature", getterName = "createCreature", getter = getKeywordGetter("id")},
        {name = "creatureBonus", getterName = "addCreatureBonus", getter = identityGetter},
        {name = "skill", getterName = "createSkill", getter = getKeywordGetter("skill_name")},
        {
            name = "creatureSkill",
            getterName = "addCreatureSkill",
            getter = function(creatureID, creatureSkill)
                local identifier = "creatureID: "..serialize(creatureID)..", skillID: "..serialize(creatureSkill.skill_id) -- one creature can have many skills and one skill can have many creatures. Only the combination is unique.
                do return identifier, creatureSkill end
            end
        },
        {name = "creatureBpRelation", getterName = "addCreatureBpRelation", getter = getKeywordGetter("creature_id")}, -- every creature needs to have a unique blueprint. No need to get the combination.
        {
            name = "mapPos",
            getterName = "addMapPos",
            getter = function(mapPos)
                local identifier = serialize(mapPos) -- it is incredibly hard to get a UUID for this
                do return identifier, relation end
            end
        }
    }
) end

do extractFile(
    "server",
    "drop",
    "txt",
    {
        {name = "dropList", getterName = "createDroplist", getter = identityGetter},
        {name = "dropPattern", getterName = "createDroppattern", getter = identityGetter},
        {name = "shrinkheadDropMap", getterName = "loadShrinkheadDropMap", getter = getSimpleGetter("shrinkheadDropMap")}
    }
) end

do extractFile(
    "server",
    "equipsets",
    "txt",
    {
        {
            name = "reservation",
            getterName = "reserveEquipsets",
            getter = function(sets, entries)
                local identifier = "reservation"
                local reservation = {sets, entries}
                do return identifier, reservation end
            end
        },
        {name = "equipsets", getterName = "createEquipset", getter = getKeywordGetter("id")}
    }
) end

do extractFile(
    "server",
    "faction",
    "txt",
    {
        {name = "faction", getterName = "addFaction", getter = getKeywordGetter("id")},
        {name = "factionRelation", getterName = "addFactionRelation", getter = getMultiKeywordGetter("id1", "id2")}
    }
) end

do extractFile(
    "server",
    "pathObjects",
    "txt",
    {
        {
            name = "path",
            getterName = "addPathObject",
            getter = function(path)
                local identifier = "name: "..serialize(path.name)..", sector: "..serialize(path.sector)
                do return identifier, path end
            end
        }
    }
) end

do extractFile(
    "server",
    "portals",
    "txt",
    {
        {name = "path", getterName = "definePortal", getter = getKeywordGetter("woid")}
    }
) end

-- quest.txt: too complicated, skip
-- questscripts.txt: too complicated, skip

do extractFile(
    "server",
    "region",
    "txt",
    {
        {name = "region", getterName = "regionSetup", getter = identityGetter}
    }
) end

-- respawn.txt: irregular, skip
-- spawn.txt: not uniquely identifyable ressources, skip
-- spawnpos.txt: deprecated, skip
-- treasure.txt: nearly no content, skip

do extractFile(
    "server",
    "triggerarea",
    "txt",
    {
        {name = "triggerArea", getterName = "addTriggerArea", getter = getKeywordGetter("name")}
    }
) end

do extractFile(
    "server",
    "triggervolumes",
    "txt",
    {
        {name = "triggerVolume", getterName = "addTriggerVolume", getter = getKeywordGetter("name")}
    }
) end

do extractFile(
    "server",
    "waypoints",
    "txt",
    {
        {name = "waypoint", getterName = "createWay", getter = identityGetter}
    }
) end

do extractFile(
    "server",
    "weaponpool",
    "txt",
    {
        {name = "weaponpool", getterName = "addWeaponPool", getter = getKeywordGetter("dbid")}
    }
) end

-- weather.txt: nt uniquely identifyable, skip
-- worldobjecthints.txt: no content, skip

do extractFile(
    "server",
    "worldobjects",
    "txt",
    {
        {name = "worldObject", getterName = "addWorldObject", getter = identityGetter}
    }
) end