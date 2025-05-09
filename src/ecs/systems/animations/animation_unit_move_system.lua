local world_ecs = require "src.ecs.world_ecs"
local move_component = require "src.ecs.components.move.move_component"
local animation_unit_component = require "src.ecs.components.animation.animation_unit_component"
local sprite_component = require "src.ecs.components.animation.sprite_component"
local anim_service = require "src.services.characters.animation_service"

local log = require("log.log")

local animation_unit_move_system = {
}

function animation_unit_move_system.init(world_id)
end

function animation_unit_move_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, move_component.name, animation_unit_component.name,
        sprite_component.name)

    for _, entity in ipairs(entites) do
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)
        --- @type AnimationUnitComponent
        local component_animation = world_ecs.get_component(world_id, entity, animation_unit_component.name)
        --- @type SpriteComponent
        local component_sprit = world_ecs.get_component(world_id, entity, sprite_component.name)

        local animation = anim_service.get_move_animation(component_move.dir_move, component_animation.type_unit)
        if component_animation.current_animation ~= animation then
            sprite.play_flipbook(component_sprit.url, animation)
            component_animation.current_animation = animation
        end
    end
end

function animation_unit_move_system.fixed_update(world_id, dt)
end

function animation_unit_move_system.destroy(world_id)
end

return animation_unit_move_system
