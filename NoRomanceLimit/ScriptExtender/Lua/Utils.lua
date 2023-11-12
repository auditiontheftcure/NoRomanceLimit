

function stripUUID(strin)
    return string.sub(strin, 1,  -38)
end
function isInList(target, list)
    for _, value in ipairs(list) do
        if value == target then
            return true
        end
    end
    return false
end

function isSublistInListOfLists(sublist,listOfLists, ignorelist)
    if not ignorelist then
        ignorelist = {}
    end

    for _, list in ipairs(listOfLists) do
        local sublistMatch = true

        -- Check if the sublist is present in the list
        for i, item in ipairs(sublist) do
            if list[i] ~= item and not(isInList(i, ignorelist)) then
                sublistMatch = false
                break
            end
        end

        if sublistMatch then
            return true
        end
    end
    return false
end
avatarName = nil
function getAvatar()
    if avatarName == nil then
        avatarName = Osi.DB_Avatars:Get(nil)[1][1]
    end
    return avatarName
end
function mergeLists(list1, list2)
    local merged = {}
    
    for _, v in ipairs(list1) do
        table.insert(merged, v)
    end
    
    for _, v in ipairs(list2) do
        table.insert(merged, v)
    end
    
    return merged
end

function DPrintAll()
    if FullPrint then
        PrintAll()
        
    end
end
function PrintAll()
    for i, val in ipairs(origin_names) do
        print(string.format("%s: Date %s partner %s (stash Rela %s Date %s)", 
        origin_names[i], GetFlag(date_flags[i], getAvatar()), GetFlag(partner_flags[i], getAvatar()), PersistentVars[i], PersistentVars[i+12]))
    end
    print(string.format("partnered %s", GetFlag(isPartneredFlag, getAvatar())))
    if FullPrint then
        _D(PersistentVars)
    end
end
function FixPersistentVars()
    local refPVars = {false, false, false, false, false, false, false, false, false, 0, false, false} 
    if not PersistentVars or  #PersistentVars < #refPVars then
        for i, value in ipairs(PersistentVars) do
            refPVars[i] = value
        end
        PersistentVars = refPVars
    end
end

function DPrint(str)
    if FullPrint then
        _D(str)
    end
end

function DTraceback()
    DPrint(debug.traceback())
end