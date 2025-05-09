--- @class MoveInputComponent
--- @field speed number
local move_input_component = {
    name = "move_input_component"
}

function move_input_component.new()
    local self = setmetatable({}, { __index = move_input_component })
    return self
end

return move_input_component
