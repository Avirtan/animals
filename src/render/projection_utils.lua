local M = {
    DEFAULT_NEAR = -1,
    DEFAULT_FAR = 1,
    DEFAULT_ZOOM = 1,
}

--
-- projection that centers content with maintained aspect ratio and optional zoom
--
function M.get_fixed_projection(camera, state)
    camera.zoom = camera.zoom or M.DEFAULT_ZOOM
    local projected_width = state.window_width / camera.zoom
    local projected_height = state.window_height / camera.zoom
    local left = -(projected_width - state.width) / 2
    local bottom = -(projected_height - state.height) / 2
    local right = left + projected_width
    local top = bottom + projected_height
    return vmath.matrix4_orthographic(left, right, bottom, top, camera.near, camera.far)
end

--
-- projection that centers and fits content with maintained aspect ratio
--
function M.get_fixed_fit_projection(camera, state)
    camera.zoom = math.min(state.window_width / state.width, state.window_height / state.height)
    return M.get_fixed_projection(camera, state)
end

--
-- projection that stretches content
--
function M.get_stretch_projection(camera, state)
    return vmath.matrix4_orthographic(0, state.width, 0, state.height, camera.near, camera.far)
end

--
-- projection for gui
--
function M.get_gui_projection(camera, state)
    return vmath.matrix4_orthographic(0, state.window_width, 0, state.window_height, camera.near, camera.far)
end

return M
