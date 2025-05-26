local log = require("log.log")
local const = require("druid.const")
local event = require("event.event")
local helper = require("druid.helper")
local input_service = require "src.services.input_service"

---@class JoystickWidget: druid.widget
---@field on_movement event
---@field on_movement_stop event
local M = {
}
local STICK_DISTANCE = 80

function M:init()
    self.root = self:get_node("root")
    self.on_screen_control = self:get_node("joystick_background")
    self.stick_root = self:get_node("stick")
    self.stick_position = gui.get_position(self.stick_root)
    self.is_multitouch = helper.is_multitouch_supported()

    self.on_movement = event.create()
    self.on_movement_stop = event.create()
end

---@param action_id hash
---@param action action
function M:on_input(action_id, action)
    if self.is_multitouch then
        if action_id == const.ACTION_MULTITOUCH then
            for _, touch in ipairs(action.touch) do
                self:process_touch(touch)
            end
        end
    else
        if action_id == const.ACTION_TOUCH then
            self:process_touch(action)
        end
    end
    return false
end

---@param action action|touch
function M:process_touch(action)
    if gui.pick_node(self.on_screen_control, action.x, action.y) then
        self._is_stick_drag = action.id or true
    end
    local is_the_same_touch_id = not action.id or action.id == self._is_stick_drag
    if self._is_stick_drag and is_the_same_touch_id then
        if self.is_multitouch then
            input_service.multitouch_data.touch_id_use[self._is_stick_drag] = true
        end
        local dx = action.x - (self._prev_x or action.x)
        local dy = action.y - (self._prev_y or action.y)
        self._prev_x = action.x
        self._prev_y = action.y

        self.stick_position.x = self.stick_position.x + dx
        self.stick_position.y = self.stick_position.y + dy

        local length = vmath.length(self.stick_position)
        if length > STICK_DISTANCE then
            self.stick_position.x = self.stick_position.x / length * STICK_DISTANCE
            self.stick_position.y = self.stick_position.y / length * STICK_DISTANCE
        end

        gui.set_position(self.stick_root, self.stick_position)
    end

    if action.released and is_the_same_touch_id then
        if self.is_multitouch then
            input_service.multitouch_data.touch_id_use[self._is_stick_drag] = false
        end
        self._is_stick_drag = false
        self.stick_position.x = 0
        self.stick_position.y = 0
        self._prev_x = nil
        self._prev_y = nil
        gui.animate(self.stick_root, gui.PROP_POSITION, self.stick_position, gui.EASING_OUTBACK, 0.3)
        self.on_movement_stop:trigger()
    end
end

function M:update(dt)
    if self.stick_position.x ~= 0 or self.stick_position.y ~= 0 then
        self.on_movement:trigger(self.stick_position.x / STICK_DISTANCE, self.stick_position.y / STICK_DISTANCE)
    end
end

return M
