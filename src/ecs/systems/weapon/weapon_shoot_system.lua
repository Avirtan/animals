local world_ecs = require "src.ecs.world_ecs"
local aim_selected_component = require "src.ecs.components.player.aim_selected_component"
local spawn_bullet_component = require "src.ecs.components.events.spawn_bullets.spawn_bullet_component"

local weapon_shoot_system = {
}

function weapon_shoot_system.init(world_id)
end

function weapon_shoot_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, aim_selected_component.name)

    for _, entity in ipairs(entites) do
        --- @type AimSelectedComponent
        local component_aim_selected = world_ecs.get_component(world_id, entity, aim_selected_component.name)
        local is_exist = false
        for k in pairs(component_aim_selected.targets) do
            is_exist = true
            break
        end
        if is_exist then
            local entity_spawn_bullet = world_ecs.create_entity(world_ecs.world_id.Main)
            local c1 = spawn_bullet_component.new()
            world_ecs.add_component(world_ecs.world_id.Main, entity_spawn_bullet, c1)
        end
    end
end

function weapon_shoot_system.fixed_update(world_id, dt)
end

function weapon_shoot_system.destroy(world_id)
end

return weapon_shoot_system
