local world_ecs = require "src.ecs.world_ecs"
local change_weapon_component = require "src.ecs.components.events.weapon.change_weapon_component"
local weapon_component = require "src.ecs.components.weapon.weapon_component"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"

local weapons_service = require "src.services.weapon.weapons_service"

local log = require("log.log")

local change_weapon_system = {
}

function change_weapon_system.init(world_id)
end

function change_weapon_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, change_weapon_component.name)

    for index, entity in ipairs(entites) do
        local entites_weapon = world_ecs.select_component(world_id, character_tag_component.tag_player_name,
            weapon_component.name)

        local component_weapon = nil

        for index, entity_weapon in ipairs(entites_weapon) do
            --- @type WeaponComponent
            component_weapon = world_ecs.get_component(world_id, entity_weapon, weapon_component.name)
        end
        if component_weapon == nil then
            return
        end

        --- @type ChangeWeaponComponent
        local component_change_weapon = world_ecs.get_component(world_id, entity, change_weapon_component.name)

        local id_weapon = component_change_weapon.id
        weapons_service.set_current_weapon(id_weapon)
        component_weapon.cached_data = weapons_service.get_weapon_data_by_id(id_weapon)
        component_weapon.weapon_id = id_weapon
        component_weapon.current_time = 0
        component_weapon.current_amount = component_weapon.cached_data.amount
        -- log:info("test", component_weapon)
        world_ecs.delete_entity(world_id, entity)
    end
end

function change_weapon_system.fixed_update(world_id, dt)
end

function change_weapon_system.destroy(world_id)
end

return change_weapon_system
