--- @class SpawnBulletComponent
--- @field position vector3
local spawn_bullet_component = {
    name = "spawn_enemy_component"
}

function spawn_bullet_component.new(position)
    local self = {}
    self.name = spawn_bullet_component.name
    self.position = position
    return self
end

return spawn_bullet_component
