local event = require("event.event")

local M = {
    game_gui = nil,
    events = {
        on_change_weapon = event.create()
    }
}

local state = {
}

function M.set_camera(game_gui_url)
    M.game_gui = game_gui_url
end

function M.change_weapon(index)
    M.events.on_change_weapon:trigger(index)
end

return M
