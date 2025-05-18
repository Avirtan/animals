--- @class SpawnPlayerComponent
--- @field position vector3
--- @field type_unit string
local spawn_player_component = {
    name = "spawn_player_component"
}

function spawn_player_component.new(position, type_unit)
    local self = {} ---setmetatable({}, { __index = spawn_player_component })
    self.name = spawn_player_component.name
    self.position = position
    self.type_unit = type_unit
    return self
end

return spawn_player_component
