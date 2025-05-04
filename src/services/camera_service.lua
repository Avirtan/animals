local M = {}

local state = {
    camera_url = nil,
    projection = nil,
}

function M.set_camera(camera_url)
    state.camera_url = camera_url
    state.projection = camera.get_projection(state.camera_url)
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

return M
