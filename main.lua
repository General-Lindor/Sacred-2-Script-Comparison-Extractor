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

function getKeywordGetter(keyword)
    local simpleGetter = function(ressource)
        local identifier = ressource[keyword]
        if identifier ~= nil then
            do return identifier, ressource end
        else
            local snippets = {
                "WARNING: Identifier not found!",
                "keyword: "..keyword,
                "ressource: "..stringifyRecursive(ressource, "    ", true, true)
            }
            local message = ""
            for _, snippet in ipairs(snippets) do
                do message = message.."    "..snippet.."\n" end
            end
            do print(message) end
        end
    end
    do return simpleGetter end
end

function identityGetter(identifier, ressource)
    do return identifier, ressource end
end

function reverseGetter(ressource, identifier)
    do return identifier, ressource end
end

do mgr = {} end
do mgr.surfGetID = function(name)
    do return 'mgr.surfgetID("'..name..'")' end
end end

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