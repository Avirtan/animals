local factory_service = require "src.services.levels.factory_service"
local character_model = require "src.models.character.character_model"
local events_service = require "src.services.events_service"
local player_model = require "src.models.player.player_model"

local M = {}

local state = {
    player = nil,
    units = {}
}

function M.spawn_player()
    local url_player_collection = factory_service.spawn_object(factory_service.factory_name.player)
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

function M.delete_unit(url)
    state.units[url] = nil
    go.delete(url, true)
end

function M.get_model(url)
    return state.units[url]
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
