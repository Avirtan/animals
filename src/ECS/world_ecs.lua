--- @class World
--- @field systems SystemEcs[]
--- @field entites table
--- @field last_id number

local world_ecs = {
    world_id = {
        Main = 1
    }
}

--- @class state_worlds
--- @field worlds World[]
local state = {
    worlds = {},
    max_entites = 10000
}


---@return World
function world_ecs.new(id)
    local world = {
        systems = {},
        entites = {},
    }
    state.worlds[id] = world
    return world
end

function world_ecs.create_entity(world_id)
    local world = state.worlds[world_id]
    for index = 1, state.max_entites, 1 do
        if not world.entites[index] then
            world.entites[index] = true
            return index
        end
    end
    return nil
end

--- @param entity any
--- @return unknown
function world_ecs.is_alive_entity(world_id, entity)
    local world = state.worlds[world_id]
    return world.entites[entity]
end

--- @param entity any
function world_ecs.delete_entity(world_id, entity)
    local world = state.worlds[world_id]
    world.entites[entity] = false
end

--- @param system SystemEcs
function world_ecs.add_system(world_id, system)
    local world = state.worlds[world_id]
    table.insert(world.systems, system)
end

function world_ecs.update_systems(world_id, dt)
    local world = state.worlds[world_id]
    for _, value in ipairs(world.systems) do
        value.update(world_id, dt)
    end
end

function world_ecs.fixed_update_systems(world_id, dt)
    local world = state.worlds[world_id]
    for _, value in ipairs(world.systems) do
        value.fixed_update(world_id, dt)
    end
end

function world_ecs.init_systems(world_id)
    local world = state.worlds[world_id]
    for _, value in ipairs(world.systems) do
        value.init(world_id)
    end
end

return world_ecs
