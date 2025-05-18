local M = {}

local state = {
    tilemap_size = 16,
    tilemap_url = nil
}

function M.set_tilemap(url)
    state.tilemap_url = url
end

function M.get_tilemap()
    return state.tilemap_url
end

function M.get_tilemap_size()
    return state.tilemap_size
end

return M
