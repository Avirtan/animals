local event = require("event.event")

local M = {
    game_gui = nil,
}

local state = {
}

function M.set_game_screen(game_gui_url)
    M.game_gui = game_gui_url
end

---@return GameGui
function M.get_game_screen()
    return M.game_gui
end

return M
