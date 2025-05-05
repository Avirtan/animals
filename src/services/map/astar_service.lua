local tilemap_service = require "src.services.map.tilemap_service"
local screen_service = require "src.services.screen_service"

local M = {}

local state = {
    map = {},
    factory_dot_debug = nil,
    points_debug = {},
    tmp_vector = vmath.vector3()
}

--- @param layer string|userdata
function M.set_map(layer)
    local urlTilemap = tilemap_service.get_tilemap()
    local _, _, map_width, map_height = tilemap.get_bounds(urlTilemap)
    local tile = 0
    for y = 1, map_height do
        for x = 1, map_width do
            tile = tilemap.get_tile(urlTilemap, layer, x, y)
            table.insert(state.map, tile)
        end
    end
    local direction = astar.DIRECTION_EIGHT
    local allocate = map_width * map_height
    local typical_adjacent = 8
    local cache = true
    local use_zero = false
    local flip_map = false
    astar.setup(map_width, map_height, direction, allocate, typical_adjacent, cache, use_zero, flip_map)
    astar.set_map(state.map)
end

function M.set_factory(url)
    state.factory_dot_debug = url
end

function M.show_points_debug(url, paths)
    M.reset_points_debug(url)
    for index, tile in ipairs(paths) do
        local x, y         = screen_service.tile_to_world(tile.x, tile.y);
        state.tmp_vector.x = x
        state.tmp_vector.y = y
        local point        = factory.create(state.factory_dot_debug, state.tmp_vector)
        print(state.tmp_vector.x, " ", state.tmp_vector.y)
        state.points_debug[url][index] = point
    end
end

function M.reset_points_debug(url)
    if state.points_debug[url] == nil then
        state.points_debug[url] = {}
    end
    for _, id_point in ipairs(state.points_debug[url]) do
        go.delete(id_point)
    end
    state.points_debug[url] = {}
end

function M.set_cost(costs)
    astar.set_costs(costs)
end

return M
