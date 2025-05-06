local input_service = require "src.services.input_service"
local events_service = require "src.services.events_service"
local components_service = require "src.services.components_service"

--- @class SimpleAttackComponent
--- @field model CharacterModel
--- @field unit_manager UnitManager
local simple_attack_component = {}

--- @param model CharacterModel
function simple_attack_component.new(model, unit_manager)
    local self = setmetatable({}, { __index = simple_attack_component })
    self.model = model
    self.unit_manager = unit_manager
    return self
end

function simple_attack_component:destroy()
end

function simple_attack_component:update(dt)
end

--- @param message key_data_event
function simple_attack_component:on_message(message_id, message)
    if message_id ~= input_service.events.key then
        return
    end
    if message.pressed and message.action_id == input_service.input_binding.fire then
        local bullet = self.unit_manager.spawn_bullet(self.model.position)
        bullet.base_model.dir_move = vmath.vector3(1, 0, 0)
    end
end

function simple_attack_component:calculate_input(message)
end

return simple_attack_component
