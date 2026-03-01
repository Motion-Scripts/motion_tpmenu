--[[
    SERVER — handles permissions for ace/ox_core
    Config in config.lua. ESX/QB/QBX use client-side permissions.
--]]

RegisterNetEvent("motion_tp:checkPermissions", function()
    local src = source

    if Config.Permissions == "ace" then
        local isAdmin = IsPlayerAceAllowed(src, "tpmenu.admin")
        TriggerClientEvent("motion_tp:permissionsResult", src, isAdmin, false)
        return
    end

    if GetResourceState("ox_core") == "started" then
        local Player = exports["ox_core"]:GetPlayer(src)
        if Player then
            local isAdmin = false
            for _, grp in ipairs(Config.AdminGroups or {}) do
                if Player.getGroup(grp) then isAdmin = true; break end
            end
            TriggerClientEvent("motion_tp:permissionsResult", src, isAdmin, false)
            return
        end
    end

    TriggerClientEvent("motion_tp:permissionsResult", src, false, false)
end)
