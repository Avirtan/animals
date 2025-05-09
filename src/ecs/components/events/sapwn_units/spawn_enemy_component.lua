--- @class SpawnEnemyComponent
--- @field position vector3
--- @field type_unit string
local spawn_enemy_component = {
    name = "spawn_enemy_component"
}

function spawn_enemy_component.new(position, type_unit)
    local self = {}
    self.name = spawn_enemy_component.name
    self.position = position
    self.type_unit = type_unit
    return self
end

return spawn_enemy_component
