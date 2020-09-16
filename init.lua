-- This project is licensed under the MIT License (see LICENSE).

--- Create key and button bindings from simple definitions.
--
-- @author James Reed &lt;jcrd@tuta.io&gt; et al.
-- @copyright 2019-2020 James Reed
-- @module awesome-ez

local awful = require("awful")
local gtable = require("gears.table")

local ez = {}

local modifiers = {
    ["M"] = "Mod4",
    ["A"] = "Mod1",
    ["S"] = "Shift",
    ["C"] = "Control",
}

--- Split a string on a delimiter.
--
-- @param s The string.
-- @param sep The delimiter.
-- @return A table of strings.
local function split(s, sep)
    sep = sep or "%s"
    local res = {}
    for m in string.gmatch(s, string.format("([^%s]+)", sep)) do
        table.insert(res, m)
    end
    return res
end

ez.util = {}

--- Convert a table into a callable function.
--
-- The first element of the table should be a function, followed by arguments
-- to this function.
--
-- @param cb The callback or a table describing the callback.
-- @usage local cb = ez.util.cb_from_table({awful.spawn, "xterm"})
-- @return The callback.
function ez.util.cb_from_table(cb)
    if type(cb) == "table" and
        not (getmetatable(cb) and getmetatable(cb).__call) then
        local tbl = gtable.clone(cb, false)
        local func = table.remove(tbl, 1)
        cb = function ()
            return func(unpack(tbl))
        end
    end
    return cb
end

--- Parse a key definition string into modifiers and a key.
--
-- Key definition strings consist of modifier characters and a key separated
-- by hyphens, e.g. "M-S-x" is the combination of Mod4, Shift, and the x key.
-- If the key is surrounded by <>, it is interpreted as a key group, e.g.
-- "M-&ltnumrow&gt uses the modifier Mod4 and the key group "numrow".
--
-- The modifier key strings are: M = Mod4, A = Mod1, S = Shift, C = Control.
--
-- @param keydef The key definition string.
-- @usage local modkeys, key = ez.util.parse_key("M-Return")
-- @return A table of modifiers and the key.
function ez.util.parse_key(keydef)
    local modkeys = {}
    for _, key in ipairs(split(keydef, "-")) do
        if modifiers[key] ~= nil then
            table.insert(modkeys, modifiers[key])
        else
            local group = string.match(key, "<(%w+)>")
            if group then
                return modkeys, nil, group
            end
            return modkeys, key
        end
    end
end

--- Parse a button definition string into modifiers and a button.
--
-- Button definition strings consist of modifier characters and a key separated
-- by hyphens, e.g. "M-S-1" is the combination of Mod4, Shift, and button 1.
--
-- The modifier key strings are: M = Mod4, A = Mod1, S = Shift, C = Control.
--
-- @param btndef The button definition string.
-- @usage local modkeys, btn = ez.util.parse_button("M-1")
-- @return A table of modifiers and the button.
function ez.util.parse_button(btndef)
    if type(btndef) == "number" then
        return {}, btndef
    end
    local modkeys = {}
    for _, key in ipairs(split(btndef, "-")) do
        if modifiers[key] ~= nil then
            table.insert(modkeys, modifiers[key])
        else
            return modkeys, tonumber(key)
        end
    end
end

--- Create a key binding from a key definition string and callback.
--
-- @param keydef The key definition string.
-- @param cb The callback or table describing the callback.
-- @return A table with the key objects.
function ez.key(keydef, cb)
    local modkeys, key, group = ez.util.parse_key(keydef)
    if group then
        return awful.key {
            keygroup = group,
            modifiers = modkeys,
            on_press = cb,
        }
    end
    return awful.key(modkeys, key, ez.util.cb_from_table(cb))
end

--- Create a button binding from a button definition string and callback.
--
-- @param btndef The button definition string.
-- @param cb The callback or table describing the callback.
-- @return A table with the button objects.
function ez.btn(btndef, cb)
    local modkeys, btn = ez.util.parse_button(btndef)
    return awful.button(modkeys, btn, ez.util.cb_from_table(cb))
end

--- Create key bindings for elements of a table.
--
-- @param tbl The table of key bindings.
-- @return A table containing created key objects.
function ez.keytable(tbl)
    local res = {}
    for keydef, cb in pairs(tbl) do
        table.insert(res, ez.key(keydef, cb))
    end
    return res
end

--- Create button bindings for elements of a table.
--
-- @param tbl The table of button bindings.
-- @return A table containing created button objects.
function ez.btntable(tbl)
    local res = {}
    for btndef, cb in pairs(tbl) do
        table.insert(res, ez.btn(btndef, cb))
    end
    return res
end

return ez
