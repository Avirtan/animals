local log = require("log.log")
local joystick_widget = require("src.gui.base_widgets.joystick.joystick_widget")
local input_service = require("src.services.input_service")

---@class AimJoystickPanel: druid.widget
local M = {
}

function M:init()
    self.root = self:get_node("root")
    self.joystick = self.druid:new_widget(joystick_widget, "joystick", nil)
    self.joystick.on_movement:subscribe(self.move_joystick, self)
    self.joystick.on_movement_stop:subscribe(self.stop_joystick, self)
    if input_service.is_multitouch then
        gui.set_enabled(self.root, true)
    end
end

function M:move_joystick(x, y)
    input_service.set_input_touch({ x = x, y = y })
end

function M:stop_joystick()
    input_service.set_input_touch({ x = 0, y = 0 })
end

function M:enable()
    gui.set_enabled(self.root, true)
end

function M:unload()
end

return M
