--[[
    CLIENT — motion_bridge: framework, notify, IsPlayerLoaded
    CUSTOM NOTIFY: Config.Notify = "custom" then add _G.CustomNotify
--]]

local menuOpen   = false
local framework  = nil
local playerData = { isAdmin = false }

-- icon map for category sidebar
local Icons = {
    ["building"]  = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>',
    ["plane"]     = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.64 12a19.79 19.79 0 0 1-3.07-8.67 2 2 0 0 1 1.99-2.18h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>',
    ["shield"]    = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>',
    ["heart"]     = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>',
    ["star"]      = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>',
    ["crosshair"] = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="22" y1="12" x2="18" y2="12"/><line x1="6" y1="12" x2="2" y2="12"/><line x1="12" y1="6" x2="12" y2="2"/><line x1="12" y1="22" x2="12" y2="18"/></svg>',
    ["car"]       = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="3" width="15" height="13" rx="2"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>',
    ["tree"]      = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 14l-5-10-5 10"/><path d="M20 20l-8-16-8 16"/><line x1="12" y1="20" x2="12" y2="22"/></svg>',
    ["dollar"]    = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>',
    ["music"]     = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 18V5l12-2v13"/><circle cx="6" cy="18" r="3"/><circle cx="18" cy="16" r="3"/></svg>',
    ["zap"]       = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>',
    ["map"]       = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"/><line x1="8" y1="2" x2="8" y2="18"/><line x1="16" y1="6" x2="16" y2="22"/></svg>',
    ["anchor"]    = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="5" r="3"/><line x1="12" y1="22" x2="12" y2="8"/><path d="M5 12H2a10 10 0 0 0 20 0h-3"/></svg>',
    ["home"]      = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>',
    ["flag"]      = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"/><line x1="4" y1="22" x2="4" y2="15"/></svg>',
    ["pin"]       = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>',
}

local function GetIcon(name)
    return Icons[name] or Icons["pin"]
end

-- framework (motion_bridge first when auto)
CreateThread(function()
    Wait(500)
    local fw = Config.Framework

    -- motion_bridge (qbx, qb, esx)
    if fw == "auto" and Bridge and Bridge.FRAMEWORK then
        local bw = Bridge.FRAMEWORK()
        if bw then
            local core = Bridge.CORE()
            if core then
                framework = { name = bw, obj = core }
                print("^2[tp_menu]^0 " .. bw:upper() .. " (bridge)")
                Wait(1000)
                RefreshPlayerData()
                return
            end
        end
    end

    -- force or fallback
    if fw == "esx" or (fw == "auto" and GetResourceState("es_extended") == "started") then
        local ok, obj = pcall(function() return exports["es_extended"]:getSharedObject() end)
        if ok and obj then framework = { name = "esx", obj = obj }; print("^2[tp_menu] ESX^0"); Wait(1000); RefreshPlayerData(); return end
    end
    if fw == "qbx" or fw == "qb" or (fw == "auto" and (GetResourceState("qbx_core") == "started" or GetResourceState("qb-core") == "started")) then
        local res = GetResourceState("qbx_core") == "started" and "qbx_core" or "qb-core"
        local ok, obj = pcall(function() return exports[res]:GetCoreObject() end)
        if ok and obj then framework = { name = res == "qbx_core" and "qbx" or "qb", obj = obj }; print("^2[tp_menu]^0 " .. (res == "qbx_core" and "QBX" or "QB") .. "^0"); Wait(1000); RefreshPlayerData(); return end
    end
    if fw == "ox" or (fw == "auto" and GetResourceState("ox_core") == "started") then
        framework = "ox_core"; print("^2[tp_menu] ox_core^0"); Wait(1000); RefreshPlayerData(); return
    end

    print("^3[tp_menu] Standalone^0")
    framework = "standalone"
    RefreshPlayerData()
end)

-- permissions (framework groups or ace)
function IsInList(tbl, val)
    if not val then return false end
    val = tostring(val):lower()
    for _, v in ipairs(tbl) do
        if tostring(v):lower() == val then return true end
    end
    return false
end

function RefreshPlayerData()
    if Config.Permissions == "none" then
        playerData.isAdmin = true; return
    end

    if Config.Permissions == "ace" then
        TriggerServerEvent("motion_tp:checkPermissions"); return
    end

    -- Use bridge HasGroup when framework permissions and bridge available
    if Config.Permissions == "framework" and GetResourceState("motion_bridge") == "started" then
        local ok, hasGroup = pcall(function() return exports.motion_bridge:HasGroup(Config.AdminGroups) end)
        if ok then
            playerData.isAdmin = hasGroup
            return
        end
    end

    local obj = type(framework) == "table" and framework.obj or framework
    if type(obj) == "table" then
        local pd = nil
        if obj.GetPlayerData then
            pd = obj.GetPlayerData()
        elseif obj.Functions and obj.Functions.GetPlayerData then
            pd = obj.Functions.GetPlayerData()
        end
        if pd then
            local grp = pd.group or pd.permission or pd.permission_level or pd.rank or (pd.job and pd.job.grade_name) or "user"
            playerData.isAdmin = IsInList(Config.AdminGroups, grp)
        end
    end
end

RegisterNetEvent("motion_tp:permissionsResult", function(isAdmin, _)
    playerData.isAdmin = isAdmin
end)

AddEventHandler("esx:playerLoaded",             function() Wait(500); RefreshPlayerData() end)
AddEventHandler("QBCore:Client:OnPlayerLoaded", function() Wait(500); RefreshPlayerData() end)
AddEventHandler("QBCore:Client:OnJobUpdate",    function() RefreshPlayerData() end)
AddEventHandler("ox_core:playerLoaded",         function() Wait(500); RefreshPlayerData() end)

-- hide admin locations from non-admins
local function FilterByBadge(items)
    local out = {}
    for _, item in ipairs(items) do
        if item.badge == "admin" and not playerData.isAdmin then
            -- skip
        else
            out[#out + 1] = item
        end
    end
    return out
end

-- build data for NUI
local function BuildPayload()
    -- Location categories with SVG icons
    local cats = {}
    for _, c in ipairs(Config.LocationCategories) do
        cats[#cats + 1] = { id = c.id, label = c.label, icon = GetIcon(c.icon) }
    end

    -- Locations (badge-filtered, coords serialised)
    local locs = {}
    for _, l in ipairs(FilterByBadge(Config.Locations)) do
        locs[#locs + 1] = {
            id       = l.id,
            name     = l.name,
            category = l.category,
            desc     = l.desc or "",
            coords   = { x = l.coords.x, y = l.coords.y, z = l.coords.z, w = l.coords.w },
            badge    = l.badge,
            image    = l.image,
        }
    end

    return {
        action = "openTPMenu",
        settings = {
            confirmTP   = Config.ConfirmTP,
            showRecent  = Config.ShowRecent,
            maxRecent   = Config.MaxRecent,
            showCoords  = Config.ShowCoords,
            defaultView = Config.DefaultView,
            theme       = Config.Theme,
        },
        categories = cats,
        locations  = locs,
        isAdmin    = playerData.isAdmin,
    }
end

-- menu open/close
local function OpenMenu()
    if menuOpen then return end
    if GetResourceState("motion_bridge") == "started" and not exports.motion_bridge:IsPlayerLoaded() then
        Notify("error", "Wait", "Please wait until you are fully loaded.")
        return
    end
    RefreshPlayerData()
    Wait(100)
    menuOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage(BuildPayload())
end

local function CloseMenu()
    if not menuOpen then return end
    menuOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "closeTPMenu" })
end

-- command and keybind
RegisterCommand("tpmenu_open", function() OpenMenu() end, false)
if Config.EnableCommand ~= false then
    RegisterCommand(Config.Command or "tp", function() OpenMenu() end, false)
end
if Config.EnableKeybind ~= false then
    RegisterKeyMapping("tpmenu_open", "Open Teleport Menu", "keyboard", Config.Keybind or "F5")
end

-- NUI callbacks
RegisterNUICallback("closeTPMenu", function(_, cb)
    CloseMenu(); cb({})
end)

RegisterNUICallback("teleport", function(data, cb)
    local loc = nil
    for _, l in ipairs(Config.Locations) do
        if l.id == data.id then loc = l; break end
    end

    if not loc then cb({}); return end

    if loc.badge == "admin" and not playerData.isAdmin then
        Notify("error", "Access Denied", "You don't have permission to teleport there.")
        cb({}); return
    end

    local ped = PlayerPedId()

    if Config.LeaveVehicle and IsPedInAnyVehicle(ped, false) then
        TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 0)
        Wait(800)
    end

    if Config.TeleportEffect == "fade" then
        DoScreenFadeOut(500); Wait(500)
    end

    SetEntityCoords(ped, loc.coords.x, loc.coords.y, loc.coords.z, false, false, false, true)
    SetEntityHeading(ped, loc.coords.w)
    Wait(100)

    if Config.TeleportEffect == "fade" then
        DoScreenFadeIn(500)
    end

    Notify("success", "Teleported", "Welcome to " .. loc.name)
    CloseMenu()
    cb({})
end)

-- notifications (bridge, ox_lib, qb, esx, motion_notify, custom)
function Notify(ntype, title, message, duration)
    local d = duration or 5000
    local n = Config.Notify or "bridge"

    if n == "bridge" and GetResourceState("motion_bridge") == "started" then
        exports.motion_bridge:Notify(title, message, ntype, d)
        return
    end
    if n == "ox_lib" and GetResourceState("ox_lib") == "started" then
        exports.ox_lib:notify({ title = title, description = message, type = ntype, duration = d })
        return
    end
    if n == "qb" and GetResourceState("qb-core") == "started" then
        local QBCore = exports["qb-core"]:GetCoreObject()
        QBCore.Functions.Notify(message, ntype, d)
        return
    end
    if n == "esx" and GetResourceState("es_extended") == "started" then
        if GetResourceState("ox_lib") == "started" then
            exports.ox_lib:notify({ title = title, description = message, type = ntype, duration = d })
        else
            print("^3[tp_menu]^0 " .. title .. ": " .. message)
        end
        return
    end
    if n == "motion_notify" and GetResourceState("motion_notify") == "started" then
        exports["motion_notify"]:Notify(title, message, ntype, d)
        return
    end
    if n == "custom" and _G.CustomNotify then
        _G.CustomNotify(ntype, title, message, d)
        return
    end
    -- fallback: try bridge, else print
    if GetResourceState("motion_bridge") == "started" then
        exports.motion_bridge:Notify(title, message, ntype, d)
    else
        print("^3[tp_menu]^0 " .. title .. ": " .. message)
    end
end
