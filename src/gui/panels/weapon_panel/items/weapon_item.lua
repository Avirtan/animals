local log = require("log.log")

---@class weapon_item: druid.widget
---@field prefab node
---@field on_click event
local M = {
    index = nil,
}

function M:init()
    self.root = self:get_node("root")
    self.name_weapon = self:get_node("name_weapon")
    self.timer_reload = self:get_node("time")
    self.button = self.druid:new_button("btn", self.click)
    gui.set_text(self.timer_reload, "0")
end

---@param event event
function M:post_init(event, index, text)
    self.on_click = event
    self.index = index
    gui.set_text(self.name_weapon, text)
end

function M:set_timer(time)
    gui.set_text(self.timer_reload, string.format("%.2f", time))
end

function M:click()
    self.on_click:trigger(self.index)
end

function M:select()
    gui.set_color(self.button:get_node("btn"), vmath.vector4(1, 0, 0, 1))
end

function M:unselect()
    gui.set_color(self.button:get_node("btn"), vmath.vector4(0, 0, 0, 1))
end

function M:unload()
    self:set_input_enabled(false)
    gui.delete_node(self.root)
end

return M
