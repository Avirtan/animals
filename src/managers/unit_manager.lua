local factory_service = require "src.services.levels.factory_service"
local events_service = require "src.services.events_service"
local player_model = require "src.models.player.player_model"
local enemy_model = require "src.models.enemy.enemy_model"

--- @class UnitManager
local M = {}

local state = {
    player = nil,
    units = {}
}

function M.spawn_player()
    local url_player_collection = factory_service.spawn_object_collection(factory_service.factory_name.player)
    local player_controller_url = url_player_collection[hash("/player_character")]
    local model = player_model.new(url_player_collection)
    model:set_url_controller(player_controller_url)
    state.player = model
    state.units[player_controller_url] = model
    msg.post(player_controller_url, events_service.character_events.set_model, {
        id = player_controller_url
    })
    return model
end

function M.spawn_enemy()
    local spawn_position = vmath.vector3(200, 200, 0)
    local enemy_url = factory_service.spawn_object_factory(factory_service.factory_name.enemy)
    local model = enemy_model.new(M)
    model.base_model.position = spawn_position
    model:set_url_controller(enemy_url)
    state.units[enemy_url] = model
    msg.post(enemy_url, events_service.character_events.set_model, {
        id = enemy_url
    })
    return model
end

function M.delete_unit(url)
    state.units[url] = nil
    go.delete(url, true)
end

function M.get_model(url)
    return state.units[url]
end

---
---@return PlayerModel
function M.get_player()
    return state.player
end

function M.update(dt)
    for url, unit in pairs(state.units) do
        unit:update(dt, self)
    end
end

function M.on_message(url, name_component, message_id, message)
    data = data or {}
    --- @type CharacterModel
    local model = state.units[url]
    if model == nil then
        return
    end
    model:on_message(name_component, message_id, message)
end

return M
