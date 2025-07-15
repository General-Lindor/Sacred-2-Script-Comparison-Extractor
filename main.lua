------------------------------------------------------------------------------------------------------------------------
-- SETUP ---------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- local pathToExe = arg[0]
-- local executionFolder = pathToExe:gsub("Extractor.exe", "")

do dofile("utils.lua") end
do dofile("extract.lua") end

function getSimpleGetter(identifier)
    local simpleGetter = function(ressource)
        do return identifier, ressource end
    end
    do return simpleGetter end
end

function keywordWarning(ressource, keyword)
    local snippets = {
        "WARNING: Identifier not found!",
        "keyword: "..keyword,
        "ressource: "..stringifyRecursive(ressource, "    ", true, true, true)
    }
    local message = ""
    for _, snippet in ipairs(snippets) do
        do message = message.."    "..snippet.."\n" end
    end
    do print(message) end
end

function getKeywordGetter(keyword)
    -- keyword typecheck
    local typeOfKeyword = type(keyword)
    if type(typeOfKeyword) ~= "string" then
        do error("getKeywordGetter: string expected, got "..typeOfKeyword) end
    end
    
    -- getter
    local keywordGetter = function(ressource)
        local identifier = ressource[keyword]
        if identifier ~= nil then
            do return identifier, ressource end
        else
            do keywordWarning(ressource, keyword) end
            do return nil end
        end
    end
    
    -- out
    do return keywordGetter end
end

function getMultiKeywordGetter(...)
    local keywords = {...}
    -- keywords typecheck
    for _, keyword in ipairs(keywords) do
        local typeOfKeyword = type(keyword)
        if typeOfKeyword ~= "string" then
            do error("getMultiKeywordGetter: string expected, got "..typeOfKeyword) end
        end
    end
    
    -- getter
    local multiKeywodGetter = function(ressource)
        local identifier = ""
        local first = true
        for _, keyword in ipairs(keywords) do
            local identifierPart = ressource[keyword]
            if identifierPart ~= nil then
                if first then
                    do first = false end
                else
                    do identifier = identifier..", " end
                end
                do identifier = identifier..keyword.." = "..identifierPart end
            else
                do keywordWarning(ressource, keyword) end
                do return nil end
            end
        end
        do return identifier, ressource end
    end
    
    -- out
    do return multiKeywodGetter end
end

function identityGetter(identifier, ressource)
    do return identifier, ressource end
end

function reverseGetter(ressource, identifier)
    do return identifier, ressource end
end

do mgr = {} end
do mgr.surfGetID = function(name) -- client/surface.txt
    do return 'mgr.surfgetID("'..name..'")' end
end end
do mgr.resetDialogs = function() end end -- client/Eliza.txt

do print("deleting old extracted changes...") end
do os.execute('rd /s/q "EXTRACTED"') end -- incredibly unsafe and os dependent command (windows), sry for that
do print("(re)creating extraction folder...") end
do os.execute('mkdir "EXTRACTED"') end -- os dependent command (windows), sry for that

------------------------------------------------------------------------------------------------------------------------
-- ExTRACTION ----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- behavior.txt
do extractFile(
    "",
    "behaviour",
    "txt",
    {
        {name = "behaviour", getterName = "createBehaviour", getter = getKeywordGetter("name")}
    }
) end

do dofile("main_client.lua") end
do dofile("main_server.lua") end
do dofile("main_shared.lua") end