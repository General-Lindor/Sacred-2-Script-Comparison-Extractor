------------
-- stage0 --
------------

-- extract changes
function processExtractedRessources(
    ressources_original,
    ressources_modified
)
    local ressources_added = {}
    local ressources_altered = {}
    local ressources_removed = {}
    
    for k, v in pairs(ressources_original) do
        if v ~= nil then
            local modified_ressource = ressources_modified[k]
            if modified_ressource == nil then
                do ressources_removed[k] = v end
            else
                if not compare(modified_ressource, v) then
                    do ressources_altered[k] = modified_ressource end
                end
                do ressources_modified[k] = nil end
            end
        end
    end
    
    for k, v in pairs(ressources_modified) do
        if v ~= nil then
            do ressources_added[k] = v end
        end
    end
    
    do return ressources_added, ressources_altered, ressources_removed end
end

-- export changes
function exportProcessedRessources(
    foldername,
    filename,
    ressourcename,
    ressources_added,
    ressources_altered,
    ressources_removed
)
    local dirname = "EXTRACTED\\"
    if foldername ~= "" then
        do dirname = dirname..foldername.."\\" end
    end
    do dirname = dirname..filename.."\\"..ressourcename end
    do os.execute("mkdir "..dirname) end
    
    local file
    
    do file = io.open(dirname.."/".."added.txt", "w+") end
    for k, v in pairs(ressources_added) do
        do file:write("identifier: "..stringify(k).."\n") end
        do file:write("ressource: "..stringify(v).."\n") end
        do file:write("\n") end
    end
    do file:close() end
    
    do file = io.open(dirname.."/".."altered.txt", "w+") end
    for k, v in pairs(ressources_altered) do
        do file:write("identifier: "..stringify(k).."\n") end
        do file:write("ressource: "..stringify(v).."\n") end
        do file:write("\n") end
    end
    
    do file = io.open(dirname.."/".."removed.txt", "w+") end
    for k, v in pairs(ressources_removed) do
        do file:write("identifier: "..stringify(k).."\n") end
        do file:write("ressource: "..stringify(v).."\n") end
        do file:write("\n") end
    end
end

------------
-- stage1 --
------------
--[[
-- mgr.create(ressource) - extractor
function extractSingle(
    foldername,
    filename,
    fileextension,
    functionName,
    getIdentifier
)
    local filepath = foldername.."/"..filename.."."..fileextension
    do print("extracting "..filepath.."...") end
    
    local getRessources = function(prefix)
        local ressources = {}
        
        mgr = {}
        do mgr[functionName] = function(ressource)
            local identifier = getIdentifier(ressource)
            if identifier ~= nil then
                do ressources[identifier] = ressource end
            end
        end end
        do dofile(prefix..filepath) end
        
        do return ressources end
    end
    
    local ressources_original = getRessources("ORIGINAL/")
    local ressources_modified = getRessources("MODIFIED/")
    
    local ressources_added, ressources_altered, ressources_removed = processExtractedRessources(ressources_original, ressources_modified)
    do exportProcessedRessources(
        foldername,
        filename,
        ressources_added,
        ressources_altered,
        ressources_removed
    ) end
end

-- mgr.create(identifier, ressource) - extractor
function extractDouble(
    foldername,
    filename,
    fileextension,
    functionName
)
    local filepath = foldername.."/"..filename.."."..fileextension
    do print("extracting "..filepath.."...") end
    
    local getRessources = function(prefix)
        local ressources = {}
        
        mgr = {}
        do mgr[functionName] = function(identifier, ressource)
            do ressources[identifier] = ressource end
        end end
        do dofile(prefix..filepath) end
        
        do return ressources end
    end
    
    local ressources_original = getRessources("ORIGINAL/")
    local ressources_modified = getRessources("MODIFIED/")
    
    local ressources_added, ressources_altered, ressources_removed = processExtractedRessources(ressources_original, ressources_modified)
    do exportProcessedRessources(
        foldername,
        filename,
        ressources_added,
        ressources_altered,
        ressources_removed
    ) end
end

-- mgr.create(ressource, identifier) - extractor
function extractDoubleReverse(
    foldername,
    filename,
    fileextension,
    functionName
)
    local filepath = foldername.."/"..filename.."."..fileextension
    do print("extracting "..filepath.."...") end
    
    local getRessources = function(prefix)
        local ressources = {}
        
        mgr = {}
        do mgr[functionName] = function(ressource, identifier)
            do ressources[identifier] = ressource end
        end end
        do dofile(prefix..filepath) end
        
        do return ressources end
    end
    
    local ressources_original = getRessources("ORIGINAL/")
    local ressources_modified = getRessources("MODIFIED/")
    
    local ressources_added, ressources_altered, ressources_removed = processExtractedRessources(ressources_original, ressources_modified)
    do exportProcessedRessources(
        foldername,
        filename,
        ressources_added,
        ressources_altered,
        ressources_removed
    ) end
end
--]]
------------
-- stage2 --
------------

function extractFile(
    foldername,
    filename,
    fileextension,
    fileressources
)
    local filepath = filename.."."..fileextension
    if foldername ~= "" then
        do filepath = foldername.."/"..filepath end
    end
    do io.write("extracting "..filepath.."...") end
    do io.flush() end
    if not file_exists("ORIGINAL/"..filepath) then
        do io.write(" original file doesn't exist!\n") end
        do io.flush() end
        do return end
    end
    if not file_exists("MODIFIED/"..filepath) then
        do io.write(" modified file doesn't exist!\n") end
        do io.flush() end
        do return end
    end
    do io.write("\n") end
    do io.flush() end
    
    -- get original
    for _, ressource in pairs(fileressources) do
        do ressource.original = {} end
        do mgr[ressource.getterName] = function(...)
            local identifier, value = ressource.getter(...)
            if identifier ~= nil then
                do (ressource.original)[identifier] = value end
            end
        end end
    end
    do dofile("ORIGINAL/"..filepath) end
    
    -- get modified
    for _, ressource in pairs(fileressources) do
        do ressource.modified = {} end
        do mgr[ressource.getterName] = function(...)
            local identifier, value = ressource.getter(...)
            if identifier ~= nil then
                do (ressource.modified)[identifier] = value end
            end
        end end
    end
    do dofile("MODIFIED/"..filepath) end
    
    -- cleanup mgr to save memory and avoid unintentional collisions
    for _, ressource in pairs(fileressources) do
        do mgr[ressource.getterName] = nil end
    end
    
    -- compare & export
    for _, ressource in pairs(fileressources) do
        local ressources_added, ressources_altered, ressources_removed = processExtractedRessources(ressource.original, ressource.modified)
        do exportProcessedRessources(
            foldername,
            filename,
            ressource.name,
            ressources_added,
            ressources_altered,
            ressources_removed
        ) end
        do ressource = nil end
    end 
end