local event_service = require "src.services.controllers.event_service"

local M = {
}

local state = {
    level_controller = nil,
    player_url = nil
}

function M.start_level()
    msg.post(state.level_controller, event_service.controller_events.start_level)
end

function M.set_level_controller(url)
    state.level_controller = url
end

function M.set_player(url)
    state.player_url = url
end

function M.get_level_controller()
    return state.level_controller
end

function M.get_player()
    return state.player_url
end

return M
