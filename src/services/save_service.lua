local game_service = require "src.services.game_service"
local weapon_state = require "src.state.weapon_state"
local log = require("log.log")

local M = {
}

local state = {
    filename = "state_store",
    states = {}
}

function M.load_save()
    local filename = sys.get_save_file(game_service.application_name, state.filename)
    local data = sys.load(filename)
    log:info("load", data)
    for key, value in pairs(data) do
        weapon_state.set_load_state(value)
    end
end

function M.reset_save()
    local filename = sys.get_save_file(game_service.application_name, state.filename)
    state.states = {}
    sys.save(filename, state.states)
    log:info("reset", state.states)
end

function M.save()
    local filename = sys.get_save_file(game_service.application_name, state.filename)
    state.states[weapon_state.name] = weapon_state.get_state()
    sys.save(filename, state.states)
    log:info("save", state.states)
end

return M
