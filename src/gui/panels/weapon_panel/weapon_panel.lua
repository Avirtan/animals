local layout = require("druid.extended.layout")
local log = require("log.log")
local weapon_item_widget = require("src.gui.panels.weapon_panel.items.weapon_item")
local event = require("event.event")
local weapons_service = require "src.services.weapon.weapons_service"
local change_weapon_component = require "src.ecs.components.events.weapon.change_weapon_component"
local world_ecs = require "src.ecs.world_ecs"
local weapon_component = require "src.ecs.components.weapon.weapon_component"

---@class WeaponPanel: druid.widget
---@field prefab node
---@field weapon_items weapon_item[]
---@field select_weapon_item weapon_item | nil
---@field weapon_component WeaponComponent | nil
local M = {
    weapon_items = {},
    select_weapon_item = nil,
    weapon_component = nil
}

function M:init()
    self.root = self:get_node("root")
    self.layout = self.druid:new(layout, "root", "horizontal_wrap")
    self.on_weapon_item_click = event.create()
    self.on_weapon_item_click:subscribe(self.select_weapon, self)
    self.item_prefab = gui.get_node(self:get_template() .. "/item/root")

    self.layout:set_margin(10, nil)
    local weapons = weapons_service.get_open_weapons()
    local index = 1
    for _, id in pairs(weapons) do
        local weapon_data = weapons_service.get_weapon_data_config_by_id(id)
        local weapon_item = self.druid:new_widget(weapon_item_widget, "item", self.item_prefab)
        weapon_item:post_init(self.on_weapon_item_click, id, weapon_data.name)
        local root = weapon_item:get_node("root")
        if id == weapons_service.get_current_weapon() or (weapons_service.get_current_weapon() == 0 and index == 1) then
            weapon_item:select()
            self.select_weapon_item = weapon_item
        end
        table.insert(self.weapon_items, weapon_item)
        gui.set_enabled(root, true)
        self.layout:add(root)
        index = index + 1
    end
end

function M:update(dt)
    if self.weapon_component == nil then
        local entites = world_ecs.select_component(world_ecs.world_id.Main, weapon_component.name)
        for _, entity in ipairs(entites) do
            --- @type WeaponComponent
            local component_weapon = world_ecs.get_component(world_ecs.world_id.Main, entity, weapon_component.name)
            self.weapon_component = component_weapon
        end
    end
    if self.weapon_component.weapon_id ~= nil and self.weapon_component.current_time > 0 and self.select_weapon_item ~= nil then
        self.select_weapon_item:set_timer(self.weapon_component.current_time)
    end
end

function M:select_weapon(index)
    for _, value in ipairs(self.weapon_items) do
        value:unselect()
    end
    for _, value in ipairs(self.weapon_items) do
        if value.index == index then
            value:select()
            self.select_weapon_item = value
        end
    end
    local entity_change_weapon = world_ecs.create_entity(world_ecs.world_id.Main)
    local c2 = change_weapon_component.new(index)
    world_ecs.add_component(world_ecs.world_id.Main, entity_change_weapon, c2)
end

function M:reset()
    for _, value in pairs(self.weapon_items) do
        value:unload()
        value = nil
    end
    self.layout:clear_layout()
    self.weapon_items = {}
    self.select_weapon_item = nil
    self:init()
end

function M:unload()
    self.on_weapon_item_click:unsubscribe(self.select_weapon, self)
end

return M
