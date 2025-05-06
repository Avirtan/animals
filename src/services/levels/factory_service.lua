local M = {
    factory_name = {
        player = "player_factory",
        enemy = "enemy_factory",
        bullet = "bullet_factory",
    }
}

local state = {
    factory = {},
    vector_zero = vmath.vector3(0, 0, 0)
}

function M.set_factory(name, url)
    state.factory[name] = url
end

function M.spawn_object_collection(name, position, data)
    local url_factory = state.factory[name]
    if position == nil then
        position = state.vector_zero
    end
    local url = collectionfactory.create(url_factory, position)
    return url
end

function M.spawn_object_factory(name, position, data)
    local url_factory = state.factory[name]
    if position == nil then
        position = state.vector_zero
    end
    local url = factory.create(url_factory, position)
    return url
end

function M.get_factory_url(name)
    return state.factory[name].url
end

return M
