--[[
    CONFIG — edit this file only
    Requires: motion_bridge (ensure it starts before tp_menu)
--]]

Config = {}

--[[
    FRAMEWORK
    auto = motion_bridge (QBX → QB → ESX) or OX → standalone
    esx, qb, qbx, ox, standalone = force
]]
Config.Framework = "auto"

--[[
    PERMISSIONS
    framework = use framework groups (AdminGroups below)
    ace = FiveM ace (tpmenu.admin)
    none = everyone sees all locations
]]
Config.Permissions = "framework"
Config.AdminGroups = { "admin", "superadmin", "god", "mod" }

--[[
    COMMAND & KEYBIND
    Set to false to disable
]]
Config.EnableCommand = true
Config.EnableKeybind = true
Config.Command      = "tp"
Config.Keybind      = "F5"

--[[
    NOTIFY
    bridge = motion_bridge (uses motion_notify, ox_lib, qb, qbx)
    ox_lib, qb, esx, motion_notify, or custom

    CUSTOM: Set to "custom" then in client.lua add:
        _G.CustomNotify = function(ntype, title, message, duration)
            -- ntype = "success", "error", "info"
        end
]]
Config.Notify = "motion_notify"

--[[
    MENU
]]
Config.ConfirmTP      = true   -- confirm before teleport
Config.ShowRecent     = true   -- recent locations at top
Config.MaxRecent      = 5
Config.ShowCoords     = false  -- show XYZ in list view
Config.DefaultView    = "grid" -- grid or list
Config.TeleportEffect = "fade" -- fade or none
Config.LeaveVehicle   = false  -- eject from vehicle before TP

--[[
    THEME
]]
Config.Theme = {
    accentColor = "#60a5fa",
    accentGlow  = "rgba(96,165,250,0.15)",
    menuWidth   = "860px",
    menuHeight  = "580px",
}

--[[
    CATEGORIES
    id = used in Locations, label = sidebar text
    icons: building, plane, shield, heart, star, crosshair, car, tree, dollar, music, zap, map, anchor, home, flag
]]
Config.LocationCategories = {
    { id = "city",    label = "City",       icon = "building"  },
    { id = "airport", label = "Airport",    icon = "plane"     },
    { id = "gang",    label = "Gang Zones", icon = "crosshair" },
    { id = "police",  label = "Police",     icon = "shield"    },
    { id = "medical", label = "Medical",    icon = "heart"     },
    { id = "leisure", label = "Leisure",    icon = "star"      },
}

--[[
    LOCATIONS
    id = unique, category = match LocationCategories id
    coords = vector4(x, y, z, heading)
    badge = nil or "admin" (admin-only)
    image = url or nil
]]
Config.Locations = {
    { id="lsc",       name="Los Santos Customs",  category="city",    desc="Vehicle mods & paint",     coords=vector4(-349.7,-137.3,39.0,60.0),     badge=nil,     image="https://i.imgur.com/3h8TnpI.jpeg" },
    { id="maze_bank", name="Maze Bank Tower",     category="city",    desc="Financial District",      coords=vector4(-75.0,-818.0,326.2,180.0),    badge=nil,     image="https://i.imgur.com/e9WcFJL.jpeg" },
    { id="sandy",     name="Sandy Shores",       category="city",    desc="Rural town",              coords=vector4(1848.7,3689.1,34.3,0.0),      badge=nil,     image="https://i.imgur.com/a9xQdJB.jpeg" },
    { id="paleto",    name="Paleto Bay",          category="city",    desc="Northern town",           coords=vector4(-151.2,6335.9,32.4,0.0),      badge=nil,     image="https://i.imgur.com/nsTnEfc.jpeg" },
    { id="lsia",      name="LSIA Departure",      category="airport", desc="International Airport",   coords=vector4(-1037.0,-2738.7,20.1,0.0),    badge=nil,     image="https://i.imgur.com/QhqKpuC.jpeg" },
    { id="mrpd",      name="Mission Row PD",      category="police",  desc="Main police department",  coords=vector4(441.1,-981.9,30.7,90.0),      badge=nil,     image="https://i.imgur.com/ZBfS1Sv.jpeg" },
    { id="zancudo",   name="Fort Zancudo",        category="police",  desc="Military base",           coords=vector4(-2047.6,3132.1,32.8,0.0),    badge="admin", image=nil },
    { id="pillbox",   name="Pillbox Hill Medical",category="medical", desc="Central hospital",        coords=vector4(307.3,-1433.9,29.9,0.0),      badge=nil,     image="https://i.imgur.com/6HVcFKW.jpeg" },
    { id="vespucci",  name="Vespucci Beach",      category="leisure", desc="Beachside hangout",       coords=vector4(-1233.6,-1116.8,7.0,0.0),     badge=nil,     image="https://i.imgur.com/VhzIYXc.jpeg" },
    { id="casino",    name="Diamond Casino",      category="leisure", desc="VIP lounge access",       coords=vector4(942.1,47.4,81.1,0.0),         badge=nil,     image="https://i.imgur.com/SXRlkhy.jpeg" },
    { id="grove",     name="Grove Street",        category="gang",    desc="Families territory",      coords=vector4(78.5,-1944.7,21.0,0.0),       badge=nil,     image="https://i.imgur.com/K2NRzil.jpeg" },
    { id="ballas",    name="Forum Drive",         category="gang",    desc="Ballas territory",        coords=vector4(112.8,-1952.7,21.1,0.0),      badge=nil,     image=nil },
}
