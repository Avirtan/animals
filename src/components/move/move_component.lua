--- @class MoveComponent
--- @field model CharacterModel | BulletModel
local move_component = {}

--- @param model CharacterModel | BulletModel
function move_component.new(model)
    local self = setmetatable({}, { __index = move_component })
    self.model = model
    return self
end

function move_component:destroy()
end

--- @param unit CharacterModel
function move_component:update(dt, unit)
    if self.model.dir_move.x == 0 and self.model.dir_move.y == 0 then
        self.model.is_moving = false
        return
    end
    self.model.is_moving = true
    self.model.position = self.model.position + self.model.dir_move * self.model.speed * dt
    go.set_position(self.model.position, self.model.controller_url)
end

--- @param unit CharacterModel
--- @param message key_data_event
function move_component:on_message(message_id, message, unit)
end

return move_component
