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
    "collision",
    "txt",
    {
        {name = "collision", getterName = "colvolCreate", getter = identityGetter}
    }
) end

do extractFile(
    "client",
    "Eliza",
    "txt",
    {
        {name = "voice", getterName = "addDlgVoices", getter = getKeywordGetter("group")},
        {name = "advancedVoice", getterName = "addDlgAdvanceVoices", getter = getKeywordGetter("race")},
        {name = "factionVoice", getterName = "addDlgFactionVoices", getter = getKeywordGetter("race")},
        {name = "combatVoice", getterName = "addDlgCombatVoices", getter = getKeywordGetter("group")},
        {name = "dialogVoice", getterName = "addDlgGroupDlg", getter = getMultiKeywordGetter("comm", "stat")}
    }
) end

do extractFile(
    "client",
    "environment",
    "txt",
    {
        {name = "water", getterName = "waterTypeCreate", getter = identityGetter}
    }
) end

do extractFile(
    "client",
    "minitype",
    "txt",
    {
        {name = "minitype", getterName = "miniCreate", getter = identityGetter}
    }
) end

do extractFile(
    "client",
    "patches",
    "txt",
    {
        {name = "patch", getterName = "patchCreate", getter = getKeywordGetter("type")}
    }
) end

do extractFile(
    "client",
    "poidata",
    "txt",
    {
        {name = "pointsOfInterest", getterName = "addPoIData", getter = getKeywordGetter("id")},
        {name = "region", getterName = "addRegionData", getter = getMultiKeywordGetter("startx", "starty", "endx", "endy")}
    }
) end

do extractFile(
    "client",
    "relations",
    "txt",
    {
        {name = "relation", getterName = "addrelation", getter = getMultiKeywordGetter("job1", "job2")}
    }
) end

do extractFile(
    "client",
    "soundcluster",
    "txt",
    {
        {name = "soundCluster", getterName = "editorAddClusterDesc", getter = getKeywordGetter("clusterId")}
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