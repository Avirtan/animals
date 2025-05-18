---@class weapon_item: druid.widget
---@field prefab node
---@field on_click event
local M = {
    index = nil,
}

function M:init()
    self.root = self:get_node("root")
    self.name_weapon = self:get_node("name_weapon")
    self.button = self.druid:new_button("root", self.click)
end

---@param event event
function M:post_init(event, index, text)
    self.on_click = event
    self.index = index
    gui.set_text(self.name_weapon, text)
end

function M:click()
    self.on_click:trigger(self.index)
end

function M:open_widget()
    print("Open widget pressed")
end

function M:select()
    gui.set_color(self.root, vmath.vector4(1, 0, 0, 1))
end

function M:unselect()
    gui.set_color(self.root, vmath.vector4(0, 0, 0, 1))
end

return M
