# 🧭 TP Menu

A modern, category-based teleport menu for FiveM servers.

Built for performance, clean UI, and full framework compatibility through `motion_bridge`.

> ⚠️ `motion_bridge` must start **before** `tp_menu`.

Support: https://discord.gg/jAbJ8rVUqw

---

## ✨ Features

- 🔌 Auto Framework Detection (`QBX → QB → ESX → OX → Standalone`)
- 🔐 Framework & ACE Permissions
- 🗂 Category Sidebar System
- 🖼 Location Image Preview Support
- ⭐ Recent Teleport System
- 🎨 Fully Customizable Theme
- 🚗 Optional Vehicle Handling
- 🔔 Advanced Notification Support
- 🖥 Grid & List View Modes
- ⚡ Teleport Fade Effect

---

# 📦 Requirements

Ensure the following resources are started:

```cfg
ensure motion_bridge
ensure motion_notify
ensure tp_menu
```

---

# ⚙️ Configuration

All configuration is handled inside:

```
config.lua
```

---

# 🧠 Framework

```lua
Config.Framework = "auto"
```

## Available Options

- `"auto"` (Recommended)
- `"esx"`
- `"qb"`
- `"qbx"`
- `"ox"`
- `"standalone"`

`"auto"` will detect in this order:

```
QBX → QB-Core → ESX → OX → Standalone
```

---

# 🔐 Permissions

```lua
Config.Permissions = "framework"
Config.AdminGroups = { "admin", "superadmin", "god", "mod" }
```

## Permission Modes

| Mode | Description |
|------|------------|
| `"framework"` | Uses framework player groups |
| `"ace"` | Uses FiveM ACE permission (`tpmenu.admin`) |
| `"none"` | Everyone can access all locations |

## ACE Example

```cfg
add_ace group.admin tpmenu.admin allow
```

---

# ⌨ Command & Keybind

```lua
Config.EnableCommand = true
Config.EnableKeybind = true
Config.Command = "tp"
Config.Keybind = "F5"
```

Set to `false` to disable either option.

---

# 🔔 Notifications (Recommended: motion_notify)

```lua
Config.Notify = "motion_notify"
```

## ⭐ Why motion_notify?

- ✅ Clean & modern design
- ✅ Fully integrated with `motion_bridge`
- ✅ Consistent styling across Motion resources
- ✅ Optimized performance
- ✅ Framework-independent

Make sure it is started:

```cfg
ensure motion_notify
```

---

## Other Supported Notify Options

| Option | Description |
|--------|------------|
| `"motion_notify"` | Direct Motion Notify (Recommended) |
| `"bridge"` | Uses `motion_bridge` auto-detection |
| `"ox_lib"` | Uses ox_lib notifications |
| `"qb"` | Uses QB-Core notify |
| `"esx"` | Uses ESX showNotification |
| `"custom"` | Fully custom notify system |

---

## Custom Notify Setup

If using `"custom"`:

```lua
Config.Notify = "custom"
```

Add inside `client.lua`:

```lua
_G.CustomNotify = function(ntype, title, message, duration)
    -- ntype = "success", "error", "info"
end
```

---

# 🖥 Menu Settings

```lua
Config.ConfirmTP      = true
Config.ShowRecent     = true
Config.MaxRecent      = 5
Config.ShowCoords     = false
Config.DefaultView    = "grid"
Config.TeleportEffect = "fade"
Config.LeaveVehicle   = false
```

## Options Explained

- `ConfirmTP` — Show confirmation dialog before teleport
- `ShowRecent` — Show recent locations at top
- `MaxRecent` — Maximum saved recent locations
- `ShowCoords` — Display XYZ in list view
- `DefaultView` — `"grid"` or `"list"`
- `TeleportEffect` — `"fade"` or `"none"`
- `LeaveVehicle` — Eject player before teleporting

---

# 🎨 Theme Customization

```lua
Config.Theme = {
    accentColor = "#60a5fa",
    accentGlow  = "rgba(96,165,250,0.15)",
    menuWidth   = "860px",
    menuHeight  = "580px",
}
```

You can customize:

- Accent color
- Glow effect
- Menu width & height

---

# 🗂 Categories

```lua
Config.LocationCategories = {
    { id = "city",    label = "City",       icon = "building"  },
    { id = "airport", label = "Airport",    icon = "plane"     },
    { id = "gang",    label = "Gang Zones", icon = "crosshair" },
    { id = "police",  label = "Police",     icon = "shield"    },
    { id = "medical", label = "Medical",    icon = "heart"     },
    { id = "leisure", label = "Leisure",    icon = "star"      },
}
```

## Supported Icons

```
building, plane, shield, heart, star,
crosshair, car, tree, dollar,
music, zap, map, anchor,
home, flag
```

---

# 📍 Locations

Example location format:

```lua
{
    id = "lsc",
    name = "Los Santos Customs",
    category = "city",
    desc = "Vehicle mods & paint",
    coords = vector4(-349.7, -137.3, 39.0, 60.0),
    badge = nil,
    image = "https://example.com/image.jpeg"
}
```

## Location Fields

| Field | Description |
|-------|------------|
| `id` | Unique identifier |
| `name` | Display name |
| `category` | Must match category `id` |
| `desc` | Location description |
| `coords` | `vector4(x, y, z, heading)` |
| `badge` | `nil` or `"admin"` |
| `image` | URL or `nil` |

---

# 🛡 Admin-Only Locations

To restrict a location to admins:

```lua
badge = "admin"
```

This respects your selected permission mode.

---

# 🚀 Adding New Locations

1. Choose a valid category `id`
2. Add a new entry inside `Config.Locations`
3. Restart `tp_menu`

---

# 🛠 Troubleshooting

### Menu not opening?

- Ensure `motion_bridge` starts before `tp_menu`
- Check `Config.Framework`
- Verify permission setup

### Notifications not showing?

- Set:

```lua
Config.Notify = "motion_notify"
```

- Ensure:

```cfg
ensure motion_notify
```

---

# 📄 License

Free to use and modify.  
Do not resell without permission.

---

Made for modern FiveM servers.

