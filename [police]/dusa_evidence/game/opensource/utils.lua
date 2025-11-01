Utils = {}

local function retreiveExportsData(export, override)
    local newMethods = {}

    for k,v in pairs(override) do
        local method = export[v.originalMethod]
        if method then
            v.selfEffect = function(...)
                return method(export, ...)
            end
            newMethods[k] = v
        end
    end
    return newMethods
end

local function retreiveNumberIndexedData(playerTable, functionsOverride)
    local newMethods = {}

    local function modifyMethods(data, method, modification)
        for dataIndex, dataValue in ipairs(data) do
            local originalMethods = type(modification.originalMethod) == 'table' and modification.originalMethod or { modification.originalMethod }
            local originalMethodRef
            local originalMethod
            for _, method in ipairs(originalMethods) do
                originalMethod = method
                originalMethodRef = originalMethod and dataValue[method]
                if originalMethodRef then
                    break
                end
            end
            
            local hasKeys = modification.hasKeys
            if hasKeys then
                local modifier = modification.modifier
                if modifier and modifier.effect then
                    newMethods[dataIndex][method] = modifier.effect(dataValue)
                end
            end

            if originalMethodRef then
                local modifier = modification.modifier
                newMethods[dataIndex] = newMethods[dataIndex] or {}
                local effect
                if modifier then
                    if modifier.executeFun then
                        effect = modifier.effect(originalMethodRef, originalMethod) 
                    else
                        effect = function(...)
                            return modifier.effect(originalMethodRef, ...)
                        end
                    end
                else
                    effect = originalMethodRef
                end
                newMethods[dataIndex][method] = effect
            end
        end
    end

    local function processTable(tableToProcess, overrides)
        for _, value in ipairs(tableToProcess) do
            for method, modification in pairs(overrides) do
                if type(modification) == 'table' and not modification.originalMethod then
                    processTable(value[method], modification)
                else
                    modifyMethods(tableToProcess, method, modification)
                end
            end
        end

    end

    processTable(playerTable, functionsOverride)
    return newMethods
end

local function retreiveStringIndexedData(wrappedData, functionsOverride, src)
    local newMethods = {}

    local function modifyMethods(data, method, modification)
        if type(modification) ~= 'table' then return end
        local selfEffect = modification.selfEffect
        local originalMethod = selfEffect or modification.originalMethod
        local ref = selfEffect or data[originalMethod]
        local modifier = modification.modifier
        if ref and originalMethod then
            local lastEffect
            if modifier then
                local executeFun, effect, passSource in modifier
                if passSource and executeFun then
                    if not src then return error('source not exist') end
                    lastEffect = ref(src)
                elseif executeFun then
                    lastEffect = effect and effect(ref) or ref
                else
                    lastEffect = function(...)
                        if passSource and not src then
                            error('source not exist')
                        end
                        return passSource and src and effect and effect(ref, src, ...) or effect and effect(ref, ...) or ref(src, ...)
                    end
                end
            else
                lastEffect = ref
            end
            newMethods[method] = lastEffect
        end
    end

    local function processTable(tableToProcess, overrides)
        for method, modification in pairs(overrides) do
            if type(modification) == 'table' and not modification.originalMethod and not modification.add then
                processTable(tableToProcess[method], modification)
            else
                modifyMethods(tableToProcess, method, modification)
            end
        end
    end

    processTable(wrappedData, functionsOverride)
    return newMethods
end

local function UUID(num)
    num = type(num) == 'number' and num or 5
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    
    local uuid = string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)

    local timestamp = os.time()
    local uuidWithTime = string.format("%s-%s", uuid, timestamp)
    
    if num > 0 and num <= #uuidWithTime then
        uuidWithTime = string.sub(uuidWithTime, 1, num)
    end

    return uuidWithTime
end

local function table_merge(t1, t2, addDuplicateNumbers)
    if addDuplicateNumbers == nil then addDuplicateNumbers = true end
    for k, v in pairs(t2) do
        local type1 = type(t1[k])
        local type2 = type(v)

		if type1 == 'table' and type2 == 'table' then
            table_merge(t1[k], v, addDuplicateNumbers)
        elseif addDuplicateNumbers and (type1 == 'number' and type2 == 'number') then
            t1[k] += v
		else
			t1[k] = v
        end
    end

    return t1
end

local function Log(message, type)
    exports['fm-logs']:createLog({
        LogType = "Custom", -- The log type
        Message = message, -- The message of the log
        Level = type or "info", -- The level of the log (can be filtered on Fivemerr) (info by default)
        Resource = Bridge.Resource, -- Resource where the log is coming from (If not provided, `fm-logs` will be set by default)
        Metadata = {} -- Custom attributes to be added
    })
end

Utils.table_merge = table_merge
Utils.retreiveStringIndexedData = retreiveStringIndexedData
Utils.retreiveExportsData = retreiveExportsData
Utils.retreiveNumberIndexedData = retreiveNumberIndexedData
Utils.Log = Log
Utils.UUID = UUID