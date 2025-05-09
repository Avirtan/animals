--- @class SpawnPlayerComponent
--- @field position vector3
local spawn_player_component = {
    name = "spawn_player_component"
}

function spawn_player_component.new(position)
    local self = setmetatable({}, { __index = spawn_player_component })
    self.position = position
    return self
end

return spawn_player_component
