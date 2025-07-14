do extractFile(
    "client",
    "animation",
    "txt",
    {
        {name = "animationInfo", getterName = "addAnimInfo", getter = getKeywordGetter("itemType")}
    }
) end

do extractFile(
    "client",
    "soundprofile",
    "txt",
    {
        {name = "soundProfile", getterName = "soundProfileCreate", getter = getKeywordGetter("profilename")}
    }
) end

do extractFile(
    "client",
    "surface",
    "txt",
    {
        {name = "surface", getterName = "surfCreate", getter = getKeywordGetter("name")}
    }
) end