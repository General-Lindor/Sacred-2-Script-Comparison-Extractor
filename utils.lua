-- table => boolean
function checkHasTables(t)
    local type_t = type(t)
    if type_t ~= "table" then
        do error("checkHasTables requires a table as input, "..type_t.." given") end
    end
    for k, v in pairs(t) do
        if type(k) == "table" then
            do return true end
        end
        if type(v) == "table" then
            do return true end
        end
    end
    do return false end
end

-- table => boolean
function checkMultiline(t)
    local type_t = type(t)
    if type_t ~= "table" then
        do error("checkHasTables requires a table as input, "..type_t.." given") end
    end
    local itemCount = 0
    for k, v in pairs(t) do
        do itemCount = itemCount + 1 end
        if type(k) == "table" then
            do return true end
        end
        if type(v) == "table" then
            do return true end
        end
    end
    do return itemCount > 3 end
end

-- any, string, boolean, boolean => string
function stringifyRecursive(obj, indent, withQuotes, ignoreFirstIndent, pretty)
    local unindentedString = ""
    local t_obj = type(obj)
    if withQuotes and (t_obj == "string") then
        do unindentedString = '"'..tostring(obj)..'"' end
    elseif t_obj == "table" then
        local nextIndent = indent.."    "
        
        -- start of the table
        do unindentedString = "{" end
        
        -- single or multi line table?
        local multiline = pretty and checkMultiline(obj)
        
        -- currying: inner function for adding table entries
        local addComma = false
        local addEntry = function(entry)
            if addComma then
                do unindentedString = unindentedString.."," end
                if multiline then
                    do unindentedString = unindentedString.."\n" end
                else
                    do unindentedString = unindentedString.." " end
                end
            else
                do addComma = true end
                if multiline then
                    do unindentedString = unindentedString.."\n" end
                end
            end
            do unindentedString = unindentedString..entry end
        end
        
        -- first the ipairs ...
        local highestIdx = 0
        for k, v in ipairs(obj) do
            do highestIdx = k end
            local s_v = stringifyRecursive(v, nextIndent, true, not multiline, pretty)
            do addEntry(s_v) end
        end
        
        -- ... second the non-ipairs
        local keys = {}
        for k, v in pairs(obj) do
            if math.type(k) == "integer" then
                if k > 0 and k <= highestIdx then
                    do goto continue end
                else
                    do error("WARNING: input table to stringify has ipairs jumps; this type of table isn't supported as it can't be constructed using standard lua table constructors.") end
                end
            elseif math.type(k) == "float" then
                do error("WARNING: input table to stringify has floats as keys; this type of table isn't supported as it can't be constructed using standard lua table constructors.") end
            end
            do keys[#keys + 1] = k end
            ::continue::
        end
        do table.sort(keys) end
        for i, k in ipairs(keys) do
            local v = obj[k]
            local s_k = stringifyRecursive(k, nextIndent, false, not multiline, pretty)
            local s_v = stringifyRecursive(v, nextIndent, true, true, pretty)
            local merged = s_k.." = "..s_v
            do addEntry(merged) end
        end
        
        --end of the table
        if multiline then
            do unindentedString = unindentedString.."\n"..indent end
        end
        do unindentedString = unindentedString.."}" end
    else
        do unindentedString = tostring(obj) end
    end
    if ignoreFirstIndent then
        do return unindentedString end
    else
        do return indent..unindentedString end
    end
end

-- any => string (multiline)
function stringify(obj)
    do return stringifyRecursive(obj, "", true, false, true) end
end

-- any => string (single line)
function serialize(obj)
    do return stringifyRecursive(obj, "", true, false, false) end
end

-- table, table => boolean
function halfCompareTables(t1, t2)
    for k1, v1 in pairs(t1) do
        if type(k1) == "table" then
            local found = false
            for k2, v2 in pairs(t2) do
                if compare(k1, k2) then
                    if compare(v1, v2) then
                        do found = true end
                        do break end
                    end
                end
            end
            if not found then
                do return false end
            end
        else
            if not compare(t2[k1], v1) then
                do return false end
            end
        end
    end
    do return true end
end

-- any, any => boolean
function compare(obj1, obj2)
    if obj1 == obj2 then
        do return true end
    else
        if type(obj1) == "table" then
            if type(obj2) == "table" then
                if not halfCompareTables(obj1, obj2) then
                    do return false end
                end
                if not halfCompareTables(obj2, obj1) then
                    do return false end
                end
                do return true end
            else
                do return false end
            end
        else
            do return false end
        end
    end
end

-- string => boolean
function file_exists(filepath)
    local file = io.open(filepath, "r")
    if file ~= nil then
        do io.close(file) end
        do return true end
    else
        do return false end
    end
end