local world_ecs = require "src.ecs.world_ecs"
local aim_selected_component = require "src.ecs.components.player.aim_selected_component"
local spawn_bullet_component = require "src.ecs.components.events.spawn_bullets.spawn_bullet_component"
local weapon_component = require "src.ecs.components.weapon.weapon_component"

local weapon_shoot_system = {
}

function weapon_shoot_system.init(world_id)
end

function weapon_shoot_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, aim_selected_component.name, weapon_component.name)

    for _, entity in ipairs(entites) do
        --- @type AimSelectedComponent
        local component_aim_selected = world_ecs.get_component(world_id, entity, aim_selected_component.name)
        --- @type WeaponComponent
        local component_weapon = world_ecs.get_component(world_id, entity, weapon_component.name)
        if component_weapon.weapon_id == nil then
            return
        end

        if component_weapon.current_time > 0 then
            component_weapon.current_time = component_weapon.current_time - dt
            break
        end

        if component_weapon.is_reloading then
            component_weapon.is_reloading = false
            component_weapon.current_amount = component_weapon.cached_data.amount
        end

        local is_exist = false
        for k in pairs(component_aim_selected.targets) do
            is_exist = true
            break
        end
        if is_exist then
            for i = 1, component_weapon.cached_data.bullet_count, 1 do
                local entity_spawn_bullet = world_ecs.create_entity(world_ecs.world_id.Main)
                local c1 = spawn_bullet_component.new()
                world_ecs.add_component(world_ecs.world_id.Main, entity_spawn_bullet, c1)
                component_weapon.current_amount = component_weapon.current_amount - 1
                if component_weapon.current_amount == 0 then
                    break
                end
            end

            if component_weapon.current_amount == 0 then
                component_weapon.current_time = component_weapon.cached_data.reloading_time
                component_weapon.is_reloading = true
            else
                component_weapon.current_time = component_weapon.cached_data.cooldown
            end
        end
    end
end

function weapon_shoot_system.fixed_update(world_id, dt)
end

function weapon_shoot_system.destroy(world_id)
end

return weapon_shoot_system
