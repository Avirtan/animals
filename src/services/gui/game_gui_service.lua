local M = {
    game_gui = nil,
    events = {
        shoot = hash("shoot_gui_event")
    }
}

local state = {
}

function M.set_camera(game_gui_url)
    M.game_gui = game_gui_url
end

function M.change_weapon()

end

return M
