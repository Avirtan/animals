--- @class MoveAstarComponent
--- @field name string
--- @field paths table
--- @field target_position vector3
--- @field next_point vector3
--- @field current_index_point number
--- @field delay_update number
local move_astar_component = {
    name = "move_astar_component"
}

function move_astar_component.new()
    local self = {}
    self.name = move_astar_component.name
    self.paths = {}
    self.current_index_point = 1
    self.delay_update = 0
    self.target_position = vmath.vector3()
    self.next_point = vmath.vector3(0, 0, 0)
    return self
end

return move_astar_component
