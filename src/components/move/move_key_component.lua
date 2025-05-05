local input_service = require "src.services.input_service"
local events_service = require "src.services.events_service"
local components_service = require "src.services.components_service"

--- @class MoveKeyComponent
--- @field last_input vector3
--- @field animation_data vector3
--- @field input vector3
--- @field model CharacterModel
local move_key_component = {}

--- @param model CharacterModel
function move_key_component.new(model)
    local self          = setmetatable({}, { __index = move_key_component })
    self.animation_data = {
        x = 0,
        y = 0
    }
    self.last_input     = vmath.vector3(0, 0, 0)
    self.input          = vmath.vector3(0, 0, 0)
    self.model          = model
    return self
end

function move_key_component:destroy()
end

function move_key_component:update(dt)
end

--- @param message key_data_event
function move_key_component:on_message(message_id, message)
    if message_id ~= input_service.events.key then
        return
    end
    self:calculate_input(message)

    if self.last_input.x ~= self.input.x or self.last_input.y ~= self.input.y then
        self.animation_data.x = self.input.x
        self.animation_data.y = self.input.y
        self.model:on_message(components_service.name.sprite_animation,
            events_service.animation_events.change_animation_event,
            self.animation_data)
        self.last_input.x = self.input.x
        self.last_input.y = self.input.y
    end

    if self.input.x == 0 and self.input.y == 0 then
        self.model.dir_move.x = 0
        self.model.dir_move.y = 0
        return
    end
    self.model.dir_move = vmath.normalize(self.input)
end

function move_key_component:calculate_input(message)
    local bindings = input_service.input_binding

    if message.action_id == bindings.up and self.input.y ~= -1 then
        self.input.y = message.released and 0 or 1
    elseif message.action_id == bindings.down and self.input.y ~= 1 then
        self.input.y = message.released and 0 or -1
    end

    if message.action_id == bindings.right and self.input.x ~= -1 then
        self.input.x = message.released and 0 or 1
    elseif message.action_id == bindings.left and self.input.x ~= 1 then
        self.input.x = message.released and 0 or -1
    end
end

return move_key_component
