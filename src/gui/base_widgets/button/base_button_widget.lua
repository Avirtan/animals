local log = require("log.log")

---@class BaseButtonWidget: druid.widget
---@field button druid.button
---@field on_click event
local M = {
    size = 12
}

function M:init()
    self.button = self.druid:new_button("btn")
    self.text_btn = self.druid:new_rich_text(self:get_node("text"))
end

function M:post_init(text)
    if text ~= nil then
        -- gui.set_text(self.text_btn, text)
    end
end

function M:set_size(size)
    self.size = size
end

function M:set_text(text)
    if text ~= nil then
        self.text_btn:set_text(text)
    end
end

function M:unload()
end

return M
