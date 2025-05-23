local M = {
}

local state = {
    selected_weapon = { 1 }
}

function M.select_weapon(id)
    state.selected_weapon[id] = id
end

function M.get_selected_weapons()
    return state.selected_weapon
end

return M
