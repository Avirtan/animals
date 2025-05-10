--- @type CameraModule
local camera_otho = require "orthographic.camera"

local M = {
    camera_id = nil
}

local state = {
    camera_url = nil,
    projection = nil,
    DISPLAY_WIDTH = sys.get_config_int("display.width"),
    DISPLAY_HEIGHT = sys.get_config_int("display.height")
}

function M.set_camera(camera_url, camera_id)
    state.camera_url = camera_url
    state.projection = camera.get_projection(state.camera_url)
    M.camera_id = camera_id
end

function M.get_camera()
    return state.camera_url
end

function M.get_projection()
    return state.projection
end

function M.get_view()
    return camera.get_view(state.camera_url)
end

function M.get_inv()
    return vmath.inv(state.projection * M.get_view())
end

function M.screen_to_world(position)
    return camera_otho.screen_to_world(M.camera_id, position)
end

function M.is_offscreen(pos, margin)
    local pos_window = camera_otho.world_to_screen(M.camera_id, pos)
    return pos_window.x > state.DISPLAY_WIDTH or pos_window.y > state.DISPLAY_HEIGHT or pos_window.y < 0 or
        pos_window.x < 0
end

return M
