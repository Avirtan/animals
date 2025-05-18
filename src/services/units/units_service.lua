local units_config = require "resources.configs.units_config"
local log = require("log.log")

local M = {
    units_key = {
        solder = "solder",
        infantry = "infantry"
    },
    animations_type = {
        move = "move"
    },
    cache_animation = {}
}

local state = {
}

function M.get_unit_config(unit_key)
    return units_config.units_type[unit_key]
end

function M.get_animation_move()
    return units_config.animations.move
end

function M.get_cache_animation(animation_key, animation)
    if M.cache_animation[animation_key] == nil then
        M.cache_animation[animation_key] = {}
    end
    if M.cache_animation[animation_key][animation] == nil then
        M.cache_animation[animation_key][animation] = hash(animation_key .. "_" .. animation)
        return M.cache_animation[animation_key][animation]
    end
    return M.cache_animation[animation_key][animation]
end

return M
