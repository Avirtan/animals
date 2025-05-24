local base_button_widget = require("src.gui.base_widgets.button.base_button_widget")
local log = require("log.log")
local event = require("event.event")

---@class SelectData
---@field text string
---@field data table

---@class BaseScrollVerticalWidget: druid.widget
---@field items BaseButtonWidget[]
---@field item_prefab node | nil
---@field on_click_item event
local M = {
    items = {},
}

function M:init()
    local item_node = self:get_node("item/root")
    gui.set_enabled(item_node, false)
    self.item_prefab   = gui.get_node(self:get_template() .. "/item/root")
    self.on_click_item = event.create()
    self.scroll        = self.druid:new_scroll("view", "content")
    self.grid          = self.druid:new_grid("content", item_node, 1)
    self.scroll:bind_grid(self.grid)
    self.scroll:set_horizontal_scroll(false)
end

function M:post_init(select_data)
end

---comment
---@param data SelectData[]
function M:set_select_data(data)
    for _, value in pairs(data) do
        self:add_item(value.text, value.data)
    end
end

function M:add_item(text, data)
    local select_item = self.druid:new_widget(base_button_widget, "item", self.item_prefab)
    data['item'] = self
    select_item.button.on_click:subscribe(self.select, data)
    select_item:set_text(text)
    self.grid:add(select_item:get_node("root"))
    table.insert(self.items, select_item)
end

function M:select()
    self.item.on_click_item:trigger(self)
end

function M:unload()
end

return M
