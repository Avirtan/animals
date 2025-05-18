local weapons_config = require "resources.configs.weapons_config"
local log = require("log.log")

local M = {}

local state = {
}

function M.get_weapon_data_config_by_id(id)
    return weapons_config[id]
end

function M.get_weapon_data_by_id(id)
    return M.get_weapon_data_config_by_id(id)
end

return M
