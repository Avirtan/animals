local character_model = require "src.models.character.character_model"
local move_key_component = require "src.components.move.move_key_component"
local aim_circle_component = require "src.components.player.aim_circle_component"
local sprite_component = require "src.components.animation.sprite_component"
local components_service = require "src.services.components_service"

local M = {}

function M.new(url_player_collection)
    local spawn_position = vmath.vector3(50, 50, 0)
    local model = character_model.new({
        position = spawn_position,
        health = 100
    })
    local url_aim = url_player_collection["/aim_circle"]
    model:add_component(components_service.name.move, move_key_component.new())
    model:add_component(components_service.name.aim_circle, aim_circle_component.new(url_aim))
    model:add_component(components_service.name.sprite_animation, sprite_component.new(url_aim))

    return model
end

return M
