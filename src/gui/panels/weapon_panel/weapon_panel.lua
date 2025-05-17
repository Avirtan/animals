local layout = require("druid.extended.layout")
local log = require("log.log")
local weapon_item_widget = require("src.gui.panels.weapon_panel.items.weapon_item")
local event = require("event.event")

---@class weapon_panel: druid.widget
---@field prefab node
---@field weapon_items weapon_item[]
local M = {
    weapon_items = {}
}

function M:init()
    self.root = self:get_node("root")
    self.layout = self.druid:new(layout, "root", "horizontal_wrap")
    -- log:info("tables", prefab_nodes)
    self.on_weapon_item_click = event.create(self.select_weapon, self)

    self.layout:set_margin(10, nil)
    for i = 1, 2 do
        local weapon_item = self.druid:new_widget(weapon_item_widget, "weapon_item", "root")
        weapon_item:post_init(self.on_weapon_item_click, i, "weapon " .. i)
        local root = weapon_item:get_node("root")
        if i == 1 then
            weapon_item:select()
        end
        table.insert(self.weapon_items, weapon_item)
        gui.set_enabled(root, true)
        self.layout:add(root)
    end
end

function M:select_weapon(index)
    for index, value in ipairs(self.weapon_items) do
        value:unselect()
    end
    self.weapon_items[index]:select()
end

function M:unload()
    self.on_weapon_item_click:unsubscribe(self.select_weapon, self)
end

return M
