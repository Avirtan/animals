--- @class MoveInputComponent
--- @field speed number
local move_input_component = {
    name = "move_input_component"
}

function move_input_component.new()
    local self = {}
    self.name = move_input_component.name
    return self
end

return move_input_component
