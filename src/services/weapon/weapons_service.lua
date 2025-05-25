local weapons_config = require "resources.configs.weapons_config"
local weapon_state = require "src.state.weapon_state"

local log = require("log.log")

local M = {}

local state = {
    current_weapon_id = 0
}

function M.set_current_weapon(id)
    state.current_weapon_id = id
end

function M.get_current_weapon()
    return state.current_weapon_id
end

function M.open_weapon(id)
    return weapon_state.open_weapon(id)
end

function M.get_open_weapons()
    return weapon_state.get_open_weapons()
end

function M.get_weapon_data_config_by_id(id)
    return weapons_config[id]
end

function M.get_weapon_data_by_id(id)
    return M.get_weapon_data_config_by_id(id)
end

function M.get_weapons_config()
    return weapons_config
end

return M
