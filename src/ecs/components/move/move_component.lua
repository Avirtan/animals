--- @class MoveComponent
--- @field name string
--- @field speed number
--- @field dir_move vector3
local move_component = {
    name = "move_component"
}

function move_component.new(speed)
    local self = {} --- setmetatable({}, { __index = move_component })
    self.name = move_component.name
    self.speed = speed
    self.dir_move = vmath.vector3(0, 0, 0)
    return self
end

return move_component
