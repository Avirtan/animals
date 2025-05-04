local input_service = require "src.services.input_service"
local screen_service = require "src.services.screen_service"

--- @class AimCircleComponent
--- @field url_aim hash
--- @field parent userdata
--- @field tmp_vector vector3
--- @field current_state_size boolean
local aim_circle_component = {}

function aim_circle_component.new(url_aim)
    self = setmetatable({}, { __index = aim_circle_component })
    self.url_aim = url_aim
    self.parent = go.get_parent(self.url_aim)
    self.tmp_vector = vmath.vector3()
    self.current_state_size = false
    return self
end

function aim_circle_component:destroy()
end

--- @param unit CharacterModel
function aim_circle_component:update(dt, unit)
    if unit.is_moving and not self.current_state_size then
        go.set(self.url_aim, "scale.x", 1)
        go.set(self.url_aim, "scale.y", 1)
        self.current_state_size = true
    elseif not unit.is_moving and self.current_state_size then
        go.set(self.url_aim, "scale.x", 0.5)
        go.set(self.url_aim, "scale.y", 0.5)
        self.current_state_size = false
    end
end

--- @param unit CharacterModel
function aim_circle_component:on_message(message_id, message, unit)
    if input_service.events.mouse_move == message_id then
        local x, y = screen_service.screen_to_world(message.x, message.y)
        local position_player = go.get_position(self.parent)
        self.tmp_vector.x = x
        self.tmp_vector.y = y
        local local_position = self.tmp_vector - position_player
        -- draw_cone(position_player, local_position, 40, 100)

        local len = vmath.length_sqr(local_position)
        if len > 10000 then
            local_position = vmath.normalize(local_position) * 100
        end
        go.set_position(local_position)
    end
end

return aim_circle_component
