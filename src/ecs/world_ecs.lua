local log = require("log.log")

--- @class World
--- @field systems SystemEcs[]
--- @field entites table
--- @field components WorldComponents[]

--- @class WorldComponents
--- @field entites table
--- @field data table

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
    if state.worlds[id] ~= nil then
        return state.worlds[id]
    end
    local world = {
        systems = {},
        entites = {},
        components = {

        }
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
    for _, value in pairs(world.components) do
        if value.entites[entity] ~= nil then
            value.entites[entity] = false
            value.data[entity] = nil
        end
    end
end

--- Компоненты

--- @param entity any
function world_ecs.add_component(world_id, entity, component)
    local name_component = component.name
    local world = state.worlds[world_id]
    local components = world.components[name_component]
    if components == nil then
        world.components[name_component] = {
            entites = {},
            data = {}
        }
        components = world.components[name_component]
    end
    components.entites[entity] = true
    components.data[entity] = component
end

--- @param entity any
function world_ecs.add_components(world_id, entity, ...)
    local components = { ... }
    for i = 1, #components do
        world_ecs.add_component(world_id, entity, components[i])
    end
end

--- @param entity any
function world_ecs.remove_component(world_id, entity, component)
    local name_component = component.name
    local world = state.worlds[world_id]
    local components = world.components[name_component]
    if components == nil then
        return
    end
    components.entites[entity] = false
    components.data[entity] = nil
end

--- @param entity any
function world_ecs.get_component(world_id, entity, name_component)
    local world = state.worlds[world_id]
    local components = world.components[name_component]
    if components == nil or components.data[entity] == nil then
        return nil
    end

    return components.data[entity]
end

function world_ecs.select_component(world_id, ...)
    local world = state.worlds[world_id]
    local components_name = { ... }
    local tables = {}
    local components_data = {}
    for i = 1, #components_name do
        components_data = world.components[components_name[i]]
        if components_data == nil then
            return {}
        end
        tables[i] = components_data.entites
    end

    if #tables == 0 then return {} end

    local commonIDs = {}
    for id, value in pairs(tables[1]) do
        if value then
            commonIDs[id] = value
        end
    end
    -- log:info("tables", tables)

    for i = 2, #tables do
        local currentTable = tables[i]
        local temp = {}

        for id, _ in pairs(currentTable) do
            if commonIDs[id] then
                temp[id] = true
            end
        end

        commonIDs = temp
        if not next(commonIDs) then break end
    end

    local result = {}
    for id in pairs(commonIDs) do
        table.insert(result, id)
    end

    return result
end

--- Системы

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
