local log = require("log.log")

local M = {
    name = "weapon_state"
}

local state = {
    selected_weapon = {}
}

function M.open_weapon(id)
    state.selected_weapon[id] = id
end

function M.get_open_weapons()
    return state.selected_weapon
end

function M.set_load_state(save_state)
    if save_state.name ~= M.name then
        return
    end
    state.selected_weapon = save_state.selected_weapon
end

function M.get_state()
    state.name = M.name
    return state
end

return M
