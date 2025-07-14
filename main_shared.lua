do extractFile(
    "shared",
    "books",
    "txt",
    {
        {
            name = "book",
            getterName = "defineBook",
            getter = function(category, idx, name)
                local identifier = name
                local ressource = {category, idx, name}
                do return identifier, ressource end
            end
        }
    }
) end

do extractFile(
    "shared",
    "creatureinfo",
    "txt",
    {
        {name = "creatureInfo", getterName = "creatureInfoCreate", getter = getKeywordGetter("type")}
    }
) end

-- defines.txt: not much content, skip

do extractFile(
    "shared",
    "iteminfo",
    "txt",
    {
        {name = "itemInfo", getterName = "itemInfoCreate", getter = getKeywordGetter("type")}
    }
) end

do extractFile(
    "shared",
    "itemtype",
    "txt",
    {
        {name = "itemtype", getterName = "typeCreate", getter = identityGetter}
    }
) end

do extractFile(
    "shared",
    "material",
    "txt",
    {
        {name = "material", getterName = "createMaterial", getter = identityGetter}
    }
) end

do extractFile(
    "shared",
    "spells",
    "txt",
    {
        {name = "spell", getterName = "defineSpell", getter = identityGetter},
        {
            name = "token",
            getterName = "addTokenBonus",
            getter = function(token)
                local identifier = token[1]
                local bonus = token[2]
                do return identifier, bonus end
            end
        }
    }
) end

-- staticinfo.txt: no content, skip

do extractFile(
    "shared",
    "typification",
    "txt",
    {
        {name = "typification", getterName = "createTypification", getter = identityGetter}
    }
) end