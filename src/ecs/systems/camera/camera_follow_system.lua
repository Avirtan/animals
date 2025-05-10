local world_ecs = require "src.ecs.world_ecs"
local camera_follow_component = require "src.ecs.components.camera.camera_follow_component"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"

local log = require("log.log")

local camera_follow_system = {
}

function camera_follow_system.init(world_id)
end

function camera_follow_system.update(world_id, dt)
    -- local entites = world_ecs.select_component(world_id, camera_follow_component.name)

    -- for _, entity in ipairs(entites) do
    --     --- @type CameraFollowComponent
    --     local component = world_ecs.get_component(world_id, entity, camera_follow_component.name)
    --     if component.target == nil then
    --         local entites_player = world_ecs.select_component(world_id, character_tag_component.tag_player_name,
    --             unit_controller_component.name)
    --         for _, entity_player in ipairs(entites_player) do
    --             --- @type UnitControllerComponent
    --             local component_unit = world_ecs.get_component(world_id, entity_player, unit_controller_component.name)
    --             component.target = component_unit.url
    --         end
    --         if component.target == nil then
    --             break
    --         end
    --     end
    --     component.target_pos = go.get_position(component.target)
    --     local distance       = vmath.length_sqr(go.get_position(component.url) - component.target_pos)
    --     if distance < 105 then
    --         return
    --     end
    --     component.camera_pos.z = 10
    --     component.camera_pos = vmath.lerp(component.ler_factor, component.camera_pos, component.target_pos)
    --     go.set_position(component.camera_pos, component.url)
    -- end
end

function camera_follow_system.fixed_update(world_id, dt)
end

function camera_follow_system.destroy(world_id)
end

return camera_follow_system
