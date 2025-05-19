local weapons_config = require "resources.configs.weapons_config"
local weapon_state = require "src.state.weapon_state"

local log = require("log.log")

local M = {}

local state = {

}

function M.select_weapon(id)
    return weapon_state.select_weapon(id)
end

function M.get_selected_weapons()
    return weapon_state.get_selected_weapons()
end

function M.get_weapon_data_config_by_id(id)
    return weapons_config[id]
end

function M.get_weapon_data_by_id(id)
    return M.get_weapon_data_config_by_id(id)
end

return M
